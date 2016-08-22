;Use MakeNSISW to compile this script
;For add files use "File <somefile>" in Section of this script
 
;-----------------------------------
;General

  !define directoryPath "Insert directory here"
  BrandingText "Liberty Eiffel Bell version"
  RequestExecutionLevel admin
  ;Name and file
  Name "Liberty Eiffel"
  OutFile "install.exe"
  ;Add version information
  !define _VERSION "1.0.0.7"
  VIProductVersion "${_VERSION}"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "Liberty Eiffel"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "${_VERSION}"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "InternalName" "install.exe"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductVersion" "bell"
  ;Change the default Modern UI icons
  !define MUI_ICON "${directoryPath}\photos\install.ico"
  !define MUI_UNICON "${directoryPath}\photos\win-uninstall.ico"
 
  ;Default installation folder
  InstallDir "$PROGRAMFILES\$(^Name)"
  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\$(^Name)" ""
  ;Define uninstaller name
  !define UninstName "uninstall"

;--------------------------------
;Header Files
  
  ;default headers
  !include "sections.nsh"
  !include "LogicLib.nsh"
  !include "MUI2.nsh"

 
;--------------------------------
;Interface Settings
 
  !define MUI_ABORTWARNING
  ;!define MUI_FINISHPAGE_NOAUTOCLOSE

  ;defining the image used in both the welcome page from the installer and the uninstaller
  !define MUI_WELCOMEFINISHPAGE_BITMAP "${directoryPath}\photos\win2.bmp"
  !define MUI_UNWELCOMEFINISHPAGE_BITMAP "${directoryPath}\photos\win2.bmp"

  ;defining the link to Liberty Eiffel's homepage for the finish page, after the installation is completed. 
  !define MUI_FINISHPAGE_LINK " Visit us"
  !define MUI_FINISHPAGE_LINK_LOCATION "http://www.liberty-eiffel.org/"
  
  ;installation  details are hidden by default, but pressing the 'view' button will pop a window with the details.
  ShowInstDetails hide

  ;uninstallation details are shown by default.f
  ShowUninstDetails show
 
;--------------------------------
;Language Selection Dialog Settings
 
  ;Remember the installer language and select it by default
  ;(should be set before installation page)
  !define MUI_LANGDLL_REGISTRY_ROOT "HKCU" 
  !define MUI_LANGDLL_REGISTRY_KEY "Software\$(^Name)" 
  !define MUI_LANGDLL_REGISTRY_VALUENAME "Installer Language"
  ;Always show the language selection dialog (override the stored value)
  !define MUI_LANGDLL_ALWAYSSHOW
 
  ;Don't filter languages according to their codepage
  ;!define MUI_LANGDLL_ALLLANGUAGES
 
;--------------------------------
;Macros

;Launches a shortcut at the end of the install/uninstall process to the finish page. 
!macro MUI_FINISHPAGE_SHORTCUT
 
  !ifndef MUI_FINISHPAGE_NOREBOOTSUPPORT
    !define MUI_FINISHPAGE_NOREBOOTSUPPORT
    !ifdef MUI_FINISHPAGE_RUN
      !undef MUI_FINISHPAGE_RUN
    !endif
  !endif
  !define MUI_PAGE_CUSTOMFUNCTION_SHOW DisableCancelButton
  !insertmacro MUI_PAGE_FINISH
  !define MUI_PAGE_CUSTOMFUNCTION_SHOW DisableBackButton
 
  Function DisableCancelButton
 
    EnableWindow $mui.Button.Cancel 0
 
  FunctionEnd
 
  Function DisableBackButton
 
    EnableWindow $mui.Button.Back 0
 
  FunctionEnd
 
!macroend
 

!include "FileFunc.nsh"

;Extracting details 
!macro Extract7z Label Archive Part
 
  ${GetFileName} "${Archive}" $0
  DetailPrint "$(Extract) $0... ${Part}"
  Nsis7z::ExtractWithDetails "${Archive}" "$(Extract) $0... %s"	
 
!macroend

;--------------------------------
;Pages

  ;Installer pages
  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "${directoryPath}\License.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH
  
  ;Uninstaller pages
  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH
 
