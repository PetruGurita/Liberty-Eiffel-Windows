-- This file has been created by wrappers_generator.
-- Any change will be lost by the next execution of the tool.
deferred class GIREPOSITORY_CLASS_STRUCT
-- Wrapper of struct _GIRepositoryClass defined in file /usr/include/gobject-introspection-1.0/girepository.h

insert STANDARD_C_LIBRARY_TYPES

	GOBJECT_INTROSPECTION_TYPES
feature {} -- Low-level setters

feature {} -- Low-level queries

	-- Unwrappable field parent.
feature {WRAPPER, WRAPPER_HANDLER} -- Structure size
       struct_size: like size_t 
               external "plug_in"
               alias "{
                       location: "."
                       module_name: "plugin"
                       feature_name: "sizeof_girepository_class"
               }"
               end

end -- class GIREPOSITORY_CLASS_STRUCT
-- This file has been created by wrappers_generator.
-- Any change will be lost by the next execution of the tool.
