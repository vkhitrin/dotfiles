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
        -r '$fname' -A 1 --field-match-separator ' ' "${HOME}/.zshrc.d""" --max-depth 1 | ${GNU_SED_COMMAND} -E 's!(\s*)(# xx )!\2!' \
        | ${GNU_SED_COMMAND} "s!${HOME}!!" | ${GNU_SED_COMMAND} 'N;s/\n/ /' | ${GNU_AWK_COMMNAD} '{$2=$3="";print}')


    echo "${XX_FUNCTIONS}" | ${GNU_AWK_COMMNAD} -F \
' *; *' 'BEGIN { print "COMMAND,TAGS,SHELL SCOPED,DESCRIPTION" }
{
    split($2, a, ":");
    gsub(",", " ", a[1]);
    shell_scoped = "";
    if (match(a[2], /@[^ ]+/)) {
        shell_scoped = substr(a[2], RSTART + 1, RLENGTH - 1);  # Remove '@'
    }
    gsub(/@[^\s]+/, "", a[2]);
    shell_scoped_colored = shell_scoped;
    if (shell_scoped == "FALSE") {
        shell_scoped_colored = "\033[32m" shell_scoped "\033[0m";  # Green
    } else if (shell_scoped == "TRUE") {
        shell_scoped_colored = "\033[31m" shell_scoped "\033[0m";  # Red
    } else if (shell_scoped == "PARTIAL") {
        shell_scoped_colored = "\033[33m" shell_scoped "\033[0m";  # Yellow
    }

    # Print the fields separated by commas (CSV format)
    print $1 "," a[1] "," shell_scoped_colored "," a[2];
}' | ansicolumn -t -s ','
}

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
            jq -r '(["TITLE", "TAGS", "URL"] | @csv), (.[] | [.title, .tag_names, .url] | @csv)' | sed 's/","/|/g' | sed 's/^"\(.*\)"$/\1/g' | column -t -s'|'
    else
        echo "Environment variable COSMICDING_SQLITE_DATABASE is not defined"
    fi
}

