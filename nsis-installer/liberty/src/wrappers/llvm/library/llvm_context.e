class LLVM_CONTEXT

inherit 
	C_STRUCT
		redefine default_create
		end
	EIFFEL_OWNED 
		-- TODO: check if it is the correct behaviour.
		redefine dispose, default_create
		end
insert CORE_EXTERNALS undefine default_create end
create {ANY} default_create, make
create {WRAPPER,WRAPPER_HANDLER} from_external_pointer
feature {} -- Creation
	make is
		do
			handle:=llvmcontext_create
		end

	default_create is
		do
			handle:=llvmget_global_context
		end

feature {} -- Disposing
	dispose is
		do
			llvmcontext_dispose(handle)
		end

	struct_size: like size_t is do not_yet_implemented end 

end -- class LLVM_CONTEXT

-- Copyright 2009 Paolo Redaelli
-- This file is part of LLVM wrappers for Liberty Eiffel.
--
-- This library is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Lesser General Public License as published by
-- the Free Software Foundation, version 3 of the License.
--
-- Liberty Eiffel is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with Liberty Eiffel.  If not, see <http://www.gnu.org/licenses/>.
--

