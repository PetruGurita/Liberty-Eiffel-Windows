deferred class GLIB_FILE_UTILITIES

--    File Utilities

--    File Utilities -- various file-related functions.

-- Synopsis


--  #include <glib.h>
--  #include <glib/gstdio.h>


--  enum        GFileError;
--  #define     G_FILE_ERROR
--  enum        GFileTest;
--  GFileError  g_file_error_from_errno         (gint err_no);
--  gboolean    g_file_get_contents             (const gchar *filename,
--                                               gchar **contents,
--                                               gsize *length,
--                                               GError **error);
--  gboolean    g_file_set_contents             (const gchar *filename,
--                                               const gchar *contents,
--                                               gssize length,
--                                               GError **error);
--  gboolean    g_file_test                     (const gchar *filename,
--                                               GFileTest test);
--  gint        g_mkstemp                       (gchar *tmpl);
--  gint        g_file_open_tmp                 (const gchar *tmpl,
--                                               gchar **name_used,
--                                               GError **error);
--  gchar*      g_file_read_link                (const gchar *filename,
--                                               GError **error);
--  int         g_mkdir_with_parents            (const gchar *pathname,
--                                               int mode);

--              GDir;
--  GDir*       g_dir_open                      (const gchar *path,
--                                               guint flags,
--                                               GError **error);
--  const gchar* g_dir_read_name                (GDir *dir);
--  void        g_dir_rewind                    (GDir *dir);
--  void        g_dir_close                     (GDir *dir);

--              GMappedFile;
--  GMappedFile* g_mapped_file_new              (const gchar *filename,
--                                               gboolean writable,
--                                               GError **error);
--  void        g_mapped_file_free              (GMappedFile *file);
--  gsize       g_mapped_file_get_length        (GMappedFile *file);
--  gchar*      g_mapped_file_get_contents      (GMappedFile *file);

--  int         g_open                          (const gchar *filename,
--                                               int flags,
--                                               int mode);
--  int         g_rename                        (const gchar *oldfilename,
--                                               const gchar *newfilename);
--  int         g_mkdir                         (const gchar *filename,
--                                               int mode);
--  int         g_stat                          (const gchar *filename,
--                                               struct stat *buf);
--  int         g_lstat                         (const gchar *filename,
--                                               struct stat *buf);
--  int         g_unlink                        (const gchar *filename);
--  int         g_remove                        (const gchar *filename);
--  int         g_rmdir                         (const gchar *filename);
--  FILE*       g_fopen                         (const gchar *filename,
--                                               const gchar *mode);
--  FILE*       g_freopen                       (const gchar *filename,
--                                               const gchar *mode,
--                                               FILE *stream);
--  int         g_chmod                         (const gchar *filename,
--                                               int mode);
--  int         g_access                        (const gchar *filename,
--                                               int mode);
--  int         g_creat                         (const gchar *filename,
--                                               int mode);
--  int         g_chdir                         (const gchar *path);


-- Description

--    There is a group of functions which wrap the common POSIX functions dealing with
--    filenames (g_open(), g_rename(), g_mkdir(), g_stat(), g_unlink(), g_remove(),
--    g_fopen(), g_freopen()). The point of these wrappers is to make it possible to
--    handle file names with any Unicode characters in them on Windows without having
--    to use ifdefs and the wide character API in the application code.

--    The pathname argument should be in the GLib file name encoding. On POSIX this is
--    the actual on-disk encoding which might correspond to the locale settings of the
--    process (or the G_FILENAME_ENCODING environment variable), or not.

--    On Windows the GLib file name encoding is UTF-8. Note that the Microsoft C
--    library does not use UTF-8, but has separate APIs for current system code page
--    and wide characters (UTF-16). The GLib wrappers call the wide character API if
--    present (on modern Windows systems), otherwise convert to/from the system code
--    page.

--    Another group of functions allows to open and read directories in the GLib file
--    name encoding. These are g_dir_open(), g_dir_read_name(), g_dir_rewind(),
--    g_dir_close().

-- Details

--   enum GFileError

