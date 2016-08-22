-- This file have been created by eiffel-gcc-xml.
-- Any change will be lost by the next execution of the tool.
deferred class GDA_LOG_EXTERNALS


inherit ANY undefine is_equal, copy end


feature {} -- External calls

	gda_log_error (a_format: POINTER; ) is
			-- Variadic call
		external "C use <library/externals/all-gda-includes.h>"
		end

	gda_log_message (a_format: POINTER; ) is
			-- Variadic call
		external "C use <library/externals/all-gda-includes.h>"
		end

	gda_log_is_enabled: INTEGER_32 is
			-- Variadic call
		external "C use <library/externals/all-gda-includes.h>"
		end

	gda_log_disable is
			-- Variadic call
		external "C use <library/externals/all-gda-includes.h>"
		end

	gda_log_enable is
			-- Variadic call
		external "C use <library/externals/all-gda-includes.h>"
		end

end
