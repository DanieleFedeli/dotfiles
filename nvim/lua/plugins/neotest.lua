return {
  "nvim-neotest/neotest",
  dependencies = {
    "marilari88/neotest-vitest",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-vitest") {
          filter_dir = function(name)
            return name ~= "node_modules"
          end,
        },
      }
    })
  end,
}
