-- This file have been created by eiffel-gcc-xml.
-- Any change will be lost by the next execution of the tool.
expanded class XLINK_ACTUATE
insert ENUM

create {ANY} default_create
feature {ANY} -- Validity
	is_valid_value (a_value: INTEGER): BOOLEAN is
		do
			Result := ((a_value = xlink_actuate_none) or else 
				(a_value = xlink_actuate_auto) or else 
				(a_value = xlink_actuate_onrequest))
		end


feature {ANY} -- Setters
	default_create, set_xlink_actuate_none is
		do
			value := xlink_actuate_none
		end

	set_xlink_actuate_auto is
		do
			value := xlink_actuate_auto
		end

	set_xlink_actuate_onrequest is
		do
			value := xlink_actuate_onrequest
		end


feature {ANY} -- Queries
	is_xlink_actuate_none: BOOLEAN is
		do
			Result := (value=xlink_actuate_none)
		end

	is_xlink_actuate_auto: BOOLEAN is
		do
			Result := (value=xlink_actuate_auto)
		end

	is_xlink_actuate_onrequest: BOOLEAN is
		do
			Result := (value=xlink_actuate_onrequest)
		end


feature {WRAPPER, WRAPPER_HANDLER} -- Low level values
	xlink_actuate_none: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "XLINK_ACTUATE_NONE"
		end

	xlink_actuate_auto: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "XLINK_ACTUATE_AUTO"
		end

	xlink_actuate_onrequest: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "XLINK_ACTUATE_ONREQUEST"
		end


end

