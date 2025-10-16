return {
  -- lazy.nvim itself
  { "folke/lazy.nvim", lazy = false },
  {'vimwiki/vimwiki',
  init = function()
    vim.g.vimwiki_list = {
      {
        path = vim.fn.expand("~/Documents/vimwiki/"),
        syntax = 'markdown',
        ext = '.md'
      }
    }
    vim.g.vimwiki_folding = 'list'
  end
 },


  -- Packer-managed itself
  -- { "wbthomason/packer.nvim", lazy = false },

    -- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        }
    },

  {'xiyaowong/transparent.nvim'},

    {"lewis6991/gitsigns.nvim"},
    {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
        { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
},
-- {
    -- TODO fix
    -- "nvim-neorg/neorg",
    -- build = ":Neorg sync-parsers", 
    --       opts = {
    --         load = {
    --             ["core.defaults"] = {}, -- Loads default behaviour
    --             ["core.concealer"] = {}, -- Adds pretty icons to your documents
    --             ["core.dirman"] = { -- Manages Neorg workspaces
    --                 config = {
    --                     workspaces = {
    --                         notes = "~/notes",
    --                     },
    --                     default_workspace = "notes",
    --                 },
    --             },
    --         },
    --     },
    --    dependencies = {
    --         { "nvim-lua/plenary.nvim", },
    --         {
    --             -- YOU ALMOST CERTAINLY WANT A MORE ROBUST nvim-treesitter SETUP
    --             -- see https://github.com/nvim-treesitter/nvim-treesitter
    --             "nvim-treesitter/nvim-treesitter",
    --             opts = {
    --                 auto_install = true,
    --                 highlight = {
    --                     enable = true,
    --                     additional_vim_regex_highlighting = false,
    --                 },
    --             },
    --             config = function(_,opts)
    --                 require('nvim-treesitter.configs').setup(opts)
    --             end
    --         },
    --     },
    -- },
{
  "lervag/vimtex",
  lazy = false,     -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "zathura"
  end
},

  -- Status Line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Buffer Bar
{'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},

{'neoclide/coc.nvim', branch='release' },

{'nvimdev/lspsaga.nvim',
    config = function()
        require('lspsaga').setup({})
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons',     -- optional
    }
},
--
{"ziontee113/color-picker.nvim",
    config = function()
        require("color-picker")
    end,
},


{'KabbAmine/vCoolor.vim'},

  {'SirVer/ultisnips'},
  { "kevinhwang91/rnvimr" },
  { "norcalli/nvim-colorizer.lua" },
  {
  "AckslD/nvim-neoclip.lua",
  dependencies = {
    -- you'll need at least one of these
    -- {'nvim-telescope/telescope.nvim'},
    -- {'ibhagwan/fzf-lua'},
  },
  config = function()
    require('neoclip').setup()
  end,
},
-- {"jose-elias-alvarez/null-ls.nvim"}, -- for formatters and linters
{"nvimtools/none-ls.nvim",
 dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
},

  -- which-key
    {
      "folke/which-key.nvim",
  dependencies = { 'echasnovski/mini.icons', "nvim-tree/nvim-web-devicons"},
      event = "VeryLazy",
    },

  -- Surround
  { "tpope/vim-surround" },

  -- Icons
  { "nvim-tree/nvim-web-devicons", opts = {} },

  -- Colorschemes
  { "tiagovla/tokyodark.nvim" },
  { "Mofiqul/vscode.nvim" },

  -- Symbol Outline
  { "simrat39/symbols-outline.nvim" },

  -- {
  --     "nvim-treesitter/nvim-treesitter",
  --     build = ":TSUpdate",
  --     opts = {
  --       ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
  --       highlight = { enable = true },
  --     },
  --     config = function(_, opts)
  --       require("nvim-treesitter.configs").setup(opts)
  --     end,
  --   },

  -- Dashboard
  {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      -- config
    }
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
},

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Indent Guides
  { "lukas-reineke/indent-blankline.nvim" },

{
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {}
  end,
},



  -- LSP and Related Plugins
  { "neovim/nvim-lspconfig" },

  }
