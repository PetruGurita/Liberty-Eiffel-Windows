note
	description: "Cursor for Postgresql database."
	copyright: "(C) 2006 Paolo Redaelli "
	license: "LGPL v2 or later"
	date: "$Date:$"
	revision: "$Revision:$"

			-- Cursor Objects represent a database cursor, which is used
			-- to manage the context of a fetch operation.

class POSTGRESQL_CURSOR
inherit
	C_STRUCT

feature {ANY} 
	rowcount: INTEGER is
		do
		end

	
	close is
			-- Close the cursor.
		deferred 
		end

	execute (some_sql: STRING; some_parameters: COLLECTION[ANY]) is
			-- Prepare and execute a database operation (query or
			-- command).  
		do
-- 			PQexec

-- 			  Submits a command to the server and waits for the result.

--  PGresult *PQexec(PGconn *conn, const char *command);

-- 			  Returns a PGresult pointer or possibly a null pointer. A non-null
-- 			  pointer will generally be returned except in out-of-memory
-- 			  conditions or serious errors such as inability to send the command
-- 			  to the server. If a null pointer is returned, it should be treated
-- 			  like a PGRES_FATAL_ERROR result. Use PQerrorMessage to get more
-- 			  information about such errors.

-- 	It is allowed to include multiple SQL commands (separated by semicolons)
-- 	in the command string. Multiple queries sent in a single PQexec call are
-- 	processed in a single transaction, unless there are explicit BEGIN/COMMIT
-- 	commands included in the query string to divide it into multiple
-- 	transactions. Note however that the returned PGresult structure describes
-- 	only the result of the last command executed from the string. Should one
-- 	of the commands fail, processing of the string stops with it and the
-- 	returned PGresult describes the error condition.

-- 	PQexecParams

-- 			  Submits a command to the server and waits for the result, with the
-- 			  ability to pass parameters separately from the SQL command text.

--  PGresult *PQexecParams(PGconn *conn,
-- 								const char *command,
-- 								int nParams,
-- 								const Oid *paramTypes,
-- 								const char * const *paramValues,
-- 								const int *paramLengths,
-- 								const int *paramFormats,
-- 								int resultFormat);

-- 			  PQexecParams is like PQexec, but offers additional functionality:
-- 			  parameter values can be specified separately from the command
-- 			  string proper, and query results can be requested in either text
-- 			  or binary format. PQexecParams is supported only in protocol 3.0
-- 			  and later connections; it will fail when using protocol 2.0.

-- 			  If parameters are used, they are referred to in the command string
-- 			  as $1, $2, etc. nParams is the number of parameters supplied; it
-- 			  is the length of the arrays paramTypes[], paramValues[],
-- 			  paramLengths[], and paramFormats[]. (The array pointers may be
-- 			  NULL when nParams is zero.) paramTypes[] specifies, by OID, the
-- 			  data types to be assigned to the parameter symbols. If paramTypes
-- 			  is NULL, or any particular element in the array is zero, the
-- 			  server assigns a data type to the parameter symbol in the same way
-- 			  it would do for an untyped literal string. paramValues[] specifies
-- 			  the actual values of the parameters. A null pointer in this array
-- 			  means the corresponding parameter is null; otherwise the pointer
-- 			  points to a zero-terminated text string (for text format) or
-- 			  binary data in the format expected by the server (for binary
-- 			  format). paramLengths[] specifies the actual data lengths of
-- 			  binary-format parameters. It is ignored for null parameters and
-- 			  text-format parameters. The array pointer may be null when there
-- 			  are no binary parameters. paramFormats[] specifies whether
-- 			  parameters are text (put a zero in the array) or binary (put a one
-- 			  in the array). If the array pointer is null then all parameters
-- 			  are presumed to be text. resultFormat is zero to obtain results in
-- 			  text format, or one to obtain results in binary format. (There is
-- 			  not currently a provision to obtain different result columns in
-- 			  different formats, although that is possible in the underlying
-- 			  protocol.)

