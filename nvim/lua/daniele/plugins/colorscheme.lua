return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  opts = {
    flavour = 'mocha',
    integrations = {
      blink = false,
      notify = false,
      mason = true,
      noice = false,
      fzf = true,
      which_key = true
    }
  }
}
