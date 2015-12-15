unit edifact;

interface

uses classes, windows, sysutils;

type
  TUNH = record
    MessageId : integer;
    Reference : integer;
    MessageType : string;
    VersionNumber : string;
    Release : string;
    Agency : string;
    Code : string;
  end;

  TBGM = record
    Code : integer;
    DocId : integer;
  end;

  TDTM = record
    Code : integer;
    Date : TDateTime;
    Format : integer;
  end;

  TFTX = record
    Code : string;
    FreeText1 : string;
    FreeText2 : string;
    FreeText3 : string;
    Language : string;
  end;

  TGEI = record
    Code : string;
    Agency : string;
  end;

  TRFF = record
    Code : string;
    Reference : integer;
  end;

  TNAD = record
    Code : string;
    PartyId : integer;
    AgentId : integer;
    PartyName : string;
    Street : string;
    City : string;
    ZipCode : string;
    Country : string;
  end;

  TCTA = record
    Code : string;
    EmployeeCode : string;
  end;

  TCOM = record
    ComId : string;
    ComCode : string;
  end;

  TFII = record
    Code : string;
    AccountId : string;
    AccountName : string;
    InstName : string;
  end;

  TCUX = record
    RefMoneyID : string;
    RefQualifier : integer;
    TargetMoneyID : string;
    TargetQualifier : integer;
    ExchangeRate : extended;
  end;

  TPYT = record
    Code : integer;
    TimeRefCode : integer;
    TimeRelationCode: integer;
    PeriodTypeCode : string;
    NumPeriods : integer;
  end;

  TLIN = record
    Id : integer;
    ItemId : string;
    IdCode : string;
  end;

  TPIA = record
    Id : integer;
    ArticleId : string;
    ArticleCode : string;
  end;

  TIMD = record
    ItemDescription : string;
    ItemId : string;
    LanguageCode : string;
  end;

  TQTY = record
    Code : integer;
    Quantity : integer;
    UnitCode : string;
  end;

  TALI = record
    CountryCode : string;
    ConditionCode : integer;
  end;

  TGIN = record
    Code : string;
    ObjectId : string;
  end;

  TMOA = record
    Code : string;
    ObjectId : string;
  end;


{
  TEdiHolder = class()
  private

  public

  end;
}
implementation

end.