--  typedef enum
--  {
--    G_FILE_ERROR_EXIST,
--    G_FILE_ERROR_ISDIR,
--    G_FILE_ERROR_ACCES,
--    G_FILE_ERROR_NAMETOOLONG,
--    G_FILE_ERROR_NOENT,
--    G_FILE_ERROR_NOTDIR,
--    G_FILE_ERROR_NXIO,
--    G_FILE_ERROR_NODEV,
--    G_FILE_ERROR_ROFS,
--    G_FILE_ERROR_TXTBSY,
--    G_FILE_ERROR_FAULT,
--    G_FILE_ERROR_LOOP,
--    G_FILE_ERROR_NOSPC,
--    G_FILE_ERROR_NOMEM,
--    G_FILE_ERROR_MFILE,
--    G_FILE_ERROR_NFILE,
--    G_FILE_ERROR_BADF,
--    G_FILE_ERROR_INVAL,
--    G_FILE_ERROR_PIPE,
--    G_FILE_ERROR_AGAIN,
--    G_FILE_ERROR_INTR,
--    G_FILE_ERROR_IO,
--    G_FILE_ERROR_PERM,
--    G_FILE_ERROR_NOSYS,
--    G_FILE_ERROR_FAILED
--  } GFileError;

--    Values corresponding to errno codes returned from file operations on UNIX. Unlike
--    errno codes, GFileError values are available on all systems, even Windows. The
--    exact meaning of each code depends on what sort of file operation you were
--    performing; the UNIX documentation gives more details. The following error code
--    descriptions come from the GNU C Library manual, and are under the copyright of
--    that manual.

--    It's not very portable to make detailed assumptions about exactly which errors
--    will be returned from a given operation. Some errors don't occur on some systems,
--    etc., sometimes there are subtle differences in when a system will report a given
--    error, etc.

--    G_FILE_ERROR_EXIST       Operation not permitted; only the owner of the file (or
--                             other resource) or processes with special privileges can
--                             perform the operation.
--    G_FILE_ERROR_ISDIR       File is a directory; you cannot open a directory for
--                             writing, or create or remove hard links to it.
--    G_FILE_ERROR_ACCES       Permission denied; the file permissions do not allow the
--                             attempted operation.
--    G_FILE_ERROR_NAMETOOLONG Filename too long.
--    G_FILE_ERROR_NOENT       No such file or directory. This is a "file doesn't
--                             exist" error for ordinary files that are referenced in
--                             contexts where they are expected to already exist.
--    G_FILE_ERROR_NOTDIR      A file that isn't a directory was specified when a
--                             directory is required.
--    G_FILE_ERROR_NXIO        No such device or address. The system tried to use the
--                             device represented by a file you specified, and it
--                             couldn't find the device. This can mean that the device
--                             file was installed incorrectly, or that the physical
--                             device is missing or not correctly attached to the
--                             computer.
--    G_FILE_ERROR_NODEV       This file is of a type that doesn't support mapping.
--    G_FILE_ERROR_ROFS        The directory containing the new link can't be modified
--                             because it's on a read-only file system.
--    G_FILE_ERROR_TXTBSY      Text file busy.
--    G_FILE_ERROR_FAULT       You passed in a pointer to bad memory. (GLib won't
--                             reliably return this, don't pass in pointers to bad
--                             memory.)
--    G_FILE_ERROR_LOOP        Too many levels of symbolic links were encountered in
--                             looking up a file name. This often indicates a cycle of
--                             symbolic links.
--    G_FILE_ERROR_NOSPC       No space left on device; write operation on a file
--                             failed because the disk is full.
--    G_FILE_ERROR_NOMEM       No memory available. The system cannot allocate more
--                             virtual memory because its capacity is full.
--    G_FILE_ERROR_MFILE       The current process has too many files open and can't
--                             open any more. Duplicate descriptors do count toward
--                             this limit.
--    G_FILE_ERROR_NFILE       There are too many distinct file openings in the entire
--                             system.
--    G_FILE_ERROR_BADF        Bad file descriptor; for example, I/O on a descriptor
--                             that has been closed or reading from a descriptor open
--                             only for writing (or vice versa).
--    G_FILE_ERROR_INVAL       Invalid argument. This is used to indicate various kinds
--                             of problems with passing the wrong argument to a library
--                             function.
--    G_FILE_ERROR_PIPE        Broken pipe; there is no process reading from the other
--                             end of a pipe. Every library function that returns this
--                             error code also generates a `SIGPIPE' signal; this
--                             signal terminates the program if not handled or blocked.
--                             Thus, your program will never actually see this code
--                             unless it has handled or blocked `SIGPIPE'.
--    G_FILE_ERROR_AGAIN       Resource temporarily unavailable; the call might work if
--                             you try again later.
--    G_FILE_ERROR_INTR        Interrupted function call; an asynchronous signal
--                             occurred and prevented completion of the call. When this
--                             happens, you should try the call again.
--    G_FILE_ERROR_IO          Input/output error; usually used for physical read or
--                             write errors. i.e. the disk or other physical device
--                             hardware is returning errors.
--    G_FILE_ERROR_PERM        Operation not permitted; only the owner of the file (or
--                             other resource) or processes with special privileges can
--                             perform the operation.
--    G_FILE_ERROR_NOSYS       Function not implemented; this indicates that the system
--                             is missing some functionality.
--    G_FILE_ERROR_FAILED      Does not correspond to a UNIX error code; this is the
--                             standard "failed for unspecified reason" error code
--                             present in all GError error code enumerations. Returned
--                             if no specific code applies.

