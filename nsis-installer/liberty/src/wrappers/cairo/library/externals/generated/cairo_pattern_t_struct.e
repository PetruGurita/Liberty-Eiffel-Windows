-- This file has been created by wrappers_generator.
-- Any change will be lost by the next execution of the tool.
deferred class CAIRO_PATTERN_T_STRUCT
-- Wrapper of struct cairo_pattern_t defined in file /usr/include/cairo/cairo.h line 220

insert STANDARD_C_LIBRARY_TYPES

	CAIRO_TYPES
	-- Fieldless struct
feature {WRAPPER, WRAPPER_HANDLER} -- Structure size
       struct_size: like size_t 
               external "plug_in"
               alias "{
                       location: "."
                       module_name: "plugin"
                       feature_name: "sizeof_cairo_pattern_t"
               }"
               end

end -- class CAIRO_PATTERN_T_STRUCT
-- This file has been created by wrappers_generator.
-- Any change will be lost by the next execution of the tool.
