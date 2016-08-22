note
	description: "GTK stock items names"
	copyright: "[
					Copyright (C) 2006 eiffel-libraries team, GTK+ team
					
					This library is free software; you can redistribute it and/or
					modify it under the terms of the GNU Lesser General Public License
					as published by the Free Software Foundation; either version 2.1 of
					the License, or (at your option) any later version.
					
					This library is distributed in the hope that it will be useful, but
					WITHOUT ANY WARRANTY; without even the implied warranty of
					MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
					Lesser General Public License for more details.

					You should have received a copy of the GNU Lesser General Public
					License along with this library; if not, write to the Free Software
					Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
					02110-1301 USA
				]"
	date: "$Date:  $"
	revision: "$Revision:  $"

deferred class GTK_STOCK_ITEMS

inherit ANY undefine is_equal, copy end

feature {ANY} -- Stock items strings
	gtk_stock_dialog_authentication: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_dialog_authentication_ptr)
		end

	gtk_stock_dialog_info: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_dialog_info_ptr)
		end

	gtk_stock_dialog_warning: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_dialog_warning_ptr)
		end

	gtk_stock_dialog_error: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_dialog_error_ptr)
		end

	gtk_stock_dialog_question: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_dialog_question_ptr)
		end

	gtk_stock_dnd: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_dnd_ptr)
		end

	gtk_stock_dnd_multiple: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_dnd_multiple_ptr)
		end

	gtk_stock_about: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_about_ptr)
		end

	gtk_stock_add: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_add_ptr)
		end

	gtk_stock_apply: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_apply_ptr)
		end

	gtk_stock_bold: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_bold_ptr)
		end

	gtk_stock_cancel: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_cancel_ptr)
		end

	gtk_stock_cdrom: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_cdrom_ptr)
		end

	gtk_stock_clear: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_clear_ptr)
		end

	gtk_stock_close: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_close_ptr)
		end

	gtk_stock_color_picker: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_color_picker_ptr)
		end

	gtk_stock_convert: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_convert_ptr)
		end

	gtk_stock_connect: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_connect_ptr)
		end

	gtk_stock_copy: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_copy_ptr)
		end

	gtk_stock_cut: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_cut_ptr)
		end

	gtk_stock_delete: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_delete_ptr)
		end

	gtk_stock_directory: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_directory_ptr)
		end

	gtk_stock_disconnect: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_disconnect_ptr)
		end

	gtk_stock_edit: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_edit_ptr)
		end

	gtk_stock_execute: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_execute_ptr)
		end

	gtk_stock_file: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_file_ptr)
		end

	gtk_stock_find: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_find_ptr)
		end

	gtk_stock_find_and_replace: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_find_and_replace_ptr)
		end

	gtk_stock_floppy: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_floppy_ptr)
		end

	gtk_stock_fullscreen: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_fullscreen_ptr)
		end

	gtk_stock_goto_bottom: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_goto_bottom_ptr)
		end

	gtk_stock_goto_first: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_goto_first_ptr)
		end

	gtk_stock_goto_last: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_goto_last_ptr)
		end

	gtk_stock_goto_top: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_goto_top_ptr)
		end

	gtk_stock_go_back: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_go_back_ptr)
		end

	gtk_stock_go_down: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_go_down_ptr)
		end

	gtk_stock_go_forward: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_go_forward_ptr)
		end

	gtk_stock_go_up: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_go_up_ptr)
		end

	gtk_stock_harddisk: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_harddisk_ptr)
		end

	gtk_stock_help: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_help_ptr)
		end

	gtk_stock_home: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_home_ptr)
		end

	gtk_stock_index: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_index_ptr)
		end

	gtk_stock_indent: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_indent_ptr)
		end

	gtk_stock_info: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_info_ptr)
		end

	gtk_stock_unindent: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_unindent_ptr)
		end

	gtk_stock_italic: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_italic_ptr)
		end

	gtk_stock_jump_to: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_jump_to_ptr)
		end

	gtk_stock_justify_center: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_justify_center_ptr)
		end

	gtk_stock_justify_fill: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_justify_fill_ptr)
		end

	gtk_stock_justify_left: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_justify_left_ptr)
		end

	gtk_stock_justify_right: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_justify_right_ptr)
		end

	gtk_stock_leave_fullscreen: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_leave_fullscreen_ptr)
		end

	gtk_stock_missing_image: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_missing_image_ptr)
		end

	gtk_stock_media_forward: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_media_forward_ptr)
		end

	gtk_stock_media_next: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_media_next_ptr)
		end

	gtk_stock_media_pause: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_media_pause_ptr)
		end

	gtk_stock_media_play: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_media_play_ptr)
		end

	gtk_stock_media_previous: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_media_previous_ptr)
		end

	gtk_stock_media_record: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_media_record_ptr)
		end

	gtk_stock_media_rewind: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_media_rewind_ptr)
		end

	gtk_stock_media_stop: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_media_stop_ptr)
		end

	gtk_stock_network: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_network_ptr)
		end

	gtk_stock_new: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_new_ptr)
		end

	gtk_stock_no: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_no_ptr)
		end

	gtk_stock_ok: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_ok_ptr)
		end

	gtk_stock_open: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_open_ptr)
		end

	gtk_stock_paste: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_paste_ptr)
		end

	gtk_stock_preferences: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_preferences_ptr)
		end

	gtk_stock_print: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_print_ptr)
		end

	gtk_stock_print_preview: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_print_preview_ptr)
		end

	gtk_stock_properties: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_properties_ptr)
		end

	gtk_stock_quit: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_quit_ptr)
		end

	gtk_stock_redo: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_redo_ptr)
		end

	gtk_stock_refresh: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_refresh_ptr)
		end

	gtk_stock_remove: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_remove_ptr)
		end

	gtk_stock_revert_to_saved: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_revert_to_saved_ptr)
		end

	gtk_stock_save: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_save_ptr)
		end

	gtk_stock_save_as: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_save_as_ptr)
		end

	gtk_stock_select_color: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_select_color_ptr)
		end

	gtk_stock_select_font: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_select_font_ptr)
		end

	gtk_stock_sort_ascending: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_sort_ascending_ptr)
		end

	gtk_stock_sort_descending: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_sort_descending_ptr)
		end

	gtk_stock_spell_check: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_spell_check_ptr)
		end

	gtk_stock_stop: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_stop_ptr)
		end

	gtk_stock_strikethrough: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_strikethrough_ptr)
		end

	gtk_stock_undelete: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_undelete_ptr)
		end

	gtk_stock_underline: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_underline_ptr)
		end

	gtk_stock_undo: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_undo_ptr)
		end

	gtk_stock_yes: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_yes_ptr)
		end

	gtk_stock_zoom_100: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_zoom_100_ptr)
		end

	gtk_stock_zoom_fit: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_zoom_fit_ptr)
		end

	gtk_stock_zoom_in: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_zoom_in_ptr)
		end

	gtk_stock_zoom_out: STRING is
		once
			create {CONST_STRING} Result.from_external (gtk_stock_zoom_out_ptr)
		end