-- 	The primary advantage of PQexecParams over PQexec is that parameter values
-- 	may be separated from the command string, thus avoiding the need for
-- 	tedious and error-prone quoting and escaping. Unlike PQexec, PQexecParams
-- 	allows at most one SQL command in the given string. (There can be
-- 	semicolons in it, but not more than one nonempty command.) This is a
-- 	limitation of the underlying protocol, but has some usefulness as an extra
-- 	defense against SQL-injection attacks.
	
		end


	execute_many(an_operation: STRING; some_parametes: COLLECTION[COLLECTION[ANY]]) is
			-- Prepare a database operation (query or command) and then
			-- execute it against `some_paramaters'.
		deferred
		end

	fetchone: RESULT_ROW is
			-- Fetch the next row of a query result set, returning a
			-- single sequence, or Void when no more data is available.
		deferred
		end

	fetchmany (row_number: INTEGER): TRAVERSABLE[RESULT_ROW] is
			-- Fetch `row_number' rows of a query result.
		deferred
		end

	fetch_all: TRAVERSABLE[RESULT_ROW] is
			-- Fetch all (remaining) rows of a query result.
		deferred
		end

feature {} -- External calls
	pqexec(a_connection: POINTER; a_command: POINTER): POINTER is -- PGresult*
			-- Submits a command to the server and waits for the result.
		
			-- Returns a PGresult pointer or possibly a null pointer. A
			-- non-null pointer will generally be returned except in
			-- out-of-memory conditions or serious errors such as
			-- inability to send the command to the server. If a null
			-- pointer is returned, it should be treated like a
			-- PGRES_FATAL_ERROR result. Use PQerrorMessage to get more
			-- information about such errors.

			-- It is allowed to include multiple SQL commands (separated
			-- by semicolons) in the command string. Multiple queries
			-- sent in a single PQexec call are processed in a single
			-- transaction, unless there are explicit BEGIN/COMMIT
			-- commands included in the query string to divide it into
			-- multiple transactions. Note however that the returned
			-- PGresult structure describes only the result of the last
			-- command executed from the string. Should one of the
			-- commands fail, processing of the string stops with it and
			-- the returned PGresult describes the error condition.
		external "plug_in"
		alias "{
			location: "${eiffel_libraries}plugins"
			module_name: "postgresql"
			feature_name: "PQexec"
			}"
		end			
	
-- 	PQexecParams

-- 			  Submits a command to the server and waits for the result, with the
-- 			  ability to pass parameters separately from the SQL command text.

--  PGresult *PQexecParams(PGconn *conn,
-- 								const char *command,
-- 								int nParams,
-- 								const Oid *paramTypes,
-- 								const char * const *paramValues,
-- 								const int *paramLengths,
-- 								const int *paramFormats,
-- 								int resultFormat);

-- 			  PQexecParams is like PQexec, but offers additional functionality:
-- 			  parameter values can be specified separately from the command
-- 			  string proper, and query results can be requested in either text
-- 			  or binary format. PQexecParams is supported only in protocol 3.0
-- 			  and later connections; it will fail when using protocol 2.0.

-- 			  If parameters are used, they are referred to in the command string
-- 			  as $1, $2, etc. nParams is the number of parameters supplied; it
-- 			  is the length of the arrays paramTypes[], paramValues[],
-- 			  paramLengths[], and paramFormats[]. (The array pointers may be
-- 			  NULL when nParams is zero.) paramTypes[] specifies, by OID, the
-- 			  data types to be assigned to the parameter symbols. If paramTypes
-- 			  is NULL, or any particular element in the array is zero, the
-- 			  server assigns a data type to the parameter symbol in the same way
-- 			  it would do for an untyped literal string. paramValues[] specifies
-- 			  the actual values of the parameters. A null pointer in this array
-- 			  means the corresponding parameter is null; otherwise the pointer
-- 			  points to a zero-terminated text string (for text format) or
-- 			  binary data in the format expected by the server (for binary
-- 			  format). paramLengths[] specifies the actual data lengths of
-- 			  binary-format parameters. It is ignored for null parameters and
-- 			  text-format parameters. The array pointer may be null when there
-- 			  are no binary parameters. paramFormats[] specifies whether
-- 			  parameters are text (put a zero in the array) or binary (put a one
-- 			  in the array). If the array pointer is null then all parameters
-- 			  are presumed to be text. resultFormat is zero to obtain results in
-- 			  text format, or one to obtain results in binary format. (There is
-- 			  not currently a provision to obtain different result columns in
-- 			  different formats, although that is possible in the underlying
-- 			  protocol.)

-- 	The primary advantage of PQexecParams over PQexec is that parameter values
-- 	may be separated from the command string, thus avoiding the need for
-- 	tedious and error-prone quoting and escaping. Unlike PQexec, PQexecParams
-- 	allows at most one SQL command in the given string. (There can be
-- 	semicolons in it, but not more than one nonempty command.) This is a
-- 	limitation of the underlying protocol, but has some usefulness as an extra
-- 	defense against SQL-injection attacks.
	

