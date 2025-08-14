-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
config.font = wezterm.font_with_fallback { 'JetBrainsMono NF', 'Noto Color Emoji' }


local cyberpunk_colors = {
  -- Dark base colors (backgrounds)
  deep_black = '#0a0a0a',        -- Almost pure black
  void_black = '#111111',        -- Slightly lighter black
  dark_purple = '#1a0d26',       -- Deep purple shadow
  matrix_black = '#0f1419',      -- Dark matrix green-black

  -- Main neon colors
  electric_cyan = '#00ffff',     -- Bright electric cyan
  hot_pink = '#ff007f',          -- Vibrant hot pink
  neon_green = '#39ff14',        -- Bright neon green
  electric_blue = '#0080ff',     -- Electric blue
  cyber_purple = '#8a2be2',      -- Deep cyber purple
  neon_magenta = '#ff00ff',      -- Pure magenta

  -- Accent colors
  laser_red = '#ff0040',         -- Laser red
  hologram_orange = '#ff8c00',   -- Holographic orange
  plasma_yellow = '#ffff00',     -- Plasma yellow

  -- Muted/secondary colors
  dim_cyan = '#66cccc',          -- Dimmed cyan
  soft_pink = '#ff69b4',         -- Softer pink
  ghost_green = '#00ff7f',       -- Ghostly green
  pale_purple = '#9370db',       -- Pale purple

  -- Text colors
  bright_white = '#ffffff',      -- Pure white
  cool_gray = '#cccccc',         -- Cool gray
  warm_gray = '#999999',         -- Warm gray
  dark_gray = '#666666',         -- Dark gray

  -- Status indicators
  critical_red = '#ff073a',      -- Critical alert red
  warning_orange = '#ff9500',    -- Warning orange
  success_green = '#00ff41',     -- Success green
  info_blue = '#00bfff',         -- Info blue
}
-- Centralized color palette for tab bar - easy to modify
local home = os.getenv("HOME")
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
      File = home .. "/.config/wezterm/bg.png"
    },
    -- The texture tiles vertically but not horizontally.
    -- When we repeat it, mirror it so that it appears "more seamless".
    -- An alternative to this is to set `width = "100%"` and have
    -- it stretch across the display
    repeat_x = "NoRepeat",
    hsb = dimmer,
    -- When the viewport scrolls, move this layer 10% of the number of
    -- pixels moved by the main viewport. This makes it appear to be
    -- further behind the text.
    attachment = "Fixed"
  }
}

