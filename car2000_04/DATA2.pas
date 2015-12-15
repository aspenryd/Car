{
==========================================================
===  (c) CopyRight 2003 ; All rights reserved          ===
==========================================================

  Filename 
     Data2.pas
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
{ $Log:  14834: DATA2.pas 
{
{   Rev 1.0    2004-08-18 11:00:52  pb64
{ Start inför införande av kontraktsfakturering.
{ 
}
{
{   Rev 1.0    2003-03-20 14:00:24  peter
}
{
{   Rev 1.0    2003-03-17 14:41:42  Supervisor
{ nytt
}
{
{   Rev 1.0    2003-03-17 14:35:56  Supervisor
{ Nystart och fixar
}
{
{   Rev 1.0    2003-03-17 09:25:22  Supervisor
{ Start av vc
}
unit Data2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComServ, ComObj, VCLCom, StdVcl, DataBkr, DBClient,
  Db, DBTables; //!, BdeProv  , CARLocServ_TLB

type
  TTCARSearch = class(TRemoteDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function ChangeSQL(const Param1: WideString): Shortint; safecall;
  protected
    function Get_SearchQ: IProvider; safecall;
    procedure UpdateQuery; safecall;
  end;

var
  TCARSearch: TTCARSearch;

implementation

uses Search, Datamodule;

{$R *.DFM}

function TTCARSearch.Get_SearchQ: IProvider;
begin
//!  Result := SearchQ.Provider;
end;

function TTCARSearch.ChangeSQL(const Param1: WideString): Shortint;
begin
  result := 0;
  try
//!    if SearchQ.Active then
    if frmsearch.GSearchCDS.active or frmsearch.SSearchCDS.active then
//!      SearchQ.Close;
      frmsearch.GSearchCDS.Close;
    frmsearch.SSearchCDS.Close;
//!    SearchQ.SQL.Clear;
    frmsearch.GSearchCDS.sql.Clear;
    frmsearch.SSearchCDS.sql.Clear;
//!    SearchQ.SQL.Text := Param1;
    frmsearch.GsearchCDS.Sql.Text := Param1;
    frmsearch.SsearchCDS.Sql.Text := Param1;
//!    SearchQ.Open;
    frmsearch.GsearchCDS.open;
    frmsearch.SsearchCDS.open;
//!    if SearchQ.Active then
    if frmsearch.GSearchCDS.active or frmsearch.SSearchCDS.active then
      result := 1;
  except
    result := 0;
  end;
end;

procedure TTCARSearch.UpdateQuery;
begin
//!  SearchQ.close;
//!  SearchQ.open;
//! Benny lagt till 4 rader;
  frmsearch.GSearchCDS.Close;
  frmsearch.GSearchCDS.OPen;
  frmsearch.SSearchCDS.Close;
  frmsearch.SSearchCDS.OPen;
end;

initialization
//!  TComponentFactory.Create(ComServer, TTCARSearch,
//!    Class_TCARSearch, ciMultiInstance, tmApartment);
end.

