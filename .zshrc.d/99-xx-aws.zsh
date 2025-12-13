which aws > /dev/null 2>&1 || return
which aws-vault > /dev/null 2>&1 || return

function awsx() {
    # xx {"tags": "aws", "description": "Activate AWS profile for shell", "subshell": true, "cache": true}
    local BIND_OPTIONS=()
    local TEXT_PROMPT="CTRL-O: Open SSO URL | CTRL-L: Login | CTRL-D: Clear Session"
    BIND_OPTIONS+="--bind=ctrl-o:execute-silent(source ~/.zshrc.d/xx_functions/__xx_open_aws_sso_url; ${XX_OPEN_COMMAND} \$(__xx_open_aws_sso_url {1}))"
    BIND_OPTIONS+="--bind=ctrl-l:execute-silent(aws-vault login {1} -s)+reload(source ~/.zshrc.d/xx_functions/__xx_construct_aws_profiles_mapping;__xx_construct_aws_profiles_mapping)"
    BIND_OPTIONS+="--bind=ctrl-d:execute-silent(aws-vault clear {1})+reload(source ~/.zshrc.d/xx_functions/__xx_construct_aws_profiles_mapping;__xx_construct_aws_profiles_mapping)"
    if [[ ! -n ${XX_CALLBACK_FROM_TMUX} ]]; then
        BIND_OPTIONS+="--bind=enter:become(aws-vault exec {1})"
        TEXT_PROMPT+=" | ENTER: Enter Session"
    else
        BIND_OPTIONS+="--bind=start:unbind(enter)"
    fi
    __xx_construct_aws_profiles_mapping | fzf --exact --ansi --header-lines=1 --info=inline \
        --prompt="> Filter " \
        --layout=reverse-list \
        --border-label ' AWS Accounts ' --color 'border:#f9e2af,label:#f9e2af,header:#f9e2af:bold,header:#f9e2af' \
        --header "${TEXT_PROMPT}" --tmux 60% \
        ${BIND_OPTIONS[@]}
}

function awsrx() {
    # xx {"tags": "aws", "description": "Change AWS region for active AWS vault in shell", "subshell": true, "cache": false}
    local BIND_OPTIONS=()
    local TEXT_PROMPT=""
    if [[ ! -n ${XX_CALLBACK_FROM_TMUX} ]]; then
        BIND_OPTIONS+="--bind=enter:become(echo {})"
        TEXT_PROMPT+="ENTER: Pick Region"
    else
        BIND_OPTIONS+="--bind=start:unbind(enter)"
    fi
    local SELECTED_REGION=$(__xx_construct_aws_regions_for_account | fzf --exact --ansi --header-lines=1 --info=inline \
        --prompt="> Filter " \
        --layout=reverse-list \
        --border-label ' Enabled Regions For AWS Account ' --color 'border:#f9e2af,label:#f9e2af,header:#f9e2af:bold,header:#f9e2af' \
        --header "${TEXT_PROMPT}" --tmux 40% \
        ${BIND_OPTIONS[@]}
    )
    if [ ! -z ${SELECTED_REGION} ]; then
        export AWS_REGION="${SELECTED_REGION}"
    fi
}

