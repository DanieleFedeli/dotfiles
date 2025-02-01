local wezterm = require "wezterm"

local Workspaces = {}

local zsh_path = "/bin/zsh"
local home = os.getenv("HOME")

-- Function to check if a workspace exists; create it if not
local function ensure_workspace_exists(name)
  local mux = wezterm.mux
  for _, workspace in ipairs(mux.get_workspace_names()) do
    if workspace == name then
      mux.set_active_workspace(name)
      return nil
    end
  end
  return mux.spawn_window({ workspace = name })
end

-- Function to create a new tab with an editor + Git pane
local function create_dev_tab(window, title, cwd)
  if not window then return end

  local tab, pane = window:spawn_tab({ cwd = cwd })
  if not tab then return end

  tab:set_title(title)
  pane:send_text("nvim .\n")

  local git_pane = pane:split {
    direction = "Bottom",
    size = 0.30,
    cwd = cwd,
  }
  git_pane:send_text("gl --rebase \n")
end

-- ======= Function to Load "LX" Workspace =======
function Workspaces.load_lx()
  local lx_win = ensure_workspace_exists("LX")
  if not lx_win then return end -- ✅ Prevent nil access

  create_dev_tab(lx_win, "Disco", home .. "/Work/service-disco-graphql-api")
  create_dev_tab(lx_win, "Service editor", home .. "/Work/service-editor")

  local k9s_tab = lx_win:spawn_tab({ cwd = home, args = { zsh_path, "-c", "k9s" } })
  if k9s_tab then k9s_tab:set_title("K9S") end
end

return Workspaces
