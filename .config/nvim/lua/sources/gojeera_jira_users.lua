local source = {}

local CACHE_TTL_MS = 30000
local CURL_COMMAND = [[
curl --silent --show-error --fail --get \
  --header 'Accept: application/json' \
  --user "$GOJEERA_JIRA_USERNAME:$GOJEERA_JIRA_TOKEN" \
  --data-urlencode "query=$GOJEERA_JIRA_QUERY" \
  --data "maxResults=$GOJEERA_JIRA_MAX_RESULTS" \
  --data "showAvatar=false" \
  "$GOJEERA_JIRA_BASE_URL/rest/api/2/user/picker"
]]

local function trim(value)
	return (value:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function unquote(value)
	if #value >= 2 then
		local first = value:sub(1, 1)
		local last = value:sub(-1)
		if (first == '"' and last == '"') or (first == "'" and last == "'") then
			return value:sub(2, -2)
		end
	end
	return value
end

local function get_gojeera_config_file()
	local env_path = vim.env.GOJEERA_CONFIG_FILE
	if env_path and env_path ~= "" then
		return env_path
	end
	return (vim.env.HOME or vim.fn.expand("~")) .. "/.config/gojeera/config.yaml"
end

local function read_gojeera_config()
	local config_path = get_gojeera_config_file()
	if vim.fn.filereadable(config_path) == 0 then
		return {}
	end
	local lines = vim.fn.readfile(config_path)

	local jira = {}
	local in_jira_block = false

	for _, raw_line in ipairs(lines) do
		local line = raw_line:gsub("%s+#.*$", "")
		if line:match("^jira:%s*$") then
			in_jira_block = true
		elseif in_jira_block and line:match("^[^%s]") then
			break
		elseif in_jira_block then
			local key, value = line:match("^%s+([%w_]+):%s*(.-)%s*$")
			if key and value and value ~= "" then
				jira[key] = unquote(trim(value))
			end
		end
	end

	return jira
end

local function get_jira_credentials()
	local config = read_gojeera_config()
	local username = vim.env.GOJEERA_JIRA__API_USERNAME or config.api_username
	local token = vim.env.GOJEERA_JIRA__API_TOKEN or config.api_token
	local base_url = vim.env.GOJEERA_JIRA__API_BASE_URL or config.api_base_url

	if not username or username == "" or not token or token == "" or not base_url or base_url == "" then
		return nil
	end

	base_url = base_url:gsub("/+$", "")

	return {
		username = username,
		token = token,
		base_url = base_url,
	}
end

local function get_mention_context(ctx)
	local line = ctx.get_line()
	local before_cursor = line:sub(1, ctx.cursor[2])
	local start_col, query = before_cursor:match("()%[@([^%]]*)$")
	if start_col then
		return {
			query = query,
			start_col = start_col,
			end_col = ctx.cursor[2],
		}
	end

	start_col, query = before_cursor:match("()%@([%w%._%-]*)$")
	if not start_col then
		return nil
	end

	return {
		query = query,
		start_col = start_col,
		end_col = ctx.cursor[2],
	}
end

local function escape_markdown_link_text(text)
	return text:gsub("%]", "\\]")
end

local function build_completion_items(users, mention_ctx, base_url, line_number)
	local kind = require("blink.cmp.types").CompletionItemKind.Reference
	local plain_text = vim.lsp.protocol.InsertTextFormat.PlainText
	local items = {}

	for index, user in ipairs(users) do
		local display_name = user.displayName or user.name or user.key
		local account_id = user.accountId

		if display_name and account_id then
			local mention = ("[@%s](%s/jira/people/%s)"):format(
				escape_markdown_link_text(display_name),
				base_url,
				account_id
			)

			items[#items + 1] = {
				label = display_name,
				kind = kind,
				detail = account_id,
				sortText = string.format("%04d", index),
				filterText = display_name,
				insertTextFormat = plain_text,
				textEdit = {
					newText = mention,
					range = {
						start = {
							line = line_number,
							character = mention_ctx.start_col - 1,
						},
						["end"] = {
							line = line_number,
							character = mention_ctx.end_col,
						},
					},
				},
				documentation = {
					kind = "markdown",
					value = ("`%s`\n\nAccount ID: `%s`"):format(display_name, account_id),
				},
			}
		end
	end

	return items
end

local function mention_response(items)
	return {
		items = items,
		is_incomplete_forward = true,
		is_incomplete_backward = true,
	}
end

function source.new(opts)
	local self = setmetatable({}, { __index = source })
	self.opts = vim.tbl_deep_extend("force", {
		max_results = 20,
	}, opts or {})
	self.cache = {}
	return self
end

function source:enabled()
	return vim.bo.filetype == "md.gojeera" and vim.fn.executable("curl") == 1
end

function source:get_trigger_characters()
	return { "@" }
end

function source:get_completions(ctx, callback)
	local credentials = get_jira_credentials()
	local mention_ctx = get_mention_context(ctx)

	if not mention_ctx then
		callback({ items = {}, is_incomplete_forward = false, is_incomplete_backward = false })
		return
	end

	if not credentials then
		callback({ items = {}, is_incomplete_forward = false, is_incomplete_backward = false })
		return
	end

	if mention_ctx.query == "" then
		callback(mention_response({}))
		return
	end

	local cache_key = credentials.base_url .. "\0" .. mention_ctx.query
	local cached = self.cache[cache_key]
	local now = vim.uv.now()
	if cached and now - cached.timestamp < CACHE_TTL_MS then
		callback(mention_response(vim.deepcopy(cached.items)))
		return
	end

	local handle = vim.system(
		{ "sh", "-c", CURL_COMMAND },
		{
			text = true,
			env = {
				GOJEERA_JIRA_BASE_URL = credentials.base_url,
				GOJEERA_JIRA_USERNAME = credentials.username,
				GOJEERA_JIRA_TOKEN = credentials.token,
				GOJEERA_JIRA_QUERY = mention_ctx.query,
				GOJEERA_JIRA_MAX_RESULTS = tostring(self.opts.max_results),
			},
		},
		vim.schedule_wrap(function(result)
			if result.code ~= 0 or not result.stdout or result.stdout == "" then
				callback(mention_response({}))
				return
			end

			local ok, payload = pcall(vim.json.decode, result.stdout)
			if not ok or type(payload) ~= "table" then
				callback(mention_response({}))
				return
			end

			local items = build_completion_items(payload.users or {}, mention_ctx, credentials.base_url, ctx.cursor[1] - 1)
			self.cache[cache_key] = {
				timestamp = now,
				items = vim.deepcopy(items),
			}

			callback(mention_response(items))
		end)
	)

	return function()
		if handle and handle.kill then
			pcall(handle.kill, handle, 15)
		end
	end
end

return source
