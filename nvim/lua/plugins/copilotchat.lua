local select = require "CopilotChat.select"

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
      PullRequest = {
        description = "Generate a pull request description based on the code changes.",
        prompt = "#gitdiff:origin/main\n\nWrite a pull request description for these changes. Include a clear title, summary of changes, and any important notes.",
        system_prompt = [[
          You are an experienced software engineer about to open a PR.  
          You explain changes clearly, provide reasoning, and note potential risks.  
          Your task is to generate a GitHub CLI command (`gh pr create`) for the given git diff.

          Steps:  
          1. Analyze the provided git diff to understand the change, its purpose, and scope.  
          2. Always use the **Quick Fix** PR template with the following sections:  
            - ## What Changed — short summary of the fix  
            - ## Why — the problem or issue this solves  
            - ## How to Test — steps or commands to verify the change  
            - ## Notes — extra context, caveats, or follow-up actions  
          3. Create a `gh pr create` command with:  
            - `--base $(git parent)`  
            - `--title` as a concise, descriptive title under **50 characters** (no commitizen convention)  
            - `--body` containing the filled-out Quick Fix template  
          4. Escape backticks in the body to avoid shell interpretation issues.  
          5. Wrap the command in a shell code block (```sh ... ```).  
          6. Do **not** use newline characters inside the `--body` string except where intended for formatting in GitHub.

          Output Format Example:  
          ```sh
          gh pr create \
            --title "Prevent crash on null user data" \
            --body "## What Changed
          Fixed a null reference when loading user data.

          ## Why
          Prevented app crash in login flow.

          ## How to Test
          1. Start app with an empty user profile.
          2. Verify login succeeds without errors.

          ## Notes
          Temporary fix — long-term solution tracked in ISSUE-123."
        ]],
      },
    },
  },
}
