local plugins = require("plugins")
local mappings = require("mappings")

local function load_plugins()
  local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazy_path) then
    local lazy_repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazy_repo, lazy_path})
  end
  vim.opt.rtp:prepend(lazy_path)

  require("lazy").setup(plugins.get(), {
    checker = {
      enabled = false
    },
  })
end

local function load_mappings()
  local defopts = { noremap = true, silent = true }
  for _, map in ipairs(mappings.get()) do
    local opts = defopts
    opts.desc = map[4]
    vim.keymap.set(map[1], map[2], map[3], opts)
  end
end

function main()
  local opt = vim.o
  local editor = vim.g

  -- Indentation
  opt.expandtab = true
  opt.smartindent = true
  opt.tabstop = 2
  opt.softtabstop = 2
  opt.shiftwidth = 2
  opt.fillchars = "eob: "
  opt.ignorecase = true
  opt.smartcase = true
  opt.mouse = "a"
  opt.cino = "g0;N-s;j1" -- cpp indents

  -- For nvim-tree
  editor.loaded_netrw = 1
  editor.loaded_netrwPlugin = 1
  opt.termguicolors = true

  -- For which-key
  opt.timeout = true
  opt.timeoutlen = 300

  -- other
  opt.signcolumn = "yes"
  opt.number = true
  opt.numberwidth = 2
  opt.ruler = false
  opt.colorcolumn = "100"
  editor.mapleader = " "
  editor.maplocalleader = "\\"
  opt.clipboard = "unnamedplus"

  -- Filetypes
  vim.filetype.add{
    extension = {
      etlua = 'etlua'
    }
  }

  load_plugins()
  load_mappings()
end
