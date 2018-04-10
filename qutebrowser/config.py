c.auto_save.interval = 0
c.auto_save.session = True
#c.session.lazy_restore = True
c.completion.shrink = True
c.confirm_quit = ['downloads']
c.content.default_encoding = 'utf-8'
#c.content.dns_prefetch = False
c.content.geolocation = False
c.content.headers.accept_language = 'en_US,en,ja_JP,ja'
c.content.media_capture = False
#c.content.notifications = False
c.content.print_element_backgrounds = False
c.content.user_stylesheets = 'userstyle.css'
c.content.windowed_fullscreen = True
#downloads.location.directory =
#c.downloads.location.prompt = False
c.downloads.position = 'bottom'
c.editor.command = [
	'mlterm', '-e',
	'sh', '-c',
	"kak -e  'execute-keys i' +{line}:{column} {file}"
]
c.hints.mode = 'number'
#c.input.forward_unbound_keys = False
c.input.partial_timeout = 0
c.keyhint.delay = 0
c.messages.timeout = 0
c.statusbar.padding = {
	'bottom': 1,
	'left': 5,
	'right': 5,
	'top': 1
}
c.statusbar.widgets = [
	'keypress',
	'progress',
	'history',
	'url',
	'scroll',
	'tabs'
]
c.tabs.close_mouse_button = 'none'
c.tabs.close_mouse_button_on_bar = 'ignore'
c.tabs.indicator.padding = {
	'bottom': 0,
	'left': 0,
	'right': 5,
	'top': 0
}
c.tabs.indicator.width = 2
c.tabs.last_close = 'default-page'
c.tabs.mousewheel_switching = False
c.tabs.padding = {
	'bottom': 1,
	'left': 0,
	'right': 0,
	'top': 1
}
c.tabs.wrap = False
c.window.title_format = '{title}{title_sep}qutebrowser'
#c.url.yank_ignored_parameters =

fontsize = '12pt '
mono = fontsize + 'monospace'
#serif = fontsize + 'serif'
sans = fontsize + 'sans-serif'
c.fonts.completion.category = sans
c.fonts.completion.entry = mono
c.fonts.debug_console = mono
c.fonts.downloads = sans
c.fonts.hints = mono
c.fonts.keyhint = mono
c.fonts.messages.error = sans
c.fonts.messages.info = sans
c.fonts.messages.warning = sans
c.fonts.prompts = sans
c.fonts.statusbar = mono
c.fonts.tabs = mono
c.fonts.monospace = 'monospace'

webfontsize = 16
c.fonts.web.size.default = webfontsize
c.fonts.web.size.default_fixed = webfontsize
c.fonts.web.size.minimum = webfontsize

#c.hints.next_regexes = [
	#'\\bnext\\b',
	#'\\bmore\\b',
	#'\\bnewer\\b',
	#'\\b[>≫»]\\b',
	#'\\b>>\\b',
	#'\\bcontinue\\b',
	#'\\b次の?ページへ?\\b',
	#'\\b次[へに]?(進む)?\\b'
	#'\\bもっと読む\\b'
#]
#c.hints.prev_regexes = [
	#'\\bprev(ious)?\\b',
	#'\\bback\\b',
	#'\\bolder\\b',
	#'\\b[<←≪«]\\b',
	#'\\b<<\\b',
	#'\\b前の?ページへ?\\b',
	#'\\b前[へに]?(戻る)?\\b'
#]
homepage = 'qute://bookmarks/'
c.url.default_page = homepage
c.url.start_pages = [ homepage ]

c.url.searchengines = {
	#'DEFAULT': 'https://duckduckgo.com?q={}',
	'DEFAULT': 'https://google.com/search?q={}',
	#[J]apanese dictionary
	'j': 'https://dictionary.goo.ne.jp/freewordsearcher.html?mode=1&kind=jn&MT={}',
	#[E]nglish dictionary
	'e': 'https://oxfordlearnersdictionaries.com/search/english/?q={}',
	#Japanese-[E]nglish dictionary
	'E': 'http://eow.alc.co.jp/search?q={}',
	#[G]ithub
	'g': 'https://github.com/search?q={}',
	#[I]mage
	'i': 'https://google.com/search?tbm=isch&q={}',
	#[V]ideo
	'v': 'https://google.com/search?tbm=vid&q={}',
	#'v' 'https://youtube.com/results?search_query={}'
	#arch [L]inux wiki
	'l': 'https://wiki.archlinux.org?search={}',
	#[W]ikipedia
	'w': 'https://wikipedia.org/wiki?search={}',
	'W': 'https://ja.wikipedia.org/wiki?search={}',
	#[P]ackage
	'p': 'https://aur.archlinux.org/packages/?K={}',
	#[H]askell
	'h': 'https://hackage.haskell.org/package/search?terms={}',
	#[R]ust
	'r': 'https://crates.io/search?q={}',
}

