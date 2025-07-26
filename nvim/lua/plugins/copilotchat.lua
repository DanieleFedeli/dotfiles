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
      },
    },
  },
}
