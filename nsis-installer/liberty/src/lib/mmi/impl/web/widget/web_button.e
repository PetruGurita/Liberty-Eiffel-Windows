-- This file is part of a Liberty Eiffel library.
-- See the full copyright at the end.
--
class WEB_BUTTON

inherit
   UI_TYPED_BRIDGE_BUTTON[WEB_JOB]
   WEB_WIDGET[UI_BUTTON]

insert
   LOGGING

create {WEB_JOB}
   make

feature {ANY}
   label: UNICODE_STRING
      do
         Result := ui.label
      end

feature {WEB_ITEM}
   save (context: WEB_CONTEXT)
      do
      end

   run (context: WEB_CONTEXT)
      local
         value: STRING
      do
         value := context.argument(id)
         if value /= Void then
            ui.click
         end
      end

   retrieve_name (a_name: STRING; a_extension: COLLECTION[STRING]): ABSTRACT_STRING
      do
         inspect
            a_name
         when "label" then
            Result := label.to_utf8
         else
            check Result = Void end
         end
      end

end -- class WEB_BUTTON
--
-- Copyright (C) 2012-2016: Cyril ADRIAN <cyril.adrian@gmail.com>.
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
