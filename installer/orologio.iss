; Εγκατάσταση «Ωρολόγιο Σχολείου» (Inno Setup 6). Χτίζεται στο GitHub Actions:
;   iscc /DAppVersion=0.5.0 /DSourceDir=..\dist\Orologio_Dimotikou installer\orologio.iss
#ifndef AppVersion
  #define AppVersion "0.0.0"
#endif
#ifndef Arch
  #define Arch "x64"
#endif
#ifndef SourceDir
  #define SourceDir "..\dist\Orologio_Dimotikou"
#endif

[Setup]
AppId={{6C1E0B5A-3F7D-4C49-9E2B-0B7A8D2E5F41}
AppName=Ωρολόγιο Σχολείου
AppVersion={#AppVersion}
AppVerName=Ωρολόγιο Σχολείου {#AppVersion}
AppPublisher=Σταμάτης Κοκολόγος (22ο Δημ. Σχ. Λαμίας)
AppPublisherURL=https://github.com/stam1966/orologio-sxoleiou
AppSupportURL=https://github.com/stam1966/orologio-sxoleiou/issues
AppUpdatesURL=https://github.com/stam1966/orologio-sxoleiou/releases
DefaultDirName={localappdata}\Programs\OrologioDimotikou
DefaultGroupName=Ωρολόγιο Σχολείου
DisableProgramGroupPage=yes
UsePreviousGroup=no
DisableDirPage=auto
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog
OutputDir=..\dist
#if Arch == "x86"
OutputBaseFilename=Orologio_Dimotikou_Setup_x86_{#AppVersion}
#else
OutputBaseFilename=Orologio_Dimotikou_Setup_{#AppVersion}
#endif
SetupIconFile=..\src\app.ico
UninstallDisplayIcon={app}\src\app.ico
UninstallDisplayName=Ωρολόγιο Σχολείου
Compression=lzma2/max
SolidCompression=yes
WizardStyle=modern
#if Arch == "x64"
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
#endif
MinVersion=10.0
CloseApplications=force
RestartApplications=no

[Languages]
#ifexist AddBackslash(SourcePath) + "Greek.isl"
Name: "el"; MessagesFile: "{#SourcePath}\Greek.isl"
#else
Name: "el"; MessagesFile: "compiler:Default.isl"
#endif

[Tasks]
Name: "desktopicon"; Description: "Εικονίδιο στην επιφάνεια εργασίας"; GroupDescription: "Εικονίδια:"

[Files]
Source: "{#SourceDir}\*"; DestDir: "{app}"; Excludes: "data\*,ΕΓΚΑΤΑΣΤΑΣΗ.cmd,ΑΠΕΓΚΑΤΑΣΤΑΣΗ.cmd,SYNTOMEFSI.cmd"; Flags: ignoreversion recursesubdirs createallsubdirs

[Dirs]
; Τα δεδομένα του σχολείου: δεν διαγράφονται ποτέ από την απεγκατάσταση
Name: "{app}\data"; Flags: uninsneveruninstall

[Icons]
Name: "{group}\Ωρολόγιο Σχολείου"; Filename: "{app}\runtime\pythonw.exe"; Parameters: "-X utf8 ""{app}\src\server.py"""; WorkingDir: "{app}"; IconFilename: "{app}\src\app.ico"
Name: "{group}\Ωρολόγιο Σχολείου (διάγνωση προβλημάτων)"; Filename: "{app}\START_KONSOLA.cmd"; WorkingDir: "{app}"; IconFilename: "{app}\src\app.ico"
Name: "{autodesktop}\Ωρολόγιο Σχολείου"; Filename: "{app}\runtime\pythonw.exe"; Parameters: "-X utf8 ""{app}\src\server.py"""; WorkingDir: "{app}"; IconFilename: "{app}\src\app.ico"; Tasks: desktopicon

[InstallDelete]
; παλιό όνομα της εφαρμογής (έως 0.22): αφαιρούνται οι παλιές συντομεύσεις
Type: files; Name: "{autodesktop}\Ωρολόγιο Δημοτικού.lnk"
Type: filesandordirs; Name: "{autoprograms}\Ωρολόγιο Δημοτικού"

[Run]
Filename: "{app}\runtime\pythonw.exe"; Parameters: "-X utf8 ""{app}\src\server.py"""; WorkingDir: "{app}"; Description: "Άνοιγμα της εφαρμογής"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: filesandordirs; Name: "{app}\src\__pycache__"
Type: filesandordirs; Name: "{app}\runtime"
Type: filesandordirs; Name: "{app}\src"
Type: filesandordirs; Name: "{app}\tests"

[Messages]
el.FinishedLabel=Η εγκατάσταση ολοκληρώθηκε. Η εφαρμογή ανοίγει από το εικονίδιο «Ωρολόγιο Σχολείου». Τα δεδομένα σας φυλάσσονται στον φάκελο «data» και διατηρούνται σε ενημερώσεις και απεγκατάσταση.
