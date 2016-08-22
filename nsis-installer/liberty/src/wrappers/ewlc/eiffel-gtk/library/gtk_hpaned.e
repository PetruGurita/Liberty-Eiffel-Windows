note
	description: "GtkHPaned -- A container with two panes arranged horizontally"
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

class GTK_HPANED
	-- The HPaned widget is a container widget with two children
	-- arranged horizontally. The division between the two panes is
	-- adjustable by the user by dragging a handle. See GtkPaned for
	-- details.
inherit
	GTK_PANED
		-- GtkHPaned implements AtkImplementorIface.
	
create {ANY} make,from_external_pointer

feature {} -- size
	struct_size: INTEGER is
		external "C inline use <gtk/gtk.h>"
		alias "sizeof(GtkHPaned)"
		end

feature {} -- Creation
	make is
			-- Create a new GtkHPaned
		require gtk_initialized: gtk.is_initialized
		do
			from_external_pointer (gtk_hpaned_new)
		end
	

feature {} 
	gtk_hpaned_new: POINTER is
		external "C use <gtk/gtk.h>"
		end
end