-- 	PQprepare

-- 			  Submits a request to create a prepared statement with the given
-- 			  parameters, and waits for completion.

--  PGresult *PQprepare(PGconn *conn,
-- 							const char *stmtName,
-- 							const char *query,
-- 							int nParams,
-- 							const Oid *paramTypes);

-- 			  PQprepare creates a prepared statement for later execution with
-- 			  PQexecPrepared. This feature allows commands that will be used
-- 			  repeatedly to be parsed and planned just once, rather than each
-- 			  time they are executed. PQprepare is supported only in protocol
-- 			  3.0 and later connections; it will fail when using protocol 2.0.

-- 			  The function creates a prepared statement named stmtName from the
-- 			  query string, which must contain a single SQL command. stmtName
-- 			  may be "" to create an unnamed statement, in which case any
-- 			  pre-existing unnamed statement is automatically replaced;
-- 			  otherwise it is an error if the statement name is already defined
-- 			  in the current session. If any parameters are used, they are
-- 			  referred to in the query as $1, $2, etc. nParams is the number of
-- 			  parameters for which types are pre-specified in the array
-- 			  paramTypes[]. (The array pointer may be NULL when nParams is
-- 			  zero.) paramTypes[] specifies, by OID, the data types to be
-- 			  assigned to the parameter symbols. If paramTypes is NULL, or any
-- 			  particular element in the array is zero, the server assigns a data
-- 			  type to the parameter symbol in the same way it would do for an
-- 			  untyped literal string. Also, the query may use parameter symbols
-- 			  with numbers higher than nParams; data types will be inferred for
-- 			  these symbols as well.

-- 			  As with PQexec, the result is normally a PGresult object whose
-- 			  contents indicate server-side success or failure. A null result
-- 			  indicates out-of-memory or inability to send the command at all.
-- 			  Use PQerrorMessage to get more information about such errors.

-- 			  At present, there is no way to determine the actual data type
-- 			  inferred for any parameters whose types are not specified in
-- 			  paramTypes[]. This is a libpq omission that will probably be
-- 			  rectified in a future release.

-- 	Prepared statements for use with PQexecPrepared can also be created by
-- 	executing SQL PREPARE statements. (But PQprepare is more flexible since it
-- 	does not require parameter types to be pre-specified.) Also, although
-- 	there is no libpq function for deleting a prepared statement, the SQL
-- 	DEALLOCATE statement can be used for that purpose.

-- 	PQexecPrepared

-- 			  Sends a request to execute a prepared statement with given
-- 			  parameters, and waits for the result.

--  PGresult *PQexecPrepared(PGconn *conn,
-- 								  const char *stmtName,
-- 								  int nParams,
-- 								  const char * const *paramValues,
-- 								  const int *paramLengths,
-- 								  const int *paramFormats,
-- 								  int resultFormat);

-- 			  PQexecPrepared is like PQexecParams, but the command to be
-- 			  executed is specified by naming a previously-prepared statement,
-- 			  instead of giving a query string. This feature allows commands
-- 			  that will be used repeatedly to be parsed and planned just once,
-- 			  rather than each time they are executed. The statement must have
-- 			  been prepared previously in the current session. PQexecPrepared is
-- 			  supported only in protocol 3.0 and later connections; it will fail
-- 			  when using protocol 2.0.

-- 			  The parameters are identical to PQexecParams, except that the name
-- 			  of a prepared statement is given instead of a query string, and
-- 			  the paramTypes[] parameter is not present (it is not needed since
-- 			  the prepared statement's parameter types were determined when it
-- 			  was created).

-- 	The PGresult structure encapsulates the result returned by the server.
-- 	libpq application programmers should be careful to maintain the PGresult
-- 	abstraction. Use the accessor functions below to get at the contents of
-- 	PGresult. Avoid directly referencing the fields of the PGresult structure
-- 	because they are subject to change in the future.

-- 	PQresultStatus

-- 			  Returns the result status of the command.

--  ExecStatusType PQresultStatus(const PGresult *res);

-- 			  PQresultStatus can return one of the following values:

-- 					 PGRES_EMPTY_QUERY

-- 								The string sent to the server was empty.

-- 					 PGRES_COMMAND_OK

-- 								Successful completion of a command returning no data.

-- 					 PGRES_TUPLES_OK

-- 								Successful completion of a command returning data
-- 								(such as a SELECT or SHOW).

-- 					 PGRES_COPY_OUT

