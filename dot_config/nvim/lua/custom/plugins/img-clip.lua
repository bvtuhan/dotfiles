return {
  'HakonHarnes/img-clip.nvim',
  event = 'VeryLazy',
  opts = {
    dir_path = 'images',
    file_name = '%Y-%m-%d-%H%M%S',
    templates = {
      markdown = '![]($FILE_PATH)',
      org = '[[file:$FILE_PATH]]',
    },
  },
  keys = {
    {
      '<leader>p',
      '<cmd>PasteImage<cr>',
      desc = 'Paste image from clipboard',
      mode = 'n',
    },
  },
}
