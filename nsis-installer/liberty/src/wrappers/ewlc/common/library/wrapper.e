note
	description: "Deferred class handling low-level C interfaces. Its heirs will fully expose each other their internals."
	copyright: "[
					Copyright (C) 2005,2008 Paolo Redaelli
					
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

deferred class WRAPPER
	-- Deferred class handling low-level C interfaces. Its heirs will fully
	-- expose each other their internals.

	-- No assumption is made on memory handling; to create a proper wrapper for
	-- it the developer shall inherit both from this class and from classes
	-- providing memory handling behaviour, depending on how structure's memory
	-- shall be handled. This is decided  case-by-case by C library. 

	-- Currently available memory handling classes are:

	-- C_OWNED: memory is always handled by the underlying C library.

	-- EIFFEL_OWNED: once created memory is fully handled by Eiffel runtime,
	-- usually with the Garbage Collector.

	-- GLOBALLY_CACHED: Until disposed by Eiffel the wrapper registered in
	-- wrappers dictionary will be the unique wrapper used on the Eiffel side.

	-- MIXED_MEMORY_HANDLING: whose memory can either by handled by the Eiffel
	-- library or by the underlying C code. Who handles memory is decided on a
	-- per-object based on the value of the flag `is_shared': handle will not
	-- be freed on dispose of the Eiffel wrapper object, when `is_shared' is
	-- true.

	-- REFERENCE_COUNTED: memory is handled throught reference counting, i.e.
	-- GObject

	-- Previous design was a black-or-white design either Eiffel-owned or not:
	-- C_STRUCT's are "owned" by the Eiffel code, and the Eiffel side should
	-- keep then longest lived reference to this struct.  This allows us to
	-- forget about wrapping for this objects.  If you have to share this
	-- struct and/or will have pointers to it around that will outlive the
	-- wrapper, please use SHARED_C_STRUCT


inherit
	DISPOSABLE
		undefine
			is_equal, -- we really should redefine is_equal and copy for all wrapper classes
			copy
		end

	-- WRAPPER conforms to ANY, because sometimes we need to get them via a
	-- POINTER.to_any operation
	ANY
		undefine
			is_equal, -- we really should redefine is_equal and copy for all wrapper classes
			copy
		end

insert
	WRAPPER_HANDLER -- to access `null_or', `exceptions' strings and external calls

	POINTER_HANDLING -- to access `address_of' and `content_of'

feature {WRAPPER, WRAPPER_HANDLER} -- Implementation

	from_external_pointer (a_ptr: POINTER) is
		do
			handle := a_ptr
		ensure
			handle = a_ptr
		end

	is_null: BOOLEAN is
		do
			Result := handle.is_null
		ensure
			definition: Result = handle.is_null
		end

	is_not_null: BOOLEAN is
		do
			Result := handle.is_not_null
		ensure
			definition: Result = handle.is_not_null
		end

	set_handle (a_ptr: POINTER) is
			-- Set a non-null handle. Raises an No_more_memory exception 
			-- if a_ptr.is_null. Use this, if you want to check the 
			-- result of some external allocation function.
		do
			if a_ptr.is_null then
				raise_exception(No_more_memory)
			end
			handle := a_ptr
		ensure
			definition: handle = a_ptr
			not_null: handle.is_not_null
		end

	handle: POINTER
		-- Pointer to the underlying C "thing" (i.e. a struct)
	
	reference: POINTER is
			-- The address of `handle'. Usuful to be passed to C
			-- functions that asks for pointer to pointer to struct
			-- (i.e. "GError **error")
		do
			Result:=address_of(handle)
		end

end -- class WRAPPER
