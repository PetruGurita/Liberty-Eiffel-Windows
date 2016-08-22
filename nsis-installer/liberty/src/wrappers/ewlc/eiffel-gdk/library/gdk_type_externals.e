note
	description: ""
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
	copyright: ""
	license: "LGPL v2 or later"
	date: "$Date:$"
	revision "$Revision:$"

class GDK_TYPE_EXTERNALS

feature {} -- External calls

	gdk_type_pixbuf: INTEGER is
		external "C macro use <gtk/gtk.h>"
		alias "GDK_TYPE_PIXBUF"
		end

end
