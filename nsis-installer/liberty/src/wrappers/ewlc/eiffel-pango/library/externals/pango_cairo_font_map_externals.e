note
	description: "External calls for PANGO_CAIRO_FONT_MAP"
	copyright: "[
					Copyright (C) 2006 eiffel-libraries team, Pango team
					
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

deferred class PANGO_CAIRO_FONT_MAP_EXTERNALS

inherit ANY undefine is_equal, copy end

feature {} -- External calls

	pango_cairo_font_map_new: POINTER is
		external "C use <pango/pangocairo.h>"
		end

	pango_cairo_font_map_get_default: POINTER is
		external "C use <pango/pangocairo.h>"
		end

	pango_cairo_font_map_set_resolution (a_handle: POINTER; a_dpi: REAL) is
		external "C use <pango/pangocairo.h>"
		end

	pango_cairo_font_map_get_resolution (a_handle: POINTER): REAL is
		external "C use <pango/pangocairo.h>"
		end

	pango_cairo_font_map_create_context (a_handle: POINTER): POINTER is
		external "C use <pango/pangocairo.h>"
		end

end -- class PANGO_CAIRO_FONT_MAP_EXTERNALS
