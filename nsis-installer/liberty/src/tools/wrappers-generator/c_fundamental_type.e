class C_FUNDAMENTAL_TYPE
   -- A node of an XML file made by gccxml representing a fundamental type of the C language.
   -- The Eiffel wrapper type is computed with the assumption that the tools
   -- is run on an x86 or an x64 or a 32-bit ARM CPU to build wrappers for the
   -- same architecture.
   -- This is a currently known limitation of the tools: it does not take in
   -- count the need of crosscompiling .

inherit
   C_TYPE
   IDENTIFIED_NODE
   NAMED_NODE
   STORABLE_NODE

insert
   WRAPPER_GENERATOR_EXCEPTIONS

create {GCCXML_TREE}
   make

feature {ANY}
   store
      do
         types.fast_put(Current, id)
      end

   is_void: BOOLEAN
      do
         Result := c_name.is_equal(once U"void")
      end

   is_fundamental: BOOLEAN True

   has_wrapper: BOOLEAN
      do
         if not is_wrapper_computed then
            compute_wrapper
         end
         Result := stored_wrapper_type /= Void
      end

   size: INTEGER
      require
         not is_void
      do
         Result := attribute_at(once U"size").to_utf8.to_integer
      ensure
         Result > 0
      end

   last_error: STRING

   wrapper_type: STRING
         -- The name of the class of Liberty that wraps Current fundamental type
      do
         if not is_wrapper_computed then
            compute_wrapper
         end
         Result := stored_wrapper_type
      end

feature {} -- Implementation
   is_wrapper_computed: BOOLEAN

   stored_wrapper_type: STRING

   compute_wrapper
         -- Compute the actual wrapper type.
      local
         c_type: STRING
      do
         c_type := c_name.to_utf8
         inspect
            c_type
         when "bool" then
            stored_wrapper_type := once "INTEGER_8"
         when "char", "signed char", "unsigned char" then
            stored_wrapper_type := once "CHARACTER"
         when "complex double" then
            last_error := unhandled_complex_type -- should be stored_wrapper_type := once "COMPLEX_DOUBLE" when implemented
         when "complex float" then
            last_error := unhandled_complex_type -- should be stored_wrapper_type := once "COMPLEX_FLOAT" when implemented
         when "double" then
            stored_wrapper_type := once "REAL"
         when "float" then
            stored_wrapper_type := once "REAL_32"
         when "int" then
            stored_wrapper_type := once "INTEGER"
         when "long double" then
            stored_wrapper_type := once "REAL_EXTENDED"
            -- TODO: check if REAL_EXTENDED has the proper lenght on all
            -- supported architectures: Long doble is 96bit long on i386, 128
            -- bit on x64 and 64 bit on ARM.
         when "long int" then
            -- long int is the most problematic C type to be wrapped since it
            -- is widely used (think about fseek) and its size changes
            -- depending on the architecture: 32bit on x86 and ARM, and 64 bits
            -- on x64. It just cannot be wrapped with an integer with an
            -- explicit size (INTEGER_32, INTEGER_64) because it would require
            -- to change user code.  Perhaphs an anchored declaration (i.e.
            -- "like long_int") could be a solution
            stored_wrapper_type := once "like long"
         when "long long int" then
            stored_wrapper_type := once "INTEGER_64"
         when "long long unsigned int" then
            stored_wrapper_type := once "NATURAL_64"
         when "long unsigned int" then
            stored_wrapper_type := once "like long_unsigned"
         when "short int" then
            check
               size = 16
            end
            stored_wrapper_type := once "INTEGER_16"
         when "short unsigned int" then
            check
               size = 16
            end
            stored_wrapper_type := once "NATURAL_16"
         when "unsigned int" then
            stored_wrapper_type := once "NATURAL"
         when "void" then
            stored_wrapper_type := Void
            -- The details and description of each type has been taken from
            -- http://en.wikipedia.org/wiki/C_variable_types_and_declarations for a detailed description
         else
            last_error := unhandled_type
         end
         -- The code previously worked like th.
         -- if c_type.has_substring(once "int") then
         --      if c_type.has_substring(once "unsigned") then
         --              inspect size
         --              when 16 then stored_wrapper_type := once "NATURAL_16"
         --              when 32 then stored_wrapper_type := once "NATURAL_32"
         --              when 64 then stored_wrapper_type := once "NATURAL_64"
         --              else last_error := unhandled_unsigned_integer_type
         --              end
         --      else
         --              inspect size
         --              when 16 then stored_wrapper_type := once "INTEGER_16"
         --              when 32 then stored_wrapper_type := once "INTEGER_32"
         --              when 64 then stored_wrapper_type := once "INTEGER_64"
         --              else last_error := unhandled_integer_type
         --              end
         --      end
         -- elseif c_type.has_substring(once "float") or else
         --      c_type.has_substring(once "double") then
         --      inspect size
         --      when 32 then stored_wrapper_type := once "REAL_32"
         --      when 64 then stored_wrapper_type := once "REAL_64"
         --      when 80 then stored_wrapper_type := once "REAL_80"
         --      when 128 then stored_wrapper_type := once "REAL_128"
         --      else last_error := unhandled_double_type
         --      end
         -- elseif c_type.has_substring(once "complex") then
         --      -- could be "complex double" "complex float",
         --      -- "complex long double"
         --      last_error := unhandled_complex_type
         -- else last_error := unhandled_type
         -- end
         -- I shall test it a little before deciding which approach is best. Paolo 2013-04-04

         is_wrapper_computed := True
      ensure
         is_wrapper_computed = True
      end -- invariant name.is_equal(once U"FundamentalType")

end -- class C_FUNDAMENTAL_TYPE
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
