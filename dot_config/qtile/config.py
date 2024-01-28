#   ___ _____ ___ _     _____    ____             __ _       
#  / _ \_   _|_ _| |   | ____|  / ___|___  _ __  / _(_) __ _ 
# | | | || |  | || |   |  _|   | |   / _ \| '_ \| |_| |/ _` |
# | |_| || |  | || |___| |___  | |__| (_) | | | |  _| | (_| |
#  \__\_\|_| |___|_____|_____|  \____\___/|_| |_|_| |_|\__, |
#                                                      |___/ 

# Icons: https://fontawesome.com/search?o=r&m=free

import os
import subprocess
from libqtile import hook, qtile, bar, layout, widget
from libqtile.core.manager import Qtile
# from libqtile.dgroups import simple_key_binder
from libqtile.config import Click, Drag, Group, Key, Match, Screen 
from libqtile.lazy import lazy
from pathlib import Path

from qtile_extras.widget.decorations import PowerLineDecoration


from libqtile import hook
from libqtile.utils import send_notification

# @hook.subscribe.focus_change
# def focus_changed():
#     send_notification("qtile", "Focus changed.")


# --------------------------------------------------------
# Your configuration
# --------------------------------------------------------

# Keyboard layout in autostart.sh

# Show wlan status bar widget (set to False if wired network)
# show_wlan = True
show_wlan = False

# Show bluetooth status bar widget
# show_bluetooth = True
show_bluetooth = False

# --------------------------------------------------------
# General Variables
# --------------------------------------------------------

# Get home path
home = str(Path.home())


# --------------------------------------------------------
# Define Status Bar
# --------------------------------------------------------
# wm_bar = "polybar"
# wm_bar = "qtile"


# --------------------------------------------------------
# Check for Desktop/Laptop
# --------------------------------------------------------

# 3 = Desktop
platform = int(os.popen("cat /sys/class/dmi/id/chassis_type").read())

# --------------------------------------------------------
# Set default apps
# --------------------------------------------------------

terminal = "alacritty"        

# --------------------------------------------------------
# Keybindings
# --------------------------------------------------------

mod = "mod4" # SUPER KEY


from libqtile.widget.backlight import ChangeDirection