__get_xx_gitlab_projects() {
    if [[ -n "${XX_CACHE_DIR}" ]]; then
        if [[ -f "${XX_CACHE_DIR}/gitlab.db" ]]; then
            sqlite3 --json "${XX_CACHE_DIR}/gitlab.db" "SELECT project,id,web_url FROM Projects" | \
                jq -r '(["PROJECT","ID","URL"] | @csv) , (.[] | [.project, .id, .web_url] | @csv)' | sed 's/"//g' | column -t -s','
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
                jq -r '(["GROUP","ID","URL"] | @csv) , (.[] | [.name, .id, .web_url] | @csv)' | sed 's/"//g' | column -t -s','
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

__construct_google_cloud_sdk_accounts() {
    (
        echo "ACCOUNT";
        gcloud auth list --format=json | jq -r -c '.[].account' | awk -v cur="${CLOUDSDK_CORE_ACCOUNT}" '
            {
              if ($0 == cur)
                print "\033[32m"$0"\033[0m";
              else
                print $0;
            }'
    )
}

__construct_azure_accounts() {
    local ACTIVE_SUBSCRIPTION=$(jq -r '.subscriptions[] | select(.isDefault == true) | .name' "${HOME}/.azure/azureProfile.json")
    (
        echo "SUBSCRIPTION,SUBSCRIPTION ID,ACCOUNT";
        cat "${HOME}/.azure/azureProfile.json" | jq -r '.subscriptions[] | [.name,.id,.user.name] | @csv' \
            | sed 's/"//g' | awk -F ',' -v cur="${ACTIVE_SUBSCRIPTION}" '
            {
              if ($1 == cur)
                print "\033[96m"$0"\033[0m";
              else
                print $0;
            }'
    ) | ansicolumn -t -s','
}

__unset_azure_account() {
    local UPDATED_JSON=$(jq '.subscriptions |= map(if has("isDefault") then .isDefault = false else . end)' \
      "${HOME}/.azure/azureProfile.json")
    if [ ! -z ${UPDATED_JSON} ]; then
        echo "${UPDATED_JSON}" > "${HOME}/.azure/azureProfile.json"
    fi
}
xx() {
    __get_xx_functions | fzf --header-lines=1 --info=inline --ansi \
        --layout=reverse-list --accept-nth 1 \
        --border-label ' xx ' --color 'border:#F4E0DC,label:#F4E0DC,header:#F4E0DC:bold,preview-fg:#F4E0DC' \
        --preview="echo 'Enter: Execute Command'" \
        --preview-window=down,1,border-none --tmux 80%
}

function awsx() {
    # xx ;aws:Activate AWS profile for shell@TRUE
    __construct_aws_profiles_mapping | fzf --exact --ansi --header-lines=1 --info=inline \
        --bind='ctrl-r:reload:__construct_aws_profiles_mapping' --prompt="Filter " \
        --bind='ctrl-l:execute-silent(aws-vault login {1} -s)+reload(__construct_aws_profiles_mapping)' \
        --bind='ctrl-d:execute-silent(aws-vault clear {1})+reload(__construct_aws_profiles_mapping)' \
        --layout=reverse-list \
        --border-label ' AWS Accounts ' --color 'border:#f9e2af,label:#f9e2af,header:#f9e2af:bold,preview-fg:#f9e2af' \
        --preview="echo 'Ctrl-R: Reload List | Ctrl-L: Login | Ctrl-D: Clear Session | Enter: Exec'" \
        --preview-window=down,1,border-none --tmux 80% \
        --bind 'enter:become(aws-vault exec {1})'
}

function kctx() {
    # xx ;kubernetes:Activate Kubernetes context for shell@TRUE
    local SELECTED_CONTEXT=$(__get_kuberentes_contexts | fzf --info=inline --ansi \
        --bind='ctrl-u:execute-silent(rm -rf ${HOME}/.kube/kubesess/cache/)+reload(__get_kuberentes_contexts)' \
        --bind='ctrl-r:reload:(__get_kuberentes_contexts)' --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' Kubernetes Contexts ' --color 'border:#89b4fa,label:#89b4fa,preview-fg:#89b4fa' \
        --preview="echo 'Ctrl-R: Reload List | Ctrl-U: Unset Current Context | Enter: Set Context'" \
        --preview-window=down,1,border-none \
        --bind 'enter:become(kubesess -v {} context)'
    )
    [ ! -z ${SELECTED_CONTEXT} ] && export KUBECONFIG="${SELECTED_CONTEXT}"
}

function gpx() {
    # xx ;git,shell:Navigate to local git projects@PARTIAL
    local STARTING_PATH="${1:-${HOME}/Projects/}"
    local SELECTED_DIR=$(__get_git_directories "${STARTING_PATH}" 2>/dev/null | fzf --border-label " Git Projects Under '${STARTING_PATH}' " \
        --info=inline --color 'border:#fab387,label:#fab387,preview-fg:#fab387' \
        --bind='ctrl-o:execute-silent(cd {}; git open)' \
        --prompt "Filter " --preview="echo 'CTRL+O: Open Remote | Enter: Navigate To Git Project Directory'" \
        --preview-window=down,1,border-none --scheme=path
    )
    [ ! -z ${SELECTED_DIR} ] && cd "${SELECTED_DIR}"
}

function bkmx() {
    # xx ;linkding:View bookmarks@FALSE
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
    fi

    __get_cosmicding_bookmarks | fzf --header-lines=1 --info=inline \
        --bind='ctrl-r:reload:__get_cosmicding_bookmarks' --prompt="Filter " \
        --bind="ctrl-u:become(echo {} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' Bookmarks ' --color 'border:#b4befe,label:#b4befe,header:#b4befe:bold,preview-fg:#b4befe' \
        --preview="echo 'Ctrl-R: Reload List | Ctrl+U: Copy URL To Clipboard | Enter: Open'" \
        --preview-window=down,1,border-none --tmux 90% \
        --bind "enter:become(echo {} | awk '{print \$NF}' | xargs ${OPEN_COMMAND})"
}

function cdx() {
    # xx ;shell:Navigate to directory@TRUE
    local STARTING_PATH="${1:-${PWD}}"
    local SELECTED_DIR=$(__get_directories "${STARTING_PATH}" | fzf --border-label " All Directories Under '$(basename ${STARTING_PATH})' " \
        --info=inline --color 'border:#f38ba8,label:#f38ba8,preview-fg:#f38ba8' \
        --prompt "Filter " --preview="echo 'Enter: Navigate To Selected Directory'" \
        --preview-window=down,1,border-none --scheme=path
    )
    [ ! -z ${SELECTED_DIR} ] && cd "${SELECTED_DIR}"
}

if which jira > /dev/null 2>&1;then
    function jipx() {
        # xx ;jira:Query Jira for projects@FALSE
        jira projects list | fzf --border-label " Jira Projects " --header-lines=1 --layout=reverse-list \
            --info=inline --color 'border:#89b4fa,label:#89b4fa,preview-fg:#89b4fa,header:#89b4fa:bold' \
            --prompt "Filter " --preview="echo 'Enter: Open Project In Browser'" \
            --preview-window=down,1,border-none \
            --bind "enter:become(jira open --project {1})"
    }
    # TODO: Add pagination support
    function jiix() {
        # xx ;jira:Query Jira for issues@FALSE
        local CLIPBOARD_COMMAND
        local OPEN_COMMAND
        if [[ $(uname) == "Darwin" ]];then
            CLIPBOARD_COMMAND="pbcopy"
            OPEN_COMMAND="open"
        elif [[ $(uname) == "Linux" ]]; then
            CLIPBOARD_COMMAND="wl-copy"
            OPEN_COMMAND="xdg-open"
        fi
        local JQL="${1:-(assignee = currentUser()) AND (status !='done')}"
        # Workaround https://github.com/ankitpokhrel/jira-cli/issues/834
        jira issues list --jql="${JQL}" --plain --columns key,status,summary  2>&1 | sed 's/\[\]/\]/g' | fzf --border-label " Jira Issues " \
            --header-lines=1 --layout=reverse-list \
            --info=inline --color 'border:#89b4fa,label:#89b4fa,preview-fg:#89b4fa,header:#89b4fa:bold' \
            --bind="ctrl-u:become(jira open --no-browser {1} | tr -d '\n' | ${CLIPBOARD_COMMAND})" \
            --prompt "JQL: ${JQL} " --preview="echo 'Ctrl+U: Copy URL To Clipboard | Enter: Open Issue In Browser'" \
            --preview-window=down,1,border-none \
            --bind "enter:become(jira open {1})"
    }
fi

function glpx() {
    # xx ;gitlab:Display cached GitLab Projects@FALSE
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
    fi

    __get_xx_gitlab_projects | fzf --header-lines=1 --info=inline \
        --bind="ctrl-u:become(echo {3} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --bind="ctrl-i:become(echo {2} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' GitLab Projects ' --color 'border:#fca326,label:#fca326,header:#fca326:bold,preview-fg:#fca326' \
        --preview="echo 'Ctrl+U: Copy URL To Clipboard | Ctrl+I: Copy ID To Clipboard | Enter: Open'" \
        --preview-window=down,1,border-none --tmux 80% \
        --bind "enter:become(echo {3} | awk '{print \$NF}' | xargs ${OPEN_COMMAND})"
}

function glgx() {
    # xx ;gitlab:Display cached GitLab Groups@FALSE
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
    fi

    __get_xx_gitlab_groups | fzf --header-lines=1 --info=inline \
        --bind="ctrl-u:become(echo {3} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --bind="ctrl-i:become(echo {2} | awk '{print \$NF}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' GitLab Groups ' --color 'border:#fca326,label:#fca326,header:#fca326:bold,preview-fg:#fca326' \
        --preview="echo 'Ctrl+U: Copy URL To Clipboard | Ctrl+I: Copy ID To Clipboard | Enter: Open'" \
        --preview-window=down,1,border-none --tmux 80% \
        --bind "enter:become(echo {3} | awk '{print \$NF}' | xargs ${OPEN_COMMAND})"
}

function cfsx() {
    # xx ;confluence:Display cached Confluence spaces@FALSE
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
    fi

    __get_xx_confluence_spaces | fzf --header-lines=1 --info=inline \
        --bind="ctrl-u:become(echo {} | awk -F '   *' '{print \$3}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --bind="ctrl-i:become(echo {} | awk -F '   *' '{print \$2}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --layout=reverse-list --delimiter ' ' \
        --border-label ' Confluence Spaces ' --color 'border:#89b4fa,label:#89b4fa,header:#89b4fa:bold,preview-fg:#89b4fa' \
        --preview="echo 'Ctrl+U: Copy URL To Clipboard | Ctrl+I: Copy Key To Clipboard | Enter: Open'" \
        --preview-window=down,1,border-none --tmux 80% \
        --bind "enter:become(echo {} | awk -F '   *' '{print \$3}' | xargs ${OPEN_COMMAND})"
}

function cfpx() {
    # xx ;confluence:Display cached Confluence pages@FALSE
    local CLIPBOARD_COMMAND
    local OPEN_COMMAND
    if [[ $(uname) == "Darwin" ]];then
        CLIPBOARD_COMMAND="pbcopy"
        OPEN_COMMAND="open"
    elif [[ $(uname) == "Linux" ]]; then
        CLIPBOARD_COMMAND="wl-copy"
        OPEN_COMMAND="xdg-open"
    fi

    __get_xx_confluence_pages | fzf --header-lines=1 --info=inline \
        --bind="ctrl-u:become(echo {} | awk -F '   *' '{print \$3}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --bind="ctrl-i:become(echo {} | awk -F '   *' '{print \$2}' | tr -d '\n' | ${CLIPBOARD_COMMAND})" --prompt="Filter " \
        --layout=reverse-list --delimiter ' ' \
        --border-label ' Confluence Pages ' --color 'border:#89b4fa,label:#89b4fa,header:#89b4fa:bold,preview-fg:#89b4fa' \
        --preview="echo 'Ctrl+U: Copy URL To Clipboard | Ctrl+I: Copy Key To Clipboard | Enter: Open'" \
        --preview-window=down,1,border-none --tmux 80% \
        --bind "enter:become(echo {} | awk -F '   *' '{print \$3}' | xargs ${OPEN_COMMAND})"
}

function gcpx() {
    # xx ;gcp:Activate GCP Account for shell@TRUE
    local SELECTED_ACCOUNT=$(__construct_google_cloud_sdk_accounts | fzf --exact --ansi --header-lines=1 --info=inline \
        --bind='ctrl-r:reload(__construct_google_cloud_sdk_accounts)' --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' GCP Accounts ' --color 'border:#a6e3a1,label:#a6e3a1,header:#a6e3a1:bold,preview-fg:#a6e3a1' \
        --preview="echo 'Ctrl-R: Reload List | Enter: Activate Account'" \
        --preview-window=down,1,border-none --tmux 40%)
    if [ ! -z ${SELECTED_ACCOUNT} ]; then
        export CLOUDSDK_CORE_ACCOUNT="${SELECTED_ACCOUNT}"
        export XX_CLOUDSDK_ACTIVE="true"
    fi
}

function azx() {
    # xx ;azure:Activate Azure Subscription globally@FALSE
    local SELECTED_SUBSCRIPTION=$(__construct_azure_accounts | fzf --exact --ansi --header-lines=1 --info=inline \
        --bind='ctrl-u:execute-silent(__unset_azure_account)+reload(__construct_azure_accounts)' --prompt="Filter " \
        --bind='ctrl-r:reload(__construct_azure_accounts)' --prompt="Filter " \
        --layout=reverse-list \
        --border-label ' Azure Subscriptions ' --color 'border:#74c7ec,label:#74c7ec,header:#74c7ec:bold,preview-fg:#74c7ec' \
        --preview="echo 'Ctrl-R: Reload List  | Ctrl+U: Unset Active Subscription | Enter: Activate Subscription'" \
        --delimiter="[[:space:]][[:space:]]+" --accept-nth 2 \
        --preview-window=down,1,border-none)
    if [ ! -z ${SELECTED_SUBSCRIPTION} ]; then
        az account set --subscription "${SELECTED_SUBSCRIPTION}"
    fi
}