feature {WRAPPER} -- Pointers to Stock items (C) strings

	gtk_stock_dialog_authentication_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_DIALOG_AUTHENTICATION"
		end

	gtk_stock_dialog_info_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_DIALOG_INFO"
		end

	gtk_stock_dialog_warning_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_DIALOG_WARNING"
		end

	gtk_stock_dialog_error_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_DIALOG_ERROR"
		end

	gtk_stock_dialog_question_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_DIALOG_QUESTION"
		end

	gtk_stock_dnd_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_DND"
		end

	gtk_stock_dnd_multiple_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_DND_MULTIPLE"
		end

	gtk_stock_about_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_ABOUT"
		end

	gtk_stock_add_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_ADD"
		end

	gtk_stock_apply_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_APPLY"
		end

	gtk_stock_bold_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_BOLD"
		end

	gtk_stock_cancel_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_CANCEL"
		end

	gtk_stock_cdrom_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_CDROM"
		end

	gtk_stock_clear_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_CLEAR"
		end

	gtk_stock_close_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_CLOSE"
		end

	gtk_stock_color_picker_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_COLOR_PICKER"
		end

	gtk_stock_convert_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_CONVERT"
		end

	gtk_stock_connect_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_CONNECT"
		end

	gtk_stock_copy_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_COPY"
		end

	gtk_stock_cut_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_CUT"
		end

	gtk_stock_delete_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_DELETE"
		end

	gtk_stock_directory_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_DIRECTORY"
		end

	gtk_stock_disconnect_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_DISCONNECT"
		end

	gtk_stock_edit_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_EDIT"
		end

	gtk_stock_execute_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_EXECUTE"
		end

	gtk_stock_file_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_FILE"
		end

	gtk_stock_find_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_FIND"
		end

	gtk_stock_find_and_replace_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_FIND_AND_REPLACE"
		end

	gtk_stock_floppy_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_FLOPPY"
		end

	gtk_stock_fullscreen_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_FULLSCREEN"
		end

	gtk_stock_goto_bottom_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_GOTO_BOTTOM"
		end

	gtk_stock_goto_first_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_GOTO_FIRST"
		end

	gtk_stock_goto_last_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_GOTO_LAST"
		end

	gtk_stock_goto_top_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_GOTO_TOP"
		end

	gtk_stock_go_back_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_GO_BACK"
		end

	gtk_stock_go_down_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_GO_DOWN"
		end

	gtk_stock_go_forward_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_GO_FORWARD"
		end

	gtk_stock_go_up_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_GO_UP"
		end

	gtk_stock_harddisk_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_HARDDISK"
		end

	gtk_stock_help_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_HELP"
		end

	gtk_stock_home_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_HOME"
		end

	gtk_stock_index_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_INDEX"
		end

	gtk_stock_indent_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_INDENT"
		end

	gtk_stock_info_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_INFO"
		end

	gtk_stock_unindent_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_UNINDENT"
		end

	gtk_stock_italic_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_ITALIC"
		end

	gtk_stock_jump_to_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_JUMP_TO"
		end

	gtk_stock_justify_center_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_JUSTIFY_CENTER"
		end

	gtk_stock_justify_fill_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_JUSTIFY_FILL"
		end

	gtk_stock_justify_left_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_JUSTIFY_LEFT"
		end

	gtk_stock_justify_right_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_JUSTIFY_RIGHT"
		end

	gtk_stock_leave_fullscreen_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_LEAVE_FULLSCREEN"
		end

	gtk_stock_missing_image_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_MISSING_IMAGE"
		end

	gtk_stock_media_forward_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_MEDIA_FORWARD"
		end

	gtk_stock_media_next_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_MEDIA_NEXT"
		end

	gtk_stock_media_pause_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_MEDIA_PAUSE"
		end

	gtk_stock_media_play_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_MEDIA_PLAY"
		end

	gtk_stock_media_previous_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_MEDIA_PREVIOUS"
		end

	gtk_stock_media_record_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_MEDIA_RECORD"
		end

	gtk_stock_media_rewind_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_MEDIA_REWIND"
		end

	gtk_stock_media_stop_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_MEDIA_STOP"
		end

	gtk_stock_network_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_NETWORK"
		end

	gtk_stock_new_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_NEW"
		end

	gtk_stock_no_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_NO"
		end

	gtk_stock_ok_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_OK"
		end

	gtk_stock_open_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_OPEN"
		end

	gtk_stock_paste_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_PASTE"
		end

	gtk_stock_preferences_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_PREFERENCES"
		end

	gtk_stock_print_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_PRINT"
		end

	gtk_stock_print_preview_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_PRINT_PREVIEW"
		end

	gtk_stock_properties_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_PROPERTIES"
		end

	gtk_stock_quit_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_QUIT"
		end

	gtk_stock_redo_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_REDO"
		end

	gtk_stock_refresh_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_REFRESH"
		end

	gtk_stock_remove_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_REMOVE"
		end

	gtk_stock_revert_to_saved_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_REVERT_TO_SAVED"
		end

	gtk_stock_save_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_SAVE"
		end

	gtk_stock_save_as_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_SAVE_AS"
		end

	gtk_stock_select_color_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_SELECT_COLOR"
		end

	gtk_stock_select_font_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_SELECT_FONT"
		end

	gtk_stock_sort_ascending_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_SORT_ASCENDING"
		end

	gtk_stock_sort_descending_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_SORT_DESCENDING"
		end

	gtk_stock_spell_check_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_SPELL_CHECK"
		end

	gtk_stock_stop_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_STOP"
		end

	gtk_stock_strikethrough_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_STRIKETHROUGH"
		end

	gtk_stock_undelete_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_UNDELETE"
		end

	gtk_stock_underline_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_UNDERLINE"
		end

	gtk_stock_undo_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_UNDO"
		end

	gtk_stock_yes_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_YES"
		end

	gtk_stock_zoom_100_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_ZOOM_100"
		end

	gtk_stock_zoom_fit_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_ZOOM_FIT"
		end

	gtk_stock_zoom_in_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_ZOOM_IN"
		end

	gtk_stock_zoom_out_ptr: POINTER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_STOCK_ZOOM_OUT"
		end

end
