note
	description: "External calls for GDK_EVENT_BUTTON"
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

deferred class GDK_EVENT_BUTTON_EXTERNALS

inherit ANY undefine is_equal, copy end

feature {} -- External calls

	gdk_event_button_get_time (ptr: POINTER): INTEGER is
		external "C struct GdkEventButton get time use <gdk/gdk.h>"
		end

	gdk_event_button_get_x (ptr: POINTER): REAL_64 is
		external "C struct GdkEventButton get x use <gdk/gdk.h>"
		end

	gdk_event_button_get_y (ptr: POINTER): REAL_64 is
		external "C struct GdkEventButton get y use <gdk/gdk.h>"
		end

	gdk_event_button_get_axes (ptr: POINTER): POINTER is
		external "C struct GdkEventButton get axes use <gdk/gdk.h>"
		end

	gdk_event_button_get_state (ptr: POINTER): INTEGER is
		external "C struct GdkEventButton get state use <gdk/gdk.h>"
		end

	gdk_event_button_get_button (ptr: POINTER): INTEGER is
		external "C struct GdkEventButton get button use <gdk/gdk.h>"
		end

	gdk_event_button_get_x_root (ptr: POINTER): REAL_64 is
		external "C struct GdkEventButton get x_root use <gdk/gdk.h>"
		end

	gdk_event_button_get_y_root (ptr: POINTER): REAL_64 is
		external "C struct GdkEventButton get y_root use <gdk/gdk.h>"
		end

end -- class GDK_EVENT_BUTTON_EXTERNALS
