-- Set tab for 4 spaces
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

-- lvim.builtin.which_key.mappings["l"] = {
--   f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },

--               vim.lsp.buf.format {
--                 filter = function(client) return client.name ~= "tsserver" end
--               }

local mappings = {
  C = {
    name = "PHP",
    f = {
      '<cmd>lua vim.lsp.buf.format{filter = function(client) return client.name ~= "intelephense" end}<cr>',
      "Format",
    },
  },
}

------------------------
-- Diagnostics
------------------------
------------------------
-- Formatting
------------------------
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "phpcsfixer",
    filetypes = { "php" },
    args = { "--config=/home/andrenewton/.config/lvim/ftplugin/php-cs-fixer.php" },
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
local dap = require "dap"
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
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

which_key.register(mappings, opts)
