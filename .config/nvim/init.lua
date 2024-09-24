vim.cmd("set relativenumber")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set expandtab")
require("config.lazy")

-- Bindings will be there:
-- Window switcher
vim.cmd("nnoremap t <C-w>w")
vim.cmd("nnoremap vs :vsplit<CR>")
vim.cmd("nnoremap rc <C-w>c")
vim.cmd("")
