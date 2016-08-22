note
	description: "Callback for the expose-event signal."
	copyright: "[
					Copyright (C) 2007 eiffel-libraries team,  GTK+ team and others
					
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
	license: "LGPL v2 or later"
	date: "$Date:$"
	revision "$Revision:$"

class EXPOSE_EVENT_CALLBACK

inherit CALLBACK redefine object end

insert G_OBJECT_FACTORY [GTK_WIDGET]

create {ANY}
	make

feature {ANY}
	object: GTK_WIDGET

feature {ANY}

	callback (event_expose_ptr: POINTER; instance: POINTER): INTEGER is
		local
			expose_event: GDK_EVENT_EXPOSE
		do
			check eiffel_created_the_widget: has_eiffel_wrapper_stored (instance) end
			object := wrapper(instance)
			create expose_event.from_external_pointer (event_expose_ptr)
			Result := function.item ([expose_event, object]).to_integer
			-- GTK is about to release this event, detach it from Eiffel
			expose_event.dispose
		end

	callback_pointer: POINTER is
		do
			Result := get_callback_pointer ($callback)
		ensure
			Result.is_not_null
		end

	connect (an_object: GTK_WIDGET; a_function: FUNCTION [ANY, TUPLE [GDK_EVENT_EXPOSE, GTK_WIDGET], BOOLEAN]) is
		do
			handler_id := g_signal_connect_closure (an_object.handle,
																 signal_name.to_external,
																 handle,
																 0 -- i.e. call it before default handler
																)
			function := a_function
		end

	function: FUNCTION [ANY, TUPLE [GDK_EVENT_EXPOSE, GTK_WIDGET], BOOLEAN]

	signal_name: STRING is "expose-event"

end -- class EXPOSE_EVENT_CALLBACK