--    ---------------------------------------------------------------------------------

--   G_FILE_ERROR

--  #define G_FILE_ERROR g_file_error_quark ()

--    Error domain for file operations. Errors in this domain will be from the
--    GFileError enumeration. See GError for information on error domains.

--    ---------------------------------------------------------------------------------

--   enum GFileTest

--  typedef enum
--  {
--    G_FILE_TEST_IS_REGULAR    = 1 < < 0,
--    G_FILE_TEST_IS_SYMLINK    = 1 < < 1,
--    G_FILE_TEST_IS_DIR        = 1 < < 2,
--    G_FILE_TEST_IS_EXECUTABLE = 1 < < 3,
--    G_FILE_TEST_EXISTS        = 1 < < 4
--  } GFileTest;

--    A test to perform on a file using g_file_test().

--    G_FILE_TEST_IS_REGULAR    TRUE if the file is a regular file (not a symlink or
--                              directory)
--    G_FILE_TEST_IS_SYMLINK    TRUE if the file is a symlink.
--    G_FILE_TEST_IS_DIR        TRUE if the file is a directory.
--    G_FILE_TEST_IS_EXECUTABLE TRUE if the file is executable.
--    G_FILE_TEST_EXISTS        TRUE if the file exists. It may or may not be a regular
--                              file.

--    ---------------------------------------------------------------------------------

--   g_file_error_from_errno ()

--  GFileError  g_file_error_from_errno         (gint err_no);

--    Gets a GFileError constant based on the passed-in errno. For example, if you pass
--    in EEXIST this function returns G_FILE_ERROR_EXIST. Unlike errno values, you can
--    portably assume that all GFileError values will exist.

--    Normally a GFileError value goes into a GError returned from a function that
--    manipulates files. So you would use g_file_error_from_errno() when constructing a
--    GError.

--    err_no :  an "errno" value
--    Returns : GFileError corresponding to the given errno

--    ---------------------------------------------------------------------------------

--   g_file_get_contents ()

--  gboolean    g_file_get_contents             (const gchar *filename,
--                                               gchar **contents,
--                                               gsize *length,
--                                               GError **error);

--    Reads an entire file into allocated memory, with good error checking.

--    If the call was successful, it returns TRUE and sets contents to the file
--    contents and length to the length of the file contents in bytes. The string
--    stored in contents will be nul-terminated, so for text files you can pass NULL
--    for the length argument. If the call was not successful, it returns FALSE and
--    sets error. The error domain is G_FILE_ERROR. Possible error codes are those in
--    the GFileError enumeration. In the error case, contents is set to NULL and length
--    is set to zero.