fg = '#CCC'
bg = '#000'
dim_bg = '#555'
menu_bg = '#124'
selected_bg = '#152'
error_bg = '#800'
warn_bg = '#660'
red = '#F33'
cyan = '#4EF'
white = '#FFF'
gray = '#888'
green = '#0D0'
c.colors.completion.category.bg = bg
c.colors.completion.category.fg = fg
c.colors.completion.fg = fg
c.colors.completion.even.bg = menu_bg
c.colors.completion.odd.bg = menu_bg
c.colors.completion.item.selected.bg = selected_bg
c.colors.completion.item.selected.border.bottom = selected_bg
c.colors.completion.item.selected.border.top = selected_bg
c.colors.completion.item.selected.fg = fg
c.colors.completion.match.fg = green
c.colors.completion.scrollbar.bg = menu_bg
c.colors.completion.scrollbar.fg = fg
c.colors.downloads.bar.bg = bg
c.colors.downloads.error.bg = error_bg
c.colors.downloads.error.fg = fg
c.colors.downloads.start.bg = bg
c.colors.downloads.start.fg = fg
c.colors.downloads.stop.bg = bg
c.colors.downloads.stop.fg = fg
c.colors.downloads.system.bg = 'none'
c.colors.downloads.system.fg = 'none'
#c.colors.hints.bg = bg
#c.colors.hints.fg = fg
#c.hints.border = '1px solid ' + bg
#c.colors.hints.match.fg = green
c.colors.keyhint.bg = menu_bg
c.colors.keyhint.fg = fg
c.colors.keyhint.suffix.fg = green
c.colors.messages.error.bg = error_bg
c.colors.messages.error.border = error_bg
c.colors.messages.error.fg = white
c.colors.messages.info.bg = menu_bg
c.colors.messages.info.border = menu_bg
c.colors.messages.info.fg = white
c.colors.messages.warning.bg = warn_bg
c.colors.messages.warning.border = warn_bg
c.colors.messages.warning.fg = fg
c.colors.prompts.bg = menu_bg
c.colors.prompts.border = '0px'
c.colors.prompts.fg = fg
c.colors.prompts.selected.bg = selected_bg
c.colors.statusbar.caret.bg = selected_bg
c.colors.statusbar.caret.fg = fg
c.colors.statusbar.caret.selection.bg = bg
c.colors.statusbar.caret.selection.fg = fg
c.colors.statusbar.command.bg = bg
c.colors.statusbar.command.fg = fg
c.colors.statusbar.command.private.bg = bg
c.colors.statusbar.command.private.fg = fg
c.colors.statusbar.insert.bg = selected_bg
c.colors.statusbar.insert.fg = fg
c.colors.statusbar.normal.bg = bg
c.colors.statusbar.normal.fg = fg
c.colors.statusbar.passthrough.bg = selected_bg
c.colors.statusbar.passthrough.fg = fg
c.colors.statusbar.private.bg = bg
c.colors.statusbar.private.fg = fg
c.colors.statusbar.progress.bg = fg
c.colors.statusbar.url.fg = gray
c.colors.statusbar.url.success.http.fg = gray
c.colors.statusbar.url.success.https.fg = gray
c.colors.statusbar.url.hover.fg = cyan
c.colors.statusbar.url.warn.fg = red
c.colors.tabs.bar.bg = red
c.colors.tabs.even.bg = dim_bg
c.colors.tabs.even.fg = fg
c.colors.tabs.odd.bg = dim_bg
c.colors.tabs.odd.fg = fg
c.colors.tabs.indicator.error = red
c.colors.tabs.indicator.start = fg
c.colors.tabs.indicator.stop = fg
c.colors.tabs.indicator.system = 'none'
c.colors.tabs.selected.even.bg = bg
c.colors.tabs.selected.even.fg = fg
c.colors.tabs.selected.odd.bg = bg
c.colors.tabs.selected.odd.fg = fg

