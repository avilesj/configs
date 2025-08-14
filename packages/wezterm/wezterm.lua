-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
  config.font = wezterm.font_with_fallback { 'JetBrainsMono NF', 'Noto Color Emoji' }

local user = os.getenv("USER")
config.window_padding = {
    left = "0cell",
    right = "0cell",
    top = "0cell",
    bottom = "0cell"
}
-- BG
-- The art is a bit too bright and colorful to be useful as a backdrop
-- for text, so we're going to dim it down to 10% of its normal brightness
local dimmer = {brightness = 0.1}
config.enable_scroll_bar = false
config.background = {
    -- This is the deepest/back-most layer. It will be rendered first
    {
        source = {
            File = "/home/" .. user .. "/.config/wezterm/bg.png"
        },
        -- The texture tiles vertically but not horizontally.
        -- When we repeat it, mirror it so that it appears "more seamless".
        -- An alternative to this is to set `width = "100%"` and have
        -- it stretch across the display
        repeat_x = "Mirror",
        hsb = dimmer,
        -- When the viewport scrolls, move this layer 10% of the number of
        -- pixels moved by the main viewport. This makes it appear to be
        -- further behind the text.
        attachment = {Parallax = 0.1}
    }
}

-- or, changing the font size and color scheme.
config.font_size = 18.5
config.color_scheme = "AdventureTime"
-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = {key = "`", timeout_milliseconds = 1000}
config.keys = {
    {
        key = "|",
        mods = "LEADER|SHIFT",
        action = wezterm.action.SplitHorizontal({domain = "CurrentPaneDomain"})
    },
    {
        key = "-",
        mods = "LEADER",
        action = wezterm.action.SplitVertical({domain = "CurrentPaneDomain"})
    },
    {
        key = "t",
        mods = "LEADER",
        action = wezterm.action.SpawnTab("CurrentPaneDomain")
    },
    {key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left")},
    {key = "h", mods = "LEADER|CTRL", action = wezterm.action.ActivatePaneDirection("Left")},
    {key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down")},
    {key = "j", mods = "LEADER|CTRL", action = wezterm.action.ActivatePaneDirection("Down")},
    {key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up")},
    {key = "k", mods = "LEADER|CTRL", action = wezterm.action.ActivatePaneDirection("Up")},
    {key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right")},
    {key = "l", mods = "LEADER|CTRL", action = wezterm.action.ActivatePaneDirection("Right")},
    {
        key = "n",
        mods = "LEADER",
        action = wezterm.action.ToggleFullScreen
    },
    {
        key = "[",
        mods = "LEADER",
        action = wezterm.action.ActivateCopyMode
    },
    {
        key = "`",
        mods = "LEADER",
        action = wezterm.action.SendKey({key = "`"})
    },
    {
        key = "1",
        mods = "LEADER",
        action = wezterm.action.ActivateTab(0),
    },
    {
        key = "2",
        mods = "LEADER",
        action = wezterm.action.ActivateTab(1),
    },
    {
        key = "3",
        mods = "LEADER",
        action = wezterm.action.ActivateTab(2),
    },
    {
        key = "4",
        mods = "LEADER",
        action = wezterm.action.ActivateTab(3),
    },
    {
        key = "5",
        mods = "LEADER",
        action = wezterm.action.ActivateTab(4),
    },
    {
        key = "6",
        mods = "LEADER",
        action = wezterm.action.ActivateTab(5),
    },
    {
        key = "7",
        mods = "LEADER",
        action = wezterm.action.ActivateTab(6),
    },
    {
        key = "8",
        mods = "LEADER",
        action = wezterm.action.ActivateTab(7),
    },

    {
        key = "9",
        mods = "LEADER",
        action = wezterm.action.ActivateTab(8),
    },
    {
        key = "0",
        mods = "LEADER",
        action = wezterm.action.ActivateTab(9),
    },
    {
        key = "Tab",
        mods = "LEADER",
        action = wezterm.action.ActivateLastTab,
    },
{
	key = "LeftArrow",
	mods = "LEADER",
	action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
},
{
	key = "RightArrow",
	mods = "LEADER",
	action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
},
{
	key = "UpArrow",
	mods = "LEADER",
	action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
},
{
	key = "DownArrow",
	mods = "LEADER",
	action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
},
}
config.status_update_interval = 2000

local function get_os()
  local success, stdout = wezterm.run_child_process { 'uname' }
  if success then
    local os = stdout:gsub('\n', '')
    return os -- Returns 'Linux', 'Darwin' (macOS), etc.
  end
end


local function get_cpu_usage()
  local os_name = get_os()
  
  if os_name == "Linux" then
    -- Linux: Use /proc/stat for more reliable CPU measurement
    local success, stdout = wezterm.run_child_process {
      'sh', '-c',
      "grep '^cpu ' /proc/stat | awk '{idle=$5; total=0; for(i=2;i<=NF;i++) total+=$i; print (total-idle)*100/total}'"
    }
    
    if success then
      local cpu = tonumber(stdout:match("([%d%.]+)"))
      return cpu and string.format("%.1f%%", cpu) or "N/A"
    end
    
    -- Fallback: top command for Linux
    local success2, stdout2 = wezterm.run_child_process {
      'sh', '-c',
      "top -bn1 | grep 'Cpu(s)' | awk '{print $2}' | sed 's/%us,//'"
    }
    
    if success2 then
      local cpu = tonumber(stdout2:match("([%d%.]+)"))
      return cpu and string.format("%.1f%%", cpu) or "N/A"
    end
    
  elseif os_name == "Darwin" then
    -- macOS: Use iostat for more accurate CPU measurement
    local success, stdout = wezterm.run_child_process {
      'sh', '-c',
      "iostat -c 1 | tail -n 1 | awk '{print 100-$6}'"
    }
    
    if success then
      local cpu = tonumber(stdout:match("([%d%.]+)"))
      return cpu and string.format("%.1f%%", cpu) or "N/A"
    end
    
    -- Fallback: top for macOS
    local success2, stdout2 = wezterm.run_child_process {
      'sh', '-c',
      "top -l 1 -n 0 | grep 'CPU usage' | awk '{print $3}' | sed 's/%//'"
    }
    
    if success2 then
      local cpu = tonumber(stdout2:match("([%d%.]+)"))
      return cpu and string.format("%.1f%%", cpu) or "N/A"
    end
  end
  
  return "N/A"
end

-- Function to get RAM usage (Linux/macOS)
local function get_ram_usage()
  local os_name = get_os()
  
  if os_name == "Linux" then
    -- Linux: Use /proc/meminfo for accurate memory info
    local success, stdout = wezterm.run_child_process {
      'sh', '-c',
      "awk '/MemTotal/ {total=$2} /MemAvailable/ {avail=$2} END {printf \"%.1f\", ((total-avail)/total)*100}' /proc/meminfo"
    }
    
    if success and stdout ~= "" then
      return stdout .. "%"
    end
    
    -- Fallback: free command
    local success2, stdout2 = wezterm.run_child_process {
      'sh', '-c',
      "free | grep '^Mem:' | awk '{printf \"%.1f\", ($3/$2)*100}'"
    }
    
    if success2 and stdout2 ~= "" then
      return stdout2 .. "%"
    end
    
  elseif os_name == "Darwin" then
    -- macOS: Use memory_pressure for accurate memory info
    local success, stdout = wezterm.run_child_process {
      'sh', '-c',
      "memory_pressure | grep 'System-wide memory free percentage' | awk '{print 100-$5}' | sed 's/%//'"
    }
    
    if success and stdout ~= "" then
      local mem = tonumber(stdout:match("([%d%.]+)"))
      return mem and string.format("%.1f%%", mem) or "N/A"
    end
    
    -- Fallback: vm_stat (simplified)
    local success2, stdout2 = wezterm.run_child_process {
      'sh', '-c',
      "vm_stat | awk 'BEGIN {total=used=0} /Pages free/ {free=$3+0} /Pages active/ {active=$3+0} /Pages inactive/ {inactive=$3+0} /Pages speculative/ {spec=$3+0} /Pages wired/ {wired=$3+0} END {total=free+active+inactive+spec+wired; used=active+inactive+wired; if(total>0) printf \"%.1f\", (used/total)*100}'"
    }
    
    if success2 and stdout2 ~= "" then
      return stdout2 .. "%"
    end
  end
  
  return "N/A"
end

wezterm.on('update-right-status', function(window, pane)
  local os_name = get_os()
  local cpu, ram
  
    cpu = get_cpu_usage()
    ram = get_ram_usage()
  
  -- Get current time
  local date = wezterm.strftime('%H:%M:%S')
  
  -- Get battery info (if available)
  local battery = ''
  for _, b in ipairs(wezterm.battery_info()) do
    battery = string.format('🔋%.0f%% ', b.state_of_charge * 100)
  end
  
  -- Build status string with color coding
  local status = {}
  
  -- CPU usage with color coding
  table.insert(status, { Text = '💻 ' })
  local cpu_val = tonumber(cpu:match("([%d%.]+)"))
  if cpu_val then
    if cpu_val > 80 then
      table.insert(status, { Foreground = { Color = '#ff6b6b' } }) -- Red for high CPU
    elseif cpu_val > 50 then
      table.insert(status, { Foreground = { Color = '#ffa500' } }) -- Orange for medium CPU
    else
      table.insert(status, { Foreground = { Color = '#50fa7b' } }) -- Green for low CPU
    end
  end
  table.insert(status, { Text = cpu })
  table.insert(status, { Foreground = { Color = '#ffffff' } }) -- Reset color
  
  -- RAM usage with color coding
  table.insert(status, { Text = ' 🧠 ' })
  local ram_val = tonumber(ram:match("([%d%.]+)"))
  if ram_val then
    if ram_val > 80 then
      table.insert(status, { Foreground = { Color = '#ff6b6b' } }) -- Red for high RAM
    elseif ram_val > 60 then
      table.insert(status, { Foreground = { Color = '#ffa500' } }) -- Orange for medium RAM
    else
      table.insert(status, { Foreground = { Color = '#50fa7b' } }) -- Green for low RAM
    end
  end
  table.insert(status, { Text = ram })
  table.insert(status, { Foreground = { Color = '#ffffff' } }) -- Reset color
  
  -- Battery (if available)
  if battery ~= '' then
    table.insert(status, { Text = ' ' .. battery })
  end
  
  -- Time
  table.insert(status, { Text = ' 🕒 ' .. date })
  
  window:set_right_status(wezterm.format(status))
end)

-- Optional: Left status with workspace and leader key indicator
wezterm.on('update-status', function(window, pane)
  local leader = window:leader_is_active() and '🔑 LEADER' or ''
  
  local status = {}
  
  if leader ~= '' then
    table.insert(status, { Foreground = { Color = '#ff6b6b' } })
    table.insert(status, { Text = leader .. ' ' })
    table.insert(status, { Foreground = { Color = '#ffffff' } })
  end
  
  window:set_left_status(wezterm.format(status))
end)

local mux = wezterm.mux
-- Fullscreen
wezterm.on(
    "gui-startup",
    function(cmd)
        local tab, pane, window = mux.spawn_window(cmd or {})
        local gui_window = window:gui_window()
        gui_window:perform_action(wezterm.action.ToggleFullScreen, pane)
    end
)
return config