--    filename : name of a file to read contents from, in the GLib file name encoding
--    contents : location to store an allocated string
--    length :   location to store length in bytes of the contents, or NULL
--    error :    return location for a GError, or NULL
--    Returns :  TRUE on success, FALSE if an error occurred

--    ---------------------------------------------------------------------------------

--   g_file_set_contents ()

--  gboolean    g_file_set_contents             (const gchar *filename,
--                                               const gchar *contents,
--                                               gssize length,
--                                               GError **error);

--    Writes all of contents to a file named filename, with good error checking. If a
--    file called filename already exists it will be overwritten.

--    This write is atomic in the sense that it is first written to a temporary file
--    which is then renamed to the final name. Notes:

--      o On Unix, if filename already exists hard links to filename will break. Also
--        since the file is recreated, existing permissions, access control lists,
--        metadata etc. may be lost. If filename is a symbolic link, the link itself
--        will be replaced, not the linked file.
--      o On Windows renaming a file will not remove an existing file with the new
--        name, so on Windows there is a race condition between the existing file being
--        removed and the temporary file being renamed.
--      o On Windows there is no way to remove a file that is open to some process, or
--        mapped into memory. Thus, this function will fail if filename already exists
--        and is open.

--    If the call was sucessful, it returns TRUE. If the call was not successful, it
--    returns FALSE and sets error. The error domain is G_FILE_ERROR. Possible error
--    codes are those in the GFileError enumeration.

--    filename : name of a file to write contents to, in the GLib file name encoding
--    contents : string to write to the file
--    length :   length of contents, or -1 if contents is a nul-terminated string
--    error :    return location for a GError, or NULL
--    Returns :  TRUE on success, FALSE if an error occurred

--    Since 2.8

--    ---------------------------------------------------------------------------------

--   g_file_test ()

--  gboolean    g_file_test                     (const gchar *filename,
--                                               GFileTest test);

--    Returns TRUE if any of the tests in the bitfield test are TRUE. For example,
--    (G_FILE_TEST_EXISTS | G_FILE_TEST_IS_DIR) will return TRUE if the file exists;
--    the check whether it's a directory doesn't matter since the existence test is
--    TRUE. With the current set of available tests, there's no point passing in more
--    than one test at a time.

--    Apart from G_FILE_TEST_IS_SYMLINK all tests follow symbolic links, so for a
--    symbolic link to a regular file g_file_test() will return TRUE for both
--    G_FILE_TEST_IS_SYMLINK and G_FILE_TEST_IS_REGULAR.

--    Note, that for a dangling symbolic link g_file_test() will return TRUE for
--    G_FILE_TEST_IS_SYMLINK and FALSE for all other flags.

--    You should never use g_file_test() to test whether it is safe to perform an
--    operation, because there is always the possibility of the condition changing
--    before you actually perform the operation. For example, you might think you could
--    use G_FILE_TEST_IS_SYMLINK to know whether it is is safe to write to a file
--    without being tricked into writing into a different location. It doesn't work!

--  /* DON'T DO THIS */
--   if (!g_file_test (filename, G_FILE_TEST_IS_SYMLINK)) {
--     fd = g_open (filename, O_WRONLY);
--     /* write to fd */
--   }

--    Another thing to note is that G_FILE_TEST_EXISTS and G_FILE_TEST_IS_EXECUTABLE
--    are implemented using the access() system call. This usually doesn't matter, but
--    if your program is setuid or setgid it means that these tests will give you the
--    answer for the real user ID and group ID, rather than the effective user ID and
--    group ID.

--    On Windows, there are no symlinks, so testing for G_FILE_TEST_IS_SYMLINK will
--    always return FALSE. Testing for G_FILE_TEST_IS_EXECUTABLE will just check that
--    the file exists and its name indicates that it is executable, checking for
--    well-known extensions and those listed in the PATHEXT environment variable.

--    filename : a filename to test in the GLib file name encoding
--    test :     bitfield of GFileTest flags
--    Returns :  whether a test was TRUE

--    ---------------------------------------------------------------------------------

--   g_mkstemp ()

--  gint        g_mkstemp                       (gchar *tmpl);

