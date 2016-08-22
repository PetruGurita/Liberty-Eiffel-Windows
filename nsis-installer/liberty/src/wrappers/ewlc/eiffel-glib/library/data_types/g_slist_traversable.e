note
	description: "The GSList provides a standard singly-linked list data structure. See also G_SLIST, G_LIST"
	copyright: "(C) 2006, 2008 Paolo Redaelli, Raphael Mack"
	license: "LGPL v2 or later"
	date: "$Date$"
	revision: "$Revision$"

deferred class G_SLIST_TRAVERSABLE [ITEM->WRAPPER]
	-- A singly-linked list data structure.
	
	-- To add elements, use `add_last', `append', `add_first', `prepend',
	-- `add' and (TODO `insert_sorted').

	-- To remove elements, use `remove', `remove_first' and `remove_last'.

	-- To find elements in the list use `last', (TODO: `next'), 
	-- `item', `fast_has' (PS: `has' calls `fast_has' in turn), `first_index_of'.

	-- To find the index of an element use TODO: g_slist_position() and
	-- g_slist_index().
	
	-- TODO: To call a function for each element in the list use
	-- g_slist_foreach().
	
	-- To free the entire list, use g_slist_free().

inherit
	WRAPPER
   
   TRAVERSABLE[ITEM]
      undefine
         copy
      redefine
         is_equal
      end
   
   WRAPPER_FACTORY[ITEM]
	G_FREEZABLE

insert
	G_SLIST_EXTERNALS 
		undefine
			fill_tagged_out_memory
		end

