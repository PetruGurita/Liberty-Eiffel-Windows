class GLIB_ERROR_REPORTING
-- Prev 	Up 	Home 	GLib Reference Manual 	Next
-- Top  |  Description
-- Error Reporting

-- Error Reporting %G�—%@ a system for reporting errors.
	
-- Synopsis

-- #include <glib.h>


--             GError;
-- GError*     g_error_new                     (GQuark domain,
--                                              gint code,
--                                              const gchar *format,
--                                              ...);
-- GError*     g_error_new_literal             (GQuark domain,
--                                              gint code,
--                                              const gchar *message);
-- void        g_error_free                    (GError *error);
-- GError*     g_error_copy                    (const GError *error);
-- gboolean    g_error_matches                 (const GError *error,
--                                              GQuark domain,
--                                              gint code);
-- void        g_set_error                     (GError **err,
--                                              GQuark domain,
--                                              gint code,
--                                              const gchar *format,
--                                              ...);
-- void        g_propagate_error               (GError **dest,
--                                              GError *src);
-- void        g_clear_error                   (GError **err);

-- Description

-- GLib provides a standard method of reporting errors from a called function to the calling code. (This is the same problem solved by exceptions in other languages.) It's important to understand that this method is both a data type (the GError object) and a set of rules. If you use GError incorrectly, then your code will not properly interoperate with other code that uses GError, and users of your API will probably get confused.

-- First and foremost: GError should only be used to report recoverable runtime errors, never to report programming errors. If the programmer has screwed up, then you should use g_warning(), g_return_if_fail(), g_assert(), g_error(), or some similar facility. (Incidentally, remember that the g_error() function should only be used for programming errors, it should not be used to print any error reportable via GError.)

-- Examples of recoverable runtime errors are "file not found" or "failed to parse input." Examples of programming errors are "NULL passed to strcmp()" or "attempted to free the same pointer twice." These two kinds of errors are fundamentally different: runtime errors should be handled or reported to the user, programming errors should be eliminated by fixing the bug in the program. This is why most functions in GLib and GTK+ do not use the GError facility.

-- Functions that can fail take a return location for a GError as their last argument. For example:

-- gboolean g_file_get_contents (const gchar *filename, 
-- 	                      gchar      **contents,
--                               gsize       *length,
--                               GError     **error);

-- If you pass a non-NULL value for the error argument, it should point to a location where an error can be placed. For example:

-- gchar *contents;
-- GError *err = NULL;
-- g_file_get_contents ("foo.txt", &contents, NULL, &err);
-- g_assert ((contents == NULL && err != NULL) || (contents != NULL && err == NULL));
-- if (err != NULL)
--   {
--     /* Report error to user, and free error */
--     g_assert (contents == NULL);
--     fprintf (stderr, "Unable to read file: %s\n", err->message);
--     g_error_free (err);
--   } 
-- else
--   {
--     /* Use file contents */
--     g_assert (contents != NULL);
--   }

-- Note that err != NULL in this example is a reliable indicator of whether g_file_get_contents() failed. Additionally, g_file_get_contents() returns a boolean which indicates whether it was successful.

-- Because g_file_get_contents() returns FALSE on failure, if you are only interested in whether it failed and don't need to display an error message, you can pass NULL for the error argument:

-- if (g_file_get_contents ("foo.txt", &contents, NULL, NULL)) /* ignore errors */
--   /* no error occurred */ ;
-- else
--   /* error */ ;

-- The GError object contains three fields: domain indicates the module the error-reporting function is located in, code indicates the specific error that occurred, and message is a user-readable error message with as many details as possible. Several functions are provided to deal with an error received from a called function: g_error_matches() returns TRUE if the error matches a given domain and code, g_propagate_error() copies an error into an error location (so the calling function will receive it), and g_clear_error() clears an error location by freeing the error and resetting the location to NULL. To display an error to the user, simply display error->message, perhaps along with additional context known only to the calling function (the file being opened, or whatever -- though in the g_file_get_contents() case, error->message already contains a filename).

-- When implementing a function that can report errors, the basic tool is g_set_error(). Typically, if a fatal error occurs you want to g_set_error(), then return immediately. g_set_error() does nothing if the error location passed to it is NULL. Here's an example:

-- gint
-- foo_open_file (GError **error)
-- {
--   gint fd;

--   fd = open ("file.txt", O_RDONLY);

--   if (fd < 0)
--     {
--       g_set_error (error,
--                    FOO_ERROR,                 /* error domain */
--                    FOO_ERROR_BLAH,            /* error code */
--                    "Failed to open file: %s", /* error message format string */
--                    g_strerror (errno));
--       return -1;
--     }
--   else
--     return fd;
-- }

-- Things are somewhat more complicated if you yourself call another function that can report a GError. If the sub-function indicates fatal errors in some way other than reporting a GError, such as by returning TRUE on success, you can simply do the following:

-- gboolean
-- my_function_that_can_fail (GError **err)
-- {
--   g_return_val_if_fail (err == NULL || *err == NULL, FALSE);

--   if (!sub_function_that_can_fail (err))
--     {
--        /* assert that error was set by the sub-function */
--        g_assert (err == NULL || *err != NULL);  
--        return FALSE;
--     }

--   /* otherwise continue, no error occurred */
--   g_assert (err == NULL || *err == NULL);
-- }

-- If the sub-function does not indicate errors other than by reporting a GError, you need to create a temporary GError since the passed-in one may be NULL. g_propagate_error() is intended for use in this case.

-- gboolean
-- my_function_that_can_fail (GError **err)
-- {
--   GError *tmp_error;

--   g_return_val_if_fail (err == NULL || *err == NULL, FALSE);

--   tmp_error = NULL;
--   sub_function_that_can_fail (&tmp_error);

--   if (tmp_error != NULL)
--     {
--        /* store tmp_error in err, if err != NULL,
--         * otherwise call g_error_free() on tmp_error 
--         */
--        g_propagate_error (err, tmp_error);
--        return FALSE;
--     }

--   /* otherwise continue, no error occurred */
-- }

-- Error pileups are always a bug. For example, this code is incorrect:

-- gboolean
-- my_function_that_can_fail (GError **err)
-- {
--   GError *tmp_error;

--   g_return_val_if_fail (err == NULL || *err == NULL, FALSE);

--   tmp_error = NULL;
--   sub_function_that_can_fail (&tmp_error);
--   other_function_that_can_fail (&tmp_error);

--   if (tmp_error != NULL)
--     {
--        g_propagate_error (err, tmp_error);
--        return FALSE;
--     }
-- }

-- tmp_error should be checked immediately after sub_function_that_can_fail(), and either cleared or propagated upward. The rule is: after each error, you must either handle the error, or return it to the calling function. Note that passing NULL for the error location is the equivalent of handling an error by always doing nothing about it. So the following code is fine, assuming errors in sub_function_that_can_fail() are not fatal to my_function_that_can_fail():

-- gboolean
-- my_function_that_can_fail (GError **err)
-- {
--   GError *tmp_error;

--   g_return_val_if_fail (err == NULL || *err == NULL, FALSE);

--   sub_function_that_can_fail (NULL); /* ignore errors */

--   tmp_error = NULL;
--   other_function_that_can_fail (&tmp_error);

--   if (tmp_error != NULL)
--     {
--        g_propagate_error (err, tmp_error);
--        return FALSE;
--     }
-- }

-- Note that passing NULL for the error location ignores errors; it's equivalent to try { sub_function_that_can_fail(); } catch (...) {} in C++. It does not mean to leave errors unhandled; it means to handle them by doing nothing.

-- Error domains and codes are conventionally named as follows:

--     *

--       The error domain is called <NAMESPACE>_<MODULE>_ERROR, for example G_EXEC_ERROR or G_THREAD_ERROR.
--     *

--       The error codes are in an enumeration called <Namespace><Module>Error; for example, GThreadError or GSpawnError.
--     *

--       Members of the error code enumeration are called <NAMESPACE>_<MODULE>_ERROR_<CODE>, for example G_SPAWN_ERROR_FORK or G_THREAD_ERROR_AGAIN.
--     *

--       If there's a "generic" or "unknown" error code for unrecoverable errors it doesn't make sense to distinguish with specific codes, it should be called <NAMESPACE>_<MODULE>_ERROR_FAILED, for example G_SPAWN_ERROR_FAILED or G_THREAD_ERROR_FAILED.

-- Summary of rules for use of GError:

--     *

--       Do not report programming errors via GError.
--     *