function awsssmx() {
    # xx {"tags": "aws", "description": "Fetch AWS Parameter Store entry value", "subshell": true, "cache": true}
    local BIND_OPTIONS=()
    local TEXT_PROMPT="CTRL-Y: Copy Value | CTRL-V: Copy Decrypted Value | CTRL-P: Toggle Preview | CTRL-R: Refresh Cache"
    BIND_OPTIONS+="--bind=ctrl-y:execute-silent(aws ssm get-parameter --name {1} --query 'Parameter.Value' --output text | tr -d '\n' | pbcopy)+abort"
    BIND_OPTIONS+="--bind=ctrl-v:execute-silent(aws ssm get-parameter --name {1} --with-decryption --query 'Parameter.Value' --output text | tr -d '\n' | pbcopy)+abort"
    BIND_OPTIONS+="--bind=ctrl-p:toggle-preview"
    BIND_OPTIONS+="--bind=ctrl-r:reload(source ~/.zshrc.d/xx_functions/__xx_cache_aws_parameter_store_to_sqlite; __xx_cache_aws_parameter_store_to_sqlite > /dev/null 2>&1; source ~/.zshrc.d/xx_functions/__xx_get_aws_parameter_store_entries; __xx_get_aws_parameter_store_entries)"
    BIND_OPTIONS+="--bind=start:unbind(enter)"
    __xx_get_aws_parameter_store_entries | fzf --exact --ansi --header-lines=2 --info=inline \
        --prompt="> Filter " \
        --layout=reverse-list \
        --border-label ' AWS Parameter Store Entries ' --color 'border:#f9e2af,label:#f9e2af,header:#f9e2af:bold,header:#f9e2af' \
        --header "${TEXT_PROMPT}" --tmux 70% \
        --preview "source ~/.zshrc.d/xx_functions/__xx_preview_aws_parameter_store_entry; __xx_preview_aws_parameter_store_entry {1}" \
        --preview-window=right:50%:wrap:hidden \
        ${BIND_OPTIONS[@]}
}

function awssecretsx() {
    # xx {"tags": "aws", "description": "Fetch AWS Secrets Manager secret value", "subshell": true, "cache": true}
    local BIND_OPTIONS=()
    local TEXT_PROMPT="CTRL-Y: Copy Secret Value | CTRL-P: Toggle Preview | CTRL-R: Refresh Cache"
    BIND_OPTIONS+="--bind=ctrl-y:execute-silent(aws secretsmanager get-secret-value --secret-id {1} --query 'SecretString' --output text | tr -d '\n' | pbcopy)+abort"
    BIND_OPTIONS+="--bind=ctrl-p:toggle-preview"
    BIND_OPTIONS+="--bind=ctrl-r:reload(source ~/.zshrc.d/xx_functions/__xx_cache_aws_secrets_manager_to_sqlite; __xx_cache_aws_secrets_manager_to_sqlite > /dev/null 2>&1; source ~/.zshrc.d/xx_functions/__xx_get_aws_secrets_manager_entries; __xx_get_aws_secrets_manager_entries)"
    BIND_OPTIONS+="--bind=start:unbind(enter)"
    __xx_get_aws_secrets_manager_entries | fzf --exact --ansi --header-lines=2 --info=inline \
        --prompt="> Filter " \
        --layout=reverse-list \
        --border-label ' AWS Secrets Manager Entries ' --color 'border:#f9e2af,label:#f9e2af,header:#f9e2af:bold,header:#f9e2af' \
        --header "${TEXT_PROMPT}" --tmux 70% \
        --preview "source ~/.zshrc.d/xx_functions/__xx_preview_aws_secrets_manager_entry; __xx_preview_aws_secrets_manager_entry {1}" \
        --preview-window=right:50%:wrap:hidden \
        ${BIND_OPTIONS[@]}
}

