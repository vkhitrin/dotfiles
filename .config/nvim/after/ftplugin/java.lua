local config = {
	cmd = {
		"jdtls",
		"--java-executable",
		"/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home/bin/java",
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
						name = "JavaSE-21",
						path = "/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home",
						default = true,
					},
					{
						name = "JavaSE-25",
						path = "/Library/Java/JavaVirtualMachines/temurin-25.jdk/Contents/Home",
					},
				},
			},
		},
	},
}
vim.lsp.config("jdtls", config)
