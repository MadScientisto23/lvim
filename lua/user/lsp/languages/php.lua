------------------------
-- Diagnostics
------------------------
------------------------
-- Formatting
------------------------
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "phpcsfixer",
    filetypes = { "php" },
    args = { "--config=/home/andrenewton/.config/lvim/lua/user/lsp/languages/php-cs-fixer.php"}
  },
}

------------------------
-- Linting
------------------------
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "phpcs", filetypes = { "php" }, args = { "--tab-width=4", "--standard=PSR12" } },
}

------------------------
-- DAP
------------------------
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#PHP
local dap = require("dap")
local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
dap.adapters.php = {
	type = "executable",
	command = "node",
	args = { mason_path .. "packages/php-debug-adapter/extension/out/phpDebug.js" },
}
dap.configurations.php = {
  {
    name = "Listen for Xdebug",
		type = "php",
		request = "launch",
		port = 9003,
  },
  {
    name = "Debug currently open script",
		type = "php",
		request = "launch",
		port = 9003,
    cwd = "${fileDirname}",
    program = "${file}",
    runtimeExecutable = "php",
  },
}
