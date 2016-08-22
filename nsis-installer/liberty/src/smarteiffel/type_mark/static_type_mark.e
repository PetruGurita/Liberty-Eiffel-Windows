-- This file is part of Liberty Eiffel The GNU Eiffel Compiler Tools and Libraries.
-- See the Copyright notice at the end of this file.
--
deferred class STATIC_TYPE_MARK
   --
   -- Some definition shared by True static type marks.
   --

inherit
   TYPE_MARK

feature {ANY}
   is_static: BOOLEAN True

   frozen has_been_specialized: BOOLEAN True

   frozen specialize_in (new_type: TYPE)
      do
      end

   frozen specialize_thru (parent_type: TYPE; parent_edge: PARENT_EDGE; new_type: TYPE): TYPE_MARK
      do
         Result := Current
      end

   frozen declaration_type: TYPE_MARK
      do
         Result := Current
      end

   to_static (new_type: TYPE; allow_raw_class_name: BOOLEAN): TYPE_MARK
      do
         Result := Current
      end

   frozen signature_resolve_in (new_type: TYPE): TYPE
      do
         Result := type
      end

end -- class STATIC_TYPE_MARK
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
