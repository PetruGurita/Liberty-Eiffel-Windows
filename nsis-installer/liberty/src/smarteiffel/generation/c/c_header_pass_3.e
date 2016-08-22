-- This file is part of Liberty Eiffel The GNU Eiffel Compiler Tools and Libraries.
-- See the Copyright notice at the end of this file.
--
class C_HEADER_PASS_3

inherit
   C_HEADER_PASS

create {C_PRETTY_PRINTER}
   make

feature {}
   header_comment: STRING "/* C Header Pass 3: */%N"

   pre_compile
      do
      end

   do_compile (live_type: LIVE_TYPE)
      do
         if live_type.canonical_type_mark.is_user_expanded and then live_type.writable_attributes /= Void then
            live_type.writable_attributes.for_each(agent compile_expanded(?))
         end
         live_type.canonical_type_mark.accept(Current)
      end

   compile_expanded (writable_attribute: RUN_FEATURE_2)
      require
         writable_attribute /= Void
      local
         attribute_type: TYPE_MARK
      do
         attribute_type := writable_attribute.result_type
         if attribute_type.is_expanded then
            compile_live_type(attribute_type.type.live_type)
         end
      end

feature {LIKE_ARGUMENT_TYPE_MARK}
   visit_like_argument_type_mark (visited: LIKE_ARGUMENT_TYPE_MARK)
      do
         check
            False
         end
      end

feature {LIKE_FEATURE_TYPE_MARK}
   visit_like_feature_type_mark (visited: LIKE_FEATURE_TYPE_MARK)
      do
         check
            False
         end
      end

feature {LIKE_CURRENT_TYPE_MARK}
   visit_like_current_type_mark (visited: LIKE_CURRENT_TYPE_MARK)
      do
         check
            False
         end
      end

feature {FORMAL_GENERIC_TYPE_MARK}
   visit_formal_generic_type_mark (visited: FORMAL_GENERIC_TYPE_MARK)
      do
         check
            False
         end
      end

feature {REAL_TYPE_MARK}
   visit_real_type_mark (visited: REAL_TYPE_MARK)
      do
      end

feature {CHARACTER_TYPE_MARK}
   visit_character_type_mark (visited: CHARACTER_TYPE_MARK)
      do
      end

feature {BOOLEAN_TYPE_MARK}
   visit_boolean_type_mark (visited: BOOLEAN_TYPE_MARK)
      do
      end

feature {POINTER_TYPE_MARK}
   visit_pointer_type_mark (visited: POINTER_TYPE_MARK)
      do
      end

feature {NATURAL_TYPE_MARK}
   visit_natural_type_mark (visited: NATURAL_TYPE_MARK)
      do
      end

feature {INTEGER_TYPE_MARK}
   visit_integer_type_mark (visited: INTEGER_TYPE_MARK)
      do
      end

feature {STRING_TYPE_MARK}
   visit_string_type_mark (visited: STRING_TYPE_MARK)
      do
      end

feature {CLASS_TYPE_MARK}
   visit_class_type_mark (visited: CLASS_TYPE_MARK)
      do
         if visited.is_expanded and then cpp.need_struct.for(visited) then
            standard_c_struct(visited)
         end
      end

feature {ANY_TYPE_MARK}
   visit_any_type_mark (visited: ANY_TYPE_MARK)
      do
      end

feature {EMPTY_TUPLE_TYPE_MARK}
   visit_empty_tuple_type_mark (visited: EMPTY_TUPLE_TYPE_MARK)
      do
      end

feature {NON_EMPTY_TUPLE_TYPE_MARK}
   visit_non_empty_tuple_type_mark (visited: NON_EMPTY_TUPLE_TYPE_MARK)
      do
      end

feature {AGENT_TYPE_MARK}
   visit_agent_type_mark (visited: AGENT_TYPE_MARK)
      do
      end

feature {NATIVE_ARRAY_TYPE_MARK}
   visit_native_array_type_mark (visited: NATIVE_ARRAY_TYPE_MARK)
      do
      end

feature {WEAK_REFERENCE_TYPE_MARK}
   visit_weak_reference_type_mark (visited: WEAK_REFERENCE_TYPE_MARK)
      do
         out_h.copy(once "struct S")
         visited.id.append_in(out_h)
         out_h.append(once "{Tid id;T0*o;};%N")
         flush_out_h
         out_h.clear_count
         out_h.extend('T')
         visited.id.append_in(out_h)
         out_h.append(once " M")
         visited.id.append_in(out_h)
         out_c.clear_count
         out_c.extend('{')
         visited.id.append_in(out_c)
         out_c.append(once ",NULL}")
         cpp.write_extern_2(out_h, out_c)
      end

feature {USER_GENERIC_TYPE_MARK}
   visit_user_generic_type_mark (visited: USER_GENERIC_TYPE_MARK)
      do
         if visited.is_expanded then
            if cpp.need_struct.for(visited) then
               standard_c_struct(visited)
            else
               out_h.append(once "typedef int T")
               visited.id.append_in(out_h)
               out_h.append(once ";%N")
            end
            standard_c_object_model(visited)
         end
      end

feature {ARRAY_TYPE_MARK}
   visit_array_type_mark (visited: ARRAY_TYPE_MARK)
      do
      end

end -- class C_HEADER_PASS_3
--
-- ------------------------------------------------------------------------------------------------------------------------------
-- Copyright notice below. Please read.
--
-- Liberty Eiffel is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License,
-- as published by the Free Software Foundation; either version 2, or (at your option) any later version.
-- Liberty Eiffel is distributed in the hope that it will be useful but WITHOUT ANY WARRANTY; without even the implied warranty
-- of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have
-- received a copy of the GNU General Public License along with Liberty Eiffel; see the file COPYING. If not, write to the Free
-- Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
--
-- Copyright (C) 2011-2016: Cyril ADRIAN, Paolo REDAELLI, Raphael MACK
--
-- http://www.gnu.org/software/liberty-eiffel/
--
--
-- Liberty Eiffel is based on SmartEiffel (Copyrights below)
--
-- Copyright(C) 1994-2002: INRIA - LORIA (INRIA Lorraine) - ESIAL U.H.P.       - University of Nancy 1 - FRANCE
-- Copyright(C) 2003-2006: INRIA - LORIA (INRIA Lorraine) - I.U.T. Charlemagne - University of Nancy 2 - FRANCE
--
-- Authors: Dominique COLNET, Philippe RIBET, Cyril ADRIAN, Vincent CROIZIER, Frederic MERIZEN
--
-- ------------------------------------------------------------------------------------------------------------------------------