;--------------------------------
;Language Include
 
  !insertmacro MUI_LANGUAGE "English"


;--------------------------------
;Language Strings
 
  !define UNINST_LOCALIZE
 
  LangString UNINST_EXCLUDE_ERROR ${LANG_ENGLISH} "Error creating an exclusion list."
  LangString UNINST_DATA_ERROR ${LANG_ENGLISH} "Error creating the uninstaller data: $\r$\nCannot find an exclusion list."
  LangString UNINST_DAT_NOT_FOUND ${LANG_ENGLISH} "$UNINST_DAT not found, unable to perform uninstall. Manually delete files."
  LangString UNINST_DAT_MISSING ${LANG_ENGLISH} "$UNINST_DAT is missing, some elements could not be removed. These can be removed manually."
  LangString UNINST_DEL_FILE ${LANG_ENGLISH} "Delete File"
 
  LangString Uninstall ${LANG_ENGLISH} "Uninstall"
  LangString NextCD ${LANG_ENGLISH} "Please insert the disk labeled"
  LangString CDNotFound ${LANG_ENGLISH} "Can not find the file $0.$\r$\nPlease insert the correct disk."
  LangString Extract ${LANG_ENGLISH} "Decompression:"
  LangString REMOVEALL ${LANG_ENGLISH} "Remove all files and folders from '$INSTDIR'?"
  LangString UNCOMPLATE ${LANG_ENGLISH} "$(^Name) uninstall complete."


;---------------------------------
!define Environ 'HKCU "Environment"'

;Custom function used for AddtoPath

; StrStr - find substring in a string
;
; Usage:
;   Push "this is some string"
;   Push "some"
;   Call StrStr
;   Pop $0 ; "some string"
	
!macro StrStr un
Function ${un}StrStr
  Exch $R1 ; $R1=substring, stack=[old$R1,string,...]
  Exch     ;                stack=[string,old$R1,...]
  Exch $R2 ; $R2=string,    stack=[old$R2,old$R1,...]
  Push $R3
  Push $R4
  Push $R5
  StrLen $R3 $R1
  StrCpy $R4 0
  ; $R1=substring, $R2=string, $R3=strlen(substring)
  ; $R4=count, $R5=tmp
  loop:
    StrCpy $R5 $R2 $R3 $R4
    StrCmp $R5 $R1 done
    StrCmp $R5 "" done
    IntOp $R4 $R4 + 1
    Goto loop
  done:
    StrCpy $R1 $R2 "" $R4
    Pop $R5
    Pop $R4
	  Pop $R3
	  Pop $R2
	  Exch $R1 ; $R1=old$R1, stack=[result,...]
FunctionEnd
	!macroend
	!insertmacro StrStr ""
	!insertmacro StrStr "un."

;--------------------------------
;Sections

 
 ;------------
 ;Liberty Eiffel 
 Section "Liberty Eiffel" Sec1
  SectionIn 1 2 RO
  SetDetailsPrint listonly
  SetOutPath "$INSTDIR"
  File /r "${directoryPath}\liberty\*"
  Push "$INSTDIR\bin"
  Call AddToPath
  Call AddLibertyConfigFile
  WriteUninstaller "$INSTDIR\uninstall.exe"
 SectionEnd
 ;------------

 ;------------
 ;MinGW
 Section /o "MinGW" Sec2
  SetDetailsPrint none
  SetOutPath "$INSTDIR"
  File "${directoryPath}\liberty\mingw-w64-install.exe"
  ExecWait "$INSTDIR\mingw-w64-install.exe"
 SectionEnd
 ;------------

 ;------------
 ;Doc
  Section /o "Documentation" Sec3
  Push "$ExePath\install.exe" ; Read our own version information in this example
  Call GetFileProductVersion
  AddSize 146432
  Pop $0 ; $0 represents the version of Liberty Eiffel, and will be used to download specific documentation.For the moment the website's hyperlinks do not have the
         ; required structure(for using the GetFileProductVersion function).
  INetC::get "http://doc.liberty-eiffel.org/files/smarteiffel.tgz" "$INSTDIR\smarteiffel.tgz" /END
  SectionEnd
 ;------------

 ;------------
 ;Write registers
 Section  
  CreateShortCut "$SMPROGRAMS\$StartMenuFolder\$(Uninstall).lnk" "$INSTDIR\uninstall.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Liberty" \
                 "DisplayName" "Liberty Eiffel Compiler"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Liberty" \               
                 "DisplayIcon" "${directoryPath}\photos\install.ico"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Liberty" \
                 "UninstallString" "$INSTDIR\uninstall.exe"
 SectionEnd
 ;------------

 ;------------
 Section "Uninstall"
  SetDetailsPrint none
  RMDir  /r /REBOOTOK $INSTDIR
  Delete $PROFILE\liberty.cfg
  System::Call 'shell32::SHGetSpecialFolderPath(i $HWNDPARENT, t .r1, i 0x23, i0)i.r0'
  Delete $1\liberty.cfg
  Push "$INSTDIR\bin"
  Call un.RemoveFromPath
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Liberty"
 SectionEnd
 ;------------
