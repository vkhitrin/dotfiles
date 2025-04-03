# Locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Custom env variables
export IS_SERVER=false

# fzf
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a --no-mouse --tmux 75%"

# PGP
export GPG_TTY=$(tty)

# Include all kubeconfig files
export KUBECONFIG=$(find "$HOME/.kube" -maxdepth 1 -type f | xargs | sed -e 's/ /:/g')

# Application(s)
export KUBECTL_COMMAND="kubectl"
export ANSIBLE_HOME="${HOME}/.local/share/ansible"
export GLAMOUR_STYLE="${HOME}/.config/glamour/catppuccin-mocha.json"

# Gcloud
export CLOUDSDK_PYTHON_SITEPACKAGES=1

__construct_aws_profiles_mapping() {
    local AWS_VAULT_LIST=$(aws-vault list | sed -e '1,3d')
    (
        echo "Profile,Account ID,Role,Session,Description";
        for PROFILE in $(aws configure list-profiles | grep -v default); do
            local PROFILE_ACCOUNT_ID=$(initool get "${HOME}/.aws/config" "profile ${PROFILE}" "sso_account_id" -v)
            local PROFILE_ROLE=$(initool get "${HOME}/.aws/config" "profile ${PROFILE}" "sso_role_name" -v)
            local PROFILE_SESSION=$(echo ${AWS_VAULT_LIST} | grep "${PROFILE}" | awk '{print $3}')
            if [[ ${PROFILE_SESSION} == "-" ]] && PROFILE_SESSION=" "
            local PROFILE_DESCRIPTION=$(initool get "${HOME}/.aws/config" "profile ${PROFILE}" "description" -v)
            echo "${PROFILE},${PROFILE_ACCOUNT_ID},${PROFILE_ROLE},${PROFILE_SESSION},${PROFILE_DESCRIPTION}" | awk -F ',' -v cur="${PROFILE_SESSION}" '
            {
              if ($4 ~ / /)
                print $0;
              else
                print "\033[33m"$0"\033[0m";
            }'
        done
    ) | awk -F ',' '{print $1,$2,$3,$5}' OFS=',' | ansicolumn -t -s ',' | sed 's/\([^,]*,[^,]*,[^,]*,[^,]*\),/\1,/' 
}

__get_kuberentes_contexts() {
    local CONTEXTS=$(kubesess completion-context | sed -e 's/ /\n/g')
    local CURRENT_CONTEXT=$(kubectl config current-context 2>/dev/null)
    if [[ -n "$CURRENT_CONTEXT" ]]; then
      (echo "$CONTEXTS" | awk -v cur="$CURRENT_CONTEXT" '
      {
        if ($0 == cur)
          print "\033[1;34m" $0 "\033[0m";
        else
          print $0;
      }')
    else
      echo ${CONTEXTS}
    fi
}

__get_git_directories() {
    local STARTING_PATH="${1}"
    fd -H -t d -g '.git' "${1}" | xargs -I {} dirname {}
}

__get_directories() {
    local STARTING_PATH="${1}"
    fd --full-path -H -t d "${1}"
}

__get_cosmicding_bookmarks() {
    if [[ -n "${COSMICDING_SQLITE_DATABASE}" ]]; then
        sqlite3 --json "${COSMICDING_SQLITE_DATABASE}" "SELECT title,url,tag_names FROM Bookmarks" | \
            jq -r '(["title", "tags", "url"] | @csv), (.[] | [.title, .tag_names, .url] | @csv)' | sed 's/","/|/g' | sed 's/^"\(.*\)"$/\1/g' | column -t -s'|'
    else
        echo "Environment variable COSMICDING_SQLITE_DATABASE is not defined"
    fi
}

__get_xx_gitlab_projects() {
    if [[ -n "${XX_CACHE_DIR}" ]]; then
        if [[ -f "${XX_CACHE_DIR}/gitlab.db" ]]; then
            sqlite3 --json "${XX_CACHE_DIR}/gitlab.db" "SELECT project,id,web_url FROM Projects" | \
                jq -r '(["project","id","url"] | @csv) , (.[] | [.project, .id, .web_url] | @csv)' | sed 's/"//g' | column -t -s','
        else
            echo "gitlab.db doesn't exist"
        fi
    else
        echo "Environment variable XX_CACHE_DIR is not defined"
    fi
}

__get_xx_gitlab_groups() {
    if [[ -n "${XX_CACHE_DIR}" ]]; then
        if [[ -f "${XX_CACHE_DIR}/gitlab.db" ]]; then
            sqlite3 --json "${XX_CACHE_DIR}/gitlab.db" "SELECT group_name AS name,id,web_url FROM Groups" | \
                jq -r '(["group","id","url"] | @csv) , (.[] | [.name, .id, .web_url] | @csv)' | sed 's/"//g' | column -t -s','
        else
            echo "gitlab.db doesn't exist"
        fi
    else
        echo "Environment variable XX_CACHE_DIR is not defined"
    fi
}

__get_xx_confluence_spaces() {
    if [[ -n "${XX_CACHE_DIR}" ]]; then
        if [[ -f "${XX_CACHE_DIR}/confluence.db" ]]; then
            sqlite3 --json "${XX_CACHE_DIR}/confluence.db" "SELECT name,key,url FROM Spaces" | \
                jq -r '(["name","key","url"] | @csv) , (.[] | [.name, .key, .url] | @csv)' | sed 's/"//g' | column -t -s','
        else
            echo "confluence.db doesn't exist"
        fi
    else
        echo "Environment variable XX_CACHE_DIR is not defined"
    fi
}

__get_xx_confluence_pages() {
    if [[ -n "${XX_CACHE_DIR}" ]]; then
        if [[ -f "${XX_CACHE_DIR}/confluence.db" ]]; then
            sqlite3 --json "${XX_CACHE_DIR}/confluence.db" "SELECT title,space,url FROM Pages" | \
                jq -r '(["title","space","url"] | @csv) , (.[] | [.title, .space, .url] | @csv)' | sed 's/"//g' | column -t -s','
        else
            echo "confluence.db doesn't exist"
        fi
    else
        echo "Environment variable XX_CACHE_DIR is not defined"
    fi
}

__get_xx_functions() {
    local GNU_SED_COMMAND
    local GNU_AWK_COMMNAD
    local XX_FUNCTIONS
    if [[ $(uname) == "Darwin" ]];then
        GNU_AWK_COMMNAD="gawk"
        GNU_SED_COMMAND="gsed"
    elif [[ $(uname) == "Linux" ]]; then
        GNU_AWK_COMMNAD="awk"
        GNU_SED_COMMAND="sed"
    fi

    XX_FUNCTIONS=$(rg --follow --type zsh --color always --field-context-separator '' --color never \
        --no-filename --no-context-separator --only-matching -e '^\s*function\s+(?P<fname>([^\s(]+))' \
        -r '$fname' -A 1 --field-match-separator ' ' "${HOME}" --max-depth 1 | ${GNU_SED_COMMAND} -E 's!(\s*)(# xx )!\2!' \
        | ${GNU_SED_COMMAND} "s!${HOME}!!" | ${GNU_SED_COMMAND} 'N;s/\n/ /' | ${GNU_AWK_COMMNAD} '{$2=$3="";print}')


    echo "${XX_FUNCTIONS}" | ${GNU_AWK_COMMNAD} -F \
      ' *; *' 'BEGIN { printf "%-8s %-12s %-s\n", "COMMAND", "TAG", "DESCRIPTION" } {split($2, a, ":"); gsub(",", " ", a[1]); printf "%-8s %-12s %-s\n", $1, a[1], a[2]}'
}
