return {
  "CopilotC-Nvim/CopilotChat.nvim",
  opts = {
    prompts = {
      Commit = {
        prompt = [[
Write a Git commit message based on the code changes below.
Follow these rules exactly:
Start with a single-line title, written in the imperative mood (like a command), and no more than 50 characters.
If the change isn’t obvious, add a short body explaining why it was made. Wrap body lines at 72 characters.
Do not use any prefixes like feat:, fix:, etc.
Be specific about what changed and why. Avoid vague words like “update” or “change”.
Write for a future human developer reading the Git history.
Return only the commit message in a ```gitcommit code block.
          ]],
        context = "git:staged",
      },
    },
  },
}
