return {
  "CopilotC-Nvim/CopilotChat.nvim",
  opts = {
    prompts = {
      Commit = {
        prompt = [[
          Write a Git commit message with:

          1. **Title**: Imperative, max 50 chars, first char uppercase only
          2. (Blank line)
          3. **Subtitle** (optional): Imperative, max 72 chars, only if needed

          Rules:
          - Keep title and subtitle separated by blank line
          - Be clear and concise
          - Use simple language, avoid business jargon
          - Add body paragraphs after subtitle only if necessary for large commits
          - Each body paragraph must add value

          Return only the commit message in a gitcommit code block.
          ]],
        context = "git:staged",
      },
    },
  },
}