feature {ANY}
	-- At C level a NULL pointer is considered to be the empty list so
	-- you simply set a GSList* to NULL.

	-- Note that most of the low-level C GSList functions expect to be
	-- passed a pointer to the first element in the list. The functions
	-- which insert elements return the new start of the list, which
	-- may have changed.

	make, make_empty is
		do
			handle := default_pointer
		end

	first: ITEM is
		local p: POINTER -- Item Pointer
		do
			p:=g_slist_get_data (handle)
			if p.is_not_null then Result := wrapper(p) end
		end

	last: like first is
		local
         p: POINTER -- Item Pointer
		do
			p := g_slist_get_data (g_slist_last (handle))
			if p.is_not_null then
            Result := wrapper(p)
         end
		end

	item (i: INTEGER): like first is
		local p: POINTER -- Item Pointer
		do
			p:=g_slist_nth_data (handle, i)
			if p.is_not_null then Result:=wrapper(p) end
		end

	put (an_item: like first; i: INTEGER) is
		require
			valid_item: an_item /= Void 
			mutable: is_mutable
		do
			g_slist_set_data (g_slist_nth(handle,i), an_item.handle)
		end
	
	slice (min, max: INTEGER): like Current is do not_yet_implemented end

	swap (i,j: INTEGER) is
		require
			is_mutable 
		local ith,jth,tmp: POINTER
		do
			ith := g_slist_nth_data (handle,i)
			jth := g_slist_nth_data (handle,j)

			tmp := g_slist_get_data(ith)
			g_slist_set_data (ith, g_slist_get_data(jth))
			g_slist_set_data (jth, tmp)
		end

	set_all_with (v: like first) is
		require
         is_mutable 
		local
         ith: POINTER
		do
			from
            ith := handle
			until
            ith.is_null
			loop
				g_slist_set_data (ith, v.handle)
				ith := g_slist_get_next (ith)
			end
		end

	clear_all is do not_yet_implemented end

	add_first (an_item: like first) is
			-- Adds `an_item' on to the start of the list.
		require 
			is_mutable
			valid_item: an_item/=Void
		do
			handle := g_slist_prepend (handle, an_item.handle)
			-- Note: The return value is the new start of the list, which
			-- may have changed, so make sure you store the new value.

			-- /* Notice that it is initialized to the empty list. */
			-- GSList *list = NULL; list = g_slist_prepend (list,
			-- "last"); list = g_slist_prepend (list, "first");
		end

	add_last (an_item: like first) is
			-- Adds `an_item' on to the end of the list.  Note: this
			-- feature has to traverse the entire list to find the end,
			-- which is inefficient when adding multiple elements. A
			-- common idiom to avoid the inefficiency is to prepend the
			-- elements and reverse the list when all elements have been
			-- added.
		require
			is_mutable
			valid_item: an_item/=Void
		do
			handle := g_slist_append (handle, an_item.handle)

			-- Note: The return value is the new start of the list, which
			-- may have changed, so make sure you store the new value.
		end

	add (element: like first; index: INTEGER) is
			-- Add `element' at `index`
		require
			is_mutable
			element /= Void
		do
			handle := g_slist_insert (handle, element.handle, index-1)
		end
	
	append_collection (other: COLLECTION[ITEM]) is
			--
		require
			is_mutable
		do
			not_yet_implemented -- TODO
		end

	force (element: like first; index: INTEGER) is do not_yet_implemented end

	remove_first is
		do
			handle := g_slist_delete_link (handle, handle)
		end

	remove (index: INTEGER) is
		do
			handle := g_slist_delete_link (handle,
												  g_slist_nth_data (handle, index-1))
		end

	remove_head (n: INTEGER) is
		local i: INTEGER
		do
			from i:=n until i>0 loop
				handle:=g_slist_delete_link(handle,handle)
				i:=i-1
			end
		end

	remove_tail (n: INTEGER) is
		local i: INTEGER
		do
			reverse
			remove_head(n)
			reverse
		end

	remove_last is
		do
			handle:=g_slist_delete_link (handle,g_slist_last (handle))
		end

	clear_count, clear_count_and_capacity is
			-- Discard all items (is_empty is True after that call). Frees
			-- all of the memory used by a GSList. The freed elements are
			-- added to the GAllocator free list.
		do
			g_slist_free (handle)
			handle := default_pointer 
		end

	has (x: like first): BOOLEAN is
			-- Look for x using is_equal for comparison. Note: current
			-- implementation is just a copy of `fast_has'; try using
			-- `fast_has' whenever possible since an implementation of
			-- `has' that really uses `is_equal' will be quite slow.
		do
			Result:=fast_has(x)
		end
	
	fast_has (x: like first): BOOLEAN is
			-- Look for x using basic = for comparison.
		do
			if (g_slist_find(handle,x.handle).is_not_null)
			then Result:=True
			else check Result=False end
			end
		end
	
	first_index_of (element: like first): INTEGER is
			-- Give the index of the first occurrence of element using
			-- is_equal for comparison. Answer upper + 1 when element is
			-- not inside.
		do
			Result:=g_slist_index(handle,element.handle)
		end

	index_of (element: like first;  start_index: INTEGER ): INTEGER is
		do
			Result:= g_slist_index(g_slist_nth(handle,start_index),element.handle)
		end

	reverse_index_of (element: like first; start_index: INTEGER): INTEGER is do not_yet_implemented end

	fast_first_index_of (element: like first): INTEGER is
			-- Give the index of the first occurrence of element using
			-- basic = for comparison. Answer upper + 1 when element is
			-- not inside.
		do
			not_yet_implemented -- TODO
		end

	fast_index_of (element: like first; start_index: INTEGER): INTEGER is do not_yet_implemented end

	fast_reverse_index_of (element: like first; start_index: INTEGER): INTEGER  is
			-- Using basic = comparison, gives the index of the first
			-- occurrence of element at or before start_index. Search is
			-- done in reverse direction, which means from the
			-- start_index down to the lower index . Answer lower -1 when
			-- the search fail.
		do
			not_yet_implemented -- TODO
		end

   
	is_equal_map (other: like Current): BOOLEAN is
			-- Do both collections have the same lower, upper, and items?
		do
			Result := is_equal(other)
		end

	is_equal (other: like Current): BOOLEAN is
			-- Do both collections have the same lower, upper, and items?
      local
         i, j: INTEGER
		do
			if count = other.count then
				from
               Result := lower = other.lower
					i := lower
					j := other.lower
				until
					not Result or else i > upper
				loop
					Result := item(i) = other.item(j)
					i := i + 1
					j := j + 1
				end
			end

		end

	all_default: BOOLEAN is
			--	Do all items have their type s default value? Note: for
			--	non Void items, the test is performed with the is_default
			--	predicate.
		do
			not_yet_implemented -- TODO
		end

	copy (other: like Current) is
		do
			not_yet_implemented -- TODO
		end

	occurrences (element: like first): INTEGER is
			-- Number of occurrences of element using is_equal for comparison.
		do
			not_yet_implemented -- TODO
		end

	fast_occurrences (element: like first): INTEGER is 
		do
			not_yet_implemented -- TODO
		end
	

	replace_all (old_value, new_value: like first) is 
		do
			not_yet_implemented -- TODO
		end

	fast_replace_all (old_value, new_value: like first) is 
		do
			not_yet_implemented -- TODO
		end

	reverse is
		local old_handle: POINTER
		do
			old_handle := handle
			handle:=g_slist_reverse (handle)
			g_slist_free (handle) -- TODO is this call correct?
		end
	
	lower: INTEGER is 0

	upper: INTEGER is
		do
			Result:=count-1
		end
	
	count: INTEGER is 
		do
			Result:=g_slist_length(handle)
			--	ensure positive: Result >= 0 
		end

	is_empty: BOOLEAN is 
		do
			Result:= (handle.is_null)
		end
	
	from_collection (model: COLLECTION[ITEM]) is
		local i: ITERATOR[ITEM]
		do
			from i:=model.get_new_iterator; i.start
			until not i.is_off
			loop add_first(i.item); i.next
			end
			reverse
		end
	
	get_new_iterator: ITERATOR[ITEM] is 
		do
			create {ITERATOR_ON_G_SLIST[ITEM]} Result.make (Current)
		end

