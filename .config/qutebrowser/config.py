import themes.catppuccin as catppuccin


# set the flavor you'd like to use
# valid options are 'mocha', 'macchiato', 'frappe', and 'latte'
# last argument (optional, default is False): enable the plain look for the menu rows

# themes
# catppuccin.setup(c, 'mocha', True)
config.source('themes/qute-city-lights/city-lights-theme.py')
# config.source('themes/onedark/onedark.py')


c.fonts.default_family = "Ubuntu Nerd Font"

# config.set("colors.webpage.darkmode.enabled", False)
# c.colors.tabs.bar.bg = None
config.load_autoconfig(True)

# Go back in the history of the current tab.
# (like kill buffer, because usually this fall back to the previous buffer)
config.bind('<Space>bk', 'back')

# Show all bookmarks/quickmarks
config.unbind('Sb') # --jump
config.unbind('Sq') # no jump; what the hell is this jump flag anyway?
config.bind('<Space><Return>', 'bookmark-list --jump')

# Show browsing history
config.unbind('Sh')
config.bind('<Space>h', 'history')

# safer reload page
config.unbind('r')
config.bind('<Space>rr', 'reload')

c.tabs.position = "top"

c.scrolling.bar ='always'
