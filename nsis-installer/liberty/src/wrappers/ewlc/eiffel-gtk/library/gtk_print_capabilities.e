note
	description: "enum GtkPrintCapabilities"
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

deferred class GTK_PRINT_CAPABILITIES
	-- An enum for specifying which features the print dialog should
	-- offer. I neither `gtk_print_capability_generate_pdf' nor
	-- `gtk_print_capability_generate_ps' is specified, GTK+ assumes
	-- that all formats are supported.

inherit ANY undefine is_equal, copy end

feature {ANY}  -- enum
	are_valid_print_capabilities (some_capabilities: INTEGER): BOOLEAN is
		do	
			Result:=((gtk_print_capability_page_set | gtk_print_capability_copies |
						 gtk_print_capability_collate | gtk_print_capability_reverse |
						 gtk_print_capability_scale | gtk_print_capability_generate_pdf |
						 gtk_print_capability_generate_ps | gtk_print_capability_preview)
						& some_capabilities).to_boolean
		end

	gtk_print_capability_page_set: INTEGER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_PRINT_CAPABILITY_PAGE_SET"
		end
		
	gtk_print_capability_copies: INTEGER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_PRINT_CAPABILITY_COPIES"
		end
		
	gtk_print_capability_collate: INTEGER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_PRINT_CAPABILITY_COLLATE"
		end
		
	gtk_print_capability_reverse: INTEGER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_PRINT_CAPABILITY_REVERSE"
		end
		
	gtk_print_capability_scale: INTEGER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_PRINT_CAPABILITY_SCALE"
		end
		
	gtk_print_capability_generate_pdf: INTEGER is
			-- The program will send the document to the printer in PDF
			-- format
		external "C macro use <gtk/gtk.h>"
		alias "GTK_PRINT_CAPABILITY_GENERATE_PDF"
		end
		
	gtk_print_capability_generate_ps: INTEGER is
			-- The program will send the document to the printer in
			-- Postscript format
		external "C macro use <gtk/gtk.h>"
		alias "GTK_PRINT_CAPABILITY_GENERATE_PS"
		end
		
	gtk_print_capability_preview: INTEGER is
		external "C macro use <gtk/gtk.h>"
		alias "GTK_PRINT_CAPABILITY_PREVIEW"
		end
		
end
