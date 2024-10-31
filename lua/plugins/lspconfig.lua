local _M = {}

function _M.config()
  local lsp = require("lspconfig")
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  vim.lsp.set_log_level('off')
  require('vim.lsp.log').set_format_func(vim.inspect)

  vim.diagnostic.config {
    signs = true,
    underline = true,
    update_in_insert = false,
  }

  capabilities.textDocument.completion.CompletionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    deprecatedSupport = true,
    comitCharactersSupport = true,
    tagSupport = { valuseSet = { 1 } },
    resolveSuport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      }
    }
  }

  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  capabilities.offsetEncoding = { "utf-16" }

  local function on_attach(_, bufnr)
    -- client.server_capabilities.semanticTokensProvider = nil

    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    local set_keymap = vim.keymap.set

    local opts = { buffer=bufnr, noremap=true, silent=true}
    set_keymap('n', 'gD', vim.lsp.buf.declaration, opts)
    set_keymap('n', 'gd', vim.lsp.buf.definition, opts)
    set_keymap('n', 'K', vim.lsp.buf.hover, opts)
    set_keymap('n', 'gi', vim.lsp.buf.implementation, opts)
    -- set_keymap('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    set_keymap('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    set_keymap('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    set_keymap('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    set_keymap('n', '<space>D', vim.lsp.buf.type_definition, opts)
    set_keymap('n', '<space>rn', vim.lsp.buf.rename, opts)
    set_keymap('n', 'gr', vim.lsp.buf.references, opts)
    set_keymap('n', '<space>e', vim.diagnostic.open_float, opts)
    set_keymap('n', '[d', vim.diagnostic.goto_prev, opts)
    set_keymap('n', ']d', vim.diagnostic.goto_next, opts)
    set_keymap('n', '<space>q', vim.diagnostic.setloclist, opts)
  end

  lsp["clangd"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
      "/usr/bin/clangd",
      "--background-index",
      "--completion-style=detailed",
    },
    filetypes = { "c", "h", "cpp", "hpp", "inl", "tpp" },
  }

  lsp["lua_ls"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "/sdr/software/_root/bin/lua-language-server" },
    on_init = function(client)
      if (client.workspace_folders == nil) then
        return
      end
      local workspace = client.workspace_folders[1]
      if (workspace.name and vim.loop.fs_stat(workspace.name.."/.luarc.json")) then
        return
      end
    end,
  }
end

return _M
