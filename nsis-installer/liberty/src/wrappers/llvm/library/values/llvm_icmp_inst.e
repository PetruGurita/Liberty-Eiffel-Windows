class LLVM_ICMP_INST
	-- An integer comparison operator.

	-- This instruction compares its operands according to the predicate given
	-- to the constructor. It only operates on integers or pointers. The
	-- operands must be identical types.

inherit LLVM_CMP_INST
create {LLVM_BUILDER} from_external_pointer

end -- class LLVM_ICMP_INST

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

