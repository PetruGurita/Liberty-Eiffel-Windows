-- This file have been created by eiffel-gcc-xml.
-- Any change will be lost by the next execution of the tool.
expanded class G_BOOKMARK_FILE_ERROR
insert ENUM

create {ANY} default_create
feature {ANY} -- Validity
	is_valid_value (a_value: INTEGER): BOOLEAN is
		do
			Result := ((a_value = g_bookmark_file_error_invalid_uri) or else 
				(a_value = g_bookmark_file_error_invalid_value) or else 
				(a_value = g_bookmark_file_error_app_not_registered) or else 
				(a_value = g_bookmark_file_error_uri_not_found) or else 
				(a_value = g_bookmark_file_error_read) or else 
				(a_value = g_bookmark_file_error_unknown_encoding) or else 
				(a_value = g_bookmark_file_error_write) or else 
				(a_value = g_bookmark_file_error_file_not_found))
		end


feature {ANY} -- Setters
	default_create, set_invalid_uri is
		do
			value := g_bookmark_file_error_invalid_uri
		end

	set_invalid_value is
		do
			value := g_bookmark_file_error_invalid_value
		end

	set_app_not_registered is
		do
			value := g_bookmark_file_error_app_not_registered
		end

	set_uri_not_found is
		do
			value := g_bookmark_file_error_uri_not_found
		end

	set_read is
		do
			value := g_bookmark_file_error_read
		end

	set_unknown_encoding is
		do
			value := g_bookmark_file_error_unknown_encoding
		end

	set_write is
		do
			value := g_bookmark_file_error_write
		end

	set_file_not_found is
		do
			value := g_bookmark_file_error_file_not_found
		end


feature {ANY} -- Queries
	is_invalid_uri: BOOLEAN is
		do
			Result := (value=g_bookmark_file_error_invalid_uri)
		end

	is_invalid_value: BOOLEAN is
		do
			Result := (value=g_bookmark_file_error_invalid_value)
		end

	is_app_not_registered: BOOLEAN is
		do
			Result := (value=g_bookmark_file_error_app_not_registered)
		end

	is_uri_not_found: BOOLEAN is
		do
			Result := (value=g_bookmark_file_error_uri_not_found)
		end

	is_read: BOOLEAN is
		do
			Result := (value=g_bookmark_file_error_read)
		end

	is_unknown_encoding: BOOLEAN is
		do
			Result := (value=g_bookmark_file_error_unknown_encoding)
		end

	is_write: BOOLEAN is
		do
			Result := (value=g_bookmark_file_error_write)
		end

	is_file_not_found: BOOLEAN is
		do
			Result := (value=g_bookmark_file_error_file_not_found)
		end


feature {WRAPPER, WRAPPER_HANDLER} -- Low level values
	g_bookmark_file_error_invalid_uri: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "G_BOOKMARK_FILE_ERROR_INVALID_URI"
		end

	g_bookmark_file_error_invalid_value: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "G_BOOKMARK_FILE_ERROR_INVALID_VALUE"
		end

	g_bookmark_file_error_app_not_registered: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "G_BOOKMARK_FILE_ERROR_APP_NOT_REGISTERED"
		end

	g_bookmark_file_error_uri_not_found: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND"
		end

	g_bookmark_file_error_read: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "G_BOOKMARK_FILE_ERROR_READ"
		end

	g_bookmark_file_error_unknown_encoding: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "G_BOOKMARK_FILE_ERROR_UNKNOWN_ENCODING"
		end

	g_bookmark_file_error_write: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "G_BOOKMARK_FILE_ERROR_WRITE"
		end

	g_bookmark_file_error_file_not_found: INTEGER is
		external "C macro use <library/externals/all-gda-includes.h>"
		alias "G_BOOKMARK_FILE_ERROR_FILE_NOT_FOUND"
		end


end

