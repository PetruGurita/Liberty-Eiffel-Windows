note
	description: "External calls for GTK_CHECK_BUTTON"
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

deferred class GTK_CHECK_BUTTON_EXTERNALS

inherit ANY undefine is_equal, copy end

feature {} -- External calls

	gtk_check_button_new: POINTER is
		external "C use <gtk/gtk.h>"
		end

	gtk_check_button_new_with_label (a_label: POINTER): POINTER is
		external "C use <gtk/gtk.h>"
		end

	gtk_check_button_new_with_mnemonic (a_label: POINTER): POINTER is
		external "C use <gtk/gtk.h>"
		end
end

