-- This file have been created by eiffel-gcc-xml.
-- Any change will be lost by the next execution of the tool.
expanded class G_TRAVERSE_FLAGS
insert ENUM

create {ANY} default_create
feature {ANY} -- Validity
	is_valid_value (a_value: INTEGER): BOOLEAN is
		do
			Result := ((a_value = g_traverse_leaves) or else 
				(a_value = g_traverse_non_leaves) or else 
				(a_value = g_traverse_all) or else 
				(a_value = g_traverse_mask) or else 
				(a_value = g_traverse_leafs) or else 
				(a_value = g_traverse_non_leafs))
		end


feature {ANY} -- Setters
	default_create, set_leaves is
		do
			value := g_traverse_leaves
		end

	set_non_leaves is
		do
			value := g_traverse_non_leaves
		end

	set_all is
		do
			value := g_traverse_all
		end

	set_mask is
		do
			value := g_traverse_mask
		end

	set_leafs is
		do
			value := g_traverse_leafs
		end

	set_non_leafs is
		do
			value := g_traverse_non_leafs
		end


feature {ANY} -- Queries
	is_leaves: BOOLEAN is
		do
			Result := (value=g_traverse_leaves)
		end

	is_non_leaves: BOOLEAN is
		do
			Result := (value=g_traverse_non_leaves)
		end

	is_all: BOOLEAN is
		do
			Result := (value=g_traverse_all)
		end

	is_mask: BOOLEAN is
		do
			Result := (value=g_traverse_mask)
		end

	is_leafs: BOOLEAN is
		do
			Result := (value=g_traverse_leafs)
		end

	is_non_leafs: BOOLEAN is
		do
			Result := (value=g_traverse_non_leafs)
		end


feature {WRAPPER, WRAPPER_HANDLER} -- Low level values
	g_traverse_leaves: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "G_TRAVERSE_LEAVES"
		end

	g_traverse_non_leaves: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "G_TRAVERSE_NON_LEAVES"
		end

	g_traverse_all: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "G_TRAVERSE_ALL"
		end

	g_traverse_mask: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "G_TRAVERSE_MASK"
		end

	g_traverse_leafs: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "G_TRAVERSE_LEAFS"
		end

	g_traverse_non_leafs: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "G_TRAVERSE_NON_LEAFS"
		end


end

