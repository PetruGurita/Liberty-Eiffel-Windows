class WRAPPERS_GENERATOR
   -- An application that processes the output of gccxml to produce low-level
   -- wrappers for functions, structures and enumerationsi and unions.
   -- Function having argument structures passed by value are not handled.

insert
   ARGUMENTS
   FILE_TOOLS
   SHARED_SETTINGS
   SHARED_COLLECTIONS
   NAME_CONVERTER
   LIBERTY_VERSION

create {ANY}
   make

feature {ANY}
   liberty_authors: STRING "P.REDAELLI"
   liberty_dates: STRING "2008-2016"

   make
      do
         log(once "wrappers generator%N")
         process_arguments
         log(once "Loading XML file: ")
         create tree.make(input.url)
         log(once "done.%N")
         open_plugin_files
         if file_exists(avoided) and then is_file(avoided) then
            log(once "Reading list of avoided symbols from '#(1)'.%N" # avoided)
            tree.read_avoided_from(avoided)
         end

         if file_exists(moved) and then is_file(moved) then
            log(once "Reading symbols to be moved/renamed from '#(1)'.%N" # moved)
            tree.read_moved_from(moved)
         end

         if file_exists(flags) and then is_file(flags) then
            log(once "Reading enumerations that will be forcefully wrapped as flags from '#(1)'.%N" # flags)
            tree.read_flags_from(flags)
         end

         if file_exists(descriptions) and then is_file(descriptions) then
            log(once "Reading descriptions flags from '#(1)'.%N" # descriptions)
            tree.read_descriptions_from(descriptions)
         end

         log(once "Making wrappers.%N")
         tree.emit_wrappers
         -- tree.namespaces.for_each(agent {GCCXML_NODE}.emit_wrappers)
         close_plugin_files
      end

   tree: GCCXML_TREE

   input: INPUT_STREAM

   path: POSIX_PATH_NAME

   preprocessor_label: STRING

   avoided: STRING

   renamed: STRING

   moved: STRING

   flags: STRING

   descriptions: STRING

   process_arguments
         -- Process arguments. If some argument is not understood `print_usage' is invoked and the program exits.
         --| TODO: Why isn't this using COMMAND_LINE_TOOLS? --djk
      local
         arg, gccxml_prefix, standard_typedefs: STRING; i: INTEGER
      do
         check
            global = False
            verbose = False
         end
         -- Setting defaults
         flags := once "flags"
         descriptions := once "descriptions"
         avoided := once "avoided"
         renamed := once "renamed"
         moved := once "moved"
         standard_typedefs := once "STANDARD_C_LIBRARY_TYPES"

         if argument_count = 0 then
            print_usage
            die_with_code(exit_success_code)
         else
            from
               i := 1
            until
               i > argument_count
            loop
               arg := argument(i)
               if arg.has_prefix(once "--") then
                  arg.remove_first
               end
               if arg.is_equal(once "-local") then
                  settings.set_global(False)
               elseif arg.is_equal(once "-global") then
                  settings.set_global(True)
               elseif arg.is_equal(once "-emit-standard-typedefs") then
                  settings.use_standard_typedefs
               elseif arg.is_equal(once "-apply-patches") then
                  not_yet_implemented
               elseif arg.is_equal(once "-descriptions") then
                  i := i + 1
                  if i <= argument_count then
                     descriptions := argument(i)
                  else
                     std_error.put_line(once "No description file given.")
                     print_usage
                  end
               elseif arg.is_equal(once "-standard-typedefs") then
                  i := i + 1
                  if i <= argument_count then
                     if is_valid_class_name(argument(i)) then
                        standard_typedefs := eiffel_class_name(argument(i), Void)
                     else
                        std_error.put_line(once "#(1)  not a valid class name" # argument(i))
                     end
                  else
                     std_error.put_line(once "Name of class containing standard typedefs not given")
                     print_usage
                  end
               elseif arg.is_equal(once "-flags") then
                  i := i + 1
                  if i <= argument_count then
                     flags := argument(i)
                  else
                     std_error.put_line(once "No flags file given")
                     print_usage
                  end
               elseif arg.is_equal(once "-avoided") then
                  i := i + 1
                  if i <= argument_count then
                     avoided := argument(i)
                  else
                     std_error.put_line(once "No avoided file given")
                     print_usage
                  end
               elseif arg.is_equal(once "-moved") then
                  not_yet_implemented
                  i := i + 1
                  if i <= argument_count then
                     moved := argument(i)
                  else
                     std_error.put_line(once "No moved functions file given")
                     print_usage
                  end
               elseif arg.is_equal(once "-version") or else arg.is_equal(once "-v") then
                  print_version
                  die_with_code(0)
               elseif arg.is_equal(once "-help") or else arg.is_equal(once "-h") then
                  print_usage
                  die_with_code(0)
               elseif arg.is_equal(once "-verbose") then
                  settings.set_verbose(True)
                  -- TODO: re-enable grouping output on standard output
                  -- elseif arg.is_equal(once "-on-standard-output") then
                  --    settings.set_directory(Void)
               else
                  if file_exists(arg) then
                     -- Current arg should be the XML file. The following
                     -- are headers to process.
                     create path.make_from_string(arg)
                     create {TEXT_FILE_READ} input.connect_to(arg)
                     from
                        i := i + 1
                     until
                        i > argument_count
                     loop
                        headers.add(argument(i))
                        i := i + 1
                     end
                  else
                     std_error.put_string(once "Input file does not exist: ")
                     std_error.put_line(arg)
                     print_usage
                  end
               end

               i := i + 1
            end
            if input = Void then
               log(once "Using standard input. Prefix will be the basename of the current directory.")
               create path.make_current
               input := std_input
            end

            gccxml_prefix := path.last.twin
            gccxml_prefix.remove_tail(path.extension.count)
            settings.set_typedefs(eiffel_class_name(gccxml_prefix, "_TYPES"))
            settings.set_standard_typedefs(standard_typedefs)
            preprocessor_label := eiffel_class_name(gccxml_prefix, "_LIBERTY_PLUGIN")

            if verbose then
               if global then
                  std_error.put_line(once "Generation wrappers for all the C features found.")
               else
                  std_error.put_string(once "Generating low-level wrappers only for ")
                  std_error.put_integer(headers.count)
                  std_error.put_string(once " files: ")
                  headers.for_each(agent (a_string: ABSTRACT_STRING)
                     do
                        std_error.put_string(once "'")
                        std_error.put_string(a_string)
                        std_error.put_string(once "', ")
                     end(?))
                  std_error.put_new_line
               end
            end
         end
      end

   open_plugin_files
      local
         cwd, plugin: DIRECTORY; file: FILE; bd: BASIC_DIRECTORY
      do
         create cwd.scan_current_working_directory
         if not cwd.has_file(once "plugin") then
            if not bd.create_new_directory(once "plugin") then
               log("Couldn't create plugin directory")
               die_with_code(exit_failure_code)
            end
         end

         file := cwd.file("plugin")
         if not file.is_directory then
            log("%'plugin'  not a directory")
            die_with_code(exit_failure_code)
         end

         plugin := file.as_directory
         if not plugin.has_file(once "c") then
            if not bd.create_new_directory(once "plugin/c") then
               log("Couldn't create plugin/c directory")
               die_with_code(exit_failure_code)
            end
         end

         file := plugin.file(once "c")
         if not file.is_directory then
            log("%'plugin/c'  not a directory")
            die_with_code(exit_failure_code)
         end
         -- TODO: check that both pdirectory exists.
         include.connect_to(once "plugin/c/plugin.h")
         include.put_string(automatically_generated_c_file)
         source.connect_to(once "plugin/c/plugin.c")
         source.put_string(automatically_generated_c_file)
         --source.put_string("#include %"plugin.h%"")
         source.put_line("#ifndef " + preprocessor_label + "%N%
         %#   define " + preprocessor_label)
      ensure
         include.is_connected
         source.is_connected
      end

   close_plugin_files
      do
         source.put_line("#endif")
         source.disconnect
         include.disconnect
      end

   print_usage
      do
         std_error.put_line(once "[
            Usage: wrappers-generator [--verbose|-v] [--local] [--global] [--directory dir] output.gcc-xml filenames...

            Option summary:

            Information:
              -h -help            Display this help information
              -V -version         Display Liberty Eiffel version information
              -v -verbose         Display detailed information about what the program is
                                   doing

            C features selection:
              -local              Produce functions, structures and enumeration classes
                                   only for the given files. Otherwise all the necessary
                                   files will be created. This is the default. Only the
                                   last global and local flag will be considered.
              -global             Emits wrappers for every feature found in the XML file.
                                   For usual wrappers it is normally not needed. Only the
                                   last global and local flag will be considered.

            Enumerations as flags:
              -flags <file>       Read a list of enumerations that will be forcefully
                                   wrapped as a flag. In fact sometimes there is no way to
                                   distinguish when an enumeration is used as-it-is or to
                                   contain flags. If this option is not given the program
                                   will use the "flags" file if present.

            Eiffel header comments:
              -descriptions <file>
                                  Apply the descriptions found in <file>. Each line
                                   contains the description of a class or of a class'
                                   feature. The syntax for a class description is
                                   `CLASS description', for a feature description
                                   `CLASS.feature description'. Trailing and leading
                                   spaces are trimmed from each line. If this option is
                                   not given the program will use the "descriptions" file
                                   if present.

            Typedefs:
              -standard-typedefs <CLASS_NAME>
                                  Use <CLASS_NAME> as the class containing the wrappers
                                  for defined typedefs. If not given the default
                                  "STANDARD_C_LIBRARY_TYPES" will be used.
              -emit-standard-typedefs
                                  Emit dummy queries useful for anchored declarations
                                   (i.e. "like long") for C types that can have different
                                   sizes on different architectures and for the typedefs
                                   defined in the C99 standard.  If this flag is not given
                                   the class containing the defined typedefs will insert
                                   the CLASS_NAME defined with "-standard-typedefs"
                                   option.

            Symbol selection:
              -moved <file>       Read from <file> a list of functions with the Liberty
                                   class they wrapped in; sometimes function declarations
                                   aren't made in a public header but in hidden places,
                                   i.e. memcpy. If this option is not given the program
                                   will use the "moved" file if present.
              -avoided <file>     Do not wrap the symbols found in <file>. If this option
                                   is not given the program will use the "avoided" file if
                                   present.

            The basename of the provided XML file made by gccxml will be used as prefix
            for the typedef class and preprocessor symbol.
         ]")
         die_with_code(exit_success_code)
      end

end -- class WRAPPERS_GENERATOR
-- class WRAPPER_GENERATOR
-- Copyright (C) 2008-2016: Paolo Redaelli
-- wrappers-generator  is free software: you can redistribute it and/or modify it
-- under the terms of the GNU General Public License as publhed by the Free
-- Software Foundation, either version 2 of the License, or (at your option)
-- any later version.
-- wrappers-generator is distributed in the hope that it will be useful, but
-- WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
-- more details.
-- You should have received a copy of the GNU General Public License along with
-- th program.  If not, see <http://www.gnu.org/licenses/>.
