-- This file has been created by wrappers_generator.
-- Any change will be lost by the next execution of the tool.
deferred class CAIRO_GLYPH_T_STRUCT
-- Wrapper of struct cairo_glyph_t defined in file /usr/include/cairo/cairo.h line 1089

insert STANDARD_C_LIBRARY_TYPES

	CAIRO_TYPES
feature {} -- Low-level setters

   cairo_glyph_t_struct_set_index (a_structure: POINTER; a_value: like long_unsigned) 
         -- Setter for index field of CAIRO_GLYPH_T_STRUCT structure.
         -- TODO: setter description

      external "plug_in"
      alias "{
         location: "."
         module_name: "plugin"
         feature_name: "cairo_glyph_t_struct_set_index"
      }"
      end

   cairo_glyph_t_struct_set_x (a_structure: POINTER; a_value: REAL) 
         -- Setter for x field of CAIRO_GLYPH_T_STRUCT structure.
         -- TODO: setter description

      external "plug_in"
      alias "{
         location: "."
         module_name: "plugin"
         feature_name: "cairo_glyph_t_struct_set_x"
      }"
      end

   cairo_glyph_t_struct_set_y (a_structure: POINTER; a_value: REAL) 
         -- Setter for y field of CAIRO_GLYPH_T_STRUCT structure.
         -- TODO: setter description

      external "plug_in"
      alias "{
         location: "."
         module_name: "plugin"
         feature_name: "cairo_glyph_t_struct_set_y"
      }"
      end

feature {} -- Low-level queries

   cairo_glyph_t_struct_get_index (a_structure: POINTER): like long_unsigned 
         -- Query for index field of CAIRO_GLYPH_T_STRUCT structure.
         -- TODO: getter description

      external "plug_in"
      alias "{
         location: "."
         module_name: "plugin"
         feature_name: "cairo_glyph_t_struct_get_index"
      }"
      end

   cairo_glyph_t_struct_get_x (a_structure: POINTER): REAL 
         -- Query for x field of CAIRO_GLYPH_T_STRUCT structure.
         -- TODO: getter description

      external "plug_in"
      alias "{
         location: "."
         module_name: "plugin"
         feature_name: "cairo_glyph_t_struct_get_x"
      }"
      end

   cairo_glyph_t_struct_get_y (a_structure: POINTER): REAL 
         -- Query for y field of CAIRO_GLYPH_T_STRUCT structure.
         -- TODO: getter description

      external "plug_in"
      alias "{
         location: "."
         module_name: "plugin"
         feature_name: "cairo_glyph_t_struct_get_y"
      }"
      end

feature {WRAPPER, WRAPPER_HANDLER} -- Structure size
       struct_size: like size_t 
               external "plug_in"
               alias "{
                       location: "."
                       module_name: "plugin"
                       feature_name: "sizeof_cairo_glyph_t"
               }"
               end

end -- class CAIRO_GLYPH_T_STRUCT
-- This file has been created by wrappers_generator.
-- Any change will be lost by the next execution of the tool.