function awsec2x() {
    # xx {"tags": "aws", "description": "View AWS EC2 instances and security groups", "subshell": true, "cache": true}
    local INSTANCES_PROMPT="CTRL-I: Copy Instance ID | CTRL-Y: Copy Private IP | CTRL-U: Copy Public IP | CTRL-P: Toggle Preview | CTRL-R: Refresh Cache | CTRL-S: Security Groups"
    local SG_PROMPT="CTRL-G: Copy Group ID | CTRL-V: Copy VPC ID | CTRL-P: Toggle Preview | CTRL-R: Refresh Cache | CTRL-B: Back to Instances"

    __xx_get_aws_ec2_instances | fzf --exact --ansi --header-lines=2 --info=inline \
        --prompt="> Filter " \
        --layout=reverse-list \
        --border-label ' AWS EC2 Instances ' --color 'border:#f9e2af,label:#f9e2af,header:#f9e2af:bold,header:#f9e2af' \
        --header "${INSTANCES_PROMPT}" --tmux 80% \
        --preview "source ~/.zshrc.d/xx_functions/__xx_preview_aws_ec2_instance; __xx_preview_aws_ec2_instance {1}" \
        --preview-window=right:50%:wrap:hidden \
        --bind="ctrl-i:execute-silent(echo {1} | tr -d '\n' | pbcopy)" \
        --bind="ctrl-y:execute-silent(echo {5} | tr -d '\n' | pbcopy)" \
        --bind="ctrl-u:execute-silent(echo {6} | tr -d '\n' | pbcopy)" \
        --bind="ctrl-p:toggle-preview" \
        --bind="start:unbind(enter,ctrl-g,ctrl-v,ctrl-b)" \
        --bind="ctrl-r:execute-silent(source ~/.zshrc.d/xx_functions/__xx_cache_aws_ec2_to_sqlite; __xx_cache_aws_ec2_to_sqlite > /dev/null 2>&1)" \
        --bind='ctrl-s:'\
'transform-border-label(echo " AWS EC2 Security Groups ")'\
'+reload(source ~/.zshrc.d/xx_functions/__xx_get_aws_ec2_security_groups_cached; __xx_get_aws_ec2_security_groups_cached)'\
"+change-header(${SG_PROMPT})+unbind(ctrl-i,ctrl-y,ctrl-u,ctrl-s)+rebind(ctrl-g,ctrl-v,ctrl-b)"\
"+transform-query(echo '')"\
"+change-preview(source ~/.zshrc.d/xx_functions/__xx_preview_aws_ec2_security_group; __xx_preview_aws_ec2_security_group {1})"\
        --bind='ctrl-b:'\
'transform-border-label(echo " AWS EC2 Instances ")'\
'+reload(source ~/.zshrc.d/xx_functions/__xx_get_aws_ec2_instances;__xx_get_aws_ec2_instances)'\
"+change-header(${INSTANCES_PROMPT})+unbind(ctrl-g,ctrl-v,ctrl-b)+rebind(ctrl-i,ctrl-y,ctrl-u,ctrl-s)"\
"+transform-query(echo '')"\
"+change-preview(source ~/.zshrc.d/xx_functions/__xx_preview_aws_ec2_instance; __xx_preview_aws_ec2_instance {1})"\
        --bind='ctrl-g:execute-silent(echo {1} | tr -d '\n' | pbcopy)'\
        --bind='ctrl-v:execute-silent(echo {4} | tr -d '\n' | pbcopy)'
}

function awsrdsx() {
    # xx {"tags": "aws", "description": "View AWS RDS instances", "subshell": true, "cache": true}
    local BIND_OPTIONS=()
    local TEXT_PROMPT="CTRL-I: Copy DB Identifier | CTRL-E: Copy Endpoint | CTRL-P: Toggle Preview | CTRL-R: Refresh Cache"
    BIND_OPTIONS+="--bind=ctrl-i:execute-silent(echo {1} | tr -d '\n' | pbcopy)+abort"
    BIND_OPTIONS+="--bind=ctrl-e:execute-silent(echo {6} | tr -d '\n' | pbcopy)+abort"
    BIND_OPTIONS+="--bind=ctrl-p:toggle-preview"
    BIND_OPTIONS+="--bind=ctrl-r:reload(source ~/.zshrc.d/xx_functions/__xx_cache_aws_rds_instances_to_sqlite; __xx_cache_aws_rds_instances_to_sqlite > /dev/null 2>&1; source ~/.zshrc.d/xx_functions/__xx_get_aws_rds_instances; __xx_get_aws_rds_instances)"
    BIND_OPTIONS+="--bind=start:unbind(enter)"
    __xx_get_aws_rds_instances | fzf --exact --ansi --header-lines=2 --info=inline \
        --prompt="> Filter " \
        --layout=reverse-list \
        --border-label ' AWS RDS Instances ' --color 'border:#f9e2af,label:#f9e2af,header:#f9e2af:bold,header:#f9e2af' \
        --header "${TEXT_PROMPT}" --tmux 80% \
        --preview "source ~/.zshrc.d/xx_functions/__xx_preview_aws_rds_instance; __xx_preview_aws_rds_instance {1}" \
        --preview-window=right:50%:wrap:hidden \
        ${BIND_OPTIONS[@]}
}