-- 								Copy Out (from server) data transfer started.

-- 					 PGRES_COPY_IN

-- 								Copy In (to server) data transfer started.

-- 					 PGRES_BAD_RESPONSE

-- 								The server's response was not understood.

-- 					 PGRES_NONFATAL_ERROR

-- 								A nonfatal error (a notice or warning) occurred.

-- 					 PGRES_FATAL_ERROR

-- 								A fatal error occurred.

-- 			  If the result status is PGRES_TUPLES_OK, then the functions
-- 			  described below can be used to retrieve the rows returned by the
-- 			  query. Note that a SELECT command that happens to retrieve zero
-- 			  rows still shows PGRES_TUPLES_OK. PGRES_COMMAND_OK is for commands
-- 			  that can never return rows (INSERT, UPDATE, etc.). A response of
-- 			  PGRES_EMPTY_QUERY may indicate a bug in the client software.

-- 			  A result of status PGRES_NONFATAL_ERROR will never be returned
-- 			  directly by PQexec or other query execution functions; results of
-- 			  this kind are instead passed to the notice processor (see Section
-- 			  27.10).

-- 	PQresStatus

-- 			  Converts the enumerated type returned by PQresultStatus into a
-- 			  string constant describing the status code. The caller should not
-- 			  free the result.

--  char *PQresStatus(ExecStatusType status);

-- 	PQresultErrorMessage

-- 			  Returns the error message associated with the command, or an empty
-- 			  string if there was no error.

--  char *PQresultErrorMessage(const PGresult *res);

-- 			  If there was an error, the returned string will include a trailing
-- 			  newline. The caller should not free the result directly. It will
-- 			  be freed when the associated PGresult handle is passed to PQclear.

-- 			  Immediately following a PQexec or PQgetResult call, PQerrorMessage
-- 			  (on the connection) will return the same string as
-- 			  PQresultErrorMessage (on the result). However, a PGresult will
-- 			  retain its error message until destroyed, whereas the connection's
-- 			  error message will change when subsequent operations are done. Use
-- 			  PQresultErrorMessage when you want to know the status associated
-- 			  with a particular PGresult; use PQerrorMessage when you want to
-- 			  know the status from the latest operation on the connection.

-- 	PQresultErrorField

-- 			  Returns an individual field of an error report.

--  char *PQresultErrorField(const PGresult *res, int fieldcode);

-- 			  fieldcode is an error field identifier; see the symbols listed
-- 			  below. NULL is returned if the PGresult is not an error or warning
-- 			  result, or does not include the specified field. Field values will
-- 			  normally not include a trailing newline. The caller should not
-- 			  free the result directly. It will be freed when the associated
-- 			  PGresult handle is passed to PQclear.

-- 			  The following field codes are available:

-- 					 PG_DIAG_SEVERITY

-- 								The severity; the field contents are ERROR, FATAL, or
-- 								PANIC (in an error message), or WARNING, NOTICE,
-- 								DEBUG, INFO, or LOG (in a notice message), or a
-- 								localized translation of one of these. Always
-- 								present.

-- 					 PG_DIAG_SQLSTATE

-- 								The SQLSTATE code for the error. The SQLSTATE code
-- 								identifies the type of error that has occurred; it
-- 								can be used by front-end applications to perform
-- 								specific operations (such as error handling) in
-- 								response to a particular database error. For a list
-- 								of the possible SQLSTATE codes, see Appendix A. This
-- 								field is not localizable, and is always present.

-- 					 PG_DIAG_MESSAGE_PRIMARY

-- 								The primary human-readable error message (typically
-- 								one line). Always present.

-- 					 PG_DIAG_MESSAGE_DETAIL

-- 								Detail: an optional secondary error message carrying
-- 								more detail about the problem. May run to multiple
-- 								lines.

-- 					 PG_DIAG_MESSAGE_HINT

-- 								Hint: an optional suggestion what to do about the
-- 								problem. This is intended to differ from detail in
-- 								that it offers advice (potentially inappropriate)
-- 								rather than hard facts. May run to multiple lines.

-- 					 PG_DIAG_STATEMENT_POSITION

-- 								A string containing a decimal integer indicating an
-- 								error cursor position as an index into the original
-- 								statement string. The first character has index 1,
-- 								and positions are measured in characters not bytes.

-- 					 PG_DIAG_INTERNAL_POSITION

-- 								This is defined the same as the
-- 								PG_DIAG_STATEMENT_POSITION field, but it is used when
-- 								the cursor position refers to an internally generated
-- 								command rather than the one submitted by the client.
-- 								The PG_DIAG_INTERNAL_QUERY field will always appear
-- 								when this field appears.

