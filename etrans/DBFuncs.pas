{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     DBFuncs.pas
}

{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13119: DBFuncs.pas 
{
{   Rev 1.0    2003-03-20 14:01:50  peter
}
{
{   Rev 1.0    2003-03-17 09:26:20  Supervisor
{ Start av vc
}
unit DBFuncs;

interface
uses DB, DBCtrls, DBTables, Sysutils, Inifiles, Dialogs, classes;

function GetDatabase(DB1 : TDatabase; inifile, db, dbname : string; var DBFile : string) : Boolean;


implementation

function GetDatabase(DB1 : TDatabase; inifile, db, dbname : string; var DBFile : string) : Boolean;
// GetDatabase(Database1, 'Car97.ini', 'DB', 'databas', DBFile);
// GetDatabase(Database2, 'Car97.ini', 'SDB', 'statisk databas', SDBFile);
var
  Car97Ini: TIniFile;
begin
  result := false;
  Car97Ini := TIniFile.Create(inifile);
  DBFile := Car97Ini.ReadString('Main', DB, '');
  Car97Ini.Free;
  while not DB1.Connected do
  begin
    while not FileExists(DBFile) do
      if not InputQuery('Hittar ej ' + dbname, 'Ange databas', DBFile) then
        exit;
    try
      DB1.Params.Clear;
      DB1.Params.add('DATABASE NAME='+ DBFile);
      DB1.Connected := true;
      result := true;
      Car97Ini := TIniFile.Create(inifile);
      Car97Ini.WriteString('Main', DB, DBFile);
      Car97Ini.Free;
    except
      if not InputQuery('Kan ej öppna ' + dbname, 'Ange databas', DBFile) then
        exit;
    end;
  end;
  result := true;
end;


end.