--    Opens a temporary file. See the mkstemp() documentation on most UNIX-like
--    systems.

--    The parameter is a string that should follow the rules for mkstemp() templates,
--    i.e. contain the string "XXXXXX". g_mkstemp() is slightly more flexible than
--    mkstemp() in that the sequence does not have to occur at the very end of the
--    template. The X string will be modified to form the name of a file that didn't
--    exist. The string should be in the GLib file name encoding. Most importantly, on
--    Windows it should be in UTF-8.

--    tmpl :    template filename
--    Returns : A file handle (as from open()) to the file opened for reading and
--              writing. The file is opened in binary mode on platforms where there is
--              a difference. The file handle should be closed with close(). In case of
--              errors, -1 is returned.

--    ---------------------------------------------------------------------------------

--   g_file_open_tmp ()

--  gint        g_file_open_tmp                 (const gchar *tmpl,
--                                               gchar **name_used,
--                                               GError **error);

--    Opens a file for writing in the preferred directory for temporary files (as
--    returned by g_get_tmp_dir()).

--    tmpl should be a string in the GLib file name encoding containing a sequence of
--    six 'X' characters, as the parameter to g_mkstemp(). However, unlike these
--    functions, the template should only be a basename, no directory components are
--    allowed. If template is NULL, a default template is used.

--    Note that in contrast to g_mkstemp() (and mkstemp()) tmpl is not modified, and
--    might thus be a read-only literal string.

--    The actual name used is returned in name_used if non-NULL. This string should be
--    freed with g_free() when not needed any longer. The returned name is in the GLib
--    file name encoding.

--    tmpl :      Template for file name, as in g_mkstemp(), basename only, or NULL, to
--                a default template
--    name_used : location to store actual name used
--    error :     return location for a GError
--    Returns :   A file handle (as from open()) to the file opened for reading and
--                writing. The file is opened in binary mode on platforms where there
--                is a difference. The file handle should be closed with close(). In
--                case of errors, -1 is returned and error will be set.

--    ---------------------------------------------------------------------------------

--   g_file_read_link ()

--  gchar*      g_file_read_link                (const gchar *filename,
--                                               GError **error);

--    Reads the contents of the symbolic link filename like the POSIX readlink()
--    function. The returned string is in the encoding used for filenames. Use
--    g_filename_to_utf8() to convert it to UTF-8.

--    filename : the symbolic link
--    error :    return location for a GError
--    Returns :  A newly allocated string with the contents of the symbolic link, or
--               NULL if an error occurred.

--    Since 2.4

--    ---------------------------------------------------------------------------------

--   g_mkdir_with_parents ()

--  int         g_mkdir_with_parents            (const gchar *pathname,
--                                               int mode);

--    Create a directory if it doesn't already exist. Create intermediate parent
--    directories as needed, too.

--    pathname : a pathname in the GLib file name encoding
--    mode :     permissions to use for newly created directories
--    Returns :  0 if the directory already exists, or was successfully created.
--               Returns -1 if an error occurred, with errno set.

--    Since 2.8

--    ---------------------------------------------------------------------------------

--   GDir

--  typedef struct _GDir GDir;

--    An opaque structure representing an opened directory.

--    ---------------------------------------------------------------------------------

--   g_dir_open ()

--  GDir*       g_dir_open                      (const gchar *path,
--                                               guint flags,
--                                               GError **error);

--    Opens a directory for reading. The names of the files in the directory can then
--    be retrieved using g_dir_read_name().

--    path :    the path to the directory you are interested in. On Unix in the on-disk
--              encoding. On Windows in UTF-8
--    flags :   Currently must be set to 0. Reserved for future use.
--    error :   return location for a GError, or NULL. If non-NULL, an error will be
--              set if and only if g_dir_open() fails.
--    Returns : a newly allocated GDir on success, NULL on failure. If non-NULL, you
--              must free the result with g_dir_close() when you are finished with it.

--    ---------------------------------------------------------------------------------

--   g_dir_read_name ()

--  const gchar* g_dir_read_name                (GDir *dir);

--    Retrieves the name of the next entry in the directory. The '.' and '..' entries
--    are omitted. On Windows, the returned name is in UTF-8. On Unix, it is in the
--    on-disk encoding.

