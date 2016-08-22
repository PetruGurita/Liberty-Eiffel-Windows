note
	description: "Enum  GtkMenuDirectionType - An enumeration representing directional movements within a menu."
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
	date: "$Date:$"
	revision: "$Revision:$"

deferred class  GTK_MENU_DIRECTION_TYPE

inherit ANY undefine is_equal, copy end

feature {} -- enum

	is_valid_gtk_menu_direction (a_direction :INTEGER): BOOLEAN is
		do
			Result:=((a_direction = gtk_menu_dir_parent) or else
						(a_direction = gtk_menu_dir_child) or else
						(a_direction = gtk_menu_dir_next) or else
						(a_direction = gtk_menu_dir_prev))
		end

	gtk_menu_dir_parent: INTEGER is
			-- To the parent menu shell.
		external "C macro use <gtk/gtk.h>"
		alias "GTK_MENU_DIR_PARENT"
		end
	
	gtk_menu_dir_child: INTEGER is
			-- To the submenu, if any, associated with the item.
		external "C macro use <gtk/gtk.h>"
		alias "GTK_MENU_DIR_CHILD"
		end

	gtk_menu_dir_next: INTEGER is
			-- To the next menu item.
		external "C macro use <gtk/gtk.h>"
		alias "GTK_MENU_DIR_NEXT"
		end

	gtk_menu_dir_prev: INTEGER is
			-- To the previous menu item.
		external "C macro use <gtk/gtk.h>"
		alias "GTK_MENU_DIR_PREV"
		end
end
