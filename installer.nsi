;Use MakeNSISW to compile this script
;For add files use "File <somefile>" in Section of this script
 
;-----------------------------------
;General
 
  ;Name and file
  Name "Liberty Eiffel"
  OutFile "install.exe"


  ;Change the default Modern UI icons
  !define MUI_ICON "C:\Users\petroo\Desktop\proj\photos\install.ico"
  !define MUI_UNICON "C:\Users\petroo\Desktop\proj\photos\win-uninstall.ico"
 
  ;Default installation folder
  InstallDir "$PROGRAMFILES\$(^Name)"
  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\$(^Name)" ""
  ;Define uninstaller name
  !define UninstName "uninstall"
 
;--------------------------------
;Header Files
  !include "UninstallLog.nsh"
  !include "C:\Users\petroo\Desktop\proj\MUI2.nsh"
  ;!include "UnInst.nsh"
  ;!include "zipdll.nsh"
 
 
;--------------------------------
;Interface Settings
 
  !define MUI_ABORTWARNING
  ;!define MUI_FINISHPAGE_NOAUTOCLOSE
 
  !define MUI_WELCOMEFINISHPAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Wizard\win.bmp"
  !define MUI_UNWELCOMEFINISHPAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Wizard\win.bmp"
 
  ;!define MUI_HEADERIMAGE
  ;!define MUI_HEADERIMAGE_RIGHT
  ;!define MUI_HEADERIMAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Header\nsis.bmp"
 
  ;!define MUI_FINISHPAGE_RUN_NOTCHECKED
 
  !define MUI_FINISHPAGE_LINK " Visit us at liberty-eiffel.org"
  !define MUI_FINISHPAGE_LINK_LOCATION "http://www.liberty-eiffel.org/"
 
  ShowInstDetails nevershow
  ShowUninstDetails nevershow
 
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
 
!macro Extract7z Label Archive Part
 
  ${GetFileName} "${Archive}" $0
  DetailPrint "$(Extract) $0... ${Part}"
  Nsis7z::ExtractWithDetails "${Archive}" "$(Extract) $0... %s"
 
!macroend

 
;--------------------------------
;Pages
 
  !insertmacro MUI_PAGE_WELCOME
 
  !insertmacro MUI_PAGE_LICENSE "${NSISDIR}\Docs\Modern UI\License.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
 

  !insertmacro MUI_PAGE_INSTFILES
 
  !define MUI_PAGE_CUSTOMFUNCTION_PRE Done
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
;Reserve Files
 
  ;If you are using solid compression this will make installer start faster
  ;!insertmacro MUI_RESERVEFILE_LANGDLL
 
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
;Liberty Eiffel Section
;---------------------------------
!include "EnvVarUpdate.nsh"

Section "Liberty Eiffel" Sec1
  SectionIn 1 2 RO
  SetDetailsPrint none
  SetOutPath "$INSTDIR"
  File /r "C:\Users\petroo\Desktop\proj\liberty\"
  ${EnvVarUpdate} $0 "PATH" "A" "HKLM" "$INSTDIR\bin"
  WriteUninstaller "$INSTDIR\uninstall.exe"
SectionEnd
;--------------------------------
; MinGW
;--------------------------------

Section /o "MinGW" Sec2
  SetDetailsPrint none
  SetOutPath "C:\mingw"
  File /r "C:\mingw32\"
  ${EnvVarUpdate} $0 "PATH" "A" "HKLM" "C:\mingw\bin"
SectionEnd

Section "Uninstall"

  SetDetailsPrint none
  RMDir  /r /REBOOTOK $INSTDIR
  ${un.EnvVarUpdate} $0 "PATH" "R" "HKLM" "$INSTDIR\bin"
  Delete $PROFILE\liberty.cfg
  System::Call 'shell32::SHGetSpecialFolderPath(i $HWNDPARENT, t .r1, i 0x23, i0)i.r0'
  Delete $1\liberty.cfg


SectionEnd

;--------------------------------
;Descriptions
 
  ;Language strings
  LangString DESC_Sec1 ${LANG_ENGLISH} "Contains the compiler, libraries and tools."
 
  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${Sec1} $(DESC_Sec1)
    !insertmacro MUI_DESCRIPTION_TEXT ${Sec2} "MinGW will be installed in C:\ ,be sure to have at least 410mb of free space."
  !insertmacro MUI_FUNCTION_DESCRIPTION_END


 Function Done
  ExpandEnvStrings $0 %COMSPEC%
  ExecWait '"$0" /C "$INSTDIR\set_path.cmd"'
  Delete $INSTDIR\set_path.cmd
 
 FunctionEnd

 
Function .onGUIEnd
  
  ;Store installation folder in registry
  WriteRegStr HKCU "Software\$(^Name)" "" $INSTDIR
 
  ;Escape from $PLUGINSDIR to completely remove it
  SetOutPath "$INSTDIR"
 
FunctionEnd
 
;--------------------------------
;Uninstaller Functions
 
Function un.onInit
 
  ;Get stored language preference
  !insertmacro MUI_UNGETLANGUAGE
 
FunctionEnd

Function un.onUninstSuccess
 
  MessageBox MB_OK|MB_ICONINFORMATION "$(UNCOMPLATE)" /SD IDOK
 
FunctionEnd

