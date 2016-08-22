note
	description: "GtkFileSelection: Prompt the user for a file or directory name."
	copyright: "[
					Copyright (C) 2007 Paolo Redaelli, GTK+ team
					
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

	wrapped_version: "2.10.6"

class GTK_FILE_SELECTION
	-- GtkFileSelection has been superseded by the newer GtkFileChooser family
	-- of widgets.
	--
	-- GtkFileSelection should be used to retrieve file or directory names from
	-- the user. It will create a new dialog window containing a directory list,
	-- and a file list corresponding to the current working directory. The
	-- filesystem can be navigated using the directory list or the drop-down
	-- history menu. Alternatively, the TAB key can be used to navigate using
	-- filename completion - common in text based editors such as emacs and jed.

	-- File selection dialogs are created with a call to `make'.
	
	-- The default filename can be set using `set_filename' and the selected
	-- filename retrieved using `filename'.
	
	-- Use gtk_file_selection_complete() to display files and directories that
	-- match a given pattern. This can be used for example, to show only *.txt
	-- files, or only files beginning with gtk*.
	
	-- Simple file operations; create directory, delete file, and rename file,
	-- are available from buttons at the top of the dialog. These can be hidden
	-- using gtk_file_selection_hide_fileop_buttons() and shown again using
	-- gtk_file_selection_show_fileop_buttons().
	
	-- Example 1. Getting a filename from the user.
	--
	--
	-- /* The file selection widget and the string to store the chosen filename */
	--
	-- void store_filename (GtkWidget *widget, gpointer user_data) {
	--    GtkWidget *file_selector = GTK_WIDGET (user_data);
	--    const gchar *selected_filename;
	--
	--    selected_filename = gtk_file_selection_get_filename (GTK_FILE_SELECTION (file_selector));
	--    g_print ("Selected filename: %s\n", selected_filename);
	-- }
	--
	-- void create_file_selection (void) {
	--
	--    GtkWidget *file_selector;
	--
	--    /* Create the selector */
	--
	--    file_selector = gtk_file_selection_new ("Please select a file for editing.");
	--
	--    g_signal_connect (GTK_FILE_SELECTION (file_selector)->ok_button,
	--                      "clicked",
	--                      G_CALLBACK (store_filename),
	--                      file_selector);
	--
	--    /* Ensure that the dialog box is destroyed when the user clicks a button. */
	--
	--    g_signal_connect_swapped (GTK_FILE_SELECTION (file_selector)->ok_button,
	--                              "clicked",
	--                              G_CALLBACK (gtk_widget_destroy),
	--                              file_selector);
	--
	--    g_signal_connect_swapped (GTK_FILE_SELECTION (file_selector)->cancel_button,
	--                              "clicked",
	--                              G_CALLBACK (gtk_widget_destroy),
	--                              file_selector);
	--
	--    /* Display that dialog */
	--
	--    gtk_widget_show (file_selector);
	-- }

obsolete
	"This class is deprecated and only here for compatibility. Use the %
	% GTK_FILE_CHOOSER family of widgets instead."

inherit
	GTK_DIALOG
		undefine
			struct_size,
			get_action_area
		end
		--   GtkFileSelection implements AtkImplementorIface.

insert
	GTK_FILE_SELECTION_EXTERNALS
	GTK_FILE_SELECTION_STRUCT
		undefine
			copy,
			is_equal
		end

create {ANY} make, from_external_pointer

feature {} -- Creation
	with_title (a_title: STRING) is
			-- Creates a new file selection dialog box. By default it will contain
			-- a GtkTreeView of the application's current working directory, and a
			-- file listing. Operation buttons that allow the user to create a
			-- directory, delete files and rename files, are also present.
			
			-- `a_title': a message that will be placed in the file requestor's
			-- titlebar.
		require title_not_void: a_title/=Void
		do
			from_external_pointer(gtk_file_selection_new(a_title.to_external))
		end

feature {ANY}
	set_filename (a_filename: STRING) is
			-- Sets a default path for the file requestor. If filename includes a
			-- directory path, then the requestor will open with that path as its
			-- current working directory.
	
			-- This has the consequence that in order to open the requestor with a
			-- working directory and an empty filename, filename must have a
			-- trailing directory separator.
	
			-- The encoding of filename is preferred GLib file name encoding, which
			-- may not be UTF-8. See g_filename_from_utf8().
	
			-- `a_filename': a string to set as the default file name.		
		require filename_not_void: a_filename/=Void
		do
			gtk_file_selection_set_filename (handle, a_filename.to_external)
		end

	filename: CONST_STRING is
			-- the selected filename in the GLib file name encoding. To convert to
			-- UTF-8, call g_filename_to_utf8 (TODO: Eiffellize). 
		
			-- If no file is selected then the selected directory path is returned.
		do
			-- The string returned gtk_file_selection_get_filename by points to a
			-- statically allocated buffer and should be copied if you plan to keep
			-- it around.
			create Result.from_external(gtk_file_selection_get_filename(handle))
		end

	complete (a_pattern: STRING) is
			-- Will attempt to match pattern to a valid filenames or subdirectories
			-- in the current directory. If a match can be made, the matched
			-- filename will appear in the text entry field of the file selection
			-- dialog. If a partial match can be made, the "Files" list will
			-- contain those file names which have been partially matched, and the
			-- "Folders" list those directories which have been partially matched.

			-- `a_pattern': a string of characters which may or may not match any
			-- filenames in the current directory.
		do
			gtk_file_selection_complete(handle, a_pattern.to_external)
		end

	show_fileop_buttons is
			-- Shows the file operation buttons, if they have previously been
			-- hidden. The rest of the widgets in the dialog will be resized
			-- accordingly.
		do
			gtk_file_selection_show_fileop_buttons(handle)
		end

	hide_fileop_buttons is
			-- Hides the file operation buttons that normally appear at the top of
			-- the dialog. Useful if you wish to create a custom file selector,
			-- based on GtkFileSelection.
		do
			gtk_file_selection_hide_fileop_buttons(handle)
		end

	selections: STRING_ARRAY is
			-- the list of file selections the user has made in the dialog box.
			-- This function is intended for use when the user can select multiple
			-- files in the file list.
	
			-- The filenames are in the GLib file name encoding. To convert to
			-- UTF-8, call g_filename_to_utf8 (TODO) on each string.
		local ptr: POINTER
		do
			ptr:=gtk_file_selection_get_selections(handle)
			create Result.from_external_null_array(ptr)
			-- Note: even if the C documentation says that the newly-allocated
			-- NULL-terminated array of strings returned by
			-- gtk_file_selection_get_selections must be freed with g_strfreev(),
			-- we will not do it; infact creating a STRING_ARRAY from the obtained
			-- pointer we pass the burden of memory handling to the garbage
			-- collector.
		end

	set_select_multiple (a_setting: BOOLEAN) is
			-- Sets whether the user is allowed to select multiple files in the
			-- file list. Use `selections' to get the list of selected files.
		do
			gtk_file_selection_set_select_multiple(handle,a_setting.to_integer)
		ensure set: a_setting = are_multiple_selection_allowed
		end

	are_multiple_selection_allowed: BOOLEAN is
			-- Is the user allowed to select multiple files in the file list?
		do
			Result:=gtk_file_selection_get_select_multiple(handle).to_boolean
		end
	
	-- Note: "filename", "select-multiple" and "show-fileops"
	-- properties already have strongly-typed setter and getter
	-- features, so they don't need to be wrapped.
	
end -- class GTK_FILE_SELECTION
