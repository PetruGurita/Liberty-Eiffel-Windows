note
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

deferred class GTK_IMAGE_EXTERNALS

inherit ANY undefine is_equal, copy end

feature {} -- External calls
	gtk_image_new: POINTER is
		external "C use <gtk/gtk.h>"
		end

	gtk_image_new_from_file (filename: POINTER): POINTER  is
		external "C use <gtk/gtk.h>"
		end

	gtk_image_new_from_pixbuf (a_pixbuf: POINTER): POINTER  is
		external "C use <gtk/gtk.h>"
		end

	gtk_image_new_from_stock (a_stock_id: POINTER; an_icon_size: INTEGER): POINTER  is
		external "C use <gtk/gtk.h>"
		end

	gtk_image_set_from_file (image: POINTER;filename: POINTER) is
		external "C use <gtk/gtk.h>"
		end

	gtk_image_set_from_pixbuf (image: POINTER; pixbuf: POINTER) is
		external "C use <gtk/gtk.h>"
		end

	gtk_image_get_pixel_size (image: POINTER): INTEGER is
		external "C use <gtk/gtk.h>"
		end

	gtk_image_set_pixel_size (image: POINTER;a_pixel_size: INTEGER) is
		external "C use <gtk/gtk.h>"
		end

	gtk_image_new_from_pixmap (a_pixmap, a_mask: POINTER): POINTER  is
		external "C use <gtk/gtk.h>"
		end

	gtk_image_set_from_pixmap (image, a_pixmap, a_mask: POINTER) is
		external "C use <gtk/gtk.h>"
		end

	gtk_image_get_pixbuf (image: POINTER): POINTER is
		external "C use <gtk/gtk.h>"
		end

	gtk_image_get_storage_type (image: POINTER): INTEGER is
		external "C use <gtk/gtk.h>"
		end

end
