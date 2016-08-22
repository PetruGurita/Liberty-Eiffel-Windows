-- This file is part of a Liberty Eiffel library.
-- See the full copyright at the end.
--
expanded class INTEGER_16

insert
   INTEGER_GENERAL

feature {ANY} -- Conversions:
   fit_integer_8: BOOLEAN
         -- Does `Current' fit in INTEGER_8?
      do
         if Current >= -128 then
            Result := Current <= 127
         end
      ensure
         Result = Current.in_range(-128, 127)
      end

   to_integer_8: INTEGER_8
         -- Explicit conversion to INTEGER_8.
      require
         fit_integer_8
      external "built_in"
      ensure
         Current.is_equal(Result)
      end

   to_integer_32: INTEGER_32
         -- Explicit conversion to INTEGER_32.
      do
         Result := Current
      ensure
         Current = Result
      end

   to_integer_64: INTEGER_64
         -- Explicit conversion to INTEGER_64.
      do
         Result := Current
      ensure
         Current = Result
      end

   fit_natural_8: BOOLEAN
         -- Does `Current' fit in NATURAL_8?
      do
         if Current >= 0 then
            Result := Current <= 255
         end
      ensure
         Result = Current.in_range(0, 255)
      end

   to_natural_8: NATURAL_8
         -- Explicit conversion to NATURAL_8.
      require
         fit_natural_8
      external "built_in"
      ensure
         Result.to_integer_16 = Current
      end

   to_natural_16: NATURAL_16
         -- Explicit conversion to NATURAL_16.
      require
         Current >= 0
      external "built_in"
      ensure
         Result.to_integer_16 = Current
      end

   to_natural_32: NATURAL_32
         -- Explicit conversion to NATURAL_32.
      require
         Current >= 0
      external "built_in"
      ensure
         Result.to_integer_16 = Current
      end

   to_natural_64: NATURAL_64
         -- Explicit conversion to NATURAL_64.
      require
         Current >= 0
      external "built_in"
      ensure
         Result.to_integer_16 = Current
      end

   to_real_32: REAL_32
         -- Explicit conversion to REAL_32.
      do
         Result := Current
      end

   to_real_64: REAL_64
         -- Explicit conversion to REAL_64.
      do
         Result := Current
      end

   to_number: NUMBER
         -- Explicit conversion to NUMBER.
      local
         number_tools: NUMBER_TOOLS
      do
         Result := number_tools.from_integer(Current)
      ensure then
         Result @= Current
      end

   decimal_digit: CHARACTER
      do
         Result := (Current + '0'.code).to_character
      end

   hexadecimal_digit: CHARACTER
      do
         if Current <= 9 then
            Result := (Current + '0'.code).to_character
         else
            Result := ('A'.code + (Current - 10)).to_character
         end
      end

   infix "|..|" (other: INTEGER_16): INTEGER_RANGE[INTEGER_16]
      require
         Current <= other
      do
         create Result.make(to_integer_32, other.to_integer_32, integer_range_itemize, integer_range_indexize)
      end

feature {}
   integer_range_itemize: FUNCTION[TUPLE[INTEGER], INTEGER_16]
      once
         Result := agent (i: INTEGER): INTEGER_16 do Result := i.to_integer_16 end (?)
      end

   integer_range_indexize: FUNCTION[TUPLE[INTEGER_16], INTEGER]
      once
         Result := agent (i: INTEGER_16): INTEGER do Result := i.to_integer_32 end (?)
      end

feature {ANY}
   low_8: INTEGER_8
         -- The 8 low bits of `Current' (i.e. the right-most part).
      external "built_in"
      end

   high_8: INTEGER_8
         -- The 8 high bits of `Current' (i.e. the left-most part).
      do
         Result := (Current |>> 8).low_8
      end

   one: INTEGER_8 1

   zero: INTEGER_8 0

   hash_code: INTEGER
      do
         Result := Current & 0x7FFF
      end

   sqrt: REAL
      do
         Result := to_real_64.sqrt
      end

   log: REAL
      do
         Result := to_real_64.log
      end

   log10: REAL
      do
         Result := to_real_64.log10
      end

   bit_count: INTEGER_8 16

end -- class INTEGER_16
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
