---------------
--BASE CONFIG--
---------------

--BASE OPTIONS--

vim.opt.number = true
vim.opt.rnu = true
vim.opt.scrolloff = 10
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.cursorline = true
vim.opt.guicursor = "i-ci-ve:block"

--BASE KEYBINDS--

vim.g.mapleader = " "
vim.keymap.set({"n", "v"}, ";", ":")
vim.keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-N>")

--TREESITTER--

vim.api.nvim_create_autocmd( 'BufEnter', {
	pattern = {"*.lua", "*.py", "*.c", "*.h", "*.cpp", "*.hpp", "*.md", "README", "*.vert", "*.frag", "Makefile", "Makefile"},
    callback = function()
        pcall(vim.treesitter.start)
    end
})

--------------
--LSP CONFIG--
--------------

vim.lsp.config('*', {root_markers = {'.git'}})

vim.lsp.config("ruff", {cmd = {"ruff", "server"}, filetypes = {"python"}})
vim.lsp.config("basedpyright", {
	cmd = {"basedpyright-langserver", "--stdio"},
	filetypes = {"python"},
	settings = {
		basedpyright = {
			disableOrganizeImports = true,
			typeCheckingMode = "strict",
			analysis = {
				ignore = "{*}"
			}
		}
	}
})

vim.lsp.config("clangd", {cmd = {"clangd"}, filetypes = {"c", "h", "cpp", "hpp"}})

vim.lsp.config("glsl_analyzer", {cmd = {"glsl_analyzer"}, filetypes = { "glsl", "vert", "tesc", "tese", "frag", "geom", "comp" }})

vim.lsp.enable("ruff")
vim.lsp.enable("basedpyright")
vim.lsp.enable("clangd")
vim.lsp.enable("glsl_analyzer")

vim.diagnostic.config({ virtual_text= true })

------------
--PACKAGES--
------------

vim.pack.add({
	  "https://github.com/nvim-lualine/lualine.nvim",
	  "https://github.com/rose-pine/neovim",
	  "https://github.com/nvim-treesitter/nvim-treesitter",
	  "https://github.com/nvim-mini/mini.nvim",
	  "https://github.com/rafamadriz/friendly-snippets",
	  "https://github.com/lukas-reineke/indent-blankline.nvim",
    })

require("rose-pine").setup({ styles = { transparency = true }})
require("lualine").setup()
require("ibl").setup()

require("mini.tabline").setup()
require("mini.animate").setup()
require("mini.starter").setup()
require("mini.map").setup()
require("mini.icons").setup()
require("mini.pick").setup()
require("mini.diff").setup()
require("mini.pairs").setup()
require("mini.completion").setup()
require("mini.surround").setup()
require("mini.indentscope").setup()
require("mini.git").setup()
require("mini.files").setup({
	-- Customization of explorer windows
	windows = {
		-- Whether to show preview of file/directory under cursor
		preview = true,
		-- Width of preview window
		width_preview = 80
	}
})
local gen_loader = require('mini.snippets').gen_loader
require('mini.snippets').setup({
  snippets = {
    -- Load custom file with global snippets first (adjust for Windows)
    gen_loader.from_file('~/.config/nvim/snippets/global.json'),

    -- Load snippets based on current language by reading files from
    -- "snippets/" subdirectories from 'runtimepath' directories.
    gen_loader.from_lang(),
  },
})
MiniSnippets.start_lsp_server({ match = false })

--PACKAGE KEYBINDS--

vim.keymap.set("n", "<leader>f", MiniFiles.open)
vim.keymap.set("n", "<leader>m", MiniMap.toggle)
vim.keymap.set("n", "<leader>d", function() pcall(MiniDiff.toggle_overlay) end)
vim.keymap.set("n", "<leader>s", MiniStarter.open)
vim.keymap.set("n", "<leader>p", MiniPick.builtin.files)
vim.keymap.set("n", "<leader>g", MiniPick.builtin.grep_live)

pcall(require, "extra")
