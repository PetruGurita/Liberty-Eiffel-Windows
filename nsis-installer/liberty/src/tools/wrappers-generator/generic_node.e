class GENERIC_NODE
   -- A generic XML node generated by gccxml, i.e. not handled as a specific type.

inherit
   XML_COMPOSITE_NODE

insert
   SHARED_SETTINGS
      --DESCRIPTIONS

feature {ANY}
   for_each (a_procedure: PROCEDURE[TUPLE[GCCXML_NODE]])
      local
         i: INTEGER; node: GCCXML_NODE
      do
         from
            i := 1
         until
            i > children_count
         loop
            node ?= child(i)
            if node /= Void then
               a_procedure.call([node])
            end

            i := i + 1
         end
      end

end -- class GENERIC_NODE
-- Copyright (C) 2008-2016: ,2009,2010 Paolo Redaelli
-- wrappers-generator  is free software: you can redistribute it and/or modify it
-- under the terms of the GNU General Public License as publhed by the Free
-- Software Foundation, either version 2 of the License, or (at your option)
-- any later version.
-- wrappers-generator is distributed in the hope that it will be useful, but
-- WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
-- more details.
-- You should have received a copy of the GNU General Public License along with
-- th program.  If not, see <http://www.gnu.org/licenses/>.