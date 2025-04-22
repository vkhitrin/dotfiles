local default_model = vim.loop.os_uname().sysname == "Darwin" and "gemma3:27b-it-qat" or "gemma3:12b-it-qat"

require("minuet").setup({
    provider = "openai_compatible",
    n_completions = 1, -- recommend for local model for resource saving
    -- I recommend beginning with a small context window size and incrementally
    -- expanding it, depending on your local computing power. A context window
    -- of 512, serves as an good starting point to estimate your computing
    -- power. Once you have a reliable estimate of your local computing power,
    -- you should adjust the context window to a larger value.
    context_window = 512,
    provider_options = {
        openai_compatible = {
            api_key = "TERM",
            name = "Ollama",
            end_point = "http://localhost:11434/v1/chat/completions",
            stream = true,
            model = default_model,
            optional = {
                max_tokens = 56,
                top_p = 0.9,
            },
        },
    },
})
