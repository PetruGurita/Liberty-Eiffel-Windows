note
	description: "The `fixed-slider-length' style property."
	copyright: "[
					Copyright (C) 2006 Paolo Redaelli, GTK+ team
					
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

deferred class HAS_BACKWARD_STEPPER_PROPERTY

inherit GTK_OBJECT 
feature {ANY} -- TODO: The  "has-backward-stepper" style property

	has_backward_stepper: BOOLEAN is
			-- Is the standard backward arrow button displayed?  Default
			-- value: True
		do
			Result := boolean_property_from_pspec (has_backward_stepper_pspec)
		end

feature {} -- Implementation
	has_backward_stepper_property_property_name: STRING is "has-backward-stepper"

	has_backward_stepper_pspec: G_PARAM_SPEC is
		require has_property (has_backward_stepper_property_property_name)
		once
			create Result.from_external_pointer
			(g_object_class_find_property
			 (g_object_get_class(handle),
			  has_backward_stepper_property_property_name.to_external))
		end
end -- class HAS_BACKWARD_STEPPER_PROPERTY
