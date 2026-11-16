; Εγκατάσταση της σουίτας «Σχολικές Εφαρμογές» (Ωρολόγιο Σχολείου + Εφημερίες Εκπαιδευτικών), Inno Setup 6.
; Περιέχει τα δύο κανονικά Setup και τα εκτελεί σιωπηλά· μόνη της γράφει τη ρύθμιση του υπολογιστή
; %APPDATA%\SchoolApps\suite.json (κοινός φάκελος, ρόλος) που διαβάζουν και οι δύο εφαρμογές.
;   iscc /DAppVersion=0.35.0 /DOroSetup=..\dist\Orologio_Dimotikou_Setup_0.35.0.exe /DEfSetup=..\dist\Efimeries_Setup_x64.exe installer\suite.iss
#ifndef AppVersion
  #define AppVersion "0.0.0"
#endif
#ifndef OroSetup
  #define OroSetup "..\dist\Orologio_Dimotikou_Setup.exe"
#endif
#ifndef OroSetup86
  #define OroSetup86 "..\dist\Orologio_Dimotikou_Setup_x86.exe"
#endif
#ifndef EfSetup86
  #define EfSetup86 "..\dist\Efimeries_Setup_x86.exe"
#endif
#ifndef EfSetup
  #define EfSetup "..\dist\Efimeries_Setup_x64.exe"
#endif

