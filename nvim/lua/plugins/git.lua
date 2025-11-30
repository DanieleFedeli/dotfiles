return {
  {
    "2kabhishek/co-author.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    cmd = { "CoAuthor" },
  },
  {
    "folke/snacks.nvim",
    opts = {
      gh = {
        -- your gh configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
      picker = {
        sources = {
          gh_issue = {
            -- your gh_issue picker configuration comes here
            -- or leave it empty to use the default settings
          },
          gh_pr = {
            -- your gh_pr picker configuration comes here
            -- or leave it empty to use the default settings
          },
        },
      },
    },
    keys = {
      { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
      { "<leader>gI", function() Snacks.picker.gh_issue { state = "all" } end, desc = "GitHub Issues (all)" },
      { "<leader>gP", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
    },
  },
}