--    dir :     a GDir* created by g_dir_open()
--    Returns : The entry's name or NULL if there are no more entries. The return value
--              is owned by GLib and must not be modified or freed.

--    ---------------------------------------------------------------------------------

--   g_dir_rewind ()

--  void        g_dir_rewind                    (GDir *dir);

--    Resets the given directory. The next call to g_dir_read_name() will return the
--    first entry again.

--    dir : a GDir* created by g_dir_open()

--    ---------------------------------------------------------------------------------

--   g_dir_close ()

--  void        g_dir_close                     (GDir *dir);

--    Closes the directory and deallocates all related resources.

--    dir : a GDir* created by g_dir_open()

--    ---------------------------------------------------------------------------------

--   GMappedFile

--  typedef struct _GMappedFile GMappedFile;

--    The GMappedFile represents a file mapping created with g_mapped_file_new(). It
--    has only private members and should not be accessed directly.

--    ---------------------------------------------------------------------------------

--   g_mapped_file_new ()

--  GMappedFile* g_mapped_file_new              (const gchar *filename,
--                                               gboolean writable,
--                                               GError **error);

--    Maps a file into memory. On UNIX, this is using the mmap() function.

--    If writable is TRUE, the mapped buffer may be modified, otherwise it is an error
--    to modify the mapped buffer. Modifications to the buffer are not visible to other
--    processes mapping the same file, and are not written back to the file.

--    Note that modifications of the underlying file might affect the contents of the
--    GMappedFile. Therefore, mapping should only be used if the file will not be
--    modified, or if all modifications of the file are done atomically (e.g. using
--    g_file_set_contents()).

--    filename : The path of the file to load, in the GLib filename encoding
--    writable : wether the mapping should be writable
--    error :    return location for a GError, or NULL
--    Returns :  a newly allocated GMappedFile which must be freed with
--               g_mapped_file_free(), or NULL if the mapping failed.

--    Since 2.8

--    ---------------------------------------------------------------------------------

--   g_mapped_file_free ()

--  void        g_mapped_file_free              (GMappedFile *file);

--    Unmaps the buffer of file and frees it.

--    file : a GMappedFile

--    Since 2.8

--    ---------------------------------------------------------------------------------

--   g_mapped_file_get_length ()

--  gsize       g_mapped_file_get_length        (GMappedFile *file);

--    Returns the length of the contents of a GMappedFile.

--    file :    a GMappedFile
--    Returns : the length of the contents of file.

--    Since 2.8

--    ---------------------------------------------------------------------------------

--   g_mapped_file_get_contents ()

--  gchar*      g_mapped_file_get_contents      (GMappedFile *file);

--    Returns the contents of a GMappedFile.

--    Note that the contents may not be zero-terminated, even if the GMappedFile is
--    backed by a text file.

--    file :    a GMappedFile
--    Returns : the contents of file.

--    Since 2.8

--    ---------------------------------------------------------------------------------

--   g_open ()

--  int         g_open                          (const gchar *filename,
--                                               int flags,
--                                               int mode);

--    A wrapper for the POSIX open() function. The open() function is used to convert a
--    pathname into a file descriptor. Note that on POSIX systems file descriptors are
--    implemented by the operating system. On Windows, it's the C library that
--    implements open() and file descriptors. The actual Windows API for opening files
--    is something different.

--    See the C library manual for more details about open().

--    filename : a pathname in the GLib file name encoding (UTF-8 on Windows)
--    flags :    as in open()
--    mode :     as in open()
--    Returns :  a new file descriptor, or -1 if an error occurred. The return value
--               can be used exactly like the return value from open().

--    Since 2.6

--    ---------------------------------------------------------------------------------

--   g_rename ()

--  int         g_rename                        (const gchar *oldfilename,
--                                               const gchar *newfilename);

--    A wrapper for the POSIX rename() function. The rename() function renames a file,
--    moving it between directories if required.

--    See your C library manual for more details about how rename() works on your
--    system. Note in particular that on Win9x it is not possible to rename a file if a
--    file with the new name already exists. Also it is not possible in general on
--    Windows to rename an open file.