[Setup]
AppId={{2F8C6A41-7B3E-4D1A-9E55-6C0B2A9D7F13}
AppName=Σχολικές Εφαρμογές
AppVersion={#AppVersion}
AppVerName=Σχολικές Εφαρμογές {#AppVersion}
AppPublisher=Σταμάτης Κοκολόγος (22ο Δημ. Σχ. Λαμίας)
AppPublisherURL=https://github.com/stam1966/orologio-sxoleiou
; Εγκαθιστά μόνο το μικρό παράθυρο επιλογής «Σχολικές Εφαρμογές» (launcher.ps1)· οι δύο εφαρμογές έχουν δικές τους εγκαταστάσεις.
DefaultDirName={localappdata}\Programs\SchoolApps
DisableDirPage=yes
Uninstallable=yes
UninstallDisplayName=Σχολικές Εφαρμογές (παράθυρο επιλογής)
UninstallDisplayIcon={app}\app.ico
DisableProgramGroupPage=yes
DisableReadyPage=no
PrivilegesRequired=lowest
OutputDir=..\dist
OutputBaseFilename=Sxolikes_Efarmoges_Setup_{#AppVersion}
SetupIconFile=..\src\app.ico
Compression=lzma2/max
SolidCompression=yes
WizardStyle=modern
; Windows 64-bit και 32-bit: κάθε εφαρμογή εγκαθίσταται στην αρχιτεκτονική του υπολογιστή (το Ωρολόγιο 32-bit χωρίς αυτόματη δημιουργία προγράμματος).
MinVersion=10.0

[Languages]
#ifexist AddBackslash(SourcePath) + "Greek.isl"
Name: "el"; MessagesFile: "{#SourcePath}\Greek.isl"
#else
Name: "el"; MessagesFile: "compiler:Default.isl"
#endif

[Tasks]
Name: "desktopicon"; Description: "Εικονίδιο «Σχολικές Εφαρμογές» (επιλογή εφαρμογής) στην επιφάνεια εργασίας"; GroupDescription: "Εικονίδια:"
Name: "appicons"; Description: "Και χωριστά εικονίδια για το Ωρολόγιο και τις Εφημερίες"; GroupDescription: "Εικονίδια:"

[Files]
Source: "..\src\launcher.ps1"; DestDir: "{app}"; Flags: ignoreversion
Source: "school.png"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\src\app.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\src\netshare.ps1"; Flags: dontcopy
Source: "{#OroSetup}"; DestDir: "{tmp}"; DestName: "orologio_setup.exe"; Flags: deleteafterinstall; Check: IsWin64
Source: "{#EfSetup}"; DestDir: "{tmp}"; DestName: "efimeries_setup.exe"; Flags: deleteafterinstall; Check: IsWin64
Source: "{#OroSetup86}"; DestDir: "{tmp}"; DestName: "orologio_setup.exe"; Flags: deleteafterinstall; Check: not IsWin64
Source: "{#EfSetup86}"; DestDir: "{tmp}"; DestName: "efimeries_setup.exe"; Flags: deleteafterinstall; Check: not IsWin64

[Icons]
Name: "{autoprograms}\Σχολικές Εφαρμογές"; Filename: "{sys}\WindowsPowerShell\v1.0\powershell.exe"; Parameters: "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File ""{app}\launcher.ps1"""; WorkingDir: "{app}"; IconFilename: "{app}\app.ico"
Name: "{autodesktop}\Σχολικές Εφαρμογές"; Filename: "{sys}\WindowsPowerShell\v1.0\powershell.exe"; Parameters: "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File ""{app}\launcher.ps1"""; WorkingDir: "{app}"; IconFilename: "{app}\app.ico"; Tasks: desktopicon

[Run]
Filename: "{tmp}\orologio_setup.exe"; Parameters: "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART {code:TasksArg}"; StatusMsg: "Εγκατάσταση: Ωρολόγιο Σχολείου…"; Check: WantOrologio
Filename: "{tmp}\efimeries_setup.exe"; Parameters: "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART {code:TasksArg}"; StatusMsg: "Εγκατάσταση: Εφημερίες Εκπαιδευτικών…"; Check: WantEfimeries
Filename: "{sys}\WindowsPowerShell\v1.0\powershell.exe"; Parameters: "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File ""{app}\launcher.ps1"""; Description: "Άνοιγμα: Σχολικές Εφαρμογές"; Flags: nowait postinstall skipifsilent runhidden

[Messages]
el.FinishedLabel=Η εγκατάσταση ολοκληρώθηκε. Οι εφαρμογές ανοίγουν από τα εικονίδιά τους. Στην πρώτη εκκίνηση του υπολογιστή της Διεύθυνσης το Ωρολόγιο ζητά να ορίσετε (ή να πληκτρολογήσετε) το PIN της Διεύθυνσης.

[Code]
var
  AppsPage, UsePage, RolePage, NetPage: TInputOptionWizardPage;
  DirPage: TInputDirWizardPage;

function WNetGetConnection(lpLocalName: String; lpRemoteName: String; var lpnLength: DWORD): DWORD;
  external 'WNetGetConnectionW@mpr.dll stdcall';

{ Γράμμα δίσκου δικτύου (Z:\...) → \\ΥΠΟΛΟΓΙΣΤΗΣ\φάκελος\...: οι αντιστοιχισμένοι δίσκοι δεν υπάρχουν πάντα, η διαδρομή δικτύου ναι. }
function ToUnc(const P: String): String;
var
  Buf: String;
  N: DWORD;
  Z: Integer;
begin
  Result := P;
  if (Length(P) >= 2) and (P[2] = ':') then
  begin
    N := 1024;
    Buf := StringOfChar(#0, N);
    if WNetGetConnection(Copy(P, 1, 2), Buf, N) = 0 then
    begin
      Z := Pos(#0, Buf);
      if Z > 1 then
      begin
        Buf := RemoveBackslash(Copy(Buf, 1, Z - 1));
        if Length(P) > 3 then Result := Buf + '\' + Copy(P, 4, Length(P)) else Result := Buf;
      end;
    end;
  end;
end;

{ Τιμή κειμένου από το μικρό JSON του netshare.ps1 (π.χ. "unc":"\\\\PC\\Share") }
function JsonValue(const J, Key: String): String;
var
  I: Integer;
begin
  Result := '';
  I := Pos('"' + Key + '":"', J);
  if I = 0 then Exit;
  Result := Copy(J, I + Length(Key) + 4, Length(J));
  I := Pos('"', Result);
  if I > 0 then Result := Copy(Result, 1, I - 1);
  StringChangeEx(Result, '\\', '\', True);
end;

function IsUncPath(const P: String): Boolean;
begin
  Result := Copy(P, 1, 2) = '\\';
end;

function Hex4(N: Integer): String;
var
  Digits: String;
begin
  Digits := '0123456789abcdef';
  Result := Digits[((N shr 12) and 15) + 1] + Digits[((N shr 8) and 15) + 1] +
            Digits[((N shr 4) and 15) + 1] + Digits[(N and 15) + 1];
end;

{ JSON μόνο με ASCII: οι ελληνικοί χαρακτήρες γράφονται ως \uXXXX }
function JsonEscape(const S: String): String;
var
  I: Integer;
  C: Char;
begin
  Result := '';
  for I := 1 to Length(S) do
  begin
    C := S[I];
    if C = '\' then
      Result := Result + '\\'
    else if C = '"' then
      Result := Result + '\"'
    else if Ord(C) > 126 then
      Result := Result + '\u' + Hex4(Ord(C))
    else
      Result := Result + C;
  end;
end;

function WantOrologio(): Boolean;
begin
  Result := AppsPage.Values[0];
end;

function WantEfimeries(): Boolean;
begin
  Result := AppsPage.Values[1];
end;

function TasksArg(Param: String): String;
begin
  if WizardIsTaskSelected('appicons') then
    Result := '/TASKS="desktopicon"'
  else
    Result := '/TASKS=""';
end;

function Shared(): Boolean;
begin
  Result := not UsePage.Values[0];
end;

{ Ο φάκελος της σουίτας: νέος → <επιλογή>\Σχολικές Εφαρμογές· σύνδεση → ο φάκελος που έχει «Κοινά»
  (ή ο γονικός του, αν δείξατε τον φάκελο που τον περιέχει). }
function SuiteRoot(): String;
var
  D: String;
begin
  D := RemoveBackslash(DirPage.Values[0]);
  if DirExists(D + '\Κοινά') then
    Result := D
  else if DirExists(D + '\Σχολικές Εφαρμογές\Κοινά') then
    Result := D + '\Σχολικές Εφαρμογές'
  else if UsePage.Values[1] then
    Result := D + '\Σχολικές Εφαρμογές'
  else
    Result := '';
end;

procedure InitializeWizard;
begin
  AppsPage := CreateInputOptionPage(wpWelcome, 'Εφαρμογές', 'Ποιες εφαρμογές θα εγκατασταθούν;',
    'Μπορείτε να προσθέσετε την άλλη εφαρμογή αργότερα, ξανατρέχοντας αυτή την εγκατάσταση.', False, False);
  if IsWin64 then
    AppsPage.Add('Ωρολόγιο Σχολείου (ωρολόγιο πρόγραμμα, αναπληρώσεις, έντυπα Διεύθυνσης)')
  else
    AppsPage.Add('Ωρολόγιο Σχολείου (Windows 32-bit: αναπληρώσεις, εκτυπώσεις, έντυπα — χωρίς αυτόματη δημιουργία προγράμματος)');
  AppsPage.Add('Εφημερίες Εκπαιδευτικών');
  AppsPage.Values[0] := True;
  AppsPage.Values[1] := True;

  UsePage := CreateInputOptionPage(AppsPage.ID, 'Χρήση από άλλο υπολογιστή', 'Θα χρησιμοποιηθούν οι εφαρμογές και από άλλο υπολογιστή;',
    'Για δύο υπολογιστές (π.χ. Διευθυντής και Υποδιευθυντής) τα δεδομένα μπαίνουν σε κοινό φάκελο που βλέπουν και οι δύο ' +
    '(κοινόχρηστος φάκελος του σχολείου, NAS ή φάκελος του ενός υπολογιστή σε κοινή χρήση).', True, False);
  UsePage.Add('Όχι, μόνο αυτός ο υπολογιστής');
  UsePage.Add('Ναι — αυτός είναι ο ΠΡΩΤΟΣ υπολογιστής: δημιουργία κοινού φακέλου');
  UsePage.Add('Ναι — σύνδεση σε κοινό φάκελο που δημιουργήθηκε ήδη στον πρώτο υπολογιστή');
  UsePage.SelectedValueIndex := 0;

  DirPage := CreateInputDirPage(UsePage.ID, 'Κοινός φάκελος', 'Πού βρίσκεται ο κοινός φάκελος;',
    'Πρώτος υπολογιστής: διαλέξτε πού θα δημιουργηθεί ο φάκελος «Σχολικές Εφαρμογές». ' +
    'Δεύτερος υπολογιστής: δείξτε τον φάκελο «Σχολικές Εφαρμογές» του πρώτου (π.χ. \\ΥΠΟΛΟΓΙΣΤΗΣ\Κοινά\Σχολικές Εφαρμογές).',
    False, 'Νέος φάκελος');
  DirPage.Add('');
  DirPage.Values[0] := ExpandConstant('{userdocs}');

  NetPage := CreateInputOptionPage(DirPage.ID, 'Δίκτυο', 'Θα βλέπει ο δεύτερος υπολογιστής τον φάκελο;',
    'Αν ο κοινός φάκελος είναι σε ΑΥΤΟΝ τον υπολογιστή, πρέπει να γίνει κοινόχρηστος στο δίκτυο. ' +
    'Τα Windows θα ζητήσουν έγκριση διαχειριστή. Στο τέλος θα δείτε τη διαδρομή που δίνετε στον δεύτερο υπολογιστή ' +
    '(γράφεται και σε αρχείο στην επιφάνεια εργασίας).', False, False);
  NetPage.Add('Κοινή χρήση του φακέλου στο δίκτυο (συνιστάται)');
  NetPage.Values[0] := True;

  RolePage := CreateInputOptionPage(NetPage.ID, 'Ρόλος του υπολογιστή', 'Ποιος χρησιμοποιεί αυτόν τον υπολογιστή;',
    'Ο ρόλος αλλάζει αργότερα από το Ωρολόγιο (Ρυθμίσεις εφαρμογής → Κοινή χρήση) μόνο με το PIN της Διεύθυνσης.', True, False);
  RolePage.Add('Διεύθυνση — αλλάζει το ωρολόγιο πρόγραμμα (στην πρώτη εκκίνηση ορίζετε ή δίνετε το PIN)');
  RolePage.Add('Υποδιευθυντής — βλέπει το πρόγραμμα, δηλώνει απουσίες και κάνει τις καλύψεις· εφημερίες πλήρως');
  RolePage.SelectedValueIndex := 0;
end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result := False;
  if (PageID = DirPage.ID) or (PageID = RolePage.ID) then
    Result := not Shared();
  if PageID = NetPage.ID then
    Result := (not UsePage.Values[1]) or IsUncPath(DirPage.Values[0]);
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  if CurPageID = RolePage.ID then
  begin
    if UsePage.Values[1] then RolePage.SelectedValueIndex := 0 else RolePage.SelectedValueIndex := 1;
  end;
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result := True;
  if (CurPageID = AppsPage.ID) and (not AppsPage.Values[0]) and (not AppsPage.Values[1]) then
  begin
    MsgBox('Επιλέξτε τουλάχιστον μία εφαρμογή.', mbError, MB_OK);
    Result := False;
  end;
  if (CurPageID = DirPage.ID) and UsePage.Values[2] then
    DirPage.Values[0] := ToUnc(RemoveBackslash(DirPage.Values[0]));
  if (CurPageID = DirPage.ID) and UsePage.Values[2] and (not DirExists(RemoveBackslash(DirPage.Values[0]))) then
  begin
    MsgBox('Ο φάκελος «' + DirPage.Values[0] + '» δεν είναι προσβάσιμος από αυτόν τον υπολογιστή.' + #13#10#13#10 +
           '• Βεβαιωθείτε ότι ο πρώτος υπολογιστής είναι ανοιχτός και ότι ο φάκελος είναι κοινόχρηστος (στο Setup του πρώτου: «Κοινή χρήση του φακέλου στο δίκτυο»).' + #13#10 +
           '• Ανοίξτε πρώτα τη διαδρομή από την Εξερεύνηση αρχείων (π.χ. \\ΥΠΟΛΟΓΙΣΤΗΣ\SxolikesEfarmoges): αν ζητηθούν, δώστε όνομα χρήστη και κωδικό του πρώτου υπολογιστή και τσεκάρετε «Απομνημόνευση διαπιστευτηρίων».' + #13#10 +
           '• Μετά πατήστε ξανά «Επόμενο».', mbError, MB_OK);
    Result := False;
  end
  else if (CurPageID = DirPage.ID) and UsePage.Values[2] and (SuiteRoot() = '') then
  begin
    MsgBox('Στον φάκελο που δείξατε δεν υπάρχουν δεδομένα της σουίτας (λείπει ο υποφάκελος «Κοινά»).' + #13#10 +
           'Δείξτε τον φάκελο «Σχολικές Εφαρμογές» που δημιουργήθηκε στον πρώτο υπολογιστή.', mbError, MB_OK);
    Result := False;
  end;
  if (CurPageID = DirPage.ID) and UsePage.Values[1] and (not DirExists(RemoveBackslash(DirPage.Values[0]))) then
  begin
    MsgBox('Ο φάκελος δεν υπάρχει ή δεν είναι προσβάσιμος.', mbError, MB_OK);
    Result := False;
  end;
end;

{ Κοινή χρήση του φακέλου της σουίτας στο δίκτυο (netshare.ps1 με έγκριση διαχειριστή). }
procedure ShareFolder(const Root: String);
var
  Ps, OutF, J, Unc, Msg, Txt: String;
  Code: Integer;
  A: AnsiString;
begin
  ExtractTemporaryFile('netshare.ps1');
  Ps := ExpandConstant('{sys}\WindowsPowerShell\v1.0\powershell.exe');
  OutF := ExpandConstant('{tmp}\netshare.json');
  if not ShellExec('runas', Ps, '-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "' + ExpandConstant('{tmp}\netshare.ps1') +
                   '" -Path "' + Root + '" -Name SxolikesEfarmoges -Out "' + OutF + '"', '', SW_HIDE, ewWaitUntilTerminated, Code) then
  begin
    MsgBox('Η κοινή χρήση στο δίκτυο δεν έγινε (δεν δόθηκε έγκριση διαχειριστή).' + #13#10 +
           'Μπορείτε να την κάνετε αργότερα από το Ωρολόγιο: Ρυθμίσεις εφαρμογής → Κοινή χρήση → «Κοινή χρήση στο δίκτυο».', mbInformation, MB_OK);
    Exit;
  end;
  J := '';
  if LoadStringFromFile(OutF, A) then J := String(A);
  Unc := JsonValue(J, 'unc');
  if Unc = '' then
  begin
    MsgBox('Η κοινή χρήση στο δίκτυο απέτυχε: ' + JsonValue(J, 'error') + #13#10 +
           'Δοκιμάστε από το Ωρολόγιο: Ρυθμίσεις εφαρμογής → Κοινή χρήση.', mbError, MB_OK);
    Exit;
  end;
  Exec(Ps, '-NoProfile -WindowStyle Hidden -Command "Set-Clipboard -Value ' + #39 + Unc + #39 + '"', '', SW_HIDE, ewWaitUntilTerminated, Code);
  Txt := 'Σχολικές Εφαρμογές — κοινός φάκελος' + #13#10#13#10 +
         'Διαδρομή για τον δεύτερο υπολογιστή:' + #13#10 + '    ' + Unc + #13#10#13#10 +
         '1. Στον δεύτερο υπολογιστή ανοίξτε την Εξερεύνηση αρχείων, γράψτε τη διαδρομή στη γραμμή διευθύνσεων και πατήστε Enter.' + #13#10 +
         '   Αν ζητηθούν, δώστε όνομα χρήστη και κωδικό ΑΥΤΟΥ του υπολογιστή (' + GetComputerNameString + ') και τσεκάρετε «Απομνημόνευση διαπιστευτηρίων».' + #13#10 +
         '2. Τρέξτε εκεί το Sxolikes_Efarmoges_Setup.exe → «Ναι — σύνδεση σε κοινό φάκελο» και επικολλήστε τη διαδρομή.' + #13#10#13#10 +
         'Ο υπολογιστής αυτός πρέπει να είναι ανοιχτός όταν δουλεύει ο δεύτερος.' + #13#10;
  SaveStringsToUTF8File(ExpandConstant('{userdesktop}\Κοινός φάκελος Σχολικών Εφαρμογών.txt'), [Txt], False);
  Msg := 'Ο φάκελος είναι πλέον κοινόχρηστος στο δίκτυο.' + #13#10#13#10 + 'Διαδρομή για τον δεύτερο υπολογιστή:' + #13#10 + Unc + #13#10#13#10 +
         'Αντιγράφηκε στο πρόχειρο και γράφτηκε σε αρχείο στην επιφάνεια εργασίας («Κοινός φάκελος Σχολικών Εφαρμογών.txt»).';
  if Pos('"public":[]', J) = 0 then
    Msg := Msg + #13#10#13#10 + 'ΠΡΟΣΟΧΗ: το δίκτυο είναι δηλωμένο ως «Δημόσιο» και τα Windows κρύβουν τους κοινόχρηστους φακέλους. ' +
           'Αλλάξτε το σε «Ιδιωτικό»: Ρυθμίσεις → Δίκτυο και Internet → Ιδιότητες → Τύπος προφίλ δικτύου.';
  MsgBox(Msg, mbInformation, MB_OK);
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  Cfg, Root, Role, Confirmed: String;
begin
  if (CurStep = ssPostInstall) and Shared() and UsePage.Values[1] and NetPage.Values[0] and
     (not IsUncPath(DirPage.Values[0])) and (not WizardSilent) then
    ShareFolder(SuiteRoot());
  if CurStep = ssInstall then
  begin
    Root := '';
    Role := 'director';
    Confirmed := 'true';
    if Shared() then
    begin
      Root := SuiteRoot();
      ForceDirectories(Root + '\Ωρολόγιο');
      ForceDirectories(Root + '\Εφημερίες');
      ForceDirectories(Root + '\Κοινά');
      if RolePage.Values[0] then Role := 'director' else Role := 'deputy';
      Confirmed := 'false';
    end;
    Cfg := ExpandConstant('{userappdata}\SchoolApps');
    ForceDirectories(Cfg);
    SaveStringToFile(Cfg + '\suite.json', '{"root": "' + JsonEscape(Root) + '", "role": "' + Role + '", "confirmed": ' + Confirmed + '}', False);
  end;
end;