feature {} -- Memory management

	dispose is
		do
			-- We override the default dispose routine; list nodes are not
			-- allocated with malloc() so we should not use free()
			g_slist_free (handle)
			handle:= default_pointer
		end

	-- Glib's doc, useful for implementing unimplemented
	
-- typedef struct {
--   gpointer data;
--   GSList *next;
-- } GSList;

-- The GSList struct is used for each element in the singly-linked list.
	-- gpointer data; 	holds the element's data, which can be a pointer to any kind of data, or any integer value using the Type Conversion Macros.
	-- GSList *next; 	contains the link to the next element in the list.
	-- g_slist_alloc ()

-- GSList*     g_slist_alloc                   (void);

-- Allocates space for one GSList element. It is called by the g_slist_append(), g_slist_prepend(), g_slist_insert() and g_slist_insert_sorted() functions and so is rarely used on its own.
-- Returns : 	a pointer to the newly-allocated GSList element.


-- g_slist_insert ()

-- GSList*     g_slist_insert                  (GSList *list, gpointer data, gint position);

-- Inserts a new element into the list at the given position.
-- list : 	a GSList.
-- data : 	the data for the new element.
-- position : 	the position to insert the element. If this is negative, or is larger than the number of elements in the list, the new element is added on to the end of the list.
-- Returns : 	the new start of the GSList.
-- g_slist_insert_before ()

-- GSList*     g_slist_insert_before           (GSList *slist, GSList *sibling, gpointer data);

-- Inserts a node before sibling containing data. Returns the new head of the list.
-- slist : 	a GSList.
-- sibling : 	node to insert data before.
-- data : 	data to put in the newly-inserted node.
-- Returns : 	new head of the list.
-- g_slist_insert_sorted ()

-- GSList*     g_slist_insert_sorted           (GSList *list, gpointer data, GCompareFunc func);

-- Inserts a new element into the list, using the given comparison function to determine its position.
-- list : 	a GSList.
-- data : 	the data for the new element.
-- func : 	the function to compare elements in the list. It should return a number > 0 if the first parameter comes after the second parameter in the sort order.
-- Returns : 	the new start of the GSList.
-- g_slist_remove ()

-- GSList*     g_slist_remove                  (GSList *list, gconstpointer data);

-- Removes an element from a GSList. If two elements contain the same data, only the first is removed. If none of the elements contain the data, the GSList is unchanged.
-- list : 	a GSList.
-- data : 	the data of the element to remove.
-- Returns : 	the new start of the GSList.
-- g_slist_remove_link ()

-- GSList*     g_slist_remove_link             (GSList *list, GSList *link_);

-- Removes an element from a GSList, without freeing the element. The removed element's next link is set to NULL, so that it becomes a self-contained list with one element.
-- list : 	a GSList.
-- link_ : 	an element in the GSList.
-- Returns : 	the new start of the GSList, without the element.
-- g_slist_delete_link ()

-- GSList*     g_slist_delete_link             (GSList *list, GSList *link_);

-- Deletes a node of list. Returns the new list head.
-- list : 	a GSList.
-- link_ : 	node to delete.
-- Returns : 	new head of list.
-- g_slist_remove_all ()

-- GSList*     g_slist_remove_all              (GSList *list, gconstpointer data);

-- Removes all list nodes with data equal to data. Returns the new head of the list. Contrast with g_slist_remove() which removes only the first node matching the given data.
-- list : 	a GSList.
-- data : 	data to remove.
-- Returns : 	new head of list.
-- g_slist_free ()

-- void        g_slist_free                    (GSList *list);

-- Frees all of the memory used by a GSList. The freed elements are added to the GAllocator free list.
-- list : 	a GSList.
-- g_slist_free_1 ()

-- void        g_slist_free_1                  (GSList *list);

-- Frees one GSList element. It is usually used after g_slist_remove_link().
-- list : 	a GSList element.
-- g_slist_length ()

-- guint       g_slist_length                  (GSList *list);

-- Gets the number of elements in a GSList.
-- list : 	a GSList.
-- Returns : 	the number of elements in the GSList.
-- g_slist_copy ()

-- GSList*     g_slist_copy                    (GSList *list);

-- Copies a GSList.

-- Note that this is a "shallow" copy. If the list elements consist of pointers to data, the pointers are copied but the actual data isn't.
-- list : 	a GSList.
-- Returns : 	a copy of list.
-- g_slist_reverse ()

-- GSList*     g_slist_reverse                 (GSList *list);

-- Reverses a GSList.
-- list : 	a GSList.
-- Returns : 	the start of the reversed GSList.
-- g_slist_sort ()

