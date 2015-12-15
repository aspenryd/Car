unit ukm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math, ADODB, DB, utilsString;

type

  TRecord = class
    sFieldName: string;
    sFieldType: string;
    iStartPos: Integer;
    iLength: Integer;
    ixtra: Integer;
  end;

  TRecords = class(Tlist)
    function AddTRecord(aFieldName, aFieldType: string; aStartPos, aLength, aXtra: Integer): Integer;
  end;


  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    Procedure ReadRecordSetup(Filnamn : String);
    function  FixTablespec(TableName : String):String;
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Helper(fname: string; DbfType: Integer);
    procedure Helper2(fname: string; DbfType: Integer);
  end;

var
  Form1: TForm1;
  autostart: Boolean;
  RecordLista: TRecords;
//  F2 : TextFile;

implementation

{$R *.dfm}





function CharToBit(f: TFileStream): string;
var
  i: Integer;
  ch: Char;
begin
  f.Read(ch, 1);
  Result := '00000000';
  if (ord(ch) and 128) = 128 then Result[1] := '1';
  if (ord(ch) and 64) = 64 then Result[2] := '1';
  if (ord(ch) and 32) = 32 then Result[3] := '1';
  if (ord(ch) and 16) = 16 then Result[4] := '1';
  if (ord(ch) and 8) = 8 then Result[5] := '1';
  if (ord(ch) and 4) = 4 then Result[6] := '1';
  if (ord(ch) and 2) = 2 then Result[7] := '1';
  if (ord(ch) and 1) = 1 then Result[8] := '1';
end;

function GetNum4(f: TFileStream): Integer;
var
  ch: Char;
begin
  f.Read(ch, 1);
  Result := ord(ch);
  f.Read(ch, 1);
  Result := Result + (ord(ch) * 256);
  f.Read(ch, 1);
  Result := Result + (ord(ch) * 256 * 256);
  f.Read(ch, 1);
  Result := Result + (ord(ch) * 256 * 256 * 256);
end;

function GetNum2(f: TFileStream): Integer;
var
  ch: Char;
begin
  f.Read(ch, 1);
  Result := ord(ch);
  f.Read(ch, 1);
  Result := Result + (ord(ch) * 256);
end;

function GetNum1(f: TFileStream): Integer;
var
  ch: Char;
begin
  f.Read(ch, 1);
  Result := ord(ch);
end;

function GetDate(f: TFileStream): string;
var
  ch: Char;
begin
  Result := intToStr(GetNum1(f)) + '/' + intToStr(GetNum1(f)) + '/' + intToStr(GetNum1(f));
end;

function GetString(f: TFileStream; len: Integer): string;
begin
  SetLength(Result, Len);

  f.Read(Result[1], Len);
end;


procedure TForm1.Button1Click(Sender: TObject);
var
  fn: TFileStream;
  i: Integer;
  RecLen, RLen, RecStart: Integer;
  HeaderLen: Integer;
  NoOfRecs: Integer;
  s1, s2, s3, s4, s5, s6, s7: string;
  Counter: Integer;
begin
  fn := TFileStream.Create('d:\kundmarknad\skBILAR.dbf', fmOpenRead);
  fn.Position := 4;
  NoOfRecs := GetNum4(fn);
  HeaderLen := GetNum2(fn);
  RecLen := GetNum2(fn);
  fn.Position := HeaderLen;
  s7 := GetString(fn, Reclen);
  fn.Position := 32;
  RLen := 0;
  while fn.Position < HeaderLen - 10 do
  begin
    s1 := GetString(fn, 11);
    s1 := Trim(s1) + '                           ';
    S1 := Copy(s1, 1, 10);
    s2 := GetString(fn, 1);
    s3 := IntToStr(Getnum4(fn));
    s4 := IntToStr(Getnum1(fn));
    s5 := IntToStr(Getnum1(fn));
    fn.Position := fn.Position + 14;
