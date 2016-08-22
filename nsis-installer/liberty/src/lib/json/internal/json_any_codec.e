-- This file is part of a Liberty Eiffel library.
-- See the full copyright at the end.
--
deferred class JSON_ANY_CODEC

insert
   JSON_HANDLER

feature {JSON_HANDLER}
   create_array: JSON_DATA
      deferred
      end

   add_to_array (array, value: JSON_DATA)
      require
         array /= Void
         value /= Void
      deferred
      end

   finalize_array (array: JSON_DATA)
      require
         array /= Void
      deferred
      end

   create_object: JSON_DATA
      deferred
      end

   add_to_object (object, key, value: JSON_DATA)
      require
         object /= Void
         key /= Void
         value /= Void
      deferred
      end

   finalize_object (object: JSON_DATA)
      require
         object /= Void
      deferred
      end

   create_string (string: JSON_STRING): JSON_DATA
      deferred
      ensure
         Result /= Void
      end

   create_number (number: JSON_NUMBER): JSON_DATA
      deferred
      ensure
         Result /= Void
      end

   true_value: JSON_DATA
      deferred
      ensure
         Result /= Void
      end

   false_value: JSON_DATA
      deferred
      ensure
         Result /= Void
      end

   null_value: JSON_DATA
      deferred
      ensure
         Result /= Void
      end

end -- class JSON_ANY_CODEC
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
