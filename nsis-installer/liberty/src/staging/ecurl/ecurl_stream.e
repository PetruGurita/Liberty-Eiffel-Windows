-- This file is part of a Liberty Eiffel library.
-- See the full copyright at the end.
--
class ECURL_STREAM

inherit
   STREAM

insert
   ECURL_PLUGIN
   ECURL_HANDLER
   URL_VALIDITY

feature {ANY}
   perform
         -- Perform the action; after that, options cannot be changed and the object can be used as a stream
         -- `on_error' is called with the cUrl error code (defined in ECURL_ERRORS) if the action failed to perform.
      require
         can_perform
      deferred
      end

   can_perform: BOOLEAN
      deferred
      end

   is_connected: BOOLEAN
      do
         Result := handle /= Void and then handle.in_use
      end

   can_disconnect: BOOLEAN True

feature {ANY}
   on_error: PROCEDURE[TUPLE[INTEGER, ECURL_HANDLE]]

   set_on_error (a_on_error: like on_error) assign on_error
      do
         on_error := a_on_error
      ensure
         on_error = a_on_error
      end

feature {ANY} -- Common options
   set_url (a_url: URL)
      require
         is_connected
         a_url /= Void
         not a_url.is_stream
      local
         s: STRING
      do
         s := once ""
         s.clear_count
         a_url.append_in(s)
         curl_easy_setopt_string(handle.handle, Curlopt_url, s)
      end

   set_url_string (a_url: ABSTRACT_STRING)
      require
         is_connected
         a_url /= Void
         valid_url(a_url)
      local
         s: STRING
      do
         if s ?:= a_url then
            s ::= a_url
         else
            s := once ""
            s.make_from_string(a_url)
         end
         curl_easy_setopt_string(handle.handle, Curlopt_url, s)
      end

   set_verbose (a_verbose: BOOLEAN)
         -- set ECURLOPT_VERBOSE
      require
         is_connected
      do
         curl_easy_setopt_boolean(handle.handle, Curlopt_verbose, a_verbose)
      end

   set_header (a_header: BOOLEAN)
         -- set ECURLOPT_HEADER
      require
         is_connected
      do
         curl_easy_setopt_boolean(handle.handle, Curlopt_header, a_header)
      end

feature {FILTER}
   filtered_descriptor: INTEGER
      do
         check False end
      end

   filtered_has_descriptor: BOOLEAN False

   filtered_stream_pointer: POINTER
      do
         check False end
      end

   filtered_has_stream_pointer: BOOLEAN False

feature {ECURL_HANDLE}
   is_connected_to (a_handle: like handle): BOOLEAN
      do
         Result := handle = a_handle
      ensure
         is_connected implies Result
      end

   connect_to (a_handle: like handle)
      require
         not is_connected
      do
         handle := a_handle
         init_connect
      end

feature {}
   handle: ECURL_HANDLE

   init_connect
      require
         handle /= Void
      deferred
      end

end -- class ECURL_STREAM
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