function awselasticachex() {
    # xx {"tags": "aws", "description": "View AWS ElastiCache clusters", "subshell": true, "cache": true}
    local BIND_OPTIONS=()
    local TEXT_PROMPT="CTRL-I: Copy Cluster ID | CTRL-P: Toggle Preview | CTRL-R: Refresh Cache"
    BIND_OPTIONS+="--bind=ctrl-i:execute-silent(echo {1} | tr -d '\n' | pbcopy)+abort"
    BIND_OPTIONS+="--bind=ctrl-p:toggle-preview"
    BIND_OPTIONS+="--bind=ctrl-r:reload(source ~/.zshrc.d/xx_functions/__xx_cache_aws_elasticache_clusters_to_sqlite; __xx_cache_aws_elasticache_clusters_to_sqlite > /dev/null 2>&1; source ~/.zshrc.d/xx_functions/__xx_get_aws_elasticache_clusters; __xx_get_aws_elasticache_clusters)"
    BIND_OPTIONS+="--bind=start:unbind(enter)"
    __xx_get_aws_elasticache_clusters | fzf --exact --ansi --header-lines=2 --info=inline \
        --prompt="> Filter " \
        --layout=reverse-list \
        --border-label ' AWS ElastiCache Clusters ' --color 'border:#f9e2af,label:#f9e2af,header:#f9e2af:bold,header:#f9e2af' \
        --header "${TEXT_PROMPT}" --tmux 80% \
        --preview "source ~/.zshrc.d/xx_functions/__xx_preview_aws_elasticache_cluster; __xx_preview_aws_elasticache_cluster {1}" \
        --preview-window=right:50%:wrap:hidden \
        ${BIND_OPTIONS[@]}
}

function awsacmx() {
    # xx {"tags": "aws", "description": "View AWS ACM certificates", "subshell": true, "cache": true}
    local BIND_OPTIONS=()
    local TEXT_PROMPT="CTRL-A: Copy ARN | CTRL-D: Copy Domain Name | CTRL-P: Toggle Preview | CTRL-R: Refresh Cache"
    BIND_OPTIONS+="--bind=ctrl-a:execute-silent(echo {5} | tr -d '\n' | pbcopy)+abort"
    BIND_OPTIONS+="--bind=ctrl-d:execute-silent(echo {1} | tr -d '\n' | pbcopy)+abort"
    BIND_OPTIONS+="--bind=ctrl-p:toggle-preview"
    BIND_OPTIONS+="--bind=ctrl-r:reload(source ~/.zshrc.d/xx_functions/__xx_cache_aws_acm_certificates_to_sqlite; __xx_cache_aws_acm_certificates_to_sqlite > /dev/null 2>&1; source ~/.zshrc.d/xx_functions/__xx_get_aws_acm_certificates; __xx_get_aws_acm_certificates)"
    BIND_OPTIONS+="--bind=start:unbind(enter)"
    __xx_get_aws_acm_certificates | fzf --exact --ansi --header-lines=2 --info=inline \
        --prompt="> Filter " \
        --layout=reverse-list \
        --border-label ' AWS ACM Certificates ' --color 'border:#f9e2af,label:#f9e2af,header:#f9e2af:bold,header:#f9e2af' \
        --header "${TEXT_PROMPT}" --tmux 80% \
        --preview "source ~/.zshrc.d/xx_functions/__xx_preview_aws_acm_certificate; __xx_preview_aws_acm_certificate {5}" \
        --preview-window=right:50%:wrap:hidden \
        ${BIND_OPTIONS[@]}
}

