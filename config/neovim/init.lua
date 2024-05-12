vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")

local plugins = {
   {"catppuccin/nvim", name = "catpuccin", priority = 1000} 
}
local options = {}

require("lazy").setup(plugins, options)

require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"