-- GSList*     g_slist_sort                    (GSList *list, GCompareFunc compare_func);

-- Sorts a GSList using the given comparison function.
-- list : 	a GSList.
-- compare_func : 	the comparison function used to sort the GSList. This function is passed the data from 2 elements of the GSList and should return 0 if they are equal, a negative value if the first element comes before the second, or a positive value if the first element comes after the second.
-- Returns : 	the start of the sorted GSList.
-- g_slist_sort_with_data ()

-- GSList*     g_slist_sort_with_data          (GSList *list, GCompareDataFunc compare_func, gpointer user_data);

-- Like g_slist_sort(), but the sort function accepts a user data argument.
-- list : 	a GSList
-- compare_func : 	comparison function.
-- user_data : 	data to pass to comparison function.
-- Returns : 	new head of the list.
-- g_slist_concat ()

-- GSList*     g_slist_concat                  (GSList *list1, GSList *list2);

-- Adds the second GSList onto the end of the first GSList. Note that the elements of the second GSList are not copied. They are used directly.
-- list1 : 	a GSList.
-- list2 : 	the GSList to add to the end of the first GSList.
-- Returns : 	the start of the new GSList.
-- g_slist_foreach ()

-- void        g_slist_foreach                 (GSList *list, GFunc func, gpointer user_data);

-- Calls a function for each element of a GSList.
-- list : 	a GSList.
-- func : 	the function to call with each element's data.
-- user_data : 	user data to pass to the function.
-- g_slist_last ()

-- GSList*     g_slist_last                    (GSList *list);

-- Gets the last element in a GSList.
-- list : 	a GSList.
-- Returns : 	the last element in the GSList, or NULL if the GSList has no elements.
-- g_slist_next()

-- #define     g_slist_next(slist)

-- A convenience macro to gets the next element in a GSList.
-- slist : 	an element in a GSList.
-- Returns : 	the next element, or NULL if there are no more elements.
-- g_slist_nth ()

-- GSList*     g_slist_nth                     (GSList *list, guint n);

-- Gets the element at the given position in a GSList.
-- list : 	a GSList.
-- n : 	the position of the element, counting from 0.
-- Returns : 	the element, or NULL if the position is off the end of the GSList.
-- g_slist_nth_data ()

-- gpointer    g_slist_nth_data                (GSList *list, guint n);

-- Gets the data of the element at the given position.
-- list : 	a GSList.
-- n : 	the position of the element.
-- Returns : 	the element's data, or NULL if the position is off the end of the GSList.
-- g_slist_find ()

-- GSList*     g_slist_find                    (GSList *list, gconstpointer data);

-- Finds the element in a GSList which contains the given data.
-- list : 	a GSList.
-- data : 	the element data to find.
-- Returns : 	the found GSList element, or NULL if it is not found.
-- g_slist_find_custom ()

-- GSList*     g_slist_find_custom             (GSList *list, gconstpointer data, GCompareFunc func);

-- Finds an element in a GSList, using a supplied function to find the desired element. It iterates over the list, calling the given function which should return 0 when the desired element is found. The function takes two gconstpointer arguments, the GSList element's data as the first argument and the given user data.
-- list : 	a GSList.
-- data : 	user data passed to the function.
-- func : 	the function to call for each element. It should return 0 when the desired element is found.
-- Returns : 	the found GSList element, or NULL if it is not found.
-- g_slist_position ()

-- gint        g_slist_position                (GSList *list, GSList *llink);

-- Gets the position of the given element in the GSList (starting from 0).
-- list : 	a GSList.
-- llink : 	an element in the GSList.
-- Returns : 	the position of the element in the GSList, or -1 if the element is not found.
-- g_slist_index ()

-- gint        g_slist_index                   (GSList *list, gconstpointer data);

-- Gets the position of the element containing the given data (starting from 0).
-- list : 	a GSList.
-- data : 	the data to find.
-- Returns : 	the index of the element containing the data, or -1 if the data is not found.
-- g_slist_push_allocator ()

-- void        g_slist_push_allocator          (GAllocator *allocator);

-- Sets the allocator to use to allocate GSList elements. Use g_slist_pop_allocator() to restore the previous allocator.

-- Note that this function is not available if GLib has been compiled with --disable-mem-pools
-- allocator : 	the GAllocator to use when allocating GSList elements.
-- g_slist_pop_allocator ()

-- void        g_slist_pop_allocator           (void);

-- Restores the previous GAllocator, used when allocating GSList elements.

-- Note that this function is not available if GLib has been compiled with --disable-mem-pools

	manifest_put (index: INTEGER; element: like item) is
		do
			put (element,index)
		end

feature {ANY} -- size
	struct_size: INTEGER is
		external "C inline use <glib.h>"
		alias "sizeof(GSList)"
		end

end



