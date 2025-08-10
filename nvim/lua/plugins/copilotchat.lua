local select = require "CopilotChat.select"

return {
  "CopilotC-Nvim/CopilotChat.nvim",
  opts = {
    prompts = {
      Commit = {
        prompt = 'Write commit message for the change without commitizen convention. Keep the title under 50 characters and wrap message at 72 characters. Format as a gitcommit code block.',
      },
      PullRequest = {
        prompt = [[
Write a GitHub pull request description based on the following code changes.
Follow this template exactly.
Use markdown formatting.
Keep it short. Short is better.
Avoid lists unless absolutely necessary.
Focus on what changed, why it was done, how it works, and any caveats.
Write clearly and professionally.
Do not include a title or commit message.
Do not invent features not present in the diff.
Use a block diff to show the changes.
Use this exact format:
```
## What does this PR do?

...

## Why is it needed?

...

## How does it work?

...

## Anything to watch out for?

...



```
        ]],
        context = "system:`git diff main`",
        description = "Generate a pull request description based on the code changes.",
        selection = select.buffer,
      },
    },
  },
}