--    oldfilename : a pathname in the GLib file name encoding (UTF-8 on Windows)
--    newfilename : a pathname in the GLib file name encoding
--    Returns :     0 if the renaming succeeded, -1 if an error occurred

--    Since 2.6

--    ---------------------------------------------------------------------------------

--   g_mkdir ()

--  int         g_mkdir                         (const gchar *filename,
--                                               int mode);

--    A wrapper for the POSIX mkdir() function. The mkdir() function attempts to create
--    a directory with the given name and permissions.

--    See the C library manual for more details about mkdir().

--    filename : a pathname in the GLib file name encoding (UTF-8 on Windows)
--    mode :     permissions to use for the newly created directory
--    Returns :  0 if the directory was successfully created, -1 if an error occurred

--    Since 2.6

--    ---------------------------------------------------------------------------------

--   g_stat ()

--  int         g_stat                          (const gchar *filename,
--                                               struct stat *buf);

--    A wrapper for the POSIX stat() function. The stat() function returns information
--    about a file.

--    See the C library manual for more details about stat().

--    filename : a pathname in the GLib file name encoding (UTF-8 on Windows)
--    buf :      a pointer to a stat struct, which will be filled with the file
--               information
--    Returns :  0 if the information was successfully retrieved, -1 if an error
--               occurred

--    Since 2.6

--    ---------------------------------------------------------------------------------

--   g_lstat ()

--  int         g_lstat                         (const gchar *filename,
--                                               struct stat *buf);

--    A wrapper for the POSIX lstat() function. The lstat() function is like stat()
--    except that in the case of symbolic links, it returns information about the
--    symbolic link itself and not the file that it refers to. If the system does not
--    support symbolic links g_lstat() is identical to g_stat().

--    See the C library manual for more details about lstat().

--    filename : a pathname in the GLib file name encoding (UTF-8 on Windows)
--    buf :      a pointer to a stat struct, which will be filled with the file
--               information
--    Returns :  0 if the information was successfully retrieved, -1 if an error
--               occurred

--    Since 2.6

--    ---------------------------------------------------------------------------------

--   g_unlink ()

--  int         g_unlink                        (const gchar *filename);

--    A wrapper for the POSIX unlink() function. The unlink() function deletes a name
--    from the filesystem. If this was the last link to the file and no processes have
--    it opened, the diskspace occupied by the file is freed.

--    See your C library manual for more details about unlink(). Note that on Windows,
--    it is in general not possible to delete files that are open to some process, or
--    mapped into memory.

--    filename : a pathname in the GLib file name encoding (UTF-8 on Windows)
--    Returns :  0 if the name was successfully deleted, -1 if an error occurred

--    Since 2.6

--    ---------------------------------------------------------------------------------

--   g_remove ()

--  int         g_remove                        (const gchar *filename);

--    A wrapper for the POSIX remove() function. The remove() function deletes a name
--    from the filesystem.

--    See your C library manual for more details about how remove() works on your
--    system. On Unix, remove() removes also directories, as it calls unlink() for
--    files and rmdir() for directories. On Windows, although remove() in the C library
--    only works for files, this function tries first remove() and then if that fails
--    rmdir(), and thus works for both files and directories. Note however, that on
--    Windows, it is in general not possible to remove a file that is open to some
--    process, or mapped into memory.

--    If this function fails on Windows you can't infer too much from the errno value.
--    rmdir() is tried regardless of what caused remove() to fail. Any errno value set
--    by remove() will be overwritten by that set by rmdir().

--    filename : a pathname in the GLib file name encoding (UTF-8 on Windows)
--    Returns :  0 if the file was successfully removed, -1 if an error occurred

--    Since 2.6

--    ---------------------------------------------------------------------------------

--   g_rmdir ()

--  int         g_rmdir                         (const gchar *filename);

--    A wrapper for the POSIX rmdir() function. The rmdir() function deletes a
--    directory from the filesystem.

--    See your C library manual for more details about how rmdir() works on your
--    system.

