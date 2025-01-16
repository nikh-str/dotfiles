return {
  -- lazy.nvim itself
  { "folke/lazy.nvim", lazy = false },

  -- Packer-managed itself
  -- { "wbthomason/packer.nvim", lazy = false },

    -- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
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

  -- Status Line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Buffer Bar
{'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},


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
{"jose-elias-alvarez/null-ls.nvim"}, -- for formatters and linters

  -- which-key
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        },
      },
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
