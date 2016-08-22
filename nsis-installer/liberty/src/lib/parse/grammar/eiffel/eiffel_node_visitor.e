-- This file is part of a Liberty Eiffel library.
-- See the full copyright at the end.
--
deferred class EIFFEL_NODE_VISITOR

inherit
   EIFFEL_LIST_NODE_IMPL_VISITOR
   EIFFEL_NON_TERMINAL_NODE_IMPL_VISITOR
   EIFFEL_TERMINAL_NODE_IMPL_VISITOR

feature {EIFFEL_LIST_NODE_IMPL}
   visit_eiffel_list_node_impl (node: EIFFEL_LIST_NODE_IMPL)
      do
         node.for_each(agent {EIFFEL_NODE}.accept(Current))
      end

feature {EIFFEL_NON_TERMINAL_NODE_IMPL}
   visit_eiffel_non_terminal_node_impl (node: EIFFEL_NON_TERMINAL_NODE_IMPL)
      local
         i: INTEGER
      do
         from
            i := node.lower
         until
            i > node.upper
         loop
            node.node_at(i).accept(Current)
            i := i + 1
         end
      end

end -- class EIFFEL_NODE_VISITOR
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
