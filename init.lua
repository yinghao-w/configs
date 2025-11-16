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
vim.keymap.set("n", "<leader>=", ":bnext<CR>")
vim.keymap.set("n", "<leader>-", ":bprev<CR>")
vim.keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-N>")
-- vim.keymap.set("t", "<C-W>", "<C-\\><C-N><C-W>")

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
	  "https://github.com/catppuccin/nvim",
	  "https://github.com/rose-pine/neovim",
	  "https://github.com/ellisonleao/gruvbox.nvim",
	  "https://github.com/folke/tokyonight.nvim",
	  "https://github.com/nvim-treesitter/nvim-treesitter",
	  "https://github.com/nvim-mini/mini.nvim",
	  "https://github.com/rafamadriz/friendly-snippets",
    })

require("tokyonight").setup()
require("gruvbox").setup({ transparent_mode = true })
require("rose-pine").setup({ styles = { transparency = true }})
require("catppuccin").setup({ transparent_background = true })
require("catppuccin").setup({ transparent_background = true, styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
            comments = { "italic" }, -- Change the style of comments
            conditionals = { "italic" },
            loops = { "italic" },
            functions = { "italic" },
            keywords = { "italic" },
            strings = { "italic" },
            variables = { "italic" },
            numbers = { "italic" },
            booleans = { "italic" },
            properties = { "italic" },
            types = { "italic" },
            operators = { "italic" },
            -- miscs = { "italic" }, -- Uncomment to turn off hard-coded styles
        }})
require("gruvbox").setup({
	transparent_mode = true,
	italic = {
		strings = false,
	},
  })

require("lualine").setup()

require("mini.tabline").setup()
require("mini.animate").setup()
require("mini.starter").setup()
require("mini.map").setup()
require("mini.icons").setup()
require("mini.pick").setup()
require("mini.diff").setup()
require("mini.pairs").setup()
require("mini.completion").setup()
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
vim.keymap.set("n", "<leader>g", function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end)
vim.keymap.set("n", "<leader>m", MiniMap.toggle)
vim.keymap.set("n", "<leader>d", function() pcall(MiniDiff.toggle_overlay) end)
vim.keymap.set("n", "<leader>s", MiniStarter.open)

pcall(require, "extra")