-- 					 PG_DIAG_INTERNAL_QUERY

-- 								The text of a failed internally-generated command.
-- 								This could be, for example, a SQL query issued by a
-- 								PL/pgSQL function.

-- 					 PG_DIAG_CONTEXT

-- 								An indication of the context in which the error
-- 								occurred. Presently this includes a call stack
-- 								traceback of active procedural language functions and
-- 								internally-generated queries. The trace is one entry
-- 								per line, most recent first.

-- 					 PG_DIAG_SOURCE_FILE

-- 								The file name of the source-code location where the
-- 								error was reported.

-- 					 PG_DIAG_SOURCE_LINE

-- 								The line number of the source-code location where the
-- 								error was reported.

-- 					 PG_DIAG_SOURCE_FUNCTION

-- 								The name of the source-code function reporting the
-- 								error.

-- 			  The client is responsible for formatting displayed information to
-- 			  meet its needs; in particular it should break long lines as
-- 			  needed. Newline characters appearing in the error message fields
-- 			  should be treated as paragraph breaks, not line breaks.

-- 			  Errors generated internally by libpq will have severity and
-- 			  primary message, but typically no other fields. Errors returned by
-- 			  a pre-3.0-protocol server will include severity and primary
-- 			  message, and sometimes a detail message, but no other fields.

-- 			  Note that error fields are only available from PGresult objects,
-- 			  not PGconn objects; there is no PQerrorField function.

-- 	PQclear

-- 			  Frees the storage associated with a PGresult. Every command result
-- 			  should be freed via PQclear when it is no longer needed.

--  void PQclear(PGresult *res);

-- 			  You can keep a PGresult object around for as long as you need it;
-- 			  it does not go away when you issue a new command, nor even if you
-- 			  close the connection. To get rid of it, you must call PQclear.
-- 			  Failure to do this will result in memory leaks in your
-- 			  application.

-- 	PQmakeEmptyPGresult

-- 			  Constructs an empty PGresult object with the given status.

--  PGresult* PQmakeEmptyPGresult(PGconn *conn, ExecStatusType status);

-- 			  This is libpq's internal function to allocate and initialize an
-- 			  empty PGresult object. It is exported because some applications
-- 			  find it useful to generate result objects (particularly objects
-- 			  with error status) themselves. If conn is not null and status
-- 			  indicates an error, the current error message of the specified
-- 			  connection is copied into the PGresult. Note that PQclear should
-- 			  eventually be called on the object, just as with a PGresult
-- 			  returned by libpq itself.

-- 27.3.2. Retrieving Query Result Information

-- 	These functions are used to extract information from a PGresult object
-- 	that represents a successful query result (that is, one that has status
-- 	PGRES_TUPLES_OK). For objects with other status values they will act as
-- 	though the result has zero rows and zero columns.

-- 	PQntuples

-- 			  Returns the number of rows (tuples) in the query result.

--  int PQntuples(const PGresult *res);

-- 	PQnfields

-- 			  Returns the number of columns (fields) in each row of the query
-- 			  result.

--  int PQnfields(const PGresult *res);

-- 	PQfname

-- 			  Returns the column name associated with the given column number.
-- 			  Column numbers start at 0. The caller should not free the result
-- 			  directly. It will be freed when the associated PGresult handle is
-- 			  passed to PQclear.

--  char *PQfname(const PGresult *res,
-- 					int column_number);

-- 			  NULL is returned if the column number is out of range.

-- 	PQfnumber

-- 			  Returns the column number associated with the given column name.

--  int PQfnumber(const PGresult *res,
-- 					const char *column_name);

-- 			  -1 is returned if the given name does not match any column.

-- 			  The given name is treated like an identifier in an SQL command,
-- 			  that is, it is downcased unless double-quoted. For example, given
-- 			  a query result generated from the SQL command

--  select 1 as FOO, 2 as "BAR";

-- 			  we would have the results:

--  PQfname(res, 0)              foo
--  PQfname(res, 1)              BAR
--  PQfnumber(res, "FOO")        0
--  PQfnumber(res, "foo")        0
--  PQfnumber(res, "BAR")        -1
--  PQfnumber(res, "\"BAR\"")    1

-- 	PQftable

-- 			  Returns the OID of the table from which the given column was
-- 			  fetched. Column numbers start at 0.

--  Oid PQftable(const PGresult *res,
-- 				  int column_number);

