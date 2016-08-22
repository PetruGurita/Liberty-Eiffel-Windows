note
	description: "External calls for POLY"
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

deferred class POLY_EXTERNALS

inherit ANY undefine is_equal, copy end

insert
	TBOOL

feature {} -- Externals -- Basic Constructors

	poly_empty (a_dimension: INTEGER): POINTER is
		external "C use <polka/poly.h>"
		end

	poly_universe (a_dimension: INTEGER): POINTER is
		external "C use <polka/poly.h>"
		end

	poly_of_constraints (a_matrix: POINTER): POINTER is
		external "C use <polka/poly.h>"
		end

	poly_of_frames (a_frame: POINTER): POINTER is
		external "C use <polka/poly.h>"
		end

feature {} -- Externals -- Basic Operations

	poly_free (handle: POINTER) is
		external "C use <polka/poly.h>"
		end

	poly_copy (handle: POINTER): POINTER is
		external "C use <polka/poly.h>"
		end

	poly_print (handle: POINTER) is
		external "C use <polka/poly.h>"
		end

	poly_minimize (handle: POINTER) is
		external "C use <polka/poly.h>"
		end

	poly_canonicalize (handle: POINTER) is
		external "C use <polka/poly.h>"
		end

feature {} -- Externals -- Access

	poly_constraints (handle: POINTER): POINTER is
		external "C use <polka/poly.h>"
		end

	poly_frames (handle: POINTER): POINTER is
		external "C use <polka/poly.h>"
		end

--	poly_satC (handle: POINTER): POINTER is
--		external "C use <polka/poly.h>"
--		end

--	poly_satF (handle: POINTER): POINTER is
--		external "C use <polka/poly.h>"
--		end

	poly_dimension (handle: POINTER): INTEGER is
		external "C use <polka/poly.h>"
		end

	poly_nbequations (handle: POINTER): INTEGER is
		external "C use <polka/poly.h>"
		end

	poly_nblines (handle: POINTER): INTEGER is
		external "C use <polka/poly.h>"
		end

	poly_nbconstraints (handle: POINTER): INTEGER is
		external "C use <polka/poly.h>"
		end

	poly_nbframes (handle: POINTER): INTEGER is
		external "C use <polka/poly.h>"
		end

feature {} -- Externals -- Predicates 

	poly_is_minimal (handle: POINTER): INTEGER is
		external "C use <polka/poly.h>"
		end

	poly_is_empty (handle: POINTER): INTEGER is
		external "C use <polka/poly.h>"
		end

	poly_is_universe (handle: POINTER): INTEGER is
		external "C use <polka/poly.h>"
		end

	poly_is_empty_lazy (handle: POINTER): INTEGER is
		external "C use <polka/poly.h>"
		ensure is_valid_tbool (Result)
		end

	poly_versus_constraint (handle, tab: POINTER): INTEGER is
		external "C use <polka/poly.h>"
		ensure is_valid_tbool (Result)
		end

	poly_is_generator_included_in (tab, handle: POINTER): INTEGER is
		external "C use <polka/poly.h>"
		end

	poly_is_included_in (handle, other: POINTER): INTEGER is
		external "C use <polka/poly.h>"
		end

	poly_is_equal (handle, other: POINTER): INTEGER is
		external "C use <polka/poly.h>"
		end

feature {} -- Externals -- Intersection and Convex Hull -- Strict version

	poly_intersection (handle, other: POINTER): POINTER is
		external "C use <polka/poly.h>"
		end

	poly_intersection_array (polys: POINTER; size: INTEGER): POINTER is
		external "C use <polka/poly.h>"
		end

	poly_add_constraints (handle, matrix: POINTER): POINTER is
		external "C use <polka/poly.h>"
		end

	poly_add_constraint (handle, tab: POINTER): POINTER is
		external "C use <polka/poly.h>"
		end

	poly_convex_hull (handle, other: POINTER): POINTER is
		external "C use <polka/poly.h>"
		end

	poly_convex_hull_array (polys: POINTER; size: INTEGER): POINTER is
		external "C use <polka/poly.h>"
		end

	poly_add_frames (handle, matrix: POINTER): POINTER is
		external "C use <polka/poly.h>"
		end

	poly_add_frame (handle, tab: POINTER): POINTER is
		external "C use <polka/poly.h>"
		end

feature {} -- Externals -- Intersection and Convex Hull -- Lazy version

	poly_intersection_lazy (handle, other: POINTER): POINTER is
		external "C use <polka/poly.h>"
		end

	poly_intersection_array_lazy (polys: POINTER; size: INTEGER): POINTER is
		external "C use <polka/poly.h>"
		end

	poly_add_constraints_lazy (handle, matrix: POINTER): POINTER is
		external "C use <polka/poly.h>"
		end

	poly_add_constraint_lazy (handle, tab: POINTER): POINTER is
		external "C use <polka/poly.h>"
		end

	poly_convex_hull_lazy (handle, other: POINTER): POINTER is
		external "C use <polka/poly.h>"
		end

	poly_convex_hull_array_lazy (polys: POINTER; size: INTEGER): POINTER is
		external "C use <polka/poly.h>"
		end

	poly_add_frames_lazy (handle, matrix: POINTER): POINTER is
		external "C use <polka/poly.h>"
		end

	poly_add_frame_lazy (handle, tab: POINTER): POINTER is
		external "C use <polka/poly.h>"
		end

feature {} -- Linear transformations

	poly_assign_variable (handle: POINTER; a_variable: INTEGER; an_assignment: POINTER): POINTER is
		external "C use <polka/poly.h>"
		end

	poly_substitute_variable (handle: POINTER; a_variable: INTEGER; a_substitution: POINTER): POINTER is
		external "C use <polka/poly.h>"
		end

	poly_assign_variables (handle, some_assignments: POINTER; size: INTEGER): POINTER is
		external "C use <polka/poly.h>"
		end

	poly_substitute_variables (handle, some_substitutions: POINTER; size: INTEGER): POINTER is
		external "C use <polka/poly.h>"
		end

end -- class POLY_EXTERNALS
