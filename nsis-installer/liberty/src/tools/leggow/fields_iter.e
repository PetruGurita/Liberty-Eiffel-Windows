expanded class FIELDS_ITER
	-- An expanded iterator over methods of a GI_OBJECT_INFO
insert ITERATOR[GI_FIELD_INFO]

feature {GI_OBJECT_INFO} 
	set_class (an_object: GI_OBJECT_INFO) is
		require an_object/=Void
		do
			object:=an_object
		end

feature {ANY}
	start is
		do
			i:=object.fields_lower
		end
	is_off: BOOLEAN is
		do
			Result:=i>object.fields_upper
		end

	item: GI_FIELD_INFO is 
	do 
		Result:=object.field(i)
	end

	next is
		do
			i:=i+1
		end

feature {GI_OBJECT_INFO} -- Implementation
	object: GI_OBJECT_INFO
	i: INTEGER

feature {ANY} -- Check that the underlying traversable has not changed
   iterable_generation: INTEGER is
	  attribute
      end

   generation: INTEGER is
	  attribute
      end

end -- class FIELDS_ITER

-- Copyright (C) 2013 Paolo Redaelli <paolo.redaelli@gmail.com>
-- 
-- This library is free software; you can redistribute it and/or
-- modify it under the terms of the GNU Lesser General Public License
-- as published by the Free Software Foundation; either version 2.1 of
-- the License, or (at your option) any later version.
-- 
-- This library is distributed in the hope that it will be useful, but
-- WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-- Lesser General Public License for more details.
-- 
-- You should have received a copy of the GNU Lesser General Public
-- License along with this library; if not, write to the Free Software
-- Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-- 02110-1301 USA
	
