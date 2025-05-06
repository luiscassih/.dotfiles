return {
  'neovim/nvim-lspconfig',
  dependencies = { 'saghen/blink.cmp' },

  opts = {
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            completion = {
              callSnippet = "Replace"
            }
          }
        }
      },
      csharp_ls = {
        cmd = { "csharp-ls" },
        filetypes = { "cs", "razor", "csproj", "fs", "fsproj" },
        -- root_dir = require("lspconfig").util.root_pattern("*.sln", "*.csproj", "packages.config"),
      },
      ts_ls = {},
      tailwindcss = {
        filetypes = { "html", "htmldjango", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
      },
      clangd = {
        ClangdSwitchSourceHeader = true,
      },
      ols = {},
      ruff = {},
      golangci_lint_ls = {},
      emmet_ls = {},
    }
  },
  config = function(_, opts)
    local lspconfig = require('lspconfig')

    local on_attach = function(_, bufnr)
      local attach_opts = { buffer = bufnr, remap = false }

      vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, attach_opts)
      vim.keymap.set("n", "gs", function() vim.cmd("vsplit"); vim.lsp.buf.definition() end, attach_opts)
      vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, attach_opts)
      vim.keymap.set("n", "<leader>lws", function() vim.lsp.buf.workspace_symbol() end, attach_opts)
      vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, attach_opts)
      vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, attach_opts)
      vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, attach_opts)
      vim.keymap.set({ 'v', 'n' }, "<leader>la", function() vim.lsp.buf.code_action() end, attach_opts)
      -- vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.references() end, attach_opts)
      vim.keymap.set("n", "<leader>lR", function() vim.lsp.buf.rename() end, attach_opts)
      -- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, attach_opts)
      vim.keymap.set("n", "<leader>R", ":LspRestart<CR>", attach_opts)
      vim.keymap.set({"n", "v"}, "<leader>f", vim.lsp.buf.format)
    end

    opts.servers.csharp_ls.root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj", "packages.config")

    for server, config in pairs(opts.servers) do
      -- passing config.capabilities to blink.cmp merges with the capabilities in your
      -- `opts[server].capabilities, if you've defined it
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      config.on_attach = on_attach
      lspconfig[server].setup(config)
    end

    -- local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    -- for type, icon in pairs(signs) do
    --   local hl = "DiagnosticSign" .. type
    --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    -- end

    vim.lsp.log.set_level(vim.log.levels.ERROR)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'qf',
      callback = function(event)
        local ops = { buffer = event.buf, silent = true }
        vim.keymap.set('n', '<C-n>', '<cmd>cn | wincmd p<CR>', ops)
        vim.keymap.set('n', '<C-p>', '<cmd>cN | wincmd p<CR>', ops)
      end,
    })
  end
}
