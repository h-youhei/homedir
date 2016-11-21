const {commatds} = vimfx.modes.normal

vimfx.set('prevent_autofocus', true)
vimfx.set('hints.chars', '0123456789')
vimfx.set('hints.auto_activate', false)
vimfx.set('prev_patterns', vimfx.getDefault('prev_patterns') + ' 前(の)?ページ(へ)? 前(へ|に)(戻る)?')
vimfx.set('next_patterns', vimfx.getDefault('next_patterns') + ' 次(の)?ページ(へ)? 次(へ|に)(進む)?')
