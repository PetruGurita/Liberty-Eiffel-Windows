class C_NAMESPACE_ALIAS
   -- An NamespaceAlias node of an XML file made by gccxml, referring to an actual a C++ namespace.

inherit
   GCCXML_NODE
   CONTEXTED_NODE
   NAMED_NODE
   IDENTIFIED_NODE

create {GCCXML_TREE}
   make

feature {ANY}
   store
      do
      end

   emit_wrapper
         -- The wrapper of a namespace actually is not any Liberty code but only
         -- a directory that will be the cluster representing that namespace.
      do
         log("A NamespaceAlias can be skipped" )
      end

end -- class C_NAMESPACE_ALIAS
-- Copyright 2015 Paolo Redaelli

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
