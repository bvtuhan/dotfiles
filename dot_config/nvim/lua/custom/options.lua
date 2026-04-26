vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = false

vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

-- UI
vim.o.background = "dark"
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.showmode = false
vim.o.showmatch = true
vim.o.termguicolors = true
vim.o.mouse = "a"
vim.o.signcolumn = "yes"
vim.o.wrap = true
vim.o.scrolloff = 10
vim.o.confirm = true

-- Shell
vim.o.shell = "/bin/bash"

-- Indentation / tabs
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true

-- Completion behavior
vim.o.completeopt = "menuone,noinsert,noselect"

-- Undo
vim.o.undofile = true

-- Timing
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Splits
vim.o.splitright = true
vim.o.splitbelow = true

-- Whitespace display
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live
vim.o.inccommand = "split"

-- Cursor shape
vim.o.guicursor = "n-v-c-i:block"

-- Spellchecking
vim.o.spell = true
vim.o.spelllang = "en_us"

-- Autosave
vim.o.autowrite = true

-- Better wrapped-line indentation
vim.o.breakindent = true
