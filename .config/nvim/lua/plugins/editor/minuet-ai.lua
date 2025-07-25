local default_model = vim.loop.os_uname().sysname == "Darwin" and "mlx-community/Mistral-Small-24B-Instruct-2501-3bit"
    or "gemma3:12b-it-qat"
local default_endpoint = vim.loop.os_uname().sysname == "Darwin" and "http://localhost:28100/v1/chat/completions"
    or "http://localhost:11434/v1/chat/completions"

require("minuet").setup({
    -- NOTE: For local models
    -- provider = "openai_compatible",
    -- n_completions = 1,
    -- context_window = 512,
    provider = "gemini",
    provider_options = {
        openai_compatible = {
            api_key = "TERM",
            name = "Ollama",
            end_point = default_endpoint,
            stream = true,
            model = default_model,
            optional = {
                max_tokens = 56,
                top_p = 0.9,
            },
        },
        gemini = {
            model = "gemini-2.0-flash",
            api_key = function()
                local stdout = vim.fn.system("security find-generic-password -ga 'gemini' -w")
                return vim.trim(stdout)
            end,
            optional = {
                generationConfig = {
                    maxOutputTokens = 256,
                    thinkingConfig = {
                        thinkingBudget = 0,
                    },
                },
                safetySettings = {
                    {
                        category = "HARM_CATEGORY_DANGEROUS_CONTENT",
                        threshold = "BLOCK_ONLY_HIGH",
                    },
                },
            },
        },
    },
})
