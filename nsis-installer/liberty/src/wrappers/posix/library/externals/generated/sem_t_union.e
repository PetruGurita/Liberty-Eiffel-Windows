-- This file has been created by wrappers_generator.
-- Any change will be lost by the next execution of the tool.
deferred class SEM_T_UNION
-- Wrapper of union  defined in file /usr/include/x86_64-linux-gnu/bits/semaphore.h

insert STANDARD_C_LIBRARY_TYPES

	POSIX_TYPES
feature {} -- Low-level setters

feature {} -- Low-level queries

	-- Unwrapped private field __size.
	-- Unwrapped private field __align.
feature {WRAPPER, WRAPPER_HANDLER} -- Structure size
       struct_size: like size_t 
               external "plug_in"
               alias "{
                       location: "."
                       module_name: "plugin"
                       feature_name: "sizeof_sem_t"
               }"
               end

end -- class SEM_T_UNION
-- This file has been created by wrappers_generator.
-- Any change will be lost by the next execution of the tool.
