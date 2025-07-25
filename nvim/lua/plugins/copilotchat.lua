return {
  "CopilotC-Nvim/CopilotChat.nvim",
  opts = {
    prompts = {
      Commit = {
        prompt = [[
            Write a Git commit message. Follow these instructions exactly:

            1. Title: Use imperative mood. Maximum 50 characters. Capitalize only the first character.
            2. Insert a blank line after the title.
            3. Subtitle (optional): Use imperative mood. Maximum 72 characters. Include only if necessary.
            4. Insert a blank line after the subtitle if present.
            5. Body paragraphs: Add only if the commit is large. Each paragraph must add value.

            Rules:
            - Separate title and subtitle with a blank line.
            - Be clear and concise.
            - Use simple language. Do not use business jargon.
            - Return only the commit message in a gitcommit code block.
          ]],
        context = "git:staged",
      },
    },
  },
}
