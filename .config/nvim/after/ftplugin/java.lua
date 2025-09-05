local config = {
	cmd = {
		"jdtls",
		"--java-executable",
		"/Library/Java/JavaVirtualMachines/temurin-24.jdk/Contents/Home/bin/java",
		"--jvm-arg="
			.. string.format("-javaagent:%s", vim.fn.expand("$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar")),
	},
	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
	settings = {
		java = {
			configuration = {
				runtimes = {
					{
						name = "JavaSE-17",
						path = "/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home",
						default = true,
					},
					{
						name = "JavaSE-24",
						path = "/Library/Java/JavaVirtualMachines/temurin-24.jdk/Contents/Home",
					},
				},
			},
		},
	},
}
-- require("lspconfig").jdtls.setup({ config })
vim.lsp.config("jdtls", config)