;--------------------------------
;Descriptions
 
  ;Language strings
  LangString DESC_Sec1 ${LANG_ENGLISH} "Contains the compiler, libraries and tools."
  LangString DESC_Sec2 ${LANG_ENGLISH} "In order for all Liberty Eifell features to work , MinGW must be installed." 
  LangString DESC_Sec3 ${LANG_ENGLISH} "The offline Documentation for Liberty Eiffel" 
  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${Sec1} $(DESC_Sec1)
    !insertmacro MUI_DESCRIPTION_TEXT ${Sec2} $(DESC_Sec2)
    !insertmacro MUI_DESCRIPTION_TEXT ${Sec3} $(DESC_Sec3)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END
;--------------------------------

;--------------------------------
;Install functions

 ;------------
 ;Gets the installer's product version in order to install the desired doc files from the website

Function GetFileProductVersion
  System::Store S
  pop $3
  push "" ;failed ret
  System::Call 'version::GetFileVersionInfoSize(t"$3",i.r2)i.r0'
  ${If} $0 <> 0
      System::Alloc $0
      System::Call 'version::GetFileVersionInfo(t"$3",ir2,ir0,isr1)i.r0 ? e'
      pop $2
      ${If} $0 <> 0
      ${AndIf} $2 = 0 ;a user comment on MSDN said you should check GLE to avoid crash
          System::Call 'version::VerQueryValue(i r1,t "\VarFileInfo\Translation",*i0r2,*i0)i.r0'
          ${If} $0 <> 0
              System::Call '*$2(&i2.r2,&i2.r3)'
              IntFmt $2 %04x $2
              IntFmt $3 %04x $3
             System::Call 'version::VerQueryValue(i r1,t "\StringFileInfo\$2$3\ProductVersion",*i0r2,*i0r3)i.r0'
              ${If} $0 <> 0
                  pop $0
                  System::Call *$2(&t$3.s)
              ${EndIf}
          ${EndIf}
      ${EndIf}
    System::Free $1
  ${EndIf}
  System::Store L
FunctionEnd
 ;------------

 ;------------
 ;Adds the the folder which contains Liberty Eiffel's binaries to the user's environment path