c.content.host_blocking.lists = [
	'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts',
	'https://warui.intaa.net/adhosts/hosts.txt'
]
c.content.host_blocking.whitelist = [
]

c.bindings.default = {}
c.bindings.key_mappings = {}
config.bind('<Escape>', 'leave-mode ;; set input.insert_mode.auto_enter true', mode = 'caret')
config.bind('<Space>', 'toggle-selection', mode = 'caret')
config.bind('<Home>', 'move-to-end-of-line', mode = 'caret')
config.bind('<End>', 'move-to-start-of-line', mode = 'caret')
config.bind('<Left>', 'move-to-prev-char', mode = 'caret')
config.bind('<Down>', 'move-to-next-line', mode = 'caret')
config.bind('<Up>', 'move-to-prev-line', mode = 'caret')
config.bind('<Right>', 'move-to-next-char', mode = 'caret')
config.bind('<PgUp>', 'scroll-page 0 0.5', mode = 'caret')
config.bind('<PgDown>', 'scroll-page 0 0.5', mode = 'caret')
config.bind('b', 'move-to-prev-word', mode = 'caret')
config.bind('w', 'move-to-next-word', mode = 'caret')
config.bind('e', 'move-to-end-of-word', mode = 'caret')
config.bind('g', 'move-to-start-of-document', mode = 'caret')
config.bind('G', 'move-to-end-of-document', mode = 'caret')
config.bind('y', 'yank selection', mode = 'caret')
#config.bind('Y', 'drop-selection ;; move-to-start-of-line ;; toggle-selection ;; move-to-end-of-line ;; yank selection', mode = 'caret')
config.bind('[', 'move-to-start-of-prev-block', mode = 'caret')
config.bind(']', 'move-to-start-of-next-block', mode = 'caret')
config.bind('{', 'move-to-end-of-prev-block', mode = 'caret')
config.bind('}', 'move-to-end-of-next-block', mode = 'caret')

config.bind('<Escape>', 'leave-mode', mode = 'hint')
config.bind('<Return>', 'follow-hint', mode = 'hint')

config.bind('<Alt-e>', 'open-editor', mode = 'insert')
config.bind('<Shift-Ins>', 'insert-text {primary}', mode = 'insert')
config.bind('<Alt-p>', 'insert-text {clipboard}', mode = 'insert')

config.bind('<Tab>', 'completion-item-focus next', mode = 'command')
config.bind('<Shift-Tab>', 'completion-item-focus prev', mode = 'command')
config.bind('<Up>', 'completion-item-focus --history prev', mode = 'command')
config.bind('<Down>', 'completion-item-focus --history next', mode = 'command')
config.bind('<Alt-f>', 'rl-forward-word', mode = 'command')
config.bind('<Alt-b>', 'rl-backward-word', mode = 'command')
config.bind('<Alt-w>', 'rl-unix-word-rubout', mode = 'command')
config.bind('<Alt-d>', 'rl-kill-word', mode = 'command')
config.bind('<Alt-l>', 'rl-end-of-line ;; rl-unix-line-discard', mode = 'command')
config.bind('<Alt-e>', 'rl-kill-line', mode = 'command')
config.bind('<Alt-h>', 'rl-unix-line-discard', mode = 'command')
config.bind('<Alt-/>', 'rl-unix-filename-rubout', mode = 'command')
config.bind('<Alt-p>', 'rl-yank', mode = 'command')

config.bind('<Tab>', 'prompt-item-focus next', mode = 'prompt')
config.bind('<Shift-Tab>', 'prompt-item-focus prev', mode = 'prompt')
#'<Up>', 'prompt-item-focus --history prev', mode = 'prompt')
#'<Down>', 'prompt-item-focus --history next', mode = 'prompt')
config.bind('<Alt-f>', 'rl-forward-word', mode = 'prompt')
config.bind('<Alt-b>', 'rl-backward-word', mode = 'prompt')
config.bind('<Alt-w>', 'rl-unix-word-rubout', mode = 'prompt')
config.bind('<Alt-d>', 'rl-kill-word', mode = 'prompt')
config.bind('<Alt-l>', 'rl-end-of-line ;; rl-unix-line-discard', mode = 'prompt')
config.bind('<Alt-e>', 'rl-kill-line', mode = 'prompt')
config.bind('<Alt-h>', 'rl-unix-line-discard', mode = 'prompt')
config.bind('<Alt-/>', 'rl-unix-filename-rubout', mode = 'prompt')
config.bind('<Alt-p>', 'rl-yank', mode = 'prompt')
config.bind('<Alt-y>', 'prompt-yank', mode = 'prompt')

