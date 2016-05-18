unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,System.Hash, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,VirusTotal,XSuperJSON,XSuperObject,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Menus, Vcl.AppEvnts,System.Win.Registry;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ric: TRichEdit;
    open: TOpenDialog;
    Button3: TButton;
    tr: TTrayIcon;
    PopupMenu1: TPopupMenu;
    DosyaTara1: TMenuItem;
    Exit1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure DosyaTara1Click(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
aFileName: String;
  VT: TVirusTotalAPI;
  vtFileSend: TvtFileSend;
  vtFileReport: TvtFileReport;
  i: Integer;
    HashMD5: THashMD5;
  Stream: TStream;
  Readed: Integer;
  Buffer: PByte;
  BufLen: Integer;




implementation

{$R *.dfm}
  function GetFileHashMD5(FileName: String): String;


begin
  HashMD5 := THashMD5.Create;
  BufLen := 16 * 1024;
  Buffer := AllocMem(BufLen);
  try
    Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    try
      while Stream.Position < Stream.Size do
      begin
        Readed := Stream.Read(Buffer^, BufLen);
        if Readed > 0 then
        begin
          HashMD5.update(Buffer^, Readed);
        end;
      end;
    finally
      Stream.Free;
    end;
  finally
    FreeMem(Buffer)
  end;

  result := HashMD5.HashAsString;
end;


procedure TForm1.ApplicationEvents1Minimize(Sender: TObject);
begin

  { Hide the window and set its state variable to wsMinimized. }
  Hide();
  WindowState := wsMinimized;

  { Show the animated tray icon and also a hint balloon. }
  tr.Visible := True;
  tr.Animate := True;
  tr.ShowBalloonHint;

end;

procedure TForm1.Button1Click(Sender: TObject);
var
error:string;

     procedure InsertRedBold(RE:TRichEdit; Text: String);
begin
ric.SelAttributes.Color := clRed;
ric.SelAttributes.Style := [fsBold];
ric.Lines.Add(Text);
end;
begin
  VT := TVirusTotalAPI.Create;
  try
    { TODO -oUser -cConsole Main : Insert code here }



    vtFileReport := VT.reportFile(GetFileHashMD5(aFileName));
  

     //
    if vtFileReport.response_code = 0 then
      vtFileSend := VT.ScanFile(aFileName);
    for i := 0 to 4 do
    Begin
      if vtFileReport.response_code = 1 then
        Break;
         Ric.Clear;
      ric.Lines.Add('hata mesajı :'+ vtFileReport.verbose_msg);
      vtFileReport := VT.reportFile(vtFileSend.md5);
     Sleep(60000); // минута
    End;
    if vtFileReport.response_code = 1 then
    Begin
    Ric.Clear;
   InsertRedBold(ric, 'sonuçlar alınıyor');
    ric.Lines.Add('AVG'+'  :  '+ vtFileReport.scans.AVG.result);
    ric.Lines.Add('Avast'+'  :  '+  vtFileReport.scans.Avast.result);
    ric.Lines.Add('Kaspersky:'+'  :  '+  vtFileReport.scans.Kaspersky.result);
    ric.Lines.Add('Tencent'+'  :  '+  vtFileReport.scans.Tencent.result);
    ric.Lines.Add('AVware'+'  :  '+  vtFileReport.scans.AVware.result);
    ric.Lines.Add('Avira'+'  :  '+  vtFileReport.scans.Avira.result);
    ric.Lines.Add('Comodo'+'  :  '+  vtFileReport.scans.Comodo.result);
    ric.Lines.Add('Ad Aware'+'  :  '+  vtFileReport.scans.Ad_Aware.result);


    End;
  except
    on E: Exception do
         ric.Lines.Add(E.ClassName+ ': '+ E.Message);
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
Var
  VT: TVirusTotalAPI;
  vv: tvtfilesend;
  aa:integer;
  ResultScan: TvtFileReport;
begin
 begin
  VT := TVirusTotalAPI.Create;
  try
    { TODO -oUser -cConsole Main : Insert code here }



ResultScan :=  vt.reportFile(inttostr(aa));
    ric.Lines.Add('Opera: '+ resultscan.scans.AVware.result);

  except
    on E: Exception do
      ric.Lines.Add(E.ClassName +': '+E.Message);

  end;


end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
if open.Execute then
   afilename:=open.FileName;

end;

procedure TForm1.DosyaTara1Click(Sender: TObject);
begin
Form1.WindowState:=wsNormal;
form1.Show;


end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
application.Terminate;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  reg        : TRegistry;
  openResult : Boolean;
  today      : TDateTime;
begin
  reg := TRegistry.Create(KEY_READ);
  reg.RootKey := HKEY_LOCAL_MACHINE;

  if (not reg.KeyExists('Software\MyCompanyName\MyApplication\')) then
    begin
      MessageDlg('Key not found! Created now.',
					        mtInformation, mbOKCancel, 0);
    end;
  reg.Access := KEY_WRITE;
  openResult := reg.OpenKey('Software\MyCompanyName\MyApplication\',True);

  if not openResult = True then
    begin
      MessageDlg('Unable to create key! Exiting.',
                  mtError, mbOKCancel, 0);
      Exit();
    end;

  { Checking if the values exist and inserting when neccesary }

  if not reg.KeyExists('Creation\ Date') then
    begin
      today := Now;
  		reg.WriteDateTime('Creation\ Date', today);
    end;

  if not reg.KeyExists('Licenced\ To') then
    begin
  		reg.WriteString('Licenced\ To', 'MySurname\ MyFirstName');
    end;

  if not reg.KeyExists('App\ Location') then
    begin
  		reg.WriteExpandString('App\ Location',
                            '%PROGRAMFILES%\MyCompanyName\MyApplication\');
    end;

  if not reg.KeyExists('Projects\ Location') then
    begin
  		reg.WriteExpandString('Projects\ Location',
                            '%USERPROFILE%\MyApplication\Projects\');
    end;

  reg.CloseKey();
  reg.Free;




tr.Visible := True;
  tr.Animate := True;
  tr.BalloonHint:='Scanner Aktif';
  tr.BalloonTitle:='Scanner';
  tr.ShowBalloonHint;

end;

end.
