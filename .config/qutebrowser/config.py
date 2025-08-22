# import themes.pywalQute.draw


# pylint: disable=C0111
c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103


# set the flavor you'd like to use
# valid options are 'mocha', 'macchiato', 'frappe', and 'latte'
# last argument (optional, default is False): enable the plain look for the menu rows

# themes
# catppuccin.setup(c, 'mocha', True)
# themes.pywalQute.draw.color(c, {
#     'spacing': {
#         'vertical': 6,
#         'horizontal': 8
#     }
# })
# config.source('themes/qute-city-lights/city-lights-theme.py')
config.source("themes/gruvbox/gruvbox.py")
# config.source('themes/breath/breath.py')

# dracula.draw.blood(c, {
#     'spacing': {
#         'vertical': 6,
#         'horizontal': 8
#     }
# })
# config.source('themes/dracula/draw.py')
# config.source('themes/matrix/matrix.py')
# config.source('themes/qutewal/qutewal.py')
c.url.searchengines = {
    # note - if you use duckduckgo, you can make use of its built in bangs, of which there are many! https://duckduckgo.com/bangs
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "!aw": "https://wiki.archlinux.org/?search={}",
    "!apkg": "https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged=",
    "!gh": "https://github.com/search?o=desc&q={}&s=stars",
    "!yt": "https://www.youtube.com/results?search_query={}",
}

c.completion.open_categories = [
    "searchengines",
    "quickmarks",
    "bookmarks",
    "history",
    "filesystem",
]


c.fonts.default_family = "Ubuntu Nerd Font"
c.tabs.title.format = "{audio}{current_title}"
c.auto_save.session = True  # save tabs on quit/restart

config.set("colors.webpage.darkmode.enabled", False)
config.load_autoconfig(True)

# Go back in the history of the current tab.
# (like kill buffer, because usually this fall back to the previous buffer)
config.bind("<Space>b", "back")
config.bind("<Space>f", "forward")

# Show all bookmarks/quickmarks
config.unbind("Sb")  # --jump
config.unbind("Sq")  # no jump; what the hell is this jump flag anyway?
config.bind("<Space><Return>", "bookmark-list --jump")

c.content.autoplay = False
c.content.pdfjs = True

# Show browsing history
config.unbind("Sh")
config.bind("<Space>h", "history")

# safer reload page
config.unbind("r")
config.bind("<Space>r", "reload")

config.unbind("d")
config.bind("<Space>x", "tab-close")


c.scrolling.bar = "always"

c.scrolling.smooth = True
# Disable JS globally
# c.content.javascript.enabled = False
# This is an equivalent form, I re-write in this other form for uniformity's sake in this particular block.
config.set("content.javascript.enabled", True)
# Enable it on DDG
config.set("content.javascript.enabled", True, "*://duckduckgo.com/")
config.set("content.javascript.enabled", True, "*://localhost")

# javascript enable
config.bind("<Space>je", ":set content.javascript.enabled true")
# javascript disable
config.bind("<Space>jd", ":set content.javascript.enabled false")

config.bind("D", "hint links spawn st -e youtube-dl {hint-url}")
config.bind("P", "hint links spawn  mpv {hint-url}")

# Load autoconfig.yml
config.load_autoconfig()

# Bind 'xb' to run the Bitwarden userscript
config.bind("xb", "spawn --userscript qute-bitwarden")

# Optional: If you want to automatically copy TOTP to clipboard
config.bind("xt", "spawn --userscript qute-bitwarden --totp", mode="normal")

# Optional: If you want to specify your dmenu/rofi invocation (if not default)
# This is often needed if you use rofi and want specific styling or options.
# For rofi, a good default might be:
# config.bind('xb', 'spawn --userscript qute-bitwarden --dmenu-invocation "rofi -dmenu -i -p Bitwarden"')
# For a password prompt (e.g., if bw is locked):
# config.bind('xb', 'spawn --userscript qute-bitwarden --password-prompt-invocation "rofi -dmenu -p Master Password -password"')

config.bind(
    "<Alt-Shift-u>",
    "spawn --userscript qute-keepassxc --key 6703057CC4E82806E3D1002FAC892382B987709A",
    mode="insert",
)
config.bind(
    "pw",
    "spawn --userscript qute-keepassxc --key 6703057CC4E82806E3D1002FAC892382B987709A",
    mode="normal",
)
