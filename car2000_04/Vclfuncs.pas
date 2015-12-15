{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Vclfuncs.pas
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
{ $Log:  14894: Vclfuncs.pas 
{
{   Rev 1.0    2004-08-18 11:01:08  pb64
{ Start inf�r inf�rande av kontraktsfakturering.
{ 
}
{
{   Rev 1.0    2003-03-20 14:00:32  peter
}
{
{   Rev 1.0    2003-03-17 14:41:44  Supervisor
{ nytt
}
{
{   Rev 1.0    2003-03-17 14:35:58  Supervisor
{ Nystart och fixar
}
{
{   Rev 1.0    2003-03-17 09:25:30  Supervisor
{ Start av vc
}
unit vclFuncs;

interface

uses windows, sysutils, grids;
procedure DeleteRow(var sg: TStringGrid; row: integer; PackGrid: boolean);

implementation

procedure DeleteRow(var sg: TStringGrid; row: integer; PackGrid: boolean);
var I, col: Integer;
begin
  if PackGrid then
  begin
    for I := row to sg.rowcount - 1 do
      for col := 0 to sg.colcount - 1 do
        sg.cells[col, I] := sg.cells[col, I + 1];
    sg.rowCount := sg.rowCount - 1;
  end
  else
    for col := 0 to sg.colcount - 1 do
      sg.cells[col, row] := '';
end;

end.