//     Memo1.Lines.Add(Format('%s %s %s %s %s',[s1,s2,s3,s4,s5]));
    RecStart := fn.Position;
    s6 := '-';
    fn.Position := HeaderLen + StrToInt(s3);
    case ord(s2[1]) of
      ord('C'): begin
          s6 := trim(GetString(fn, strToInt(s4)));
        end;
      ord('D'): begin
          s6 := trim(GetString(fn, strToInt(s4)));
        end;
      ord('N'): begin
          s6 := trim(GetString(fn, strToInt(s4)));
        end;
      ord('L'): begin
          s6 := trim(GetString(fn, strToInt(s4)));
        end;
    end;
    Memo1.Lines.Add(Format('%s %s %s %s %s "%s"', [s1, s2, s3, s4, s5, s6]));
    fn.Position := RecStart;

  end;
  Memo1.Lines.Add(s7);

  fn.Free;
end;

procedure TForm1.Helper(fname: string; DbfType: Integer);
var
  fn: TFileStream;
  i: Integer;
  RecLen, RLen, RecStart: Integer;
  HeaderLen: Integer;
  NoOfRecs: Integer;
  s1, s2, s3, s4, s5, s6, s7: string;
  Counter: Integer;
begin
  fn := TFileStream.Create(fname, fmOpenRead);
  fn.Position := 4;
  NoOfRecs := GetNum4(fn);
  HeaderLen := GetNum2(fn);
  RecLen := GetNum2(fn);
  fn.Position := 32;
  RLen := 0;
  Counter := 0;
  RecStart := HeaderLen + 1 - RecLen;
  for i := 1 to NoOfRecs do
  begin
    RecStart := RecStart + RecLen;
    fn.Position := RecStart - 1;
    if GetNum1(fn) = ord(' ') then
    begin
      inc(Counter);
      case DBFType of
        1: begin
            fn.Position := RecStart + 2; // Positionera till RegNR;
            s1 := GetString(fn, 10);
            fn.Position := RecStart + 12; // Positionera till KundNR;
            s2 := GetString(fn, 10);
            fn.Position := RecStart + 140; // Positionera till SREGDAT;
            s3 := GetString(fn, 8);
