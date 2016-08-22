-- This file have been created by eiffel-gcc-xml.
-- Any change will be lost by the next execution of the tool.
expanded class GDA_DICT_CONSTRAINT_TYPE
insert ENUM

create {ANY} default_create
feature {ANY} -- Validity
	is_valid_value (a_value: INTEGER): BOOLEAN is
		do
			Result := ((a_value = constraint_primary_key) or else 
				(a_value = constraint_foreign_key) or else 
				(a_value = constraint_unique) or else 
				(a_value = constraint_not_null) or else 
				(a_value = constraint_check_expr) or else 
				(a_value = constraint_check_in_list) or else 
				(a_value = constraint_check_setof_list) or else 
				(a_value = constraint_unknown))
		end


feature {ANY} -- Setters
	default_create, set_primary_key is
		do
			value := constraint_primary_key
		end

	set_foreign_key is
		do
			value := constraint_foreign_key
		end

	set_unique is
		do
			value := constraint_unique
		end

	set_not_null is
		do
			value := constraint_not_null
		end

	set_check_expr is
		do
			value := constraint_check_expr
		end

	set_check_in_list is
		do
			value := constraint_check_in_list
		end

	set_check_setof_list is
		do
			value := constraint_check_setof_list
		end

	set_unknown is
		do
			value := constraint_unknown
		end


feature {ANY} -- Queries
	is_primary_key: BOOLEAN is
		do
			Result := (value=constraint_primary_key)
		end

	is_foreign_key: BOOLEAN is
		do
			Result := (value=constraint_foreign_key)
		end

	is_unique: BOOLEAN is
		do
			Result := (value=constraint_unique)
		end

	is_not_null: BOOLEAN is
		do
			Result := (value=constraint_not_null)
		end

	is_check_expr: BOOLEAN is
		do
			Result := (value=constraint_check_expr)
		end

	is_check_in_list: BOOLEAN is
		do
			Result := (value=constraint_check_in_list)
		end

	is_check_setof_list: BOOLEAN is
		do
			Result := (value=constraint_check_setof_list)
		end

	is_unknown: BOOLEAN is
		do
			Result := (value=constraint_unknown)
		end


feature {WRAPPER, WRAPPER_HANDLER} -- Low level values
	constraint_primary_key: INTEGER is
		external "C macro use <libgda/libgda.h>"
		alias "CONSTRAINT_PRIMARY_KEY"
		end

	constraint_foreign_key: INTEGER is
		external "C macro use <libgda/libgda.h>"
		alias "CONSTRAINT_FOREIGN_KEY"
		end

	constraint_unique: INTEGER is
		external "C macro use <libgda/libgda.h>"
		alias "CONSTRAINT_UNIQUE"
		end

	constraint_not_null: INTEGER is
		external "C macro use <libgda/libgda.h>"
		alias "CONSTRAINT_NOT_NULL"
		end

	constraint_check_expr: INTEGER is
		external "C macro use <libgda/libgda.h>"
		alias "CONSTRAINT_CHECK_EXPR"
		end

	constraint_check_in_list: INTEGER is
		external "C macro use <libgda/libgda.h>"
		alias "CONSTRAINT_CHECK_IN_LIST"
		end

	constraint_check_setof_list: INTEGER is
		external "C macro use <libgda/libgda.h>"
		alias "CONSTRAINT_CHECK_SETOF_LIST"
		end

	constraint_unknown: INTEGER is
		external "C macro use <libgda/libgda.h>"
		alias "CONSTRAINT_UNKNOWN"
		end


end

