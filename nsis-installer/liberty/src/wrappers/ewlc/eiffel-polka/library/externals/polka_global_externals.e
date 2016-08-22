note
	description: "Externals calls for POLKA_GLOBAL"
	copyright: "[
					Copyright (C) 2001 Natalia B. Bidart
					
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
	license: "LGPL v2 or later"
	date: "$Date:$"
	revision "$Revision:$"

deferred class POLKA_GLOBAL_EXTERNALS

inherit ANY undefine is_equal, copy end

feature {} -- Externals

	polka_strict_external: INTEGER is
		external "C macro use <polka/polka.h>"
		end

	polka_cts_external: INTEGER is
		external "C macro use <polka/polka.h>"
		end

	polka_eps_external: INTEGER is
		external "C macro use <polka/polka.h>"
		end

	polka_dec_external: INTEGER is
		external "C macro use <polka/polka.h>"
		end

	polka_maxnbdims_external: INTEGER is
		external "C macro use <polka/polka.h>"
		end

	polka_maxnbrows_external: INTEGER is
		external "C macro use <polka/polka.h>"
		end

	polka_maxnbcolumns_external: INTEGER is
		external "C macro use <polka/polka.h>"
		end

end -- class POLKA_GLOBAL_EXTERNALS