//            Writeln(F2,Format('INSERT INTO BILAR (REGNR,KUNDNR) VALUES ('''%s''','''%s''')',[trim(s2),trim(s1)]));
//            Memo1.Lines.Add(Format('INSERT INTO BILAR (REGNR,KUNDNR,SDAT) VALUES (''%s'',''%s'',''%s'')',[trim(s2),trim(s1),trim(s3)]));



            ADOConnection1.Execute(Format('UPDATE BILAR SET REGNR=''%s'', KUNDNR=''%s'', SDAT=''%s'' WHERE REGNR=''%s'' AND SDAT<''%s'' ', [trim(s2), trim(s1), trim(s3), trim(s2), trim(s3)]), NoOfRecs);
            if NoOfRecs = 0 then
            begin
              try
                ADOConnection1.Execute(Format('INSERT INTO BILAR (REGNR,KUNDNR,SDAT) VALUES (''%s'',''%s'',''%s'')', [trim(s2), trim(s1), trim(s3)]), NoOfRecs);
              except
                NoOfRecs := 0;
              end;
            end;

          end;
        2: begin
            fn.Position := RecStart + 73; // Positionera till kundNR;
            s1 := GetString(fn, 10);
            s2 := GetString(fn, 36);
            s3 := GetString(fn, 36);
            s4 := GetString(fn, 27);
            fn.Position := RecStart + 212; // Positionera till kundNR;
            s5 := GetString(fn, 5);
            s6 := GetString(fn, 13);
            s7 := GetString(fn, 20);
            if (trim(s3) = '') and (trim(s2) = '') then
            begin
              fn.Position := RecStart + 698; // Positionera till NAMN;
              s3 := GetString(fn, 36);
            end;
            s2 := strReplaceAll(s2, '''', '');
            s3 := strReplaceAll(s3, '''', '');
            s4 := strReplaceAll(s4, '''', '');
            s6 := strReplaceAll(s6, '''', '');
            s7 := strReplaceAll(s7, '''', '');
//            Writeln(F2,Format('INSERT INTO KUNDER (KUNDNR,FNAMN,ENAMN,ADRESS,POSTNR,ORT,TEL) VALUES ("%s","%s","%s","%s","%s","%s","%s")',[trim(s1),trim(s2),trim(s3),trim(s4),trim(s5),trim(s6),trim(s7)]));
//            Memo1.Lines.Add(Format('INSERT INTO KUNDER (KUNDNR,FNAMN,ENAMN,ADRESS,POSTNR,ORT,TEL) VALUES (''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'')',[trim(s1),trim(s2),trim(s3),trim(s4),trim(s5),trim(s6),trim(s7)]));
            ADOConnection1.Execute(Format('INSERT INTO KUNDER (KUNDNR,FNAMN,ENAMN,ADRESS,POSTNR,ORT,TEL) VALUES (''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',''%s'')', [trim(s1), trim(s2), trim(s3), trim(s4), trim(s5), trim(s6), trim(s7)]), NoOfRecs);
          end;
      end;
{       if (Counter mod 100)=0 then
       begin
          ADOConnection1.Execute(Memo1.Lines.Text,NoOfRecs);
          Memo1.Lines.Clear;
       end;
}
//          Writeln(F2,'GO');
    end;
  end;
{   if (Counter mod 100)<>0 then
   begin
     ADOConnection1.Execute(Memo1.Lines.Text,NoOfRecs);
     Memo1.Lines.Clear;
   end;
}
//     Writeln(F2,'GO');
  fn.Free;
end;

function PBTrim(s:String):String;
begin
   Result := strReplaceAll(s,'''','''+''');
end;

procedure TForm1.Helper2(fname: string; DbfType: Integer);
var
  fn: TFileStream;
  i,j: Integer;
  RecLen, RLen, RecStart: Integer;
  HeaderLen: Integer;
  NoOfRecs: Integer;
  s1, s2, s3, s4, s5, s6, s7, TblName: string;
  Counter: Integer;
begin
  ReadRecordSetup(fName);
  if DbfType = 1 then TblName := 'PBBILAR'
  else TblName := 'PBKUNDER';
  try
    ADOConnection1.Execute(FixTablespec(TblName),NoOfRecs);
  except
  end;


  fn := TFileStream.Create(fname, fmOpenRead);
  fn.Position := 4;
  NoOfRecs := GetNum4(fn);
  HeaderLen := GetNum2(fn);
  RecLen := GetNum2(fn);
  fn.Position := 32;
  RLen := 0;
  Counter := 0;
  RecStart := HeaderLen + 1 - RecLen;
  for i := 1 to NoOfRecs do
  begin
    fn.Position := HeaderLen + ((i - 1) * RecLen);
    s1 := '';
    s2 := '';
    if GetString(fn, 1) = ' ' then
    begin
      for j := 0 to RecordLista.Count - 1 do
      begin
        fn.Position := HeaderLen + ((i - 1) * RecLen) + TRecord(Recordlista[j]).iStartPos;
        s6 := '-';
        case ord(TRecord(Recordlista[j]).sFieldType[1]) of
          ord('C'): begin
              s6 := '''' + PBtrim(GetString(fn, TRecord(Recordlista[j]).iLength)) + '''';
            end;
          ord('D'): begin
              s6 := trim(GetString(fn, TRecord(Recordlista[j]).iLength));
              if trim(s6) = '' then
                s6 := '''' + ''''
              else
              begin
                s7 := s6;
                s6 := Format('''%s-%s-%s''', [copy(s7, 1, 4), copy(s7, 5, 2), copy(s7, 7, 2)]);
              end;

            end;
          ord('N'): begin
              s6 := trim(GetString(fn, TRecord(Recordlista[j]).iLength));
            end;
          ord('L'): begin
              s6 := trim(GetString(fn, TRecord(Recordlista[j]).iLength));
              if s6 = 'F' then
                s6 := '0'
              else
                s6 := '-1';
            end;
        end;
        if s6 <> '-' then
        begin
          if s1 = '' then
          begin
            s1 := 'INSERT INTO ' + TblName + ' (' + TRecord(Recordlista[j]).sFieldName;
          end
          else
            s1 := s1 + ',' + TRecord(Recordlista[j]).sFieldName;

          if s2 = '' then
            S2 := 'VALUES (' + s6
          else
            s2 := s2 + ',' + s6;
        end;
      end;
      s1 := s1 + ')';
      s2 := s2 + ')';
    end;
    try
      ADOConnection1.Execute(s1 + ' ' + s2, NoOfRecs);
    except
    end;
  end;
  fn.Free;
end;






procedure TForm1.Button2Click(Sender: TObject);
var
  NoOfRecs: Integer;
  i: Integer;
begin
  Memo1.Visible := False;
  Memo1.WordWrap := False;
  Memo1.Lines.Clear;
  Memo1.Lines.LoadFromFile(extractFilePath(Application.ExeName) + 'km_settings.txt');
  ADOConnection1.ConnectionString := Memo1.Lines[0];
  ADOConnection1.Connected := True;
  ADOConnection1.CommandTimeout := 1200;
  ADOConnection1.Execute('DELETE BILAR', NoOfRecs);
  ADOConnection1.Execute('DELETE KUNDER', NoOfRecs);
//   AssignFile(F2, 'f:\km.sql');
//   Rewrite(F2);

  for i := 1 to Memo1.Lines.Count - 1 do
    Helper(copy(Memo1.Lines[i], 3, 99), StrToInt(Memo1.Lines[i][1]));
//   Helper('f:\kundmarknad\skbilar.dbf',1);
//   Helper('f:\kundmarknad\SKkunder.dbf',2);
//   Helper('f:\kundmarknad\sybilar.dbf',1);
//   Helper('f:\kundmarknad\SYkunder.dbf',2);
//   Helper('f:\kundmarknad\vabilar.dbf',1);
//   Helper('f:\kundmarknad\VAkunder.dbf',2);
//   Helper('f:\kundmarknad\osbilar.dbf',1);
//   Helper('f:\kundmarknad\oskunder.dbf',2);

//   CloseFile(F2);

  ADOConnection1.CommandTimeout := 1200;

  ADOConnection1.Execute('DELETE ANSWER', NoOfRecs);
  ADOConnection1.Execute('INSERT INTO Answer (REGNR, KUNDNR, FNAMN_CBR, ENAMN_CBR, UADR_CBR, POSTNR_CBR, ORT_CBR, TELNR_CBR)' +
    'SELECT CAST(BILAR.REGNR AS VARCHAR(6)), BILAR.KUNDNR,MAX(CAST( KUNDER.FNAMN AS VARCHAR(20))), MAX(CAST(KUNDER.ENAMN AS VARCHAR(30))), MAX(KUNDER.ADRESS), MAX(KUNDER.POSTNR), MAX(KUNDER.ORT), MAX(CAST(KUNDER.TEL AS VARCHAR(11)))' +
    'FROM BILAR INNER JOIN KUNDER ON BILAR.KUNDNR = KUNDER.KUNDNR GROUP BY CAST(BILAR.REGNR AS VARCHAR(6)), BILAR.KUNDNR ORDER BY 1', NoOfRecs);

  Memo1.Lines.Clear;
  Memo1.Visible := True;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Str: string;
begin
  Memo1.Lines.LoadFromFile(extractFilePath(Application.ExeName) + 'km_settings.txt');
  ADOConnection1.ConnectionString := Memo1.Lines[0];
  Str := ADOConnection1.ConnectionString;
  Str := PromptDataSource(self.Handle, str);
  if Str <> '' then
  begin
    ADOConnection1.ConnectionString := Str;
    Memo1.Lines[0] := Str;
    Memo1.Lines.SaveToFile(extractFilePath(Application.ExeName) + 'km_settings.txt');
    Memo1.Lines.Clear;
  end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  AutoStart := False;
  if ParamCount >= 1 then
  begin
    if uppercase(ParamStr(1)) = 'AUTO' then
      AutoStart := True;
  end;
  if AutoStart then
  begin
    Button2Click(nil);
    Application.Terminate;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  NoOfRecs: Integer;
begin
  Memo1.Visible := False;
  Memo1.WordWrap := False;
  Memo1.Lines.Clear;
  Memo1.Lines.LoadFromFile(extractFilePath(Application.ExeName) + 'km_settings.txt');
  ADOConnection1.ConnectionString := Memo1.Lines[0];
  ADOConnection1.Connected := True;
  ADOConnection1.CommandTimeout := 1200;

  ADOConnection1.Execute('DELETE ANSWER', NoOfRecs);
  ADOConnection1.Execute('INSERT INTO Answer (REGNR, KUNDNR, FNAMN_CBR, ENAMN_CBR, UADR_CBR, POSTNR_CBR, ORT_CBR, TELNR_CBR)' +
    'SELECT CAST(BILAR.REGNR AS VARCHAR(6)), BILAR.KUNDNR,MAX(CAST( KUNDER.FNAMN AS VARCHAR(20))), MAX(CAST(KUNDER.ENAMN AS VARCHAR(30))), MAX(KUNDER.ADRESS), MAX(KUNDER.POSTNR), MAX(KUNDER.ORT), MAX(CAST(KUNDER.TEL AS VARCHAR(11)))' +
    'FROM BILAR INNER JOIN KUNDER ON BILAR.KUNDNR = KUNDER.KUNDNR GROUP BY CAST(BILAR.REGNR AS VARCHAR(6)), BILAR.KUNDNR ORDER BY 1', NoOfRecs);
  ADOConnection1.Connected := True;

end;

{ TRecords }

function TRecords.AddTRecord(aFieldName, aFieldType: string; aStartPos,
  aLength, aXtra: Integer): Integer;
var
  aR: TRecord;
begin
  aR := TRecord.Create;
  Result := Add(aR);
  aR.sFieldName := '['+trim(aFieldName)+']';
  aR.sFieldType := trim(aFieldType);
  aR.iStartPos := aStartPos;
  aR.iLength := aLength;
  aR.ixtra := aXtra;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  ReadRecordSetup('d:\kundmarknad\skkunder.dbf');
end;

Procedure TForm1.ReadRecordSetup(Filnamn : String);
var
  fn: TFileStream;
  i: Integer;
  RecLen, RLen, RecStart: Integer;
  HeaderLen: Integer;
  NoOfRecs: Integer;
  s1, s2, s3, s4, s5, s6, s7: string;
  Counter: Integer;
begin
  if not Assigned(RecordLista) then
  begin
    RecordLista := TRecords.Create;
  end;
  RecordLista.Clear;
  fn := TFileStream.Create(FilNamn, fmOpenRead);
  fn.Position := 4;
  NoOfRecs := GetNum4(fn);
  HeaderLen := GetNum2(fn);
  RecLen := GetNum2(fn);
  fn.Position := 32;
  RLen := 0;
  while fn.Position < HeaderLen - 10 do
  begin
    s1 := GetString(fn, 11);
    s1 := Trim(s1) + '                           ';
    S1 := Copy(s1, 1, 10);
    s2 := GetString(fn, 1);
    s3 := IntToStr(Getnum4(fn));
    s4 := IntToStr(Getnum1(fn));
    s5 := IntToStr(Getnum1(fn));
    fn.Position := fn.Position + 14;
    RecordLista.AddTRecord(s1, s2, StrToInt(s3), StrToInt(s4), StrToInt(s5));
  end;

  fn.Free;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  fn: TFileStream;
  i, j: Integer;
  RecLen, RLen, RecStart: Integer;
  HeaderLen: Integer;
  NoOfRecs: Integer;
  s1, s2, s3, s4, s5, s6, s7: string;
  Counter: Integer;
begin
  if not Assigned(RecordLista) then
    Button7Click(nil);

  fn := TFileStream.Create('d:\kundmarknad\skkunder.dbf', fmOpenRead);
  fn.Position := 4;
  NoOfRecs := GetNum4(fn);
  HeaderLen := GetNum2(fn);
  RecLen := GetNum2(fn);
  fn.Position := HeaderLen;
  for i := 1 to min(1000, NoOfRecs) do
  begin
    fn.Position := HeaderLen + ((i - 1) * RecLen);
    s1 := '';
    s2 := '';
    if GetString(fn, 1) = ' ' then
    begin
      for j := 0 to RecordLista.Count - 1 do
      begin
        fn.Position := HeaderLen + ((i - 1) * RecLen) + TRecord(Recordlista[j]).iStartPos;
        s6 := '-';
        case ord(TRecord(Recordlista[j]).sFieldType[1]) of
          ord('C'): begin
              s6 := '''' + trim(GetString(fn, TRecord(Recordlista[j]).iLength)) + '''';
            end;
          ord('D'): begin
              s6 := trim(GetString(fn, TRecord(Recordlista[j]).iLength));
              if trim(s6) = '' then
                s6 := '''' + ''''
              else
              begin
                s7 := s6;
                s6 := Format('''%s-%s-%s''', [copy(s7, 1, 4), copy(s7, 5, 2), copy(s7, 7, 2)]);
              end;

            end;
          ord('N'): begin
              s6 := trim(GetString(fn, TRecord(Recordlista[j]).iLength));
            end;
          ord('L'): begin
              s6 := trim(GetString(fn, TRecord(Recordlista[j]).iLength));
              if s6 = 'F' then
                s6 := '''False'''
              else
                s6 := '''True''';
            end;
        end;
        if s6 <> '-' then
        begin
          if s1 = '' then
          begin
            s1 := 'INSERT INTO BILAR (' + TRecord(Recordlista[j]).sFieldName;
          end
          else
            s1 := s1 + ',' + TRecord(Recordlista[j]).sFieldName;

          if s2 = '' then
            S2 := 'VALUES (' + s6
          else
            s2 := s2 + ',' + s6;
        end;
      end;
      s1 := s1 + ')';
      s2 := s2 + ')';
      Memo1.Lines.Add(s1);
      Memo1.Lines.Add(s2);
      Memo1.Lines.Add('');
    end;
  end;
  fn.Free;

end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  Memo1.Lines.Add(FixTablespec('KUNDER'));
end;


Function TForm1.FixTablespec(TableName : String):String;
var
  sl : TStringList;
  i, j: Integer;
  RecLen, RLen, RecStart: Integer;
  HeaderLen: Integer;
  NoOfRecs: Integer;
  s1, s2, s3, s4, s5, s6, s7: string;
  Counter: Integer;
begin
  Result := '';
  sl := TStringList.Create;
  if not Assigned(RecordLista) then
    Button5Click(nil);

  sl.Add('CREATE TABLE '+TableName+' (');
  for j := 0 to RecordLista.Count - 1 do
  begin
    s6 := '-';
    with TRecord(Recordlista[j]) do
    begin
      case ord(sFieldType[1]) of
        ord('C'): begin
            if j > 0 then
              sl[sl.Count - 1] := sl[sl.Count - 1] + ' ,';
            sl.Add(Format('      %s NVARCHAR(%d) NULL DEFAULT '''+'''', [sFieldName, iLength]))
          end;
        ord('D'): begin
            if j > 0 then
              sl[sl.Count - 1] := sl[sl.Count - 1] + ' ,';
            sl.Add(Format('      %s DATETIME NULL ', [sFieldName]))
          end;
        ord('N'): begin
            if j > 0 then
              sl[sl.Count - 1] := sl[sl.Count - 1] + ' ,';
            if ixtra = 0 then
              sl.Add(Format('      %s INT NULL DEFAULT 0', [sFieldName]))
            else
              sl.Add(Format('      %s DECIMAL(%d,%d) NULL DEFAULT 0', [sFieldName, iLength, ixtra]))
          end;
        ord('L'): begin
            if j > 0 then
              sl[sl.Count - 1] := sl[sl.Count - 1] + ' ,';
            sl.Add(Format('      %s int NULL DEFAULT 0', [sFieldName]));
          end;
      end;
    end;
  end;
  sl.Add(')');
  Result := sl.Text;
  sl.Free;
end;

procedure TForm1.Button8Click(Sender: TObject);
var
  NoOfRecs: Integer;
  i: Integer;
begin
  Memo1.Visible := False;
  Memo1.WordWrap := False;
  Memo1.Lines.Clear;
  Memo1.Lines.LoadFromFile(extractFilePath(Application.ExeName) + 'km_settings.txt');
  ADOConnection1.ConnectionString := Memo1.Lines[0];
  ADOConnection1.Connected := True;
  ADOConnection1.CommandTimeout := 1200;

  for i := 1 to Memo1.Lines.Count - 1 do
    Helper2(copy(Memo1.Lines[i], 3, 99), StrToInt(Memo1.Lines[i][1]));

  Memo1.Lines.Clear;
  Memo1.Visible := True;
end;

end.