-- or, changing the font size and color scheme.
config.font_size = 22
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
-- Replace your get_ram_usage() function with one of these approaches
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
    -- Approach 1: Try to match Stats app calculation (exclude speculative pages)
    local success, stdout = wezterm.run_child_process {
      'sh', '-c',
      [[
      vm_stat | awk '
      /Pages free/ { free = $3 + 0 }
      /Pages active/ { active = $3 + 0 }
      /Pages inactive/ { inactive = $3 + 0 }
      /Pages wired/ { wired = $3 + 0 }
      /Pages occupied by compressor/ { compressed = $5 + 0 }
      END {
        total_pages = free + active + inactive + wired + compressed
        used_pages = active + wired + compressed
        if (total_pages > 0) {
          usage = (used_pages / total_pages) * 100
          printf "%.1f", usage
        }
      }'
      ]]
    }

    if success and stdout ~= "" and tonumber(stdout) then
      return stdout .. "%"
    end

    -- Approach 2: Use memory_pressure (more reliable)
    local success2, stdout2 = wezterm.run_child_process {
      'sh', '-c',
      "memory_pressure | grep 'System-wide memory free percentage' | awk '{printf \"%.1f\", 100-$5}'"
    }

    if success2 and stdout2 ~= "" and tonumber(stdout2) then
      return stdout2 .. "%"
    end

    -- Approach 3: Use top command for memory info
    local success3, stdout3 = wezterm.run_child_process {
      'sh', '-c',
      "top -l 1 -s 0 | grep PhysMem | sed 's/PhysMem: //' | awk -F'[, ]' '{used=0; total=0} {for(i=1;i<=NF;i++) {if($i ~ /used/) {gsub(/[^0-9.]/, \"\", $(i-1)); used=$(i-1)} if($i ~ /total/) {gsub(/[^0-9.]/, \"\", $(i-1)); total=$(i-1)}}} END {if(total>0) printf \"%.1f\", (used/total)*100}'"
    }

    if success3 and stdout3 ~= "" and tonumber(stdout3) then
      return stdout3 .. "%"
    end

    -- Approach 4: Alternative vm_stat calculation (exclude inactive pages)
    local success4, stdout4 = wezterm.run_child_process {
      'sh', '-c',
      [[
      vm_stat | awk '
      /Pages free/ { free = $3 + 0 }
      /Pages active/ { active = $3 + 0 }
      /Pages wired/ { wired = $3 + 0 }
      /Pages occupied by compressor/ { compressed = $5 + 0 }
      END {
        total_pages = free + active + wired + compressed
        used_pages = active + wired + compressed  
        if (total_pages > 0) {
          usage = (used_pages / total_pages) * 100
          printf "%.1f", usage
        }
      }'
      ]]
    }

    if success4 and stdout4 ~= "" and tonumber(stdout4) then
      return stdout4 .. "%"
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

  -- Build status string with color coding
  local status = {}

  -- CPU usage with color coding
  table.insert(status, { Foreground = { Color = cyberpunk_colors.electric_cyan } })
  table.insert(status, { Text = wezterm.nerdfonts.fae_chip .. ' ' })
  local cpu_val = tonumber(cpu:match("([%d%.]+)"))
  if cpu_val then
    if cpu_val > 80 then
      table.insert(status, { Foreground = { Color = cyberpunk_colors.laser_red } }) -- Red for high CPU
    elseif cpu_val > 50 then
      table.insert(status, { Foreground = { Color = cyberpunk_colors.plasma_yellow } }) -- Yellow for medium CPU
    else
      table.insert(status, { Foreground = { Color = cyberpunk_colors.electric_cyan } }) -- Green for low CPU
    end
  end
  table.insert(status, { Text = cpu })
  table.insert(status, { Foreground = { Color = '#ffffff' } }) -- Reset color

  -- RAM usage with color coding
  local ram_val = tonumber(ram:match("([%d%.]+)"))
  if ram_val then
    if ram_val > 80 then
      table.insert(status, { Foreground = { Color = cyberpunk_colors.laser_red } }) -- Red for high RAM
    elseif ram_val > 60 then
      table.insert(status, { Foreground = { Color = cyberpunk_colors.plasma_yellow } }) -- Yellow for medium RAM
    else
      table.insert(status, { Foreground = { Color = cyberpunk_colors.electric_cyan } }) -- Green for low RAM
    end
  end

  table.insert(status, { Text = ' ' .. wezterm.nerdfonts.md_memory .. ' ' })
  table.insert(status, { Text = ram })
  table.insert(status, { Foreground = { Color = '#ffffff' } }) -- Reset color

  -- Battery (if available)
  local battery = ''
  for _, b in ipairs(wezterm.battery_info()) do
    if b.state_of_charge >= 0.95 then
      table.insert(status, { Foreground = { Color = cyberpunk_colors.electric_cyan } }) -- Green for low RAM
      battery = string.format(wezterm.nerdfonts.fa_battery_full ..' %.0f%% ', b.state_of_charge * 100)

    elseif b.state_of_charge >= 0.7 then
      battery = string.format(wezterm.nerdfonts.fa_battery_three_quarters ..' %.0f%% ', b.state_of_charge * 100)
    elseif b.state_of_charge >= 0.4 then

      table.insert(status, { Foreground = { Color = cyberpunk_colors.plasma_yellow } }) 
      battery = string.format(wezterm.nerdfonts.fa_battery_half ..' %.0f%% ', b.state_of_charge * 100)
    elseif b.state_of_charge >= 0.1 then

      table.insert(status, { Foreground = { Color = cyberpunk_colors.laser_red } }) 
      battery = string.format(wezterm.nerdfonts.fa_battery_quarter ..' %.0f%% ', b.state_of_charge * 100)
    else

      table.insert(status, { Foreground = { Color = cyberpunk_colors.laser_red } }) 
      battery = string.format(wezterm.nerdfonts.fa_battery_empty ..' %.0f%% ', b.state_of_charge * 100)
    end

  end

  if battery ~= '' then
    table.insert(status, { Text = ' ' .. battery })
  end

  -- Time
  table.insert(status, { Foreground = { Color = cyberpunk_colors.electric_cyan } }) 
  table.insert(status, { Text = ' ' .. wezterm.nerdfonts.fa_clock_o .. ' ' .. date })

  window:set_right_status(wezterm.format(status))
