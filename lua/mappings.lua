local _M = {}

local function __map(modes, input, desc, cmd)
  return {modes, input, cmd, desc}
end

local mappings = {
  -- nvim-tree
  __map('n', '<C-n>', "Toggle NvimTree",
    '<cmd>NvimTreeToggle<CR>'
  ),

  -- nvterm
  __map({'n', 't'}, '<A-i>', "Toggle floating terminal", function()
    require("nvterm.terminal").toggle("float")
  end),
  __map({'n', 't'}, '<A-v>', "Toggle floating terminal", function()
    require("nvterm.terminal").toggle("vertical")
  end),
  __map({'n', 't'}, '<A-h>', "Toggle floating terminal", function()
    require("nvterm.terminal").toggle("horizontal")
  end),

  -- bufferline
  __map('n', '<tab>', 'Next buffer',
    '<cmd>BufferLineCycleNext<CR>'
  ),
  __map('n', '<S-tab>', 'Previous buffer',
    '<cmd>BufferLineCyclePrev<CR>'
  ),
  __map('n', '<leader>x', 'Close buffer',
    '<cmd>bd<CR>'
  ),

  -- comment
  __map('n', '<leader>/', 'Toggle comment', function()
    require("Comment.api").toggle.linewise.current()
  end),
  __map('v', '<leader>/', 'Toggle comment',
    "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>"
  ),

  -- renamer
  __map('n', '<leader>ra', 'LSP rename', function()
    require("renamer").rename()
  end),

  --telescope
  __map('n', '<leader>ff', "Telescope find files", function()
    require("telescope.builtin").find_files()
  end),
  __map('n', '<leader>fg', "Telescope live grep", function()
  require("telescope.builtin").live_grep()
  end),
  __map('n', '<leader>fb', "Telescope buffers", function()
    require("telescope.builtin").buffers()
  end),
  __map('n', '<leader>fh', "Telescope help tags", function()
  require("telescope.builtin").help_tags()
  end),

  -- misc
  __map('n', '<Esc>', "Clear highlights",
    '<cmd>noh<CR>'
  ),
  __map('n', '<C-h>', "Go to left window",
    '<C-w>h'
  ),
  __map('n', '<C-l>', "Go to right window",
    '<C-w>l'
  ),
  __map('n', '<C-j>', "Go to bottom window",
    '<C-w>j'
  ),
  __map('n', '<C-k>', "Go to upper window",
    '<C-w>k'
  ),
  __map('i', '<C-h>', "Left",
    '<Left>'
  ),
  __map('i', '<C-l>', "Right",
    '<Right>'
  ),
  __map('i', '<C-j>', "Down",
    '<Down>'
  ),
  __map('i', '<C-k>', "Up",
    '<Up>'
  ),
  __map('v', '<', "Indent left",
    '<gv'
  ),
  __map('v', '>', "Indent right",
    '>gv'
  ),
}

function _M.get()
  return mappings
end

return _M
