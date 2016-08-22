-- This file is part of a Liberty Eiffel library.
-- See the full copyright at the end.
--
class REGULAR_EXPRESSION_ITEM_LOOK
   --
   --

inherit
   REGULAR_EXPRESSION_ITEM
   REGULAR_EXPRESSION_ITEM_GLOBALS

create {ANY}
   make

feature {ANY}
   node: BACKTRACKING_NODE
         -- the node look

   is_ahead: BOOLEAN
         -- should look ahead? (or else behind?)

   is_positive: BOOLEAN
         -- is positive look? (or else negative?)

   make (value: BACKTRACKING_NODE; ahead, positive: BOOLEAN)
      require
         value_not_void: value /= Void
      do
         node := value
         is_ahead := ahead
         is_positive := positive
      ensure
         definition: node = value and is_ahead = ahead and is_positive = positive
         node_not_void: node /= Void
      end

   explore (matcher: BACKTRACKING_REGULAR_EXPRESSION)
      do
         if is_ahead then
            matcher.begin_look_ahead
            matcher.push_cut_point
            if is_positive then
               matcher.push_or(the_end_look_ahead_backtrack_item)
               matcher.push_and(the_end_look_ahead_continue_item)
            else
               matcher.push_or(the_end_look_ahead_continue_item)
               matcher.push_and(the_end_look_ahead_backtrack_item)
            end
         else
            matcher.begin_look_behind
            matcher.push_cut_point
            if is_positive then
               matcher.push_or(the_end_look_behind_backtrack_item)
               matcher.push_and(the_end_look_behind_continue_item)
            else
               matcher.push_or(the_end_look_behind_continue_item)
               matcher.push_and(the_end_look_behind_backtrack_item)
            end
         end
         matcher.set_current_node(node)
      end

feature {} -- looks
   the_end_look_ahead_backtrack_item: REGULAR_EXPRESSION_ITEM_LOOK_END
      once
         create Result.make(True, False)
      end

   the_end_look_ahead_continue_item: REGULAR_EXPRESSION_ITEM_LOOK_END
      once
         create Result.make(True, True)
      end

   the_end_look_behind_backtrack_item: REGULAR_EXPRESSION_ITEM_LOOK_END
      once
         create Result.make(False, False)
      end

   the_end_look_behind_continue_item: REGULAR_EXPRESSION_ITEM_LOOK_END
      once
         create Result.make(False, True)
      end

end -- class REGULAR_EXPRESSION_ITEM_LOOK
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
