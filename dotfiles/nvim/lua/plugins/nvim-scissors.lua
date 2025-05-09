return {
  "chrisgrieser/nvim-scissors",
  opts = {
    snippetDir = "$HOME/.config/nvim/snippets",
  },
  keys = {
    { "<leader>sA", function() require("scissors").addNewSnippet() end, mode = { "n", "x" }, desc = "Add New Snippet" },
    { "<leader>se", function() require("scissors").editSnippet() end, mode = { "n", "x" }, desc = "Add New Snippet" },
  }
}
