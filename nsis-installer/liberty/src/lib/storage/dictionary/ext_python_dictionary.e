-- This file is part of a Liberty Eiffel library.
-- See the full copyright at the end.
--
class EXT_PYTHON_DICTIONARY[V_, K_]
   --
   -- Associative memory. Values of type `V_' are stored using Keys of type `K_'.
   --
   -- Efficient implementation of DICTIONARY using a hash_coder function on keys, using Python's algorithm.
   --

inherit
   ABSTRACT_PYTHON_DICTIONARY[V_, K_]
      rename
         make as abs_make
         with_capacity as abs_with_capacity
      end

create {ANY}
   make, with_capacity

feature {ANY}
   hash_coder: FUNCTION[TUPLE[K_], INTEGER]

feature {}
   hash_code (k: K_): INTEGER
      do
         Result := hash_coder.item([k])
      end

feature {ANY}
   make (a_hash_coder: like hash_coder)
      require
         a_hash_coder /= Void
      do
         hash_coder := a_hash_coder
         abs_make
      ensure
         is_empty
         hash_coder = a_hash_coder
      end

   with_capacity (a_hash_coder: like hash_coder; medium_size: INTEGER)
      require
         a_hash_coder /= Void
         medium_size > 0
      do
         hash_coder := a_hash_coder
         abs_with_capacity(medium_size)
      ensure
         is_empty
         hash_coder = a_hash_coder
         capacity >= medium_size
      end

invariant
   hash_coder /= Void

end -- class EXT_PYTHON_DICTIONARY
--
-- Copyright (C) 2009-2016: by all the people cited in the AUTHORS file.
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
