-- This file is part of a Liberty Eiffel library.
-- See the full copyright at the end.
--
class TIME_IN_SPANISH
   --
   -- The Spanish format class for class TIME.
   --

inherit
   TIME_FORMATTER

create {ANY}
   default_create, set_time

feature {ANY}
   day_in (buffer: STRING)
      local
         s: STRING
      do
         if short_mode then
            inspect
               time.week_day
            when 0 then
               s := once "Dom"
            when 1 then
               s := once "Lun"
            when 2 then
               s := once "Mar"
            when 3 then
               s := once "Mie"
            when 4 then
               s := once "Jue"
            when 5 then
               s := once "Vie"
            when 6 then
               s := once "Sab"
            end
         else
            inspect
               time.week_day
            when 0 then
               s := once "Domingo"
            when 1 then
               s := once "Lunes"
            when 2 then
               s := once "Martes"
            when 3 then
               s := once "Miercoles"
            when 4 then
               s := once "Jueves"
            when 5 then
               s := once "Viernes"
            when 6 then
               s := once "Sabado"
            end
         end
         buffer.append(s)
      end

   month_in (buffer: STRING)
      local
         s: STRING
      do
         if short_mode then
            inspect
               time.month
            when 1 then
               s := once "Ene"
            when 2 then
               s := once "Feb"
            when 3 then
               s := once "Mar"
            when 4 then
               s := once "Abr"
            when 5 then
               s := once "May"
            when 6 then
               s := once "Jun"
            when 7 then
               s := once "Jul"
            when 8 then
               s := once "Ago"
            when 9 then
               s := once "Sep"
            when 10 then
               s := once "Oct"
            when 11 then
               s := once "Nov"
            when 12 then
               s := once "Dic"
            end
         else
            inspect
               time.month
            when 1 then
               s := once "Enero"
            when 2 then
               s := once "Febrero"
            when 3 then
               s := once "Marzo"
            when 4 then
               s := once "Abril"
            when 5 then
               s := once "Mayo"
            when 6 then
               s := once "Junio"
            when 7 then
               s := once "Julio"
            when 8 then
               s := once "Agosto"
            when 9 then
               s := once "Septiembre"
            when 10 then
               s := once "Octubre"
            when 11 then
               s := once "Noviembre"
            when 12 then
               s := once "Diciembre"
            end
         end
         buffer.append(s)
      end

   append_in (buffer: STRING)
      do
         day_in(buffer)
         buffer.extend(' ')
         time.day.append_in(buffer)
         buffer.extend(' ')
         month_in(buffer)
         buffer.extend(' ')
         time.year.append_in(buffer)
         buffer.extend(' ')
         time.hour.append_in(buffer)
         buffer.extend(':')
         time.minute.append_in(buffer)
         if not short_mode then
            buffer.extend(':')
            time.second.append_in(buffer)
         end
      end

end -- class TIME_IN_SPANISH
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
