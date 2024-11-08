local telescope = require("plugins.telescope")

local _M = {}

local function _map(modes, input, desc, cmd)
  return {modes, input, cmd, desc}
end


local mappings = {
  -- nvim-tree
  _map('n', '<C-n>', "Toggle NvimTree",
    '<cmd>NvimTreeToggle<CR>'
  ),

  _map('n', '<leader>tp', "AMOGUS", function()
    telescope.show_garbage()
  end),

  -- nvterm
  _map('n', '<leader>tf', "Toggle floating terminal", function()
    require("nvterm.terminal").toggle("float")
  end),
  _map('n', '<leader>tv', "Toggle vertical terminal", function()
    require("nvterm.terminal").toggle("vertical")
  end),
  _map('n', '<leader>th', "Toggle horizontal terminal", function()
    require("nvterm.terminal").toggle("horizontal")
  end),

  _map('n', '<leader>tr', "Call run.sh", function()
    require("nvterm.terminal").send("./run.sh", "horizontal")
  end),

  _map('n', '<leader>tb', "Call build.sh", function()
    require("nvterm.terminal").send("./build.sh", "vertical")
  end),

  -- bufferline
  _map('n', '<tab>', 'Next buffer',
    '<cmd>BufferLineCycleNext<CR>'
  ),
  _map('n', '<S-tab>', 'Previous buffer',
    '<cmd>BufferLineCyclePrev<CR>'
  ),
  _map('n', '<leader>x', 'Close buffer',
    '<cmd>bd<CR>'
  ),

  -- comment
  _map('n', '<leader>/', 'Toggle comment', function()
    require("Comment.api").toggle.linewise.current()
  end),
  _map('v', '<leader>/', 'Toggle comment',
    "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>"
  ),

  -- renamer
  _map('n', '<leader>ra', 'LSP rename', function()
    require("renamer").rename()
  end),

  --telescope
  _map('n', '<leader>ff', "Telescope find files", function()
    require("telescope.builtin").find_files()
  end),
  _map('n', '<leader>fg', "Telescope live grep", function()
  require("telescope.builtin").live_grep()
  end),
  _map('n', '<leader>fb', "Telescope buffers", function()
    require("telescope.builtin").buffers()
  end),
  _map('n', '<leader>fh', "Telescope help tags", function()
  require("telescope.builtin").help_tags()
  end),

  -- misc
  _map('n', '<Esc>', "Clear highlights",
    '<cmd>noh<CR>'
  ),
  _map('n', '<C-h>', "Go to left window",
    '<C-w>h'
  ),
  _map('n', '<C-l>', "Go to right window",
    '<C-w>l'
  ),
  _map('n', '<C-j>', "Go to bottom window",
    '<C-w>j'
  ),
  _map('n', '<C-k>', "Go to upper window",
    '<C-w>k'
  ),
  _map('i', '<C-h>', "Left",
    '<Left>'
  ),
  _map('i', '<C-l>', "Right",
    '<Right>'
  ),
  _map('i', '<C-j>', "Down",
    '<Down>'
  ),
  _map('i', '<C-k>', "Up",
    '<Up>'
  ),
  _map('v', '<', "Indent left",
    '<gv'
  ),
  _map('v', '>', "Indent right",
    '>gv'
  ),

  _map('t', '<Esc>', 'Exit terminal mode', "<C-\\><C-n>"),
}

function _M.get()
  return mappings
end

return _M
