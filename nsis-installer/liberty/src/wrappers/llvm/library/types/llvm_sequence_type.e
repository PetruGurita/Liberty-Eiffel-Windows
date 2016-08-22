deferred class LLVM_SEQUENCE_TYPE
-- Anchestor of LLVM_ARRAY_TYPE, LLVM_POINTER_TYPE and LLVM_VECTOR_TYPE
inherit LLVM_TYPE
insert LLVM_TYPE_FACTORY

feature {ANY}
   element_type: LLVM_TYPE is
         -- The type of the elements of Current sequence.
      do
         Result:=type_wrapper(llvmget_element_type(handle))
      ensure Result/=Void
      end

end -- class LLVM_SEQUENCE_TYPE

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
