-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
-- Define a custom command to reload the configuration



-- Default settings
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.transparent_window = true
lvim.colorscheme = "custom"

local custom_colorscheme = require('user.colorscheme')
custom_colorscheme.setup()

vim.cmd([[
  command! ReloadConfig lua require('lvim.config'):reload()
]])


local function run_command(cmd)
  local output = vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 then
    vim.cmd('echohl ErrorMsg')
    for _, line in ipairs(output) do
      vim.cmd('echo "' .. line .. '"')
    end
    vim.cmd('echohl None')
  else
    vim.cmd('new')
    vim.cmd('setlocal bt=nofile bh=delete nobl noswapfile')
    vim.cmd('normal! ggdG')
    for _, line in ipairs(output) do
      vim.cmd('normal! o' .. line)
    end
    vim.cmd('normal! dd')
  end
end

_G.run_command = run_command

-- Add commands for building projects with various build systems
vim.cmd([[
  command! BuildZig lua run_command('zig build')
  command! BuildRust lua run_command('cargo build')
  command! BuildCMake lua run_command('cmake -S . -B build && cmake --build build')
  command! BuildMeson lua run_command('meson setup build && meson compile -C build')
  command! BuildCS lua run_command('dotnet build')
  command! BuildJava lua run_command('javac -d out $(find . -name "*.java")')
]])

-- Keybindings for the build commands
lvim.keys.normal_mode["<leader>bz"] = ":BuildZig<CR>"
lvim.keys.normal_mode["<leader>br"] = ":BuildRust<CR>"
lvim.keys.normal_mode["<leader>bc"] = ":BuildCMake<CR>"
lvim.keys.normal_mode["<leader>bm"] = ":BuildMeson<CR>"
lvim.keys.normal_mode["<leader>bcs"] = ":BuildCS<CR>"
lvim.keys.normal_mode["<leader>bj"] = ":BuildJava<CR>"

-- Enable shift + arrow keys for text selection
vim.api.nvim_set_keymap('n', '<S-Left>', 'v<Left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Right>', 'v<Right>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Up>', 'v<Up>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Down>', 'v<Down>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('v', '<S-Left>', '<Left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-Right>', '<Right>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-Up>', '<Up>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-Down>', '<Down>', { noremap = true, silent = true })

-- ~/.config/lvim/config.lua
lvim.plugins = {
  -- Other plugins you have already configured
  -- ...

  -- Add activate.nvim plugin
  {
    "roobert/activate.nvim",
    keys = {
      {
        "<leader>P",
        '<CMD>lua require("activate").list_plugins()<CR>',
        desc = "Plugins",
      },
    },
    dependencies = {
      { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } }
    }
  },

  {
    "github/copilot.vim"
  },

  {
    "iabdelkareem/csharp.nvim",
    dependencies = {
      "williamboman/mason.nvim", -- Required, automatically installs omnisharp
      "mfussenegger/nvim-dap",
      "Tastyep/structlog.nvim",  -- Optional, but highly recommended for debugging
    },
    config = function()
      require("mason").setup() -- Mason setup must run before csharp
      require("csharp").setup()
    end
  },

  {
    "dylanaraps/wal.vim"
  },

  {
    "folke/tokyonight.nvim"
  },

  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },

  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        plugins = {
          marks = true,       -- shows a list of your marks on ' and `
          registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
          spelling = {
            enabled = false,  -- enabling this will show Z= to replace suggested words
            suggestions = 20, -- how many suggestions to show in the list?
          },
          presets = {
            operators = false,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = false,      -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = false,      -- default bindings on <c-w>
            nav = false,          -- misc bindings to work with windows
            z = false,            -- bindings for folds, spelling and others prefixed with z
            g = false,            -- bindings for prefixed with g
          },
        },
      }
    end
  },
  { "glepnir/dashboard-nvim" },
  { "glepnir/galaxyline.nvim",            branch = 'main',                          requires = { 'kyazdani42/nvim-web-devicons', opt = true } },
  { "akinsho/nvim-bufferline.lua",        requires = 'kyazdani42/nvim-web-devicons' },
  { "lukas-reineke/indent-blankline.nvim" },
  { "norcalli/nvim-colorizer.lua" },

  -- Productivity Enhancements
  { "numToStr/Comment.nvim" },
  { "tpope/vim-surround" },
  { "windwp/nvim-autopairs" },
  { "phaazon/hop.nvim",                   branch = 'v1' },
  { "lewis6991/gitsigns.nvim" },
  { "nvim-telescope/telescope.nvim",      requires = { "nvim-lua/plenary.nvim" } },

  -- Development Tools
  { "neovim/nvim-lspconfig" },
  { "kabouzeid/nvim-lspinstall" },
  { "jose-elias-alvarez/null-ls.nvim" },
  { "L3MON4D3/LuaSnip" },
  { "hrsh7th/nvim-compe" },

  -- Utility Plugins
  { "windwp/nvim-spectre" },
  { "L3MON4D3/LuaSnip",                   requires = "rafamadriz/friendly-snippets" },
  { "TimUntersberger/neogit",             requires = "nvim-lua/plenary.nvim" },
  {
    "abecodes/tabout.nvim",
    config = function()
      require('tabout').setup {
        tabkey = '<Tab>',           -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true,          -- shift content if tab out is not possible
        enable_backwards = true,    -- well ...
        completion = true,          -- if the tabkey is used in a completion pum
        ignore_beginning = true,    -- if tabout is invoked at the beginning of a line, ignore it
        exclude = {}                -- tabout will ignore these filetypes
      }
    end,
    wants = { 'nvim-treesitter' },
    after = { 'nvim-compe' }
  },

  -- Performance Plugins
  { "lewis6991/impatient.nvim" },
  { "Olical/aniseed" },


}
