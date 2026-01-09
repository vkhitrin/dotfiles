container_login() {
    local CONTAINER_USERNAME=""
    local CONTAINER_PASSWORD=""
    local CONTAINER_REGISTRY=""
    local CONTAINER_PASSWORD_STDIN=0

    while [[ ${#} -gt 0 ]]; do
        case "${1}" in
            --username)
                if [[ ${#} -lt 2 ]]; then
                    echo "Error: --username requires a value" >&2
                    return 1
                fi
                CONTAINER_USERNAME="${2}"
                shift 2
                ;;
            --password)
                if [[ ${#} -lt 2 ]]; then
                    echo "Error: --password requires a value" >&2
                    return 1
                fi
                if [[ ${CONTAINER_PASSWORD_STDIN} -eq 1 ]]; then
                    echo "Error: --password and --password-stdin cannot be used together" >&2
                    return 1
                fi
                CONTAINER_PASSWORD="${2}"
                shift 2
                ;;
            --password-stdin)
                if [[ -n "${CONTAINER_PASSWORD}" ]]; then
                    echo "Error: --password and --password-stdin cannot be used together" >&2
                    return 1
                fi
                CONTAINER_PASSWORD_STDIN=1
                shift
                ;;
            --help|-h)
                echo "Usage: container_login --username USERNAME [--password PASSWORD | --password-stdin] REGISTRY" >&2
                return 0
                ;;
            --*)
                echo "Error: unknown option: ${1}" >&2
                return 1
                ;;
            *)
                if [[ -n "${CONTAINER_REGISTRY}" ]]; then
                    echo "Error: expected a single registry argument" >&2
                    return 1
                fi
                CONTAINER_REGISTRY="${1}"
                shift
                ;;
        esac
    done

    if [[ ${CONTAINER_PASSWORD_STDIN} -eq 1 ]]; then
        IFS= read -r CONTAINER_PASSWORD
    fi

    if [[ -z "${CONTAINER_USERNAME}" || -z "${CONTAINER_PASSWORD}" || -z "${CONTAINER_REGISTRY}" ]]; then
        echo "Usage: container_login --username USERNAME [--password PASSWORD | --password-stdin] REGISTRY" >&2
        return 1
    fi

    sudo security add-internet-password \
        -a "${CONTAINER_USERNAME}" \
        -s "${CONTAINER_REGISTRY}" \
        -w "${CONTAINER_PASSWORD}" \
        -d "com.apple.container.registry" \
        -T "$(brew --prefix container)/bin/container" \
        -T "$(brew --prefix container)/libexec/container-plugins/container-core-images/bin/container-core-images" \
        -U "/Library/Keychains/System.keychain"
}

_container_login() {
    local -a OPTIONS
    local -a REGISTRIES
    local HAS_USERNAME=0
    local HAS_PASSWORD=0
    local HAS_PASSWORD_STDIN=0
    local HAS_REGISTRY=0
    local HAS_HELP=0
    local INDEX=2

    while [[ ${INDEX} -lt ${CURRENT} ]]; do
        case "${words[INDEX]}" in
            --username)
                HAS_USERNAME=1
                if [[ $((INDEX + 1)) -lt ${CURRENT} && "${words[INDEX + 1]}" != -* ]]; then
                    ((INDEX+=2))
                else
                    ((INDEX++))
                fi
                continue
                ;;
            --password|-p)
                HAS_PASSWORD=1
                if [[ $((INDEX + 1)) -lt ${CURRENT} && "${words[INDEX + 1]}" != -* ]]; then
                    ((INDEX+=2))
                else
                    ((INDEX++))
                fi
                continue
                ;;
            --password-stdin)
                HAS_PASSWORD_STDIN=1
                ;;
            --help|-h)
                HAS_HELP=1
                ;;
            --*)
                ;;
            *)
                if [[ ${HAS_REGISTRY} -eq 0 ]]; then
                    HAS_REGISTRY=1
                fi
                ;;
        esac
        ((INDEX++))
    done

    if [[ ${HAS_USERNAME} -eq 0 ]]; then
        OPTIONS+=(--username)
    fi

    if [[ ${HAS_PASSWORD} -eq 0 && ${HAS_PASSWORD_STDIN} -eq 0 ]]; then
        OPTIONS+=(--password -p --password-stdin)
    fi

    if [[ ${HAS_HELP} -eq 0 ]]; then
        OPTIONS+=(--help -h)
    fi

    if [[ ${HAS_REGISTRY} -eq 0 ]]; then
        REGISTRIES=($(_container_login_registries))
    fi

    if [[ "${PREFIX}" == -* ]]; then
        compadd -- "${OPTIONS[@]}"
        return 0
    fi

    compadd -- "${OPTIONS[@]}" "${REGISTRIES[@]}"
}

_container_login_registries() {
    local -a registries

    registries=(${(f)"$(container registry list 2>/dev/null | awk 'NR > 1 { print $1 }')"})

    if [[ ${#registries[@]} -gt 0 ]]; then
        print -l -- "${registries[@]}"
    fi
}

compdef _container_login container_login
