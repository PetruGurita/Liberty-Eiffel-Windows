-- This file has been created by wrappers_generator.
-- Any change will be lost by the next execution of the tool.
deferred class GTYPE_CVALUE_UNION
-- Wrapper of union _GTypeCValue defined in file /usr/include/glib-2.0/gobject/gtype.h

insert STANDARD_C_LIBRARY_TYPES

	GOBJECT_INTROSPECTION_TYPES
	-- Fieldless union
feature {WRAPPER, WRAPPER_HANDLER} -- Structure size
       struct_size: like size_t 
               external "plug_in"
               alias "{
                       location: "."
                       module_name: "plugin"
                       feature_name: "sizeof_gtype_cvalue"
               }"
               end

end -- class GTYPE_CVALUE_UNION
-- This file has been created by wrappers_generator.
-- Any change will be lost by the next execution of the tool.
