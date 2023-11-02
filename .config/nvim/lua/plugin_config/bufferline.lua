require("bufferline").setup({
	highlights = {
		fill = {
			bg = "none",
		},
		background = {
			bg = "none",
		},
		tab = {
			bg = "none",
		},
		tab_selected = {
			bg = "none",
		},
		tab_separator = {
			bg = "none",
		},
		tab_separator_selected = {
			bg = "none",
			sp = "none",
			underline = false
		},
		tab_close = {
			bg = "none",
		},
		close_button = {
			bg = "none",
		},
		close_button_visible = {
			bg = "none",
		},
		close_button_selected = {
			bg = "none",
		},
		buffer_visible = {
			bg = "none",
		},
		buffer_selected = {
			bg = "none",
			bold = true,
			italic = true,
		},
		numbers = {
			bg = "none",
		},
		numbers_visible = {
			bg = "none",
		},
		numbers_selected = {
			bg = "none",
			bold = true,
			italic = true,
		},
		diagnostic = {
			bg = "none",
		},
		diagnostic_visible = {
			bg = "none",
		},
		diagnostic_selected = {
			bg = "none",
			bold = true,
			italic = true,
		},
		hint = {
			sp = "none",
			bg = "none",
		},
		hint_visible = {
			bg = "none",
		},
		hint_selected = {
			bg = "none",
			sp = "none",
			bold = true,
			italic = true,
		},
		hint_diagnostic = {
			sp = "none",
			bg = "none",
		},
		hint_diagnostic_visible = {
			bg = "none",
		},
		hint_diagnostic_selected = {

			bg = "none",
			sp = "none",
			bold = true,
			italic = true,
		},
		info = {
			sp = "none",
			bg = "none",
		},
		info_visible = {
			bg = "none",
		},
		info_selected = {
			bg = "none",
			sp = "none",
			bold = true,
			italic = true,
		},
		info_diagnostic = {
			sp = "none",
			bg = "none",
		},
		info_diagnostic_visible = {

			bg = "none",
		},
		info_diagnostic_selected = {

			bg = "none",
			sp = "none",
			bold = true,
			italic = true,
		},
		warning = {

			sp = "none",
			bg = "none",
		},
		warning_visible = {

			bg = "none",
		},
		warning_selected = {

			bg = "none",
			sp = "none",
			bold = true,
			italic = true,
		},
		warning_diagnostic = {

			sp = "none",
			bg = "none",
		},
		warning_diagnostic_visible = {

			bg = "none",
		},
		warning_diagnostic_selected = {
			bg = "none",
			sp = "none",
			bold = true,
			italic = true,
		},
		error = {
			bg = "none",
			sp = "none",
		},
		error_visible = {
			bg = "none",
		},
		error_selected = {
			bg = "none",
			sp = "none",
			bold = true,
			italic = true,
		},
		error_diagnostic = {
			bg = "none",
			sp = "none",
		},
		error_diagnostic_visible = {
			bg = "none",
		},
		error_diagnostic_selected = {
			bg = "none",
			sp = "none",
			bold = true,
			italic = true,
		},
		modified = {
			bg = "none",
		},
		modified_visible = {
			bg = "none",
		},
		modified_selected = {
			bg = "none",
		},
		duplicate_selected = {
			bg = "none",
			italic = true,
		},
		duplicate_visible = {
			bg = "none",
			italic = true,
		},
		duplicate = {
			bg = "none",
			italic = true,
		},
		separator_selected = {
			bg = "none",
		},
		separator_visible = {
			bg = "none",
		},
		separator = {
			bg = "none",
		},
		indicator_visible = {
			bg = "none",
		},
		indicator_selected = {
			bg = "none",
		},
		pick_selected = {
			bg = "none",
			bold = true,
			italic = true,
		},
		pick_visible = {
			bg = "none",
			bold = true,
			italic = true,
		},
		pick = {
			bg = "none",
			bold = true,
			italic = true,
		},
		offset_separator = {
			bg = "none",
		},
		trunc_marker = {
			bg = "none",
		},
	},
	options = {
		mode = "buffers",
		indicator = { style = "none" },
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = true,
		show_buffer_icons = false,
		show_buffer_close_icons = false,
		show_tab_indicators = true,
	},
})
