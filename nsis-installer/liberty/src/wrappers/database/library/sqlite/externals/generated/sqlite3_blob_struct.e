-- This file has been created by wrappers_generator.
-- Any change will be lost by the next execution of the tool.
deferred class SQLITE3_BLOB_STRUCT
-- Wrapper of struct sqlite3_blob defined in file /usr/include/sqlite3.h

insert STANDARD_C_LIBRARY_TYPES

	SQLITE_TYPES
	-- Fieldless struct
feature {WRAPPER, WRAPPER_HANDLER} -- Structure size
       struct_size: like size_t 
               external "plug_in"
               alias "{
                       location: "."
                       module_name: "plugin"
                       feature_name: "sizeof_sqlite3_blob"
               }"
               end

end -- class SQLITE3_BLOB_STRUCT
-- This file has been created by wrappers_generator.
-- Any change will be lost by the next execution of the tool.
