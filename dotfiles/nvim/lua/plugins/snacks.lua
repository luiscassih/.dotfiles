return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  --@type snacks.Config
  opts = {
    explorer = {
      enabled = true,
    },
    picker = {
      layout = {
        preset = "ivy",
        cycle = false,
      },
      layouts = {
        ivy = {
          layout = {
            box = "vertical",
            height = 0.5,
            backdrop = false,
            row = -1,
            width = 0,
            border = "top",
            title = " {title} {live} {flags}",
            title_pos = "left",
            { win = "input", height = 1, border = "bottom" },
            {
              box = "horizontal",
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", width = 0.5, border = "left" },
            },
          },
        },
      }
    },
  },
  keys = {
    -- Pickers
    {
      "<leader><leader>",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = "Open Explorer",
    },
  },
}
