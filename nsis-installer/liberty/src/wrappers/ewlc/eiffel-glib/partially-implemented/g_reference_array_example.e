note
	copyright: "(C) 2007 Paolo Redaelli "
	license: "LGPL v2 or later"
	date: "$Date:$"
	revision "$REvision:$"

class G_REFERENCE_ARRAY_EXAMPLE

create {ANY} make

feature {ANY}
	array: G_REFERENCE_ARRAY[G_STRING]
	first: G_STRING

feature {ANY} make is
		local i: ITERATOR [G_STRING]
		do
			create array.make_empty
			list.prepend (create {G_STRING}.from_string("Third and last Foo"))
			list.prepend (create {G_STRING}.from_string("Second Foo"))
			list.prepend (create {G_STRING}.from_string("First Foo"))
			list.append (create {G_STRING}.from_string("Fourth and new last Foo"))
			check
				list_not_empty: not list.is_empty
			end
			
			print ("First is: ") print (list.first.to_string) print ("%N")
			from i:=list.get_new_iterator; i.start  until i.is_off
			loop
				print (i.item.to_string) print (", ")
				i.next
			end
			print ("%N")
		end
end
	
