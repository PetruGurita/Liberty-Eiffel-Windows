class LLVM_VECTOR_TYPE
-- A type representing a vector
inherit LLVM_SEQUENCE_TYPE
create {ANY} make
create {WRAPPER, WRAPPER_HANDLER} from_external_pointer

feature {ANY} -- Creation
   make (a_type: LLVM_TYPE; a_count: NATURAL_32) is
         -- Creates a vector type with `a_count' elements of `a_type'.
      require a_type/=Void
      do
         handle:=llvmvector_type(a_type.handle,a_count)
      end
feature {ANY}
   size: NATURAL_32 is
         -- Size of current vector
      do
         Result:=llvmget_vector_size(handle)
      end
invariant type_kind.is_vector_type_kind
end -- class LLVM_VECTOR_TYPE

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
