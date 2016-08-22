-- This file is part of a Liberty Eiffel library.
-- See the full copyright at the end.
--
class TEST_ATTRIBUTE03

insert
   EIFFELTEST_TOOLS

create {}
   main

feature {ANY}
   main
      do
         label_assert("attribute is initialized", attrib = 5)
         attrib := 6
         label_assert("attribute is modifiable", attrib = 6)
      end

   attrib: INTEGER
         -- test attribute which initializes during the first access "self-initializing"
      is
      attribute
         Result := 5
         -- see ECMA-367 chapter 8.18.1 this is some "object-level 
         -- once" instead of the real once, which is class-level (or 
         -- even system level if you want)
      ensure
         Result = 5
         -- TODO: check what ECMA defines: When is the postcondition 
         -- of an atterbute to be executed? Only for the case a 
         -- Compound is given (i. e. it is initialized by the code above??
      end
         

end -- class TEST_ATTRIBUTE03
--
-- Copyright (C) 2015-2016: by all the people cited in the AUTHORS file.
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