-- 			  InvalidOid is returned if the column number is out of range, or if
-- 			  the specified column is not a simple reference to a table column,
-- 			  or when using pre-3.0 protocol. You can query the system table
-- 			  pg_class to determine exactly which table is referenced.

-- 			  The type Oid and the constant InvalidOid will be defined when you
-- 			  include the libpq header file. They will both be some integer
-- 			  type.

-- 	PQftablecol

-- 			  Returns the column number (within its table) of the column making
-- 			  up the specified query result column. Query-result column numbers
-- 			  start at 0, but table columns have nonzero numbers.

--  int PQftablecol(const PGresult *res,
-- 					  int column_number);

-- 			  Zero is returned if the column number is out of range, or if the
-- 			  specified column is not a simple reference to a table column, or
-- 			  when using pre-3.0 protocol.

-- 	PQfformat

-- 			  Returns the format code indicating the format of the given column.
-- 			  Column numbers start at 0.

--  int PQfformat(const PGresult *res,
-- 					int column_number);

-- 			  Format code zero indicates textual data representation, while
-- 			  format code one indicates binary representation. (Other codes are
-- 			  reserved for future definition.)

-- 	PQftype

-- 			  Returns the data type associated with the given column number. The
-- 			  integer returned is the internal OID number of the type. Column
-- 			  numbers start at 0.

--  Oid PQftype(const PGresult *res,
-- 				 int column_number);

-- 			  You can query the system table pg_type to obtain the names and
-- 			  properties of the various data types. The OIDs of the built-in
-- 			  data types are defined in the file src/include/catalog/pg_type.h
-- 			  in the source tree.

-- 	PQfmod

-- 			  Returns the type modifier of the column associated with the given
-- 			  column number. Column numbers start at 0.

--  int PQfmod(const PGresult *res,
-- 				int column_number);

-- 			  The interpretation of modifier values is type-specific; they
-- 			  typically indicate precision or size limits. The value -1 is used
-- 			  to indicate "no information available". Most data types do not use
-- 			  modifiers, in which case the value is always -1.

-- 	PQfsize

-- 			  Returns the size in bytes of the column associated with the given
-- 			  column number. Column numbers start at 0.

--  int PQfsize(const PGresult *res,
-- 				 int column_number);

-- 			  PQfsize returns the space allocated for this column in a database
-- 			  row, in other words the size of the server's internal
-- 			  representation of the data type. (Accordingly, it is not really
-- 			  very useful to clients.) A negative value indicates the data type
-- 			  is variable-length.

-- 	PQbinaryTuples

-- 			  Returns 1 if the PGresult contains binary data and 0 if it
-- 			  contains text data.

--  int PQbinaryTuples(const PGresult *res);

-- 			  This function is deprecated (except for its use in connection with
-- 			  COPY), because it is possible for a single PGresult to contain
-- 			  text data in some columns and binary data in others. PQfformat is
-- 			  preferred. PQbinaryTuples returns 1 only if all columns of the
-- 			  result are binary (format 1).

-- 	PQgetvalue

-- 			  Returns a single field value of one row of a PGresult. Row and
-- 			  column numbers start at 0. The caller should not free the result
-- 			  directly. It will be freed when the associated PGresult handle is
-- 			  passed to PQclear.

--  char *PQgetvalue(const PGresult *res,
-- 						int row_number,
-- 						int column_number);

-- 			  For data in text format, the value returned by PQgetvalue is a
-- 			  null-terminated character string representation of the field
-- 			  value. For data in binary format, the value is in the binary
-- 			  representation determined by the data type's typsend and
-- 			  typreceive functions. (The value is actually followed by a zero
-- 			  byte in this case too, but that is not ordinarily useful, since
-- 			  the value is likely to contain embedded nulls.)

-- 			  An empty string is returned if the field value is null. See
-- 			  PQgetisnull to distinguish null values from empty-string values.

-- 			  The pointer returned by PQgetvalue points to storage that is part
-- 			  of the PGresult structure. One should not modify the data it
-- 			  points to, and one must explicitly copy the data into other
-- 			  storage if it is to be used past the lifetime of the PGresult
-- 			  structure itself.

-- 	PQgetisnull

-- 			  Tests a field for a null value. Row and column numbers start at 0.

--  int PQgetisnull(const PGresult *res,
-- 					  int row_number,
-- 					  int column_number);

-- 			  This function returns 1 if the field is null and 0 if it contains
-- 			  a non-null value. (Note that PQgetvalue will return an empty
-- 			  string, not a null pointer, for a null field.)

