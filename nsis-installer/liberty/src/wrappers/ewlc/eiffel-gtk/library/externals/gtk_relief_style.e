note
	description: "enum GtkReliefStyle indicates the relief to be drawn around a GtkButton."
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

deferred class GTK_RELIEF_STYLE

inherit ANY undefine is_equal, copy end

feature {} -- enum

	is_valid_gtk_relief_style (a_style: INTEGER): BOOLEAN is
		do
			Result:=((a_style=gtk_relief_normal) or else
						(a_style=gtk_relief_half) or else
						(a_style=gtk_relief_none))
		end

	gtk_relief_normal: INTEGER is
			-- Draw a normal relief.
		external "C macro use <gtk/gtk.h>"
		alias "GTK_RELIEF_NORMAL"
		end

	gtk_relief_half: INTEGER is
			-- A half relief.
		external "C macro use <gtk/gtk.h>"
		alias "GTK_RELIEF_HALF"
		end

	gtk_relief_none: INTEGER is
			-- No relief.
		external "C macro use <gtk/gtk.h>"
		alias "GTK_RELIEF_NONE"
		end

end
