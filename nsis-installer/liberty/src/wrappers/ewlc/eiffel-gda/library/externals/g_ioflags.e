-- This file have been created by eiffel-gcc-xml.
-- Any change will be lost by the next execution of the tool.
expanded class G_IOFLAGS
insert ENUM

create {ANY} default_create
feature {ANY} -- Validity
	is_valid_value (a_value: INTEGER): BOOLEAN is
		do
			Result := ((a_value = g_io_flag_append) or else 
				(a_value = g_io_flag_nonblock) or else 
				(a_value = g_io_flag_is_readable) or else 
				(a_value = g_io_flag_is_writeable) or else 
				(a_value = g_io_flag_is_seekable) or else 
				(a_value = g_io_flag_mask) or else 
				(a_value = g_io_flag_get_mask) or else 
				(a_value = g_io_flag_set_mask))
		end


feature {ANY} -- Setters
	default_create, set_append is
		do
			value := g_io_flag_append
		end

	set_nonblock is
		do
			value := g_io_flag_nonblock
		end

	set_is_readable is
		do
			value := g_io_flag_is_readable
		end

	set_is_writeable is
		do
			value := g_io_flag_is_writeable
		end

	set_is_seekable is
		do
			value := g_io_flag_is_seekable
		end

	set_mask is
		do
			value := g_io_flag_mask
		end

	set_get_mask is
		do
			value := g_io_flag_get_mask
		end

	set_set_mask is
		do
			value := g_io_flag_set_mask
		end


feature {ANY} -- Queries
	is_append: BOOLEAN is
		do
			Result := (value=g_io_flag_append)
		end

	is_nonblock: BOOLEAN is
		do
			Result := (value=g_io_flag_nonblock)
		end

	is_is_readable: BOOLEAN is
		do
			Result := (value=g_io_flag_is_readable)
		end

	is_is_writeable: BOOLEAN is
		do
			Result := (value=g_io_flag_is_writeable)
		end

	is_is_seekable: BOOLEAN is
		do
			Result := (value=g_io_flag_is_seekable)
		end

	is_mask: BOOLEAN is
		do
			Result := (value=g_io_flag_mask)
		end

	is_get_mask: BOOLEAN is
		do
			Result := (value=g_io_flag_get_mask)
		end

	is_set_mask: BOOLEAN is
		do
			Result := (value=g_io_flag_set_mask)
		end


feature {WRAPPER, WRAPPER_HANDLER} -- Low level values
	g_io_flag_append: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "G_IO_FLAG_APPEND"
		end

	g_io_flag_nonblock: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "G_IO_FLAG_NONBLOCK"
		end

	g_io_flag_is_readable: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "G_IO_FLAG_IS_READABLE"
		end

	g_io_flag_is_writeable: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "G_IO_FLAG_IS_WRITEABLE"
		end

	g_io_flag_is_seekable: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "G_IO_FLAG_IS_SEEKABLE"
		end

	g_io_flag_mask: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "G_IO_FLAG_MASK"
		end

	g_io_flag_get_mask: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "G_IO_FLAG_GET_MASK"
		end

	g_io_flag_set_mask: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "G_IO_FLAG_SET_MASK"
		end


end

