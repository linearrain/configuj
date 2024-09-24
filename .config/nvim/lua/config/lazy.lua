-- Bootstrap lazy.nvim local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }) if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
local plugins = {
	{
  		"folke/tokyonight.nvim",
  		lazy = false,
  		priority = 1000,
  		opts = {
			transparent = true,
			styles = {
       				sidebars = "transparent",
       				floats = "transparent",
    			}
		},
	},
	{
    	'nvim-lualine/lualine.nvim',
    	dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"rust_analyzer", "clangd"
			},
		},
	},
	"nvim-telescope/telescope.nvim",
	{
		"neovim/nvim-lspconfig",
        ensure_installed = {"clangd", "pyright"}
	},
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-vsnip",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-buffer",
	"hrsh7th/nvim-cmp",
	"simrat39/rust-tools.nvim",

    "tree-sitter/tree-sitter",
    
    "catppuccin/nvim",

    {
        'maxmx03/fluoromachine.nvim',
        lazy = false,
        priority = 1000,
        config = function ()
         local fm = require 'fluoromachine'

         fm.setup {
            glow = false,
            theme = 'retrowave',
            transparent = true,
         }

        end
    },
    "yassinebridi/vim-purpura",
    "ray-x/aurora",
    "navarasu/onedark.nvim",
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        }
    },
    { "L3MON4D3/LuaSnip", event = "VeryLazy",
        config = function()
        require("luasnip.loaders.from_lua").load({paths = "./snippets"})
        end
    },
}
local opts    = {
    {{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}}
}
--
--
require("lazy").setup(plugins, opts)
require("catppuccin").setup {
    transparent_background = true
}

local purple = '#F68EFF'

require("onedark").setup {
    transparent = true,
    colors = {
        fg = '#EBE0EA',
        grey = '#AE8DB2',
        light_grey = '#DCBEE0',
        cyan       = '#B69EFF',
        red    = '#FF577A',
        yellow = '#FFF656',
        orange = '#FF9F80',
        green  = '#B0FF5B',
        blue   = '#FF7AB3',
        purple = purple
    },
    syntax = {
        Type    = { fg = purple, fmt = "bold" },
        StorageClass = purple,
        Typedef = purple,
    },
    diagnostics = {
        darker = false, -- darker colors for diagnostic
        undercurl = false,   -- use undercurl instead of underline for diagnostics
        background = false,    -- use background color for virtual text
    },
}

vim.cmd("colorscheme onedark")

vim.api.nvim_set_hl(0, "Type", { fg = purple })
vim.api.nvim_set_hl(0, "StorageClass", { fg = purple })
vim.api.nvim_set_hl(0, "Typedef", { fg = purple })
vim.api.nvim_set_hl(0, "Structure", { fg = purple })

local lualinetheme = require'lualine.themes.gruvbox'

local grey = '#C8BFCB';

-- Making the thing transparent

lualinetheme.normal.c.bg   = innerbg
lualinetheme.insert.c.bg   = innerbg
lualinetheme.command.c.bg  = innerbg
lualinetheme.visual.c.bg   = innerbg
lualinetheme.inactive.a.bg = innerbg
lualinetheme.inactive.b.bg = innerbg
lualinetheme.inactive.c.bg = innerbg

-- Assigning the text colors

lualinetheme.normal.a.fg = '#FFFFFF'
lualinetheme.normal.b.fg = '#FFFFFF'
lualinetheme.normal.c.fg = grey

lualinetheme.insert.a.fg = '#FFFFFF'
lualinetheme.insert.b.fg = '#FFFFFF'
lualinetheme.insert.c.fg = grey

lualinetheme.command.a.fg = '#FFFFFF'
lualinetheme.command.b.fg = '#FFFFFF'
lualinetheme.command.c.fg = grey

lualinetheme.visual.a.fg = '#050A28'
lualinetheme.visual.b.fg = '#050A28'
lualinetheme.visual.c.fg = grey

lualinetheme.inactive.a.fg = '#FFFFFF'
lualinetheme.inactive.b.fg = '#FFFFFF'
lualinetheme.inactive.c.fg = grey 

-- Assigning the bg colors:

lualinetheme.normal.a.bg = '#64017F'
lualinetheme.normal.b.bg = '#64017F'

lualinetheme.insert.a.bg = '#A080F0'
lualinetheme.insert.b.bg = '#A080F0'

lualinetheme.command.a.bg = '#EB71FF'
lualinetheme.command.b.bg = '#EB71FF'

lualinetheme.visual.a.bg = '#5AC6F8'
lualinetheme.visual.b.bg = '#5AC6F8'

require("lualine").setup {
	options = { theme = lualinetheme }
}

require("mason").setup()

require("nvim-tree").setup()

require'lspconfig'.rust_analyzer.setup {
    settings = {
        ['rust-analyzer'] = {
            check = {
                command = "clippy";
            },
            diagnostics = {
                enable = true;
            }
        }
    }
}


require'cmp'.setup({
  snippet = {
    expand = function(args)
         vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources =  {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})



-- For C and C++ shit:

require'lspconfig'.clangd.setup {
    opts = {
  servers = {
    -- Ensure mason installs the server
    clangd = {
      keys = {
        { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
      },
      root_dir = function(fname)
        return require("lspconfig.util").root_pattern(
          "Makefile",
          "configure.ac",
          "configure.in",
          "config.h.in",
          "meson.build",
          "meson_options.txt",
          "build.ninja"
        )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
          fname
        ) or require("lspconfig.util").find_git_ancestor(fname)
      end,
      capabilities = {
        offsetEncoding = { "utf-16" },
      },
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
      },
      init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
      },
    },
  },
  setup = {
    clangd = function(_, opts)
      local clangd_ext_opts = LazyVim.opts("clangd_extensions.nvim")
      require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
      return false
    end,
  },
}
}

require("lspconfig").pyright.setup {
    capabilities = capabilities,
}
