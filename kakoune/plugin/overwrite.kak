define-command overwrite %{
	try %{
		hook buffer -group overwrite InsertChar .* %{ execute-keys <right><backspace> }
		map buffer insert <backspace> <left>
		hook buffer -group overwrite ModeChange insert:.* %{
			remove-hooks buffer overwrite
			unmap buffer insert <backspace> <left>
		}
		execute-keys ;i
	}
}
