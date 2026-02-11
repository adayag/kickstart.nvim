-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { 'tpope/vim-projectionist' },
  { 'tpope/vim-rails', ft = 'ruby' },
  { 'tpope/vim-fugitive' },

  -- Toggle comments with gcc (line) or gc (visual selection)
  { 'numToStr/Comment.nvim', event = 'VimEnter', opts = {} },

  -- Buffer tabs at the top
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = 'VimEnter',
    opts = {
      options = {
        diagnostics = 'nvim_lsp',
        offsets = {
          { filetype = 'neo-tree', text = 'File Explorer', text_align = 'center' },
        },
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = 'thin',
      },
    },
  },

  -- Markdown preview in browser
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = 'markdown',
    build = 'cd app && npx --yes yarn install',
    keys = {
      { '<leader>mp', '<cmd>MarkdownPreviewToggle<CR>', desc = '[M]arkdown [P]review toggle' },
    },
  },

  -- Telescope live grep with args (filter by file type: "foo -t ruby")
  {
    'nvim-telescope/telescope-live-grep-args.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      local telescope = require 'telescope'
      local lga_actions = require 'telescope-live-grep-args.actions'
      telescope.setup {
        extensions = {
          live_grep_args = {
            auto_quoting = true,
            mappings = {
              i = {
                ['<C-k>'] = lga_actions.quote_prompt(),
                ['<C-i>'] = lga_actions.quote_prompt { postfix = ' --iglob ' },
              },
            },
          },
        },
      }
      telescope.load_extension 'live_grep_args'
      vim.keymap.set('n', '<leader>sG', function()
        require('telescope').extensions.live_grep_args.live_grep_args()
      end, { desc = '[S]earch by [G]rep (with args)' })
    end,
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = 'VimEnter',
    opts = {
      options = {
        theme = 'base16',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    },
  },
}
