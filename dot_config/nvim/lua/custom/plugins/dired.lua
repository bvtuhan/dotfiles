return {
  'X3eRo0/dired.nvim',
  lazy = false,
  keys = {
    {
      '<leader>ff',
      function()
        require('dired').open()
      end,
      desc = 'Open Dired file explorer',
    },
  },
  dependencies = { 'MunifTanjim/nui.nvim' },
  opts = {
    default_file_explorer = true,
  },
  config = function()
    require('dired').setup {
      path_separator = '/',
      show_banner = false,
      show_icons = false,
      show_hidden = true,
      show_dot_dirs = true,
      show_colors = true,

      keybinds = {
        dired_enter = '<CR>',
        dired_back = '-',
        dired_up = '^',
        dired_rename = 'R',
        dired_create = '+',
        dired_delete = 'D',
        dired_delete_range = 'D',
        dired_copy = 'C',
        dired_copy_range = 'C',
        dired_copy_marked = 'MC',
        dired_move = 'X',
        dired_move_range = 'X',
        dired_move_marked = 'MX',
        dired_paste = 'P',
        dired_mark = 'm',
        dired_mark_range = 'm',
        dired_delete_marked = 'MD',
        dired_shell_cmd = '!',
        dired_shell_cmd_marked = '&',
        dired_toggle_hidden = '.',
        dired_toggle_sort_order = 's',
        dired_toggle_icons = '*',
        dired_toggle_colors = 'c',
        dired_toggle_hide_details = '(',
        dired_quit = 'q',
      },
    }
  end,
}
