All the functions/sections from installer.nsi are fully working.  the GetFileProductVersion function will be used in order to get the specific documentation for every Liberty Eiffel version (It is not used now due to the site's structure). 
Please note that the ProductVersion (row 19) will need to be changed accordingly for every version.

The resulting application can be found at https://drive.google.com/open?id=0BzWWQWj9idKcRWdpRnN3ejRpcG8 .

Use MakeNSISW to compile installer.nsi.
In order to install NSIS visit http://prdownloads.sourceforge.net/nsis/nsis-3.0-setup.exe?download .

In installer.nsi, at row 7 change "Insert directory here" with the location where you want to compile installer.nsi.
E.g. "C:\Program Files\Liberty" (don't use backslash after the last directory in hierarchy)