end)

-- Optional: Left status with workspace and leader key indicator
wezterm.on('update-status', function(window, pane)
  local leader = window:leader_is_active() and wezterm.nerdfonts.cod_unlock or wezterm.nerdfonts.cod_lock

  local status = {}

  if leader ~= '' then
    if window:leader_is_active() then
      table.insert(status, { Foreground = { Color = cyberpunk_colors.electric_cyan } }) -- Green when leader is active
    else
      table.insert(status, { Foreground = { Color = cyberpunk_colors.laser_red } }) -- Red when leader is inactive
    end
    table.insert(status, { Text = leader .. ' ' })
    table.insert(status, { Foreground = { Color = '#ffffff' } })
  end

  window:set_left_status(wezterm.format(status))
end)

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false
-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider
local tab_colors = {
  -- Main tab bar background
  tab_bar_bg = '#0b0022',

  -- Active tab colors
  active_tab_bg = cyberpunk_colors.plasma_yellow,
  active_tab_fg = cyberpunk_colors.deep_black,

  -- Inactive tab colors
  inactive_tab_bg = '#1b1032',
  inactive_tab_fg = '#808080',

  -- Hover colors
  hover_tab_bg = '#3b3052',
  hover_tab_fg = '#909090',

  -- New tab button colors
  new_tab_bg = '#1b1032',
  new_tab_fg = '#808080',
  new_tab_hover_bg = '#3b3052',
  new_tab_hover_fg = '#909090',

  -- Tab separator/arrow colors (used in format-tab-title)
  separator_bg = '#0b0022',
}

-- Apply the colors to the config
config.colors = {
  tab_bar = {
    background = tab_colors.tab_bar_bg,

    active_tab = {
      bg_color = tab_colors.active_tab_bg,
      fg_color = tab_colors.active_tab_fg,
      intensity = 'Normal',
      underline = 'None',
      italic = false,
      strikethrough = false,
    },

    inactive_tab = {
      bg_color = tab_colors.inactive_tab_bg,
      fg_color = tab_colors.inactive_tab_fg,
    },

    inactive_tab_hover = {
      bg_color = tab_colors.hover_tab_bg,
      fg_color = tab_colors.hover_tab_fg,
      italic = true,
    },

    new_tab = {
      bg_color = tab_colors.new_tab_bg,
      fg_color = tab_colors.new_tab_fg,
    },

    new_tab_hover = {
      bg_color = tab_colors.new_tab_hover_bg,
      fg_color = tab_colors.new_tab_hover_fg,
      italic = true,
    },
  },
}

-- Updated format-tab-title using the centralized colors
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local background = tab_colors.inactive_tab_bg
  local foreground = tab_colors.inactive_tab_fg

  if tab.is_active then
    background = tab_colors.active_tab_bg
    foreground = tab_colors.active_tab_fg
  elseif hover then
    background = tab_colors.hover_tab_bg
    foreground = tab_colors.hover_tab_fg
  end

  local edge_background = tab_colors.separator_bg
  local edge_foreground = background

  local title = tab.active_pane.title
  if title and #title > 0 then
    title = tab.tab_index + 1 .. " - " .. title
  else
    title = tab.tab_index + 1
  end

  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_LEFT_ARROW },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = ' ' .. title .. ' ' },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_RIGHT_ARROW },
  }
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