-- 	PQgetlength

-- 			  Returns the actual length of a field value in bytes. Row and
-- 			  column numbers start at 0.

--  int PQgetlength(const PGresult *res,
-- 					  int row_number,
-- 					  int column_number);

-- 			  This is the actual data length for the particular data value, that
-- 			  is, the size of the object pointed to by PQgetvalue. For text data
-- 			  format this is the same as strlen(). For binary format this is
-- 			  essential information. Note that one should not rely on PQfsize to
-- 			  obtain the actual data length.

-- 	PQprint

-- 			  Prints out all the rows and, optionally, the column names to the
-- 			  specified output stream.

--  void PQprint(FILE *fout,      /* output stream */
-- 				  const PGresult *res,
-- 				  const PQprintOpt *po);

--  typedef struct {
-- 	pqbool  header;      /* print output field headings and row count */
-- 	pqbool  align;       /* fill align the fields */
-- 	pqbool  standard;    /* old brain dead format */
-- 	pqbool  html3;       /* output HTML tables */
-- 	pqbool  expanded;    /* expand tables */
-- 	pqbool  pager;       /* use pager for output if needed */
-- 	char    *fieldSep;   /* field separator */
-- 	char    *tableOpt;   /* attributes for HTML table element */
-- 	char    *caption;    /* HTML table caption */
-- 	char    **fieldName; /* null-terminated array of replacement field names */
--  } PQprintOpt;

-- 			  This function was formerly used by psql to print query results,
-- 			  but this is no longer the case. Note that it assumes all the data
-- 			  is in text format.

-- 27.3.3. Retrieving Result Information for Other Commands

-- 	These functions are used to extract information from PGresult objects that
-- 	are not SELECT results.

-- 	PQcmdStatus

-- 			  Returns the command status tag from the SQL command that generated
-- 			  the PGresult.

--  char *PQcmdStatus(PGresult *res);

-- 			  Commonly this is just the name of the command, but it may include
-- 			  additional data such as the number of rows processed. The caller
-- 			  should not free the result directly. It will be freed when the
-- 			  associated PGresult handle is passed to PQclear.

-- 	PQcmdTuples

-- 			  Returns the number of rows affected by the SQL command.

--  char *PQcmdTuples(PGresult *res);

-- 			  This function returns a string containing the number of rows
-- 			  affected by the SQL statement that generated the PGresult. This
-- 			  function can only be used following the execution of an INSERT,
-- 			  UPDATE, DELETE, MOVE, or FETCH statement, or an EXECUTE of a
-- 			  prepared query that contains a INSERT, UPDATE, or DELETE
-- 			  statement. If the command that generated the PGresult was anything
-- 			  else, PQcmdTuples returns the empty string. The caller should not
-- 			  free the return value directly. It will be freed when the
-- 			  associated PGresult handle is passed to PQclear.

-- 	PQoidValue

-- 			  Returns the OID of the inserted row, if the SQL command was an
-- 			  INSERT that inserted exactly one row into a table that has OIDs,
-- 			  or a EXECUTE of a prepared query containing a suitable INSERT
-- 			  statement. Otherwise, this function returns InvalidOid. This
-- 			  function will also return InvalidOid if the table affected by the
-- 			  INSERT statement does not contain OIDs.

--  Oid PQoidValue(const PGresult *res);

-- 	PQoidStatus

-- 			  Returns a string with the OID of the inserted row, if the SQL
-- 			  command was an INSERT that inserted exactly one row, or a EXECUTE
-- 			  of a prepared statement consisting of a suitable INSERT. (The
-- 			  string will be 0 if the INSERT did not insert exactly one row, or
-- 			  if the target table does not have OIDs.) If the command was not an
-- 			  INSERT, returns an empty string.

--  char *PQoidStatus(const PGresult *res);

-- 			  This function is deprecated in favor of PQoidValue. It is not
-- 			  thread-safe.

-- 27.3.4. Escaping Strings for Inclusion in SQL Commands

-- 	PQescapeString escapes a string for use within an SQL command. This is
-- 	useful when inserting data values as literal constants in SQL commands.
-- 	Certain characters (such as quotes and backslashes) must be escaped to
-- 	prevent them from being interpreted specially by the SQL parser.
-- 	PQescapeString performs this operation.

-- 	Tip: It is especially important to do proper escaping when handling
-- 	strings that were received from an untrustworthy source. Otherwise there
-- 	is a security risk: you are vulnerable to "SQL injection" attacks
-- 	wherein unwanted SQL commands are fed to your database.