function awsroute53x() {
    # xx {"tags": "aws", "description": "View AWS Route53 hosted zones", "subshell": true, "cache": true}
    local RECORDS_PROMPT="CTRL-N: Copy Record Name | CTRL-V: Copy Record Value | CTRL-P: Toggle Preview"

    __xx_get_aws_route53_hosted_zones | fzf --exact --ansi --header-lines=2 --info=inline \
        --prompt="> Filter " \
        --layout=reverse-list \
        --border-label ' AWS Route53 Hosted Zones ' --color 'border:#f9e2af,label:#f9e2af,header:#f9e2af:bold,header:#f9e2af' \
        --header "CTRL-I: Copy Zone ID | CTRL-D: Copy Domain Name | CTRL-P: Toggle Preview | CTRL-R: Refresh Cache | ENTER: View Records" --tmux 80% \
        --preview "source ~/.zshrc.d/xx_functions/__xx_preview_aws_route53_hosted_zone; __xx_preview_aws_route53_hosted_zone {1}" \
        --preview-window=right:50%:wrap:hidden \
        --bind="ctrl-i:execute-silent(echo {1} | tr -d '\n' | pbcopy)" \
        --bind="ctrl-d:execute-silent(echo {2} | tr -d '\n' | pbcopy)" \
        --bind="ctrl-p:toggle-preview" \
        --bind="ctrl-r:reload(source ~/.zshrc.d/xx_functions/__xx_cache_aws_route53_hosted_zones_to_sqlite; __xx_cache_aws_route53_hosted_zones_to_sqlite > /dev/null 2>&1; source ~/.zshrc.d/xx_functions/__xx_get_aws_route53_hosted_zones; __xx_get_aws_route53_hosted_zones)" \
        --bind='enter:'\
'transform-border-label(printf " %s DNS Records " {2})'\
'+reload(source ~/.zshrc.d/xx_functions/__xx_get_aws_route53_records;__xx_get_aws_route53_records {1} {2})'\
"+change-header(${RECORDS_PROMPT})+unbind(ctrl-i,ctrl-d,ctrl-r,enter)"\
"+transform-query(echo '')"\
"+change-preview(source ~/.zshrc.d/xx_functions/__xx_preview_aws_route53_record; __xx_preview_aws_route53_record {1} {2} {3})"\
"+rebind(ctrl-p)"\
        --bind="ctrl-n:execute-silent(echo {2} | tr -d '\n' | pbcopy)"\
        --bind="ctrl-v:execute-silent(echo {4} | tr -d '\n' | pbcopy)"
}

function awsvpcx() {
    # xx {"tags": "aws", "description": "View AWS VPCs", "subshell": true, "cache": true}
    local SUBNETS_PROMPT="CTRL-S: Copy Subnet ID | CTRL-V: Copy CIDR Block"

    __xx_get_aws_vpcs | fzf --exact --ansi --header-lines=2 --info=inline \
        --prompt="> Filter " \
        --layout=reverse-list \
        --border-label ' AWS VPCs ' --color 'border:#f9e2af,label:#f9e2af,header:#f9e2af:bold,header:#f9e2af' \
        --header "CTRL-I: Copy VPC ID | CTRL-V: Copy CIDR Block | CTRL-P: Toggle Preview | CTRL-R: Refresh Cache | ENTER: View Subnets" --tmux 80% \
        --preview "source ~/.zshrc.d/xx_functions/__xx_preview_aws_vpc; __xx_preview_aws_vpc {1}" \
        --preview-window=right:50%:wrap:hidden \
        --bind="ctrl-i:execute-silent(echo {1} | tr -d '\n' | pbcopy)" \
        --bind="ctrl-v:execute-silent(echo {3} | tr -d '\n' | pbcopy)" \
        --bind="ctrl-p:toggle-preview" \
        --bind="ctrl-r:reload(source ~/.zshrc.d/xx_functions/__xx_cache_aws_vpcs_to_sqlite; __xx_cache_aws_vpcs_to_sqlite > /dev/null 2>&1; source ~/.zshrc.d/xx_functions/__xx_get_aws_vpcs; __xx_get_aws_vpcs)" \
        --bind='enter:'\
'transform-border-label(printf " %s Subnets " {2})'\
'+reload(source ~/.zshrc.d/xx_functions/__xx_get_aws_vpc_subnets;__xx_get_aws_vpc_subnets {1} {2})'\
"+change-header(${SUBNETS_PROMPT})+unbind(ctrl-i,ctrl-v,ctrl-r,ctrl-p,enter)"\
"+transform-query(echo '')"\
        --bind="ctrl-s:execute-silent(echo {1} | tr -d '\n' | pbcopy)"\
        --bind="ctrl-v:execute-silent(echo {4} | tr -d '\n' | pbcopy)"
}

