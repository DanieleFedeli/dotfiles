local wezterm = require "wezterm"
local mux = wezterm.mux

local Workspaces = {}

local home = os.getenv("HOME")

local function has_value(tab, val)
  for _index, value in ipairs(tab) do
    if value == val then return true end
  end

  return false
end
-- Function to create a new tab with an editor + Git pane
local function create_dev_tab(window, title, cwd)
  local tab, pane = window:spawn_tab({ cwd = cwd })
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
  if has_value(mux.get_workspace_names(), "LX") then
    wezterm.log_error("Workspace LX already exists")
    mux.set_active_workspace("LX")
    return
  end

  local tab, pane, window = mux.spawn_window({ workspace = "LX" })

  tab:set_title("K9S")
  wezterm.log_info("PANE", pane)
  pane:send_text("k9s\n")

  create_dev_tab(window, "Disco", home .. "/Work/service-disco-graphql-api")
  create_dev_tab(window, "Service editor", home .. "/Work/service-editor")

  mux.set_active_workspace("LX")
end

return Workspaces
