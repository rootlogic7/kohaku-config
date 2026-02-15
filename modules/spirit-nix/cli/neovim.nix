{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    # Plugins
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      catppuccin-nvim
      lualine-nvim
      nvim-web-devicons
      telescope-nvim
      plenary-nvim
      neo-tree-nvim
    ];

    # Lua Config
    initLua = ''
      -- Basics
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.mouse = "a"
      vim.opt.clipboard = "unnamedplus"
      vim.opt.termguicolors = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true

      -- Theme
      require("catppuccin").setup({
          flavour = "mocha",
          transparent_background = true,
          custom_highlights = function(colors)
            return {
              SignColumn = { bg = "NONE" },
              NeoTreeNormal = { bg = "NONE" },
              NeoTreeNormalNC = { bg = "NONE" },
              EndOfBuffer = { bg = "NONE" },
            }
          end
      })
      vim.cmd.colorscheme "catppuccin"

      -- Statusline
      require('lualine').setup {
        options = { theme = 'catppuccin' }
      }

      -- Keybindings
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>b', builtin.buffers, {})
      vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', {})
    '';
  };
}
