return {
  "CopilotC-Nvim/CopilotChat.nvim",
  ---@type CopilotChat.config.Shared
  opts = {
    headers = {
      user = "꠵ User ",
      assistant = "꠵ Assistant ",
      tool = "꠵ Tool ",
    },
    prompts = {
      Commit = {
        prompt = "Write commit message for the change without commitizen convention. Keep the title under 50 characters and wrap message at 72 characters. Format as a gitcommit code block.",
      },
    },
  },
}
