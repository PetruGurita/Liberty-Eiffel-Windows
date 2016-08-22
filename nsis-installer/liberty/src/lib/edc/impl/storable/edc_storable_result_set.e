-- -----------------------------------------------------------------------------------------------------------
-- This file is part of the ESE library.
-- Copyright (C) 2006-2016: Cyril ADRIAN <cyril.adrian@gmail.com> and others (see AUTHORS)
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
-- associated documentation files (the "Software"), to deal in the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
-- following conditions:
--
-- The above copyright notice and this permission notice shall be included in all copies or substantial
-- portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
-- LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
-- EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
-- IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
-- USE OR OTHER DEALINGS IN THE SOFTWARE.
--
-- http://ese.sourceforge.net
-- -----------------------------------------------------------------------------------------------------------
class EDC_STORABLE_RESULT_SET

inherit
   EDC_RESULT_SET

create {EDC_STORABLE_EXPRESSION_SELECTOR}
   make

feature {ANY} -- Connection:
   disconnect
      do
         connection := Void
      end

   is_connected: BOOLEAN
      do
         Result := connection /= Void and then connection.is_connected
      end

   connection: EDC_STORABLE_CONNECTION

feature {ANY} -- Data query:
   is_after_last: BOOLEAN
      do
         Result := cursor > rows.upper
      end

   is_before_first: BOOLEAN
      do
         Result := cursor < rows.lower
      end

   next
      do
         cursor := cursor + 1
      end

   previous
      do
         cursor := cursor - 1
      end

feature {EDC_CONNECTION}
   update (new_values: TRAVERSABLE[EDC_VALUE])
      do
         not_yet_implemented
      end

   delete
      do
         not_yet_implemented
      end

feature {ANY}
   fetch_direction: INTEGER_8

   column_count: INTEGER
      do
         Result := columns.count
      end

   column (index: INTEGER): EDC_COLUMN
      do
         Result := columns.item(index)
      end

   column_named (column_name: STRING): EDC_COLUMN
      local
         i: INTEGER; col: EDC_COLUMN
      do
         from
            i := columns.lower
         until
            Result /= Void or else i > columns.upper
         loop
            col := columns.item(i)
            if col.name.is_equal(column_name) then
               Result := col
            end
            i := i + 1
         end
      end

feature {EDC_COLUMN}
   item (a_column: EDC_COLUMN): EDC_DATUM
      local
         i: INTEGER
      do
         i := columns.first_index_of(a_column)
         Result := rows.item(cursor).item(i)
      end

feature {EDC_STORABLE_EXPRESSION_SELECTOR}
   add (a_row: FAST_ARRAY[EDC_DATUM])
      require
         valid_row(a_row)
         not has(a_row)
      do
         rows.add_last(a_row)
      end

   valid_row (a_row: FAST_ARRAY[EDC_DATUM]): BOOLEAN
      local
         i: INTEGER
      do
         Result := a_row /= Void and then a_row.count = columns.count
         from
            i := columns.lower
         until
            not Result or else i > columns.upper
         loop
            Result := columns.item(i).valid_value(a_row.item(i))
            i := i + 1
         end
      end

   has (a_row: FAST_ARRAY[EDC_DATUM]): BOOLEAN
      require
         valid_row(a_row)
      local
         r, i: INTEGER; row: FAST_ARRAY[EDC_DATUM]
      do
         from
            r := rows.lower
         until
            Result or else r > rows.upper
         loop
            row := rows.item(r)
            from
               Result := True
               i := a_row.lower
            until
               not Result or else i > a_row.upper
            loop
               Result := columns.item(i).same_values(a_row.item(i), row.item(i))
               i := i + 1
            end
            r := r + 1
         end
      end

feature {}
   make (a_connection: EDC_STORABLE_CONNECTION; a_columns: like columns)
      require
         a_columns.count > 0
      do
         columns := a_columns
         connection := a_connection
         fetch_direction := a_connection.fetch_direction
         create rows.make(0)
         cursor := -1
      ensure
         is_before_first
      end

   columns: FAST_ARRAY[EDC_COLUMN]

   rows: FAST_ARRAY[FAST_ARRAY[EDC_DATUM]]

   cursor: INTEGER

end -- class EDC_STORABLE_RESULT_SET
