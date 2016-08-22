note
	description: "Enum "
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

deferred class GTK_ICON_THEME_ERROR
	--    Error codes for GtkIconTheme operations.
	
inherit ANY undefine is_equal, copy end

feature {ANY}  -- enum
	is_valid_gtk_theme_error (an_error: INTEGER): BOOLEAN is
		do	
			Result:=((an_error = gtk_icon_theme_not_found) or else
						(an_error = gtk_icon_theme_failed))
		end

	gtk_icon_theme_not_found: INTEGER is
			-- The icon specified does not exist in the theme
		external "C macro <gtk/gtk.h>"
		alias "GTK_ICON_THEME_NOT_FOUND"
		end

	gtk_icon_theme_failed: INTEGER is
			-- An unspecified error occurred.
		external "C macro <gtk/gtk.h>"
		alias "GTK_ICON_THEME_FAILED"
		end
end