--       The last argument of a function that returns an error should be a location where a GError can be placed (i.e. "GError** error"). If GError is used with varargs, the GError** should be the last argument before the "...".
--     *

--       The caller may pass NULL for the GError** if they are not interested in details of the exact error that occurred.
--     *

--       If NULL is passed for the GError** argument, then errors should not be returned to the caller, but your function should still abort and return if an error occurs. That is, control flow should not be affected by whether the caller wants to get a GError.
--     *

--       If a GError is reported, then your function by definition had a fatal failure and did not complete whatever it was supposed to do. If the failure was not fatal, then you handled it and you should not report it. If it was fatal, then you must report it and discontinue whatever you were doing immediately.
--     *

--       A GError* must be initialized to NULL before passing its address to a function that can report errors.
--     *

--       "Piling up" errors is always a bug. That is, if you assign a new GError to a GError* that is non-NULL, thus overwriting the previous error, it indicates that you should have aborted the operation instead of continuing. If you were able to continue, you should have cleared the previous error with g_clear_error(). g_set_error() will complain if you pile up errors.
--     *

--       By convention, if you return a boolean value indicating success then TRUE means success and FALSE means failure. If FALSE is returned, the error must be set to a non-NULL value.
--     *

--       A NULL return value is also frequently used to mean that an error occurred. You should make clear in your documentation whether NULL is a valid return value in non-error cases; if NULL is a valid value, then users must check whether an error was returned to see if the function succeeded.
--     *

--       When implementing a function that can report errors, you may want to add a check at the top of your function that the error return location is either NULL or contains a NULL error (e.g. g_return_if_fail (error == NULL || *error == NULL);).

-- Details
-- GError

-- typedef struct {
--   GQuark       domain;
--   gint         code;
--   gchar       *message;
-- } GError;

-- The GError structure contains information about an error that has occurred.
-- GQuark domain; 	error domain, e.g. G_FILE_ERROR.
-- gint code; 	error code, e.g. G_FILE_ERROR_NOENT.
-- gchar *message; 	human-readable informative error message.
-- g_error_new ()

-- GError*     g_error_new                     (GQuark domain,
--                                              gint code,
--                                              const gchar *format,
--                                              ...);

-- Creates a new GError with the given domain and code, and a message formatted with format.

-- domain : 	error domain
-- code : 	error code
-- format : 	printf()-style format for error message
-- ... : 	parameters for message format
-- Returns : 	a new GError
-- g_error_new_literal ()

-- GError*     g_error_new_literal             (GQuark domain,
--                                              gint code,
--                                              const gchar *message);

-- Creates a new GError; unlike g_error_new(), message is not a printf()-style format string. Use this function if message contains text you don't have control over, that could include printf() escape sequences.

-- domain : 	error domain
-- code : 	error code
-- message : 	error message
-- Returns : 	a new GError
-- g_error_free ()

-- void        g_error_free                    (GError *error);

-- Frees a GError and associated resources.

-- error : 	a GError
-- g_error_copy ()

-- GError*     g_error_copy                    (const GError *error);

-- Makes a copy of error.

-- error : 	a GError
-- Returns : 	a new GError
-- g_error_matches ()

-- gboolean    g_error_matches                 (const GError *error,
--                                              GQuark domain,
--                                              gint code);

-- Returns TRUE if error matches domain and code, FALSE otherwise.

-- error : 	a GError
-- domain : 	an error domain
-- code : 	an error code
-- Returns : 	whether error has domain and code
-- g_set_error ()

-- void        g_set_error                     (GError **err,
--                                              GQuark domain,
--                                              gint code,
--                                              const gchar *format,
--                                              ...);

-- Does nothing if err is NULL; if err is non-NULL, then *err must be NULL. A new GError is created and assigned to *err.

-- err : 	a return location for a GError, or NULL
-- domain : 	error domain
-- code : 	error code
-- format : 	printf()-style format
-- ... : 	args for format
-- g_propagate_error ()

-- void        g_propagate_error               (GError **dest,
--                                              GError *src);

-- If dest is NULL, free src; otherwise, moves src into *dest. *dest must be NULL.

-- dest : 	error return location
-- src : 	error to move into the return location
-- g_clear_error ()

-- void        g_clear_error                   (GError **err);

-- If err is NULL, does nothing. If err is non-NULL, calls g_error_free() on *err and sets *err to NULL.

-- err : 	a GError return location
end
