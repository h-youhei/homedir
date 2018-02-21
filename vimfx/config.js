const OPTIONS = {
	'prevent_autofocus': true,
	'hints.chars': '01234567 89',
	'timeout': 10000,
	//fromDefault('prev_patterns', `${def} 前(の)?ページ(へ)? 前(へ|に)(戻る)?`)
	//fromDefault('next_patterns', `${def} 次(の)?ページ(へ)? 次(へ|に)(進む)?`)
}

const NORMAL_MAPPINGS = {
	'focus_search_bar': 's',
	'paste_and_go': '',
	'paste_and_go_in_tab': 'p',
	'copy_current_url': 'y',
	'go_up_path': '^',
	'go_to_root': 'g^',
	'history_back': 'h',
	'history_forward': 'H',
	'history_list': '<a-h>',
	'reload_force': '<a-r>',
	'reload_all': '',
	'reload_all_force': '',
	'stop': 'R',
	'stop_all': '',
	'scroll_left': '<left>',
	'scroll_right': '<right>',
	'scroll_down': '<down>',
	'scroll_up': '<up>',
	'scroll_page_down': '<pagedown>',
	'scroll_page_up': '<pageup>',
	'scroll_half_page_down': '',
	'scroll_half_page_up': '',
	'scroll_to_top': '<s-pageup>',
	'scroll_to_bottom': '<s-pagedown>',
	'scroll_to_left': '<home>',
	'scroll_to_right': '<end>',
	'mark_scroll_position': 'M',
	'scroll_to_mark': 'm',
	'scroll_to_previous_position': '',
	'scroll_to_next_position': '',
	'tab_new': '',
	'tab_new_after_current': 'O',
	'tab_duplicate': 'c',
	'tab_select_previous': 'T',
	'tab_select_next': '',
	'tab_select_most_recent': '',
	'tab_select_oldest_unvisited': '',
	'tab_move_backward': '',
	'tab_move_forward': '',
	'tab_move_to_window': '<a-w>',
	'tab_select_first': '',
	'tab_select_first_non_pinned': '',
	'tab_select_last': '',
	'tab_toggle_pinned': '',
	'tab_close': 'd',
	'tab_restore': 'u',
	'tab_restore_list': 'U',
	'tab_close_to_end': 'D',
	'tab_close_other': '',
	'follow': 'l',
	'follow_in_tab': '<a-l>',
	'follow_in_focused_tab': 'L',
	'follow_in_window': '',
	'follow_in_private_window': '',
	'follow_multiple': '<a-L>',
	'follow_copy': 'ey',
	'open_context_menu': 'em',
	'focus_text_input': 'i',
	'element_text_select': 'et',
	'element_text_copy': 'eT',
	'find_highlight_all': '',
	'find_links_only': '',
	'enter_mode_ignore': '',
	'quote': '',
}

const CARET_MAPPINGS = {
	'move_left': '<left>',
	'move_right': '<right>',
	'move_down': '<down>',
	'move_up': '<up>',
	'move_to_line_start': '<home>',
	'move_to_line_end': '<end>',
}

const HINT_MAPPINGS = {
	'activate_highlighted': '<enter>',
}

const {commands} = vimfx.modes.normal

vimfx.addCommand(
	{
		name: 'tab_next_count_index',
		description: "Tab next. If it's given count, move tab to index",
		category: 'tabs',
	},
	(args) => {
		let {vim, count} = args
		if (count === undefined) {
			commands.tab_select_next.run(args)
		}
		else {
			let {window} = vim
			window.gBrowser.selectTabAtIndex(count - 1)
		}
	}
)
vimfx.set('custom.mode.normal.tab_next_count_index', 't')



set(OPTIONS)

map(NORMAL_MAPPINGS, 'mode.normal')
map(CARET_MAPPINGS, 'mode.caret')
map(HINT_MAPPINGS, 'mode.hints')

function map(mappings, mode) {
	Object.entries(mappings).forEach( ([command, key]) => {
		vimfx.set(`${mode}.${command}`, key)
	})
}

function set(options) {
	Object.entries(options).forEach( ([option, makeValue]) => {
		const value = typeof makeValue === 'function'
			? makeValue(vimfx.getDefault(option))
			: makeValue
		vimfx.set(option, value)
	})
}