function awsiamx() {
    # xx {"tags": "aws", "description": "View AWS IAM roles and policies", "subshell": true, "cache": true}
    local ROLES_PROMPT="CTRL-N: Copy Role Name | CTRL-A: Copy Role ARN | CTRL-P: Toggle Preview | CTRL-R: Refresh Cache | CTRL-O: View Policies"
    local POLICIES_PROMPT="CTRL-N: Copy Policy Name | CTRL-A: Copy Policy ARN | CTRL-P: Toggle Preview | CTRL-R: Refresh Cache | CTRL-B: Back to Roles"

    __xx_get_aws_iam_roles | fzf --exact --ansi --header-lines=2 --info=inline \
        --prompt="> Filter " \
        --layout=reverse-list \
        --border-label ' AWS IAM Roles ' --color 'border:#f9e2af,label:#f9e2af,header:#f9e2af:bold,header:#f9e2af' \
        --header "${ROLES_PROMPT}" --tmux 80% \
        --preview "source ~/.zshrc.d/xx_functions/__xx_preview_aws_iam_role; __xx_preview_aws_iam_role {1}" \
        --preview-window=right:50%:wrap:hidden \
        --bind="ctrl-n:execute-silent(echo {1} | tr -d '\n' | pbcopy)" \
        --bind="ctrl-a:execute-silent(echo {4} | tr -d '\n' | pbcopy)" \
        --bind="ctrl-p:toggle-preview" \
        --bind="start:unbind(enter,ctrl-b)" \
        --bind='ctrl-r:reload(source ~/.zshrc.d/xx_functions/__xx_cache_aws_iam_to_sqlite; __xx_cache_aws_iam_to_sqlite > /dev/null 2>&1; source ~/.zshrc.d/xx_functions/__xx_get_aws_iam_roles; __xx_get_aws_iam_roles)'\
        --bind='ctrl-o:'\
'transform-border-label(echo " AWS IAM Policies ")'\
'+reload(source ~/.zshrc.d/xx_functions/__xx_get_aws_iam_policies_cached; __xx_get_aws_iam_policies_cached)'\
"+change-header(${POLICIES_PROMPT})+unbind(ctrl-o)+rebind(ctrl-b)"\
"+transform-query(echo '')"\
"+change-preview(source ~/.zshrc.d/xx_functions/__xx_preview_aws_iam_policy; __xx_preview_aws_iam_policy {3})"\
        --bind='ctrl-b:'\
'transform-border-label(echo " AWS IAM Roles ")'\
'+reload(source ~/.zshrc.d/xx_functions/__xx_get_aws_iam_roles;__xx_get_aws_iam_roles)'\
"+change-header(${ROLES_PROMPT})+unbind(ctrl-b)+rebind(ctrl-o)"\
"+transform-query(echo '')"\
"+change-preview(source ~/.zshrc.d/xx_functions/__xx_preview_aws_iam_role; __xx_preview_aws_iam_role {1})"\
}