keys = [

    # Focus (everything works)
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window around"),
    
    # Move (everything works)
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),

    # Swap (works, but should we keep it or removed it ?)
    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),

    # Size (everything works)
    Key([mod, "control"], "Down", lazy.layout.shrink(), desc="Grow window to the left"),
    Key([mod, "control"], "Up", lazy.layout.grow(), desc="Grow window to the right"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Floating (works)
    Key([mod], "t", lazy.window.toggle_floating(), desc='Toggle floating'),
    
    # Split (do nothing)
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),

    # Toggle Layouts (works)
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),

    # Fullscreen (works)
    Key([mod], "f", lazy.window.toggle_fullscreen()),

    # Screenshots (works, needed to add shell=True to work)
    Key([], "Print", lazy.spawn("maim ~/Downloads/$(date +%s).png --select", shell=True), desc="Take a Screenshotsomething"),

    #System (works)
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "q",  lazy.shutdown()),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "y", lazy.restart()),
    Key([mod, "mod1"], "l", lazy.spawn("sleep 0.3; betterlockscreen -l", shell=True), desc="Suspend and lock"),

    # Volume (works, but XF86AudioLowerVolume/Up doesn't work)

    Key([mod, "control"], "j", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -2%")),
    Key([mod, "control"], "k", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +2%")),
    Key([mod, "control"], "m", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    # Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -2%")),
    # Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +2%")),
    # Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),

    # Brightness (works, but XF86MonBrightnessUp/Down doesn't work)
    Key([mod, "shift"], "k", lazy.spawn("brightnessctl set +10%", shell=True)),
    Key([mod, "shift"], "j", lazy.spawn("brightnessctl set 10%-", shell=True)),
    # Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-", shell=True)),
    # Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set 10%-", shell=True)),


    # Switch Groups (works)
    Key(["mod1"], "Tab", lazy.screen.next_group(), desc="Switch Group"),
    Key(["mod1", "control"], "Tab", lazy.screen.prev_group(), desc="Switch Group"),

    # Apps
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "i", lazy.spawn("rofi -show drun"), desc="Display available Apps"),
    Key([mod], "b", lazy.spawn("/opt/brave.com/brave/brave"), desc="Launch Brave browser"),
    Key([mod], "p", lazy.spawn("/usr/bin/bruno"), desc="Launch Bruno"),
    Key([mod, "shift"], "p", lazy.spawn("/snap/bin/postman"), desc="Launch Postman"),
    Key([mod], "o", lazy.spawn("/snap/bin/obsidian"), desc="Launch Obsidian"),
    Key([mod], "n", lazy.spawn("/usr/share/code/code"), desc="Launch VSCode")

]


# --------------------------------------------------------
# Groups
# --------------------------------------------------------


groups = [
    Group("a", layout='monadtall', screen_affinity=0),
    Group("z", layout='monadtall', screen_affinity=1),
    Group('e', layout='monadtall', screen_affinity=1),# matches=[Match(wm_class="brave")]),
]

def go_to_group(name: str):
    def _inner(qtile: Qtile) -> None:
        if len(qtile.screens) == 1:
            qtile.groups_map[name].toscreen()
            return

        if name in 'a':
            qtile.focus_screen(0)
            qtile.groups_map[name].toscreen()
        else:
            qtile.focus_screen(1)
            qtile.groups_map[name].toscreen()

    return _inner

for group in groups:
    keys.append(Key([mod], group.name, lazy.function(go_to_group(group.name))))
    # keys.append(Key(["mod4"], group.name, lazy.group[group.name].toscreen()))
    keys.append(Key([mod, "shift"], group.name, lazy.window.togroup(group.name)))


# --------------------------------------------------------
# Scratchpads
# --------------------------------------------------------

# groups.append(ScratchPad("6", [
#     DropDown("chatgpt", "chromium --app=https://chat.openai.com", x=0.3, y=0.1, width=0.40, height=0.4, on_focus_lost_hide=False ),
#     DropDown("mousepad", "mousepad", x=0.3, y=0.1, width=0.40, height=0.4, on_focus_lost_hide=False ),
#     DropDown("terminal", "alacritty", x=0.3, y=0.1, width=0.40, height=0.4, on_focus_lost_hide=False ),
#     DropDown("scrcpy", "scrcpy -d", x=0.8, y=0.05, width=0.15, height=0.6, on_focus_lost_hide=False )
# ]))

# keys.extend([
#     Key([mod], 'F10', lazy.group["6"].dropdown_toggle("chatgpt")),
#     Key([mod], 'F11', lazy.group["6"].dropdown_toggle("mousepad")),
#     Key([mod], 'F12', lazy.group["6"].dropdown_toggle("terminal")),
#     Key([mod], 'F9', lazy.group["6"].dropdown_toggle("scrcpy"))
# ])

# --------------------------------------------------------
# Pywal Colors
# --------------------------------------------------------


# --------------------------------------------------------
# Setup Layout Theme
# --------------------------------------------------------

layout_theme = { 
    "border_width": 3,
    "margin": 15,
    "border_normal": "FFFFFF",
    "single_border_width": 3
}

# --------------------------------------------------------
# Layouts
# --------------------------------------------------------

layouts = [
    layout.Max(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.RatioTile(**layout_theme),
    layout.Floating()
]

# --------------------------------------------------------
# Setup Widget Defaults
# --------------------------------------------------------

widget_defaults = dict(
    font="Fira Sans SemiBold",
    fontsize=24,#14,
    padding=3
)
extension_defaults = widget_defaults.copy()

# --------------------------------------------------------
# Decorations
# https://qtile-extras.readthedocs.io/en/stable/manual/how_to/decorations.html
# --------------------------------------------------------

decor_left = {
    "decorations": [
        PowerLineDecoration(
            path="arrow_left"
            # path="rounded_left"
            # path="forward_slash"
            # path="back_slash"
        )
    ],
}

decor_right = {
    "decorations": [
        PowerLineDecoration(
            path="arrow_right"
            # path="rounded_right"
            # path="forward_slash"
            # path="back_slash"
        )
    ],
}

# --------------------------------------------------------
# Widgets
# --------------------------------------------------------

GREY = "#222222"
DARK_GREY = "#111111"
BLUE = "#759bed"
DARK_BLUE = "#545AA7"
ORANGE = "#dd6600"
DARK_ORANGE = "#371900"

def parse_notification(message):
    return message.replace("\n", "⏎")

widget_list = [
    widget.TextBox(
        **decor_left,
        text='Apps',
        foreground='ffffff',
        desc='',
        padding=30,
        mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("rofi -show drun")},
    ),
    widget.GroupBox(padding=10, borderwidth=0, active=BLUE, inactive=GREY, highlight_method="block", rounded=False, highlight_color=DARK_BLUE),
    widget.CurrentLayoutIcon(scale=0.6, padding=20),
    widget.Spacer(length=2000),
    # widget.Bluetooth(
    #     **decor_right,
    #     padding=10,
    #     mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("blueman-manager")},
    # ),
    # widget.Wlan(
    #     **decor_right,
    #     padding=10,
    #     format='{essid} {percent:2.0%}',
    #     mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("alacritty -e nmtui")},
    # ),
    widget.Memory(
        **decor_right,
        padding=20,        
        measure_mem='G',
        format="RAM: {MemUsed:.0f}{mm} ({MemTotal:.0f}{mm})"
    ),
    widget.DF(
        **decor_right,
        padding=20, 
        visible_on_warn=False,
        format="Disk: {p} {uf}{m} ({r:.0f}%)"
    ),
    widget.CPU(**decor_right, padding=20),
    widget.BatteryIcon(),
    widget.Battery(),

    widget.Spacer(length=55),
    widget.Volume(
        theme_path = '~/.config/qtile/assets/volume/',
        # volume_up_command='pactl set-sink-volume @DEFAULT_SINK@ +2%',
        # volume_down_command='pactl set-sink-volume @DEFAULT_SINK@ -2%',
        # padding=20,
        step=5,
        mouse_callbacks = {'Button1': lazy.spawn("pavucontrol")},
        # mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(terminal + ' -e pactl set-sink-mute @DEFAULT_SINK@ toggle')}
    ),
    widget.Clock(format=" ⏱ %H:%M  <span color='#666'>%A %d-%m-%Y</span>  "),
]


# --------------------------------------------------------
# Screens
# --------------------------------------------------------

# On Ubuntu
# Single Monitor
# res: 3840x2400 (16:10)
# Refresh Rate: 59.99 Hz
# Scale: 200%
# Fractional Scaling: True

# To reproduce it:
# ~/.Xresources
# Xft.dpi: 192
# #!/bin/sh
# xrandr --output eDP-1 --primary --mode 3840x2400 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off

wm_bar = "qtile"
# wm_bar = "polybar"

if (wm_bar == "polybar"):
    screens = [Screen(top=bar.Gap(size=28))]
else:
    screens = [
        Screen(
            top=bar.Bar(
                widget_list,
                48,#30,
                padding=20,
                opacity=0.7,
                border_width=[0, 0, 0, 0],
                margin=[0,0,0,0],
                background="#2e3440"
            ),
        ),
        Screen(),
    ]

# --------------------------------------------------------
# Drag floating layouts
# --------------------------------------------------------

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

# --------------------------------------------------------
# Define floating layouts
# --------------------------------------------------------

floating_layout = layout.Floating(
    border_width=3,
    border_normal="FFFFFF",
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)

# --------------------------------------------------------
# General Setup
# --------------------------------------------------------

follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# --------------------------------------------------------
# Windows Manager Name
# --------------------------------------------------------

wmname = "QTILE"


# --------------------------------------------------------
# Hooks
# --------------------------------------------------------

# HOOK startup
@hook.subscribe.startup_once
def autotart():
    autostartscript = "~/.config/qtile/autostart.sh"
    home = os.path.expanduser(autostartscript)
    subprocess.run([home])