-- 	Note that it is not necessary nor correct to do escaping when a data value
-- 	is passed as a separate parameter in PQexecParams or its sibling routines.

--  size_t PQescapeString (char *to, const char *from, size_t length);

-- 	The parameter from points to the first character of the string that is to
-- 	be escaped, and the length parameter gives the number of characters in
-- 	this string. A terminating zero byte is not required, and should not be
-- 	counted in length. (If a terminating zero byte is found before length
-- 	bytes are processed, PQescapeString stops at the zero; the behavior is
-- 	thus rather like strncpy.) to shall point to a buffer that is able to hold
-- 	at least one more character than twice the value of length, otherwise the
-- 	behavior is undefined. A call to PQescapeString writes an escaped version
-- 	of the from string to the to buffer, replacing special characters so that
-- 	they cannot cause any harm, and adding a terminating zero byte. The single
-- 	quotes that must surround PostgreSQL string literals are not included in
-- 	the result string; they should be provided in the SQL command that the
-- 	result is inserted into.

-- 	PQescapeString returns the number of characters written to to, not
-- 	including the terminating zero byte.

-- 	Behavior is undefined if the to and from strings overlap.

-- 27.3.5. Escaping Binary Strings for Inclusion in SQL Commands

-- 	PQescapeBytea

-- 			  Escapes binary data for use within an SQL command with the type
-- 			  bytea. As with PQescapeString, this is only used when inserting
-- 			  data directly into an SQL command string.

--  unsigned char *PQescapeBytea(const unsigned char *from,
-- 										size_t from_length,
-- 										size_t *to_length);

-- 			  Certain byte values must be escaped (but all byte values may be
-- 			  escaped) when used as part of a bytea literal in an SQL statement.
-- 			  In general, to escape a byte, it is converted into the three digit
-- 			  octal number equal to the octet value, and preceded by two
-- 			  backslashes. The single quote (') and backslash (\) characters
-- 			  have special alternative escape sequences. See Section 8.4 for
-- 			  more information. PQescapeBytea performs this operation, escaping
-- 			  only the minimally required bytes.

-- 			  The from parameter points to the first byte of the string that is
-- 			  to be escaped, and the from_length parameter gives the number of
-- 			  bytes in this binary string. (A terminating zero byte is neither
-- 			  necessary nor counted.) The to_length parameter points to a
-- 			  variable that will hold the resultant escaped string length. The
-- 			  result string length includes the terminating zero byte of the
-- 			  result.

-- 			  PQescapeBytea returns an escaped version of the from parameter
-- 			  binary string in memory allocated with malloc(). This memory must
-- 			  be freed using PQfreemem when the result is no longer needed. The
-- 			  return string has all special characters replaced so that they can
-- 			  be properly processed by the PostgreSQL string literal parser, and
-- 			  the bytea input function. A terminating zero byte is also added.
-- 			  The single quotes that must surround PostgreSQL string literals
-- 			  are not part of the result string.

-- 	PQunescapeBytea

-- 			  Converts an escaped string representation of binary data into
-- 			  binary data -- the reverse of PQescapeBytea. This is needed when
-- 			  retrieving bytea data in text format, but not when retrieving it
-- 			  in binary format.

--  unsigned char *PQunescapeBytea(const unsigned char *from, size_t *to_length);

-- 			  The from parameter points to an escaped string such as might be
-- 			  returned by PQgetvalue when applied to a bytea column.
-- 			  PQunescapeBytea converts this string representation into its
-- 			  binary representation. It returns a pointer to a buffer allocated
-- 			  with malloc(), or null on error, and puts the size of the buffer
-- 			  in to_length. The result must be freed using PQfreemem when it is
-- 			  no longer needed.

-- 	PQfreemem

-- 			  Frees memory allocated by libpq.

--  void PQfreemem(void *ptr);

-- 			  Frees memory allocated by libpq, particularly PQescapeBytea,
-- 			  PQunescapeBytea, and PQnotifies. It is needed by Microsoft
-- 			  Windows, which cannot free memory across DLLs, unless
-- 			  multithreaded DLLs (/MD in VC6) are used. On other platforms, this
-- 			  function is the same as the standard library function free().

-- 	--------------------------------------------------------------------------

-- 	Prev                             Home                                 Next
-- 	Connection Status Functions       Up       Asynchronous Command Processing
	end -- class POSTGRESQL_CURSOR
