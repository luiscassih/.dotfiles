return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    local ts = require('nvim-treesitter.configs')
    ts.setup({
      -- A list of parser names, or "all" (the five listed parsers should always be installed)
      ensure_installed = { "typescript", "tsx", "css", "html", "latex", "scss", "svelte", "typst", "vue", "cpp", "javascript", "rust", "go", "lua", "vim", "vimdoc", "query", "http", "json", "gdscript", "markdown_inline", "regex" },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "s",
          node_incremental = "s",
          scope_incremental = false,
          node_decremental = "S",
        },
      },
      textobjects = {
        enable = true,
        select = {
          enable = true,
          keymaps = {
            ['w'] = { query = '@word.inner', desc = "Word" },
          },
        },
      }
    })

    -- local incremental_selection = require("nvim-treesitter.incremental_selection")
    -- vim.keymap.set({'n', 'v'}, 'w', incremental_selection.init_selection)
    -- vim.keymap.set({'n', 'v'}, 'w', function ()
    --   vim.cmd("w")
    --   incremental_selection.init_selection()
    -- end)
    -- vim.keymap.set({'n', 'v'}, 's', incremental_selection.node_incremental)
    -- vim.keymap.set({'x'}, 'S', incremental_selection.node_decremental)

  end
}
