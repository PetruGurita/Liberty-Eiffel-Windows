-- This file is part of a Liberty Eiffel library.
-- See the full copyright at the end.
--
class EXEC_OUTPUT_STREAM_POSIX

inherit
   TERMINAL_OUTPUT_STREAM
      redefine
         can_put_character
      end

insert
   EXEC_STREAM

create {PROCESS}
   make

feature {ANY}
   is_connected: BOOLEAN

   can_put_character (c: CHARACTER): BOOLEAN
      do
         Result := not process.is_finished
      end

   disconnect
      do
         is_connected := False
         basic_exec_close(filtered_descriptor)
      end

feature {FILTER}
   filtered_put_character (c: CHARACTER)
      do
         basic_exec_put_character(descriptor, c)
         if c = '%N' then
            filtered_flush
         end
      end

   filtered_flush
      do
         basic_exec_flush(descriptor)
      end

   filtered_descriptor: INTEGER

   filtered_has_descriptor: BOOLEAN True

   filtered_stream_pointer: POINTER
      do
         std_error.put_string("EXEC_OUTPUT_STREAM_POSIX.filtered_stream_pointer has been called!%N")
         crash
      end

   filtered_has_stream_pointer: BOOLEAN False

feature {PROCESS}
   make (a_process: like process)
      require
         a_process /= Void
         process /= Void implies process = a_process
      do
         process := a_process
         create_pipe
         is_connected := pipe.is_not_null
         if is_connected then
            filtered_descriptor := basic_exec_get_out_descriptor(pipe)
         end
      end

   process: PROCESS

feature {}
   basic_exec_get_out_descriptor (a_pipe: POINTER): INTEGER
      external "plug_in"
      alias "{
         location: "${sys}/plugins"
         module_name: "exec"
         feature_name: "basic_exec_posix_get_out_descriptor"
         }"
      end

   basic_exec_put_character (fd: INTEGER; c: CHARACTER)
      external "plug_in"
      alias "{
         location: "${sys}/plugins"
         module_name: "exec"
         feature_name: "basic_exec_posix_put_character"
         }"
      end

   basic_exec_flush (fd: INTEGER)
      external "plug_in"
      alias "{
         location: "${sys}/plugins"
         module_name: "exec"
         feature_name: "basic_exec_posix_flush"
         }"
      end

   basic_exec_close (a_fd: INTEGER)
      external "plug_in"
      alias "{
         location: "${sys}/plugins"
         module_name: "exec"
         feature_name: "basic_exec_posix_close"
         }"
      end

end -- class EXEC_OUTPUT_STREAM_POSIX
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