Function AddToPath
  Exch $0
  Push $1
  Push $2
  Push $3
  Push $4
	
  ; NSIS ReadRegStr returns empty string on string overflow
  ; Native calls are used here to check actual length of PATH
  ; $4 = RegOpenKey(HKEY_CURRENT_USER, "Environment", &$3)
  System::Call "advapi32::RegOpenKey(i 0x80000001, t'Environment', *i.r3) i.r4"
  IntCmp $4 0 0 done done
  ; $4 = RegQueryValueEx($3, "PATH", (DWORD*)0, (DWORD*)0, &$1, ($2=NSIS_MAX_STRLEN, &$2))
  ; RegCloseKey($3)
  System::Call "advapi32::RegQueryValueEx(i $3, t'PATH', i 0, i 0, t.r1, *i ${NSIS_MAX_STRLEN} r2) i.r4"
  System::Call "advapi32::RegCloseKey(i $3)"
	
  IntCmp $4 234 0 +4 +4 ; $4 == ERROR_MORE_DATA
    DetailPrint "AddToPath: original length $2 > ${NSIS_MAX_STRLEN}"
    MessageBox MB_OK "PATH not updated, original length $2 > ${NSIS_MAX_STRLEN}"
    Goto done
	
  IntCmp $4 0 +5 ; $4 != NO_ERROR
    IntCmp $4 2 +3 ; $4 != ERROR_FILE_NOT_FOUND
      DetailPrint "AddToPath: unexpected error code $4"
      Goto done
    StrCpy $1 ""
	
  ; Check if already in PATH
  Push "$1;"
  Push "$0;"
  Call StrStr
  Pop $2
  StrCmp $2 "" 0 done
  Push "$1;"
  Push "$0\;"
  Call StrStr
  Pop $2
  StrCmp $2 "" 0 done
	
  ; Prevent NSIS string overflow
  StrLen $2 $0
  StrLen $3 $1
  IntOp $2 $2 + $3
  IntOp $2 $2 + 2 ; $2 = strlen(dir) + strlen(PATH) + sizeof(";")
  IntCmp $2 ${NSIS_MAX_STRLEN} +4 +4 0
    DetailPrint "AddToPath: new length $2 > ${NSIS_MAX_STRLEN}"
    MessageBox MB_OK "PATH not updated, new length $2 > ${NSIS_MAX_STRLEN}."
    Goto done
	
  ; Append dir to PATH
  DetailPrint "Add to PATH: $0"
  StrCpy $2 $1 1 -1
  StrCmp $2 ";" 0 +2
    StrCpy $1 $1 -1 ; remove trailing ';'
  StrCmp $1 "" +2   ; no leading ';'
    StrCpy $0 "$1;$0"
  WriteRegExpandStr ${Environ} "PATH" $0
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000
	
  done:
  Pop $4
  Pop $3
  Pop $2
  Pop $1
  Pop $0
 FunctionEnd
 ;------------

 ;------------
 ;Uses a cmd file to create and store the configuration file in %USERSPROFILE% and %ALLUSERSPROFILE%. The cmd file is later on uninstalled from the user's machine
 Function AddLibertyConfigFile
  ExpandEnvStrings $0 %COMSPEC%
  ExecWait '"$0" /C "$INSTDIR\set_path.cmd"'
  Delete $INSTDIR\set_path.cmd 
 FunctionEnd
 ;------------

 ;------------
 Function .onGUIEnd
  
  ;Store installation folder in registry
  WriteRegStr HKCU "Software\$(^Name)" "" $INSTDIR
 
  ;Escape from $PLUGINSDIR to completely remove it
  SetOutPath "$INSTDIR"
FunctionEnd
;------------

;--------------------------------
;Uninstall Functions

 ;--------------
 ;Removes the environment variable created for the user's account
 Function un.RemoveFromPath
  Exch $0
  Push $1
  Push $2
  Push $3
  Push $4
  Push $5
  Push $6
	
  ReadRegStr $1 ${Environ} "PATH"
  StrCpy $5 $1 1 -1
  StrCmp $5 ";" +2
  StrCpy $1 "$1;" ; ensure trailing ';'
  Push $1
  Push "$0;"
  Call un.StrStr
  Pop $2 ; pos of our dir
  StrCmp $2 "" done
	
  DetailPrint "Remove from PATH: $0"
  StrLen $3 "$0;"
  StrLen $4 $2
  StrCpy $5 $1 -$4 ; $5 is now the part before the path to remove
  StrCpy $6 $2 "" $3 ; $6 is now the part after the path to remove
  StrCpy $3 "$5$6"
  StrCpy $5 $3 1 -1
  StrCmp $5 ";" 0 +2
  StrCpy $3 $3 -1 ; remove trailing ';'
  WriteRegExpandStr ${Environ} "PATH" $3
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000
	
  done:
  Pop $6
  Pop $5
  Pop $4
  Pop $3
  Pop $2
  Pop $1
  Pop $0
 FunctionEnd
 ;--------------

 ;--------------
 ;Creates a message box that announces that the installing process was succesfully done
 Function un.onUninstSuccess
 
  MessageBox MB_OK|MB_ICONINFORMATION "$(UNCOMPLATE)" /SD IDOK
 FunctionEnd
 ;--------------- 
;--------------------------------
