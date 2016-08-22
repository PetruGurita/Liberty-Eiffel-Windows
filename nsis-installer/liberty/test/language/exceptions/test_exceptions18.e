-- This file is part of SmartEiffel The GNU Eiffel Compiler Tools and Libraries.
-- See the Copyright notice at the end of this file.
--
class TEST_EXCEPTIONS18

insert
   EXCEPTIONS

create {}
   make

feature {ANY}
   val: INTEGER

   aux: AUX_EXCEPTIONS18A

   make
      local
         counter: INTEGER
      do
         create aux.make(val)
      rescue
         is_true(Class_invariant = exception)
         counter := counter + 1
         val := val + 1
         retry
      end

feature {ANY}
   is_true (b: BOOLEAN)
      do
         cpt := cpt + 1
         if not b then
            crash
            std_output.put_string("TEST_EXCEPTION18: ERROR Test # ")
            std_output.put_integer(cpt)
            std_output.put_string("%N")
         else
            --std_output.put_string("Yes%N");
         end
      end

   cpt: INTEGER

invariant
   val = 2
   val = aux.i

end -- class TEST_EXCEPTIONS18
--
-- ------------------------------------------------------------------------------------------------------------------------------
-- Copyright notice below. Please read.
--
-- SmartEiffel is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License,
-- as published by the Free Software Foundation; either version 2, or (at your option) any later version.
-- SmartEiffel is distributed in the hope that it will be useful but WITHOUT ANY WARRANTY; without even the implied warranty
-- of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have
-- received a copy of the GNU General Public License along with SmartEiffel; see the file COPYING. If not, write to the Free
-- Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
--
-- Copyright(C) 1994-2002: INRIA - LORIA (INRIA Lorraine) - ESIAL U.H.P.       - University of Nancy 1 - FRANCE
-- Copyright(C) 2003-2006: INRIA - LORIA (INRIA Lorraine) - I.U.T. Charlemagne - University of Nancy 2 - FRANCE
--
-- Authors: Dominique COLNET, Philippe RIBET, Cyril ADRIAN, Vincent CROIZIER, Frederic MERIZEN
--
-- http://SmartEiffel.loria.fr - SmartEiffel@loria.fr
-- ------------------------------------------------------------------------------------------------------------------------------
