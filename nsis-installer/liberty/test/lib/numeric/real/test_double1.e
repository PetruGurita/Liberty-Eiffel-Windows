-- This file is part of SmartEiffel The GNU Eiffel Compiler Tools and Libraries.
-- See the Copyright notice at the end of this file.
--
class TEST_DOUBLE1

create {}
   make

feature {ANY}
   make
      local
         i: INTEGER; d, d2: REAL_64
      do
         d := 1.6
         assert(d = d)
         assert(d >= 1.59)
         assert(d <= 1.61)
         d := 2
         assert(d = 2.0)
         i := 2
         d := i
         assert(d = 2)
         assert(d = 2.0)
         d := 1.51.to_string.to_real
         assert(d < 1.511)
         assert(d > 1.509)
         d := (-1.51).to_string.to_real
         assert(d > -1.52)
         assert(d < -1.50)
         assert(d.abs < 1.52)
         assert(d.abs > 1.50)
         assert((-d).abs < 1.52)
         assert((-d).abs > 1.50)
         d := 4.0
         d2 := 2.0
         assert(d.sqrt = d2)
      end

   assert (b: BOOLEAN)
      do
         cpt := cpt + 1
         if not b then
            std_output.put_string("TEST_DOUBLE1: ERROR Test # ")
            std_output.put_integer(cpt)
            std_output.put_string("%N")
         else
            -- std_output.put_string("Yes%N");
         end
      end

   cpt: INTEGER

end -- class TEST_DOUBLE1
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