--    filename : a pathname in the GLib file name encoding (UTF-8 on Windows)
--    Returns :  0 if the directory was successfully removed, -1 if an error occurred

--    Since 2.6

--    ---------------------------------------------------------------------------------

--   g_fopen ()

--  FILE*       g_fopen                         (const gchar *filename,
--                                               const gchar *mode);

--    A wrapper for the POSIX fopen() function. The fopen() function opens a file and
--    associates a new stream with it.

--    See the C library manual for more details about fopen().

--    filename : a pathname in the GLib file name encoding (UTF-8 on Windows)
--    mode :     a string describing the mode in which the file should be opened
--    Returns :  A FILE pointer if the file was successfully opened, or NULL if an
--               error occurred

--    Since 2.6

--    ---------------------------------------------------------------------------------

--   g_freopen ()

--  FILE*       g_freopen                       (const gchar *filename,
--                                               const gchar *mode,
--                                               FILE *stream);

--    A wrapper for the POSIX freopen() function. The freopen() function opens a file
--    and associates it with an existing stream.

--    See the C library manual for more details about freopen().

--    filename : a pathname in the GLib file name encoding (UTF-8 on Windows)
--    mode :     a string describing the mode in which the file should be opened
--    stream :   an existing stream which will be reused, or NULL
--    Returns :  A FILE pointer if the file was successfully opened, or NULL if an
--               error occurred.

--    Since 2.6

--    ---------------------------------------------------------------------------------

--   g_chmod ()

--  int         g_chmod                         (const gchar *filename,
--                                               int mode);

--    A wrapper for the POSIX chmod() function. The chmod() function is used to set the
--    permissions of a file system object. Note that on Windows the file protection
--    mechanism is not at all POSIX-like, and the underlying chmod() function in the C
--    library just sets or clears the READONLY attribute. It does not touch any ACL.
--    Software that needs to manage file permissions on Windows exactly should use the
--    Win32 API.

--    See the C library manual for more details about chmod().

--    filename : a pathname in the GLib file name encoding (UTF-8 on Windows)
--    mode :     as in chmod()
--    Returns :  zero if the operation succeeded, -1 on error.

--    Since 2.8

--    ---------------------------------------------------------------------------------

--   g_access ()

--  int         g_access                        (const gchar *filename,
--                                               int mode);

--    A wrapper for the POSIX access() function. This function is used to test a
--    pathname for one or several of read, write or execute permissions, or just
--    existence. On Windows, the underlying access() function in the C library only
--    checks the READONLY attribute, and does not look at the ACL at all. Software that
--    needs to handle file permissions on Windows more exactly should use the Win32
--    API.

--    See the C library manual for more details about access().

--    filename : a pathname in the GLib file name encoding (UTF-8 on Windows)
--    mode :     as in access()
--    Returns :  zero if the pathname refers to an existing file system object that has
--               all the tested permissions, or -1 otherwise or on error.

--    Since 2.8

--    ---------------------------------------------------------------------------------

--   g_creat ()

--  int         g_creat                         (const gchar *filename,
--                                               int mode);

--    A wrapper for the POSIX creat() function. The creat() function is used to convert
--    a pathname into a file descriptor, creating a file if necessar. Note that on
--    POSIX systems file descriptors are implemented by the operating system. On
--    Windows, it's the C library that implements creat() and file descriptors. The
--    actual Windows API for opening files is something different.

--    See the C library manual for more details about creat().

--    filename : a pathname in the GLib file name encoding (UTF-8 on Windows)
--    mode :     as in creat()
--    Returns :  a new file descriptor, or -1 if an error occurred. The return value
--               can be used exactly like the return value from creat().

--    Since 2.8

--    ---------------------------------------------------------------------------------

--   g_chdir ()

--  int         g_chdir                         (const gchar *path);

--    A wrapper for the POSIX chdir() function. The function changes the current
--    directory of the process to path.

--    See your C library manual for more details about chdir().

--    path :    a pathname in the GLib file name encoding (UTF-8 on Windows)
--    Returns : 0 on success, -1 if an error occurred.

--    Since 2.8
end -- class GLIB_FILE_UTILITIES


													