config.bind('<Escape>', 'leave-mode', mode = 'yesno')
config.bind('<Return>', 'prompt-accept', mode = 'yesno')
config.bind('y', 'prompt-accept yes', mode = 'yesno')
config.bind('n', 'prompt-accept no', mode = 'yesno')
config.bind('<Alt-y>', 'prompt-yank', mode = 'yesno')

config.bind('<Shift-Escape>', 'leave-mode', mode = 'passthrough')

config.bind('<Escape>', 'leave-mode', mode= 'register')

config.bind('<Escape>', 'clear-keychain ;; search ;; clear-messages ;; fullscreen --leave ;; stop')
config.bind('<Shift-Escape>', 'clear-messages ;; enter-mode passthrough')
config.bind('<Space>', 'clear-messages ;; tab-focus last')
config.bind('<Up>', 'clear-messages ;; scroll up')
config.bind('<Down>', 'clear-messages ;; scroll down')
config.bind('<Left>', 'clear-messages ;; scroll left')
config.bind('<Right>', 'clear-messages ;; scroll right')
config.bind('<PgUp>', 'clear-messages ;; scroll-page 0 -0.5')
config.bind('<PgDown>', 'clear-messages ;; scroll-page 0 0.5')
config.bind('<Home>', 'clear-messages ;; scroll-page -0.5 0')
config.bind('<End>', 'clear-messages ;; scroll-page 0.5 0')
config.bind('i', 'clear-messages ;; enter-mode insert')
config.bind('I', 'clear-messages ;; set hints.auto_follow always ;; later 10 set hints.auto_follow unique-match ;; hint inputs')
config.bind('v', 'clear-messages ;; set input.insert_mode.auto_enter false ;; enter-mode caret')
config.bind(':', 'clear-messages ;; set-cmd-text :')
config.bind(';', 'clear-messages ;; set-cmd-text --space :jseval')
config.bind('/', 'clear-messages ;; set-cmd-text /')
config.bind('?', 'clear-messages ;; set-cmd-text ?')
#next release
#config.bind('#', 'clear-messages ;; set-cmd-text --space scroll-to-anchor')
config.bind('n', 'clear-messages ;; search-next')
config.bind('N', 'clear-messages ;; search-prev')
config.bind('s', 'clear-messages ;; set-cmd-text --space :open')
config.bind('S', 'clear-messages ;; set-cmd-text --space :open -t')
config.bind('ws', 'clear-messages ;; set-cmd-text --space :open -w')
config.bind('o', 'clear-messages ;; home')
config.bind('O', 'clear-messages ;; open -t')
config.bind('wo', 'clear-messages ;; open -w')
config.bind('J', 'clear-messages ;; enter-mode set_mark')
config.bind('j', 'clear-messages ;; enter-mode jump_mark')
config.bind('a', 'clear-messages ;; quickmark-save')
config.bind('A', 'clear-messages ;; quickmark-del')
config.bind('m', 'clear-messages ;; set-cmd-text --space :quickmark-load')
config.bind('M', 'clear-messages ;; set-cmd-text --space :quickmark-load -t')
config.bind('wm', 'clear-messages ;; set-cmd-text --space :quickmark-load -w')
config.bind('d', 'clear-messages ;; tab-close')
config.bind('D', 'clear-messages ;; tab-close --opposite')
config.bind('u', 'clear-messages ;; undo')
config.bind('[', 'clear-messages ;; tab-prev')
config.bind(']', 'clear-messages ;; tab-next')
config.bind('{', 'clear-messages ;; tab-move -')
config.bind('}', 'clear-messages ;; tab-move +')
config.bind('t', 'clear-messages ;; set-cmd-text --space --run-on-count :buffer')
config.bind('T', 'clear-messages ;; tab-focus -1')
config.bind('h', 'clear-messages ;; set-cmd-text --space :history')
config.bind('H', 'clear-messages ;; set-cmd-text --space :history -t')
config.bind('wh', 'clear-messages ;; set-cmd-text --space :history -w')
config.bind('c', 'clear-messages ;; tab-clone')
config.bind('p', 'clear-messages ;; open -- {clipboard}')
config.bind('P', 'clear-messages ;; open -t -- {clipboard}')
config.bind('yy', 'clear-messages ;; yank')
config.bind('yd', 'clear-messages ;; yank domain')
config.bind('yt', 'clear-messages ;; yank title')
config.bind('yp', 'clear-messages ;; yank pretty-url')
config.bind('Y', 'clear-messages ;; hint links yank')
config.bind('g', 'clear-messages ;; scroll-to-perc 0')
config.bind('G', 'clear-messages ;; scroll-to-perc')
#change to element in the future
config.bind('e', 'clear-messages ;; hint all current')
config.bind('E', 'clear-messages ;; hint all tab')
config.bind('we', 'clear-messages ;; hint all window')
config.bind('l', 'clear-messages ;; hint links current')
config.bind('L', 'clear-messages ;; hint links tab')
config.bind('wl', 'clear-messages ;; hint links window')
config.bind('f', 'clear-messages ;; hint')
config.bind('Fe', 'clear-messages ;; hint all hover')
config.bind('Fl', 'clear-messages ;; hint links hover')
#'fa', 'clear-messages ;; hint all current')
#'Fa', 'clear-messages ;; hint all tab')
#'wa', 'clear-messages ;; hint all window')
config.bind('Ff', 'clear-messages ;; hint all hover')
#zoom up image
config.bind('z', 'clear-messages ;; hint images current')
config.bind('Z', 'clear-messages ;; hint images tab')
config.bind('wz', 'clear-messages ;; hint images window')
config.bind('Fz', 'clear-messages ;; hint images hover')
#queue
config.bind('q', 'clear-messages ;; hint --rapid links tab-bg')
config.bind('wq', 'clear-messages ;; hint --rapid links window')
#keep
config.bind('k', 'clear-messages ;; hint links download')
config.bind('K', 'clear-messages ;; download')
config.bind('!', 'clear-messages ;; set-cmd-text --space spawn')
config.bind('V', 'clear-messages ;; view-source --edit')
config.bind('^', 'clear-messages ;; navigate up')
config.bind('<', 'clear-messages ;; navigate prev')
config.bind('>', 'clear-messages ;; navigate next')
config.bind('(', 'clear-messages ;; navigate decrement')
config.bind(')', 'clear-messages ;; navigate increment')
config.bind('b', 'clear-messages ;; back')
config.bind('B', 'clear-messages ;; forward')
config.bind('r', 'clear-messages ;; reload')
config.bind('R', 'clear-messages ;; reload -f')
config.bind('=', 'clear-messages ;; zoom')
config.bind('+', 'clear-messages ;; zoom-in')
config.bind('-', 'clear-messages ;; zoom-out')
config.bind('.', 'clear-messages ;; repeat-command')
config.bind('Ch', 'clear-messages ;; history-clear')
config.bind('Cd', 'clear-messages ;; download-clear')
config.bind('Q', 'clear-messages ;; download-cancel')
config.bind('wi', 'spawn firefox-developer-edition -devtools {url}')

#turn off input method when going back normal mode
config.bind('<Escape>', 'spawn --userscript ibus-off.sh ;; leave-mode', mode='insert')
config.bind('<Escape>', 'spawn --userscript ibus-off.sh ;; leave-mode', mode='command')
config.bind('<Return>', 'spawn --userscript ibus-off.sh ;; command-accept', mode='command')
config.bind('<Escape>', 'spawn --userscript ibus-off.sh ;; leave-mode', mode='prompt')
config.bind('<Return>', 'spawn --userscript ibus-off.sh ;; prompt-accept', mode='prompt')
#config.bind('<Escape>', 'spawn --userscript ibus-off.sh ;; leave-mode', mode='hint')
#config.bind('<Return>', 'spawn --userscript ibus-off.sh ;; follow-hint', mode='hint')


