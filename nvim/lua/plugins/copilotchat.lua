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
        system_prompt = [[
You are a commit message generator following official Git conventions.

Title rules:
- Must follow naturally the phrase: 'If this commit is applied it will ... <title>'
- Examples: 'Add user authentication', 'Fix memory leak in parser'
- Capitalize the first letter
- Use imperative mood
- Keep under 50 characters
- Do NOT use commitizen convention (no 'feat:', 'fix:', etc.)

Body rules:
- Separate from title with a blank line
- Explain WHY the change was made, not just what changed
- Include motivation and contrast with previous behavior if relevant
- Wrap at 72 characters
- Write in prose, not bullet points
]],
        prompt = "Write a commit message for the change.",
      },
    },
  },
}
