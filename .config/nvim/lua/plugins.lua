local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " ..
                install_path)
    execute "packadd packer.nvim"
end


local packer_ok, packer = pcall(require, "packer")
if not packer_ok then return end

packer.init {
    -- compile_path = vim.fn.stdpath('data')..'/site/pack/loader/start/packer.nvim/plugin/packer_compiled.vim',
    compile_path = require("packer.util").join_paths(vim.fn.stdpath('config'),
                                                     'plugin',
                                                     'packer_compiled.vim'),
    git = {clone_timeout = 300},
    display = {
        open_fn = function()
            return require("packer.util").float {border = "single"}
        end
    }
}

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return require('packer').startup(function(use)
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim'}


    -- Status Line
    use { 'glepnir/galaxyline.nvim',
        branch = 'main',
        requires = {'kyazdani42/nvim-web-devicons'}
    }

    -- Buffer Bar
       -- use { 'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons' }
    use { "akinsho/nvim-bufferline.lua",
    config = function()
        require("nv-bufferline").config()
    end,
    event = "BufRead"
    }
    -- use {'romgrk/barbar.nvim'}

    -- whichkey
    use {"folke/which-key.nvim"}

    use {'tpope/vim-surround'}

    -- Colorscheme
    use 'tiagovla/tokyodark.nvim'

    -- Lua formatter
    -- use 'andrejlevkovitch/vim-lua-format'

      -- Symbol Outline
    use { "simrat39/symbols-outline.nvim" }
    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

    -- Dash
    use { 'glepnir/dashboard-nvim', }

    -- Telescope
    use { 'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/popup.nvim'},
            {'nvim-lua/plenary.nvim'}},
        -- config = [[require('nv-telescope')]],
        -- cmd = "Telescope"
    }

    use { "lukas-reineke/indent-blankline.nvim", }

    -- Nvim Tree
    use { 'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = function()
        require("nv-nvimtree").config()
        end
    }

    -- Nvim Built in LSP configs
    use 'neovim/nvim-lspconfig'
    use 'glepnir/lspsaga.nvim'

    -- Autocomplete
    use { "hrsh7th/nvim-compe",
        event = "InsertEnter",
        config = function()
            require("nv-compe").config()
        end
    }
    -- use "hrsh7th/vim-vsnip"
    -- use "rafamadriz/friendly-snippets"
    --

    -- Autopairs
    use { "windwp/nvim-autopairs",
        event = "InsertEnter",
        after = {"telescope.nvim", "nvim-compe"},
        config = function()
            require 'nv-autopairs'
        end
    }

        -- Comments
    use { 'terrortylor/nvim-comment',
        cmd = "CommentToggle",
        config = function()
            require('nvim_comment').setup({comment_empty=false})
        end
        }

    -- Zen Mode
    use {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        -- event = "BufRead",
        config = function()
            require('nv-zen').config()
        end
    }

    use { "norcalli/nvim-colorizer.lua"}
    -- Color Pick
    use { 'KabbAmine/vCoolor.vim' } -- alt-c to color pick


    use {'lervag/vimtex'}
    use {'vimwiki/vimwiki'}
    use {'sirver/ultisnips'}

    -- Ranger
    use { 'kevinhwang91/rnvimr'}

     -- Floating terminal
    use {
        'numToStr/FTerm.nvim',
        event = "BufRead",
        config = function()
            require'FTerm'.setup({
                dimensions = {height = 0.8, width = 0.8, x = 0.5, y = 0.5},
                border = 'single' -- or 'double'
            })
        end,
    }
    use "oberblastmeister/neuron.nvim"
    use {'vim-pandoc/vim-pandoc'}

  -- Sane gx for netrw_gx bug
  use {
    "felipec/vim-sanegx",
    event = "BufRead"
  }
  use {"iamcco/markdown-preview.nvim", run = [[sh -c 'cd app && yarn install']]}
  use {'jbyuki/nabla.nvim'}

end)
