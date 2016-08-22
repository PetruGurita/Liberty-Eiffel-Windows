note
	description: "Iterator for G_SLIST_STRING."
	copyright: "[
					Copyright (C) 2006 Paolo Redaelli
					
					This library is free software; you can redistribute it and/or
					modify it under the terms of the GNU Lesser General Public License
					as published by the Free Software Foundation; either version 2.1 of
					the License, or (at your option) any later version.
					
					This library is distributed in the hope that it will be useful, but
					WITHOUT ANY WARRANTY; without even the implied warranty of
					MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
					Lesser General Public License for more details.

					You should have received a copy of the GNU Lesser General Public
					License along with this library; if not, write to the Free Software
					Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
					02110-1301 USA
			]"

class ITERATOR_ON_G_LIST_STRING 
inherit
	ITERATOR [STRING]
	WRAPPER_HANDLER
insert
	G_SLIST_EXTERNALS
	
create {ANY} make
	
feature {} -- Creation
	make (a_list: G_LIST_STRING) is
		require valid_list: a_list/=Void
		do
			list := a_list
		end
	
feature {} -- Implementation
	list: G_LIST_STRING
	current_element: POINTER

feature {ANY} -- Iterator's features
	start is
		do
			current_element := list.handle
		end
	
	is_off: BOOLEAN is
		do
			Result:=(current_element.is_null)
		end
	
	item: STRING is
		local cstr: POINTER
		do
			cstr := g_slist_get_data(current_element)
			if cstr.is_not_null then 
				create Result.from_external_copy(cstr)
			end
		ensure result_not_void: Result /= Void
		end
	
	next is
		do
			current_element := g_slist_get_next (current_element)
		end
end
