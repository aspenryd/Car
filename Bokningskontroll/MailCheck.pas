unit MailCheck;

interface

//{$DEFINE DEBUG}

uses SysUtils, Windows, Messages, Winsock;

const
  CM_SOCKETMESSAGE = WM_USER + 100;
  CM_GETHOSTNAME = WM_USER + 101;
  CRLF = #13#10;
type
  TCMSocketMessage = record
    Msg: Cardinal;
    Socket: TSocket;
    SelectEvent: Word;
    SelectError: Word;
    Result: Longint;
  end;

  TCMGetHostName = record
    Msg: Cardinal;
    Empty: array[0..2] of Word;
    SelectError: Word;
    Result: Longint;
  end;

  TPopState = (psConnecting, psUser, psPass, psStat,
    psTop, psReadingHeaders, psRetr, psReadingBody, psQuit, psClosed);

  ESocketError = class(Exception);

//  TMailOutputEvent = procedure(Sender: TObject; Output: string) of object;
//  TGotMailEvent = procedure(Sender: TObject; NumMessages: Integer) of object;
//  TNotifyEvent = procedure(Sender: TObject) of object;
  //change to "of object" to use in an object
  TMailOutputEvent = procedure(Sender: TObject; Output: string);
  TGotMailEvent = procedure(Sender: TObject; NumMessages: Integer);
  TNotifyEvent = procedure(Sender: TObject);


  TEmailHeader = record
    From: string;
    Subject: string;
  end;

  TMailChecker = class
  private
    FEmailHeaders: array of TEmailHeader;
    FRetrList : array of integer;

    FCurrentState: TPopState;
    FUserName: string;
    FPassword: string;
    FHost: string;
    FPort: Integer;
    FHeaders: string;

    FApiRequestHandle: THandle;

    FHandle: THandle;


    FConnected: Boolean;
    FSocketCalled: Boolean;

    FNumMessages: Integer;
    FOnMessage: Integer;

    FNumBodyMessages: Integer;
    FOnBodyMessage: Integer;


    FSocket: TSocket;
    FHostEntBuffer: array[0..MAXGETHOSTSTRUCT-1] of char;

    FOnMailOutput: TMailOutputEvent;
    FOnGotMailEvent: TGotMailEvent;
    FOnCloseEvent: TNotifyEvent;
    FOnErrorEvent: TMailOutputEvent;

    // Winsock startup/cleanup
    procedure StartUp;
    procedure CleanUp;

//    function LookupService(const Service: string): Integer;
    procedure NiceClose;
    procedure SendCommand(StrCommand: string);
    procedure ProcessHeaderInput(Input: string);
    procedure ProcessBodyInput(Input: string);
    procedure FillInHeader;
    procedure FillInBody;

    procedure CheckRequiredData;
    procedure CancelAsyncRequest;

    procedure SetConnected(const Value: Boolean);
    function GetConnected: Boolean;

    procedure DoConnect;
    procedure DoWrite;
    procedure DoRead;
    procedure DoClose;
    procedure ProcessInput(Input: string);
    function GetEmailHeader(Index: Integer): TEmailHeader;
    procedure SetHost(const Value: string);
    procedure SetUserName(const Value: string);
  public
    constructor Create(AHandle: THandle);
    destructor Destroy; override;
    procedure Connect;
    procedure Disconnect;

    procedure ProcessSocketMessage(var Message: TCMSocketMessage);
    procedure ProcessGetHostNameMessage(var Message: TCMGetHostName);

    property OnMailOutput: TMailOutputEvent read FOnMailOutput write FOnMailOutput;
    property OnGotMail: TGotMailEvent read FOnGotMailEvent write FOnGotMailEvent;
    property OnClose: TNotifyEvent read FOnCloseEvent write FOnCloseEvent;
    property OnError: TMailOutputEvent read FOnErrorEvent write FOnErrorEvent;

    property UserName: string read FUserName write SetUserName;
    property Password: string read FPassword write FPassword;
    property Host: string read FHost write SetHost;
    property Port: Integer read FPort write FPort;

    property MessageCount: Integer read FNumMessages;

    property Handle: THandle read FHandle write FHandle;
    property Connected: Boolean read GetConnected write SetConnected;

    property EmailHeaders[Index: Integer]: TEmailHeader read GetEmailHeader;

  end;


implementation

uses WinsockError;

const
  // not defined in winsock.pas (in winsock2.h)
  SD_RECEIVE  = $00;
  SD_SEND     = $01;
  SD_BOTH     = $02;

procedure RemoveCRLF(var AString: string);
begin
  // if the last character is a linefeed, remove it
  // and the #13 before it
  if Length(AString) >= 2 then
  begin
    if AnsiLastChar(AString) = #10 then
      Delete(AString, Length(AString), 1);
    if AnsiLastChar(AString) = #13 then
      Delete(AString, Length(AString), 1);
  end;
end;

(*
function TMailChecker.LookupService(const Service: string): Integer;
var
  ServEnt: PServEnt;
begin
  {$ifdef DEBUG}
  if Assigned(FOnMailOutput) then
    FOnMailOutput(Self, 'Getting service');
  {$endif}
  ServEnt := getservbyname(PChar(Service), 'tcp');
  if ServEnt <> nil then
    Result := ntohs(ServEnt.s_port)
  else Result := 0;
end;
  *)
function CheckSocketResult(ResultCode: Integer; const Op: string): Integer;
begin
  if ResultCode <> 0 then
  begin
    Result := WSAGetLastError;
    // ignore would blocks
    if Result <> WSAEWOULDBLOCK then
      raise ESocketError.Create('Socket Error: ' + GetWinsockErrorString(Result));
  end else Result := 0;
end;

procedure TMailChecker.NiceClose;
var
  Buff: array [0..255] of char;
  Res: Integer;
//  Msg: TMsg;
begin
  // If connected, try a gracefull close
  if FConnected then
  begin
    // show something if got mail
    if FNumMessages > 0 then
      if Assigned(FOnGotMailEvent) then
        FOnGotMailEvent(Self, FNumMessages);
    // Dont call shutdown if we never got
    // a connected message back setting FConnected to true

    // Now do a gracefull close
    CheckSocketResult(shutdown(FSocket, SD_SEND), 'shutdown');
    // eat up anything left in the socket
    Res := recv(FSocket, Buff, SizeOf(Buff), 0);
    while (Res <> 0) and (Res <> SOCKET_ERROR) do
    begin

{      // possibly add in peak for messages to keep icon always moving
      if PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then
      begin
    		TranslateMessage(Msg);
		    DispatchMessage(Msg);
      end;
}
      Res := recv(FSocket, Buff, SizeOf(Buff), 0);
    end;
    // now close the socket
  end;

  // sanity check
  if FConnected and not FSocketCalled then
    Assert(False);


  // Winsock.socket needs to always be closed with CloseSocket
  // so we save weather or not it was called. This doesn't
  // necessarily mean that it was ever connected


  if FSocketCalled or FConnected then
  begin
    FConnected := False;
    FSocketCalled := False;
    if FSocket <> INVALID_SOCKET then
      CheckSocketResult(closesocket(FSocket), 'closesocket');
  end;
end;

procedure TMailChecker.ProcessSocketMessage(var Message: TCMSocketMessage);
begin
  // First check to see if an error happened
  if Message.SelectError <> 0 then
  begin
    // disconnect on error
    Disconnect;
    // show exception
    raise ESocketError.Create('Windows socket error: '+
      GetWinsockErrorString(Message.SelectError));
  end
  else // No error
  with Message do
    case SelectEvent of
      FD_CONNECT: DoConnect;
      FD_CLOSE: DoClose;
      FD_READ: DoRead;
      FD_WRITE: DoWrite;
  end;
end;

procedure TMailChecker.DoClose;
begin
  {$ifdef DEBUG}
  if Assigned(FOnMailOutput) then
    FOnMailOutput(Self, 'DoClose');
  {$endif}

end;

procedure TMailChecker.DoConnect;
begin
  // mark that we connected okay
  FConnected := True;

  {$ifdef DEBUG}
  if Assigned(FOnMailOutput) then
    FOnMailOutput(Self, 'OnConnect');
  {$endif}
end;

procedure TMailChecker.DoRead;
const
  BufferSize = 1024;
var
  BytesRead: Integer;
  Buffer: PChar;
  InputStr: string;
begin
  {$ifdef DEBUG}
  if Assigned(FOnMailOutput) then
    FOnMailOutput(Self, 'OnRead');
  {$endif}
  // Receive waiting data
  InputStr := '';
  Buffer := AllocMem(BufferSize);
  try
    BytesRead := 1;
    while BytesRead > 0 do
    begin
      // fill buffer with zeros
      FillChar(Buffer^, BufferSize, #0);
      // read in some bytes
      BytesRead := recv(FSocket, Buffer^, BufferSize, 0);
      if BytesRead > 0 then
        InputStr := InputStr + Copy(Buffer, 0, BytesRead);
    end; // while
  finally
    FreeMem(Buffer);
  end;
  // now try to process the input
  if InputStr <> '' then
    ProcessInput(InputStr);
end;

procedure TMailChecker.DoWrite;
begin
  {$ifdef DEBUG}
  if Assigned(FOnMailOutput) then
    FOnMailOutput(Self, 'OnWrite');
  {$endif}
end;

procedure TMailChecker.ProcessInput(Input: string);

  procedure GetNums(var Num, Size: Integer);
  var
    WhitePos: Integer;
  begin
    // Delete the '+OK ' first 4 characters
    Delete(Input, 1, 4);
    WhitePos := Pos(' ', Input);
    Num := StrToInt(Copy(Input, 1, WhitePos-1));
    Size := StrToInt(Copy(Input, WhitePos+1, Length(Input) - (WhitePos)));
  end;

var
  MailSize: Integer;
begin
  // Okay, depending on the current state,
  // we do different things.

  // First check to see if the input is an okay message
  if StrLIComp(PChar(Input), '+OK', 3) = 0 then
  begin
    // We got an okay response, so check the state
    // to see what to do next
    case FCurrentState of
      psConnecting:
        begin
          // We are Connecting, so send user name
          SendCommand('USER ' + FUserName + CRLF);
          FCurrentState := psUser;
        end;
      psUser:
        begin
          // We already sent USER, so send pass
          SendCommand('PASS ' + FPassword + CRLF);
          FCurrentState := psPass;
        end;
      psPass:
        begin
          // Already sent pass, so send STAT
          SendCommand('STAT' + CRLF);
          FCurrentState := psStat;
        end;
      psStat:
        begin
          // Already sent STAT, so process results from STAT
          RemoveCRLF(Input);
          GetNums(FNumMessages, MailSize);

  {$ifdef DEBUG}
          if Assigned(FOnMailOutput) then
            FOnMailOutput(Self, Format('Messages: %d, MailSize: %d',
              [FNumMessages, MailSize]));
  {$endif}

          // If there are some messages,
          // try to retrieve headers for them
          if FNumMessages > 0 then
          begin
            // set the length of the email header array
            SetLength(FEmailHeaders, FNumMessages);
            // try to get top of the first message
            FCurrentState := psTop;
            FOnMessage := 1;
            SendCommand('TOP 1 0' + CRLF);
          end
          else // send a quit messag
          begin
            SendCommand('QUIT' + CRLF);
            FCurrentState := psQuit;
          end;
        end;
      psTop:
        begin
          // Okay, when doing a TOP request, the first thing returned is
          // the okay, and then more reads are sent with the actual
          // headers
          FCurrentState := psReadingHeaders;
          ProcessHeaderInput(Input);

          // We don't set strTemp to anything because
          // we don't want to send anything else at this point,
          // and just read in the headers
        end;
      psRetr:
        begin
          // Okay, when doing a Retr request, the first thing returned is
          // the okay, and then more reads are sent with the actual
          // headers
          FCurrentState := psReadingBody;
          ProcessBodyInput(Input);

          // We don't set strTemp to anything because
          // we don't want to send anything else at this point,
          // and just read in the headers
        end;
      psQuit:
        begin
  {$ifdef DEBUG}
          if Assigned(FOnMailOutput) then
            FOnMailOutput(Self, 'Host quit - closing socket');
  {$endif}
          FCurrentState := psClosed;
          Disconnect;
        end;
    end;
  end
  // check for error
  else if StrLIComp(PChar(Input), '-ERR', 4) = 0 then
  begin
    // pass the error on
    if Assigned(FOnErrorEvent) then
      FOnErrorEvent(Self, Input);
  {$ifdef DEBUG}
    if Assigned(FOnMailOutput) then
      FOnMailOutput(Self, 'Error: ' + Input + CRLF + 'Quitting');
  {$endif DEBUG}
    Disconnect;
  end
  else if FCurrentState = psReadingHeaders then
  begin
    // If we are in psReadingHeaders state then we are reading the headers.
    // when we have finished reading in the headers, we will
    // go send another request to try to read another header
    // or call QUIT if there isn't any left

    // We are requesting that 0 lines be sent after the headers.
    // This means that the headers will be sent, and then a blank
    // line will be sent. look for the blank line before sending
    // a request for another header
    ProcessHeaderInput(Input);
  end
  else if FCurrentState = psReadingBody then
  begin
    // If we are in psReadingBody state then we are reading the Body.
    // when we have finished reading in the headers, we will
    // go send another request to try to read another header
    // or call QUIT if there isn't any left

    // We are requesting that 0 lines be sent after the headers.
    // This means that the headers will be sent, and then a blank
    // line will be sent. look for the blank line before sending
    // a request for another header
    ProcessBodyInput(Input);
  end
  else
  begin
    // pass the error on
    if Assigned(FOnErrorEvent) then
      FOnErrorEvent(Self, Input);
    /////Output errors here!!
  {$ifdef DEBUG}
    if Assigned(FOnMailOutput) then
      FOnMailOutput(Self, 'Error - Unknown what we are doing right now:'+
        CRLF + Input);

  {$endif}
  end;
end;

procedure TMailChecker.CleanUp;
var
  ErrorCode: Integer;
begin
 ErrorCode := WSACleanup;
  if ErrorCode <> 0 then
    raise ESocketError.Create('Socket Error on WSACleanup API call');
end;

procedure TMailChecker.Connect;
begin
  CheckRequiredData;
  // First check to see if connected
  if FConnected then
    raise ESocketError.Create('Socket already open')
  // also check to see if trying to connect
  else if FCurrentState = psConnecting then
    raise ESocketError.Create('Already trying to connect');

  // Set state to connecting
  FCurrentState := psConnecting;
  FSocketCalled := False;
  // Clear out internal data used
  FNumMessages := 0;
  FHeaders := '';

  // clear the email headers array
  SetLength(FEmailHeaders, 0);
  SetLength(FRetrList, 0);

  // Now try to grab the host name
  // We will get a message when this returns.
  // Store the handle returned to so that we can
  // cancel the ASync request if need be
  FApiRequestHandle := WSAAsyncGetHostByName(FHandle, CM_GETHOSTNAME,
    PChar(FHost), FHostEntBuffer, SizeOf(FHostEntBuffer));

  // If the FApiRequestHandle is zero, then there was a problem
  if FApiRequestHandle = 0 then
    CheckSocketResult(-1, 'WSAAsyncGetHostByName');

  // The rest of the connecting is done after this message is recieved.

  // Optionally, I could start a timer to record how long
  // this takes and timeout after some time.
  // The timeout would envolve canceling the ASync request
  // using FApiRequestHandle
end;

constructor TMailChecker.Create(AHandle: THandle);
begin
  // copy the handle passed in
  FHandle := AHandle;

  // start out as closed
  FCurrentState := psClosed;
  FConnected := False;
  FSocketCalled := False;
  FSocket := INVALID_SOCKET;

  // Initialize private data members
  FUserName := '';
  FPassword := '';
  FHost := '';
  FPort := 110;
  FOnMessage := 0;
  FNumMessages := 0;

  FApiRequestHandle := 0;
  // Start up winsock
  Startup;
end;

destructor TMailChecker.Destroy;
begin
  // disconnect checks to see if we are connected
  Disconnect;
  // Close down winsock
  CleanUp;
  inherited;
end;

procedure TMailChecker.StartUp;
var
  ErrorCode: Integer;
  WSAData: TWSAData;
begin
  ErrorCode := WSAStartup($0101, WSAData);
  if ErrorCode <> 0 then
    raise ESocketError.Create('Socket Error on WSAStartup');
end;


procedure TMailChecker.Disconnect;
begin
 // Tell that we are closing
  if Assigned(FOnCloseEvent) then
    FOnCloseEvent(Self);

  // Cancel the AsyncRequest
  CancelAsyncRequest;
  // Now try a nice close if connected
  if FConnected or FSocketCalled then
    NiceClose;

  // mark the current state as closed
  FCurrentState := psClosed;
end;

procedure TMailChecker.SendCommand(StrCommand: string);
begin
  if FConnected then
  begin
  {$ifdef DEBUG}
    if Assigned(FOnMailOutput) then
      FOnMailOutput(Self, 'Sending:' + StrCommand);
  {$endif}
    if send(FSocket, Pointer(StrCommand)^, Length(StrCommand), 0) = SOCKET_ERROR then
      raise ESocketError.Create('Error on sending data (winsock.send)');
  end;
end;

procedure TMailChecker.ProcessHeaderInput(Input: string);
// This just processes the Input header string
// and does stuff depending on if all the header was recieved or not

  function CheckEnd(AString: string): Boolean;
  // Helper function that determines when a multi-line
  // message is done recieving
  begin
    if Pos(CRLF + '.' + CRLF, AString) <> 0 then
      Result := True
    else
      Result := False;
  end;
begin
  FHeaders := FHeaders + Input;
  if CheckEnd(FHeaders) then
  begin
    FillInHeader;
    // send header to client
  {$ifdef DEBUG}
    if Assigned(FOnMailOutput) then
      FOnMailOutput(Self, FHeaders);
  {$endif}

    // restart the headers at blank for a next message
    FHeaders := '';
    // Get any more headers left
    Inc(FOnMessage);
    if FOnMessage > FNumMessages then
    begin
      if Length(FRetrList)>0 then
      begin
        SendCommand('RETR '+IntToStr(FretrList[1]) + CRLF);
        FOnBodyMessage := 1;
        FCurrentState := psRetr;
      end
      else
      begin
      // None left, so send quit message
      SendCommand('QUIT' + CRLF);
      FCurrentState := psQuit;
      end;
    end
    else // get more headers
    begin
      FCurrentState := psTop;
      SendCommand('TOP ' + IntToStr(FOnMessage) + ' 0' + CRLF);
    end;
  end;
end;

procedure TMailChecker.ProcessBodyInput(Input: string);
// This just processes the Input header string
// and does stuff depending on if all the header was recieved or not

  function CheckEnd(AString: string): Boolean;
  // Helper function that determines when a multi-line
  // message is done recieving
  begin
    if Pos(CRLF + '.' + CRLF, AString) <> 0 then
      Result := True
    else
      Result := False;
  end;
begin
  FHeaders := FHeaders + Input;
  if CheckEnd(FHeaders) then
  begin
    FillInBody;
    // send header to client
  {$ifdef DEBUG}
    if Assigned(FOnMailOutput) then
      FOnMailOutput(Self, FHeaders);
  {$endif}

    // restart the headers at blank for a next message
    FHeaders := '';
    // Get any more headers left
    Inc(FOnBodyMessage);
    if FOnBodyMessage > FNumBodyMessages then
    begin
      // None left, so send quit message
      SendCommand('QUIT' + CRLF);
      FCurrentState := psQuit;
    end
    else // get more headers
    begin
      FCurrentState := psRetr;
      SendCommand('RETR ' + IntToStr(FRetrList[FOnBodyMessage]) + '' + CRLF);
    end;
  end;
end;

procedure TMailChecker.FillInHeader;
// Add header looks at the FHeaders and
// tokens out the sender and subject
// and adds it to the header array based on the
// FOnMessage
var
  tmpStr: string;
  tmpHeader: string;
  Loc: Integer;
  NumFound: Integer;
begin
  tmpHeader := Copy(FHeaders, 1, Length(FHeaders));

  Loc := 1;
  NumFound := 0;
  while (Loc <> 0) and (NumFound < 2) do
  begin
    // go through each line in the header looking for the
    // line that starts with 'From:' or 'Subject'
    Loc := Pos(CRLF, tmpHeader);
    if Loc <> 0 then
    begin
      // copy the first line into tmpStr
      tmpStr := Copy(tmpHeader, 1, Loc+1);
      if StrLIComp(PChar(tmpStr), 'From:', 5) = 0 then
      begin
        Inc(NumFound);
        //Delete the From from the tmpStr
        Delete(tmpStr, 1, 5);
        // trim any white spaces in front
        tmpStr := TrimLeft(tmpStr);
        // remove the CRLF
        RemoveCRLF(tmpStr);
        FEmailHeaders[FOnMessage-1].From := tmpStr;
      end
      else if StrLIComp(PChar(tmpStr), 'Subject:', 8) = 0 then
      begin
        Inc(NumFound);
        Delete(tmpStr, 1, 8);
        tmpStr := TrimLeft(tmpStr);
        // remove the CRLF
        RemoveCRLF(tmpStr);
        FEmailHeaders[FOnMessage-1].Subject := tmpStr;
        if Pos('BOKNING',Uppercase(tmpStr))>0 then
        begin
          FNumBodyMessages := Length(FRetrList)+1;
          SetLength(FRetrList,FNumBodyMessages);
          FRetrList[FNumBodyMessages] := FOnMessage;
        end;
      end;
      // Delete the first line from the tmpHeader
      Delete(tmpHeader, 1, Length(tmpStr));
    end;
  end;
end;

procedure TMailChecker.FillInBody;
// Add header looks at the FHeaders and
// tokens out the sender and subject
// and adds it to the header array based on the
// FOnMessage
var
  tmpStr: string;
  tmpHeader: string;
  Loc: Integer;
  NumFound: Integer;
begin
  tmpHeader := Copy(FHeaders, 1, Length(FHeaders));

  Loc := 1;
  NumFound := 0;
  while (Loc <> 0) and (NumFound < 3) do
  begin
    // go through each line in the header looking for the
    // line that starts with 'From:' or 'Subject'
    Loc := Pos(CRLF, tmpHeader);
    if Loc <> 0 then
    begin
      // copy the first line into tmpStr
      tmpStr := Copy(tmpHeader, 1, Loc+1);
      if StrLIComp(PChar(tmpStr), 'From:', 5) = 0 then
      begin
        Inc(NumFound);
        //Delete the From from the tmpStr
        Delete(tmpStr, 1, 5);
        // trim any white spaces in front
        tmpStr := TrimLeft(tmpStr);
        // remove the CRLF
        RemoveCRLF(tmpStr);
//        FEmailHeaders[FOnMessage-1].From := tmpStr;
      end
      else if StrLIComp(PChar(tmpStr), 'Subject:', 8) = 0 then
      begin
        Inc(NumFound);
        Delete(tmpStr, 1, 8);
        tmpStr := TrimLeft(tmpStr);
        // remove the CRLF
        RemoveCRLF(tmpStr);
//        FEmailHeaders[FOnMessage-1].Subject := tmpStr;
      end;
      // Delete the first line from the tmpHeader
      Delete(tmpHeader, 1, Length(tmpStr));
    end;
  end;
end;



procedure TMailChecker.ProcessGetHostNameMessage(
  var Message: TCMGetHostName);
var
  SockAddrIn: TSockAddrIn;
  InAddr: TInAddr;
  HostEnt: PHostEnt;
begin
  // We get this message after a successful (or failed)
  // lookup of the host. This means that FHostEnt
  // is full if an error didn't happen

  // First, kill the handle from the ASync API call
  // because we don't want to stop the request (we already got it)
  FApiRequestHandle := 0;

  // Now check for any errors
  if Message.SelectError <> 0 then
  begin
    // close the connection and raise an exception
    FCurrentState := psClosed;
    raise ESocketError.Create('Socket Error: ' +
      GetWinsockErrorString(Message.SelectError));
  end;

  // No error happened, so now we can use the FHostEnt
  // to fill in a SockAddrIn
  {$ifdef DEBUG}
  if Assigned(FOnMailOutput) then
    FOnMailOutput(Self, 'Initializing socket address');
  {$endif}

  FillChar(InAddr, SizeOf(InAddr), 0);
  HostEnt := @FHostEntBuffer;
  with InAddr, HostEnt^ do
  begin
    S_un_b.s_b1 := h_addr^[0];
    S_un_b.s_b2 := h_addr^[1];
    S_un_b.s_b3 := h_addr^[2];
    S_un_b.s_b4 := h_addr^[3];
  end;

  SockAddrIn.sin_family := PF_INET;
  SockAddrIn.sin_addr := InAddr;
  // alternativly have it input an ip address
  // instead of a host name
  {
  if Address <> '' then
    SockAddrIn.sin_addr.s_addr := inet_addr(PChar(Address))
  }
//  SockAddrIn.sin_port := htons(LookupService('POP3'));
//  if SockAddrIn.sin_port = 0 then
  SockAddrIn.sin_port := htons(FPort);

  // Now create the socket
  {$ifdef DEBUG}
  if Assigned(FOnMailOutput) then
    FOnMailOutput(Self, 'creating socket with winsock.socket call');
  {$endif}
  FSocket := socket(PF_INET, SOCK_STREAM, IPPROTO_IP);
  if FSocket = INVALID_SOCKET then raise ESocketError.Create('Can''t create new socket');
  // mark that we called the socket, so we can call closesocket
  // to free the resources
  FSocketCalled := True;

  // set the socket to async so we get messages on events
  // with the message CM_SOCKETMESSAGE
  CheckSocketResult(WSAAsyncSelect(FSocket, FHandle, CM_SOCKETMESSAGE,
		FD_CONNECT or FD_READ or FD_WRITE or FD_CLOSE), 'WSAAsyncSelect');
  // connect to the socket
  try
    CheckSocketResult(Winsock.connect(FSocket, SockAddrIn, SizeOf(SockAddrIn)),
      'connect');
  except
    FConnected := False;
    FCurrentState := psClosed;
    NiceClose;
    raise;
  end;

  {$ifdef DEBUG}
  if Assigned(FOnMailOutput) then
    FOnMailOutput(Self, 'Responding to messages now');
  {$endif}
end;

procedure TMailChecker.SetConnected(const Value: Boolean);
begin
  if Value then
    Connect
  else
    Disconnect;
end;

function TMailChecker.GetConnected: Boolean;
begin
  // if connecting or connected, return true
  // so we won't issue another connect request
  if (FCurrentState = psConnecting) or FConnected then
    Result := True
  else
    Result := False;
end;

procedure TMailChecker.CheckRequiredData;
{
  This procedure checks that the required input fields
  are all filled in. Otherwise, an exception is raised.
  If an exception was raise, it calls disconnect
  method
}
begin
  try
    if FHost = '' then
      raise ESocketError.Create('No host assigned');
    if FUserName = '' then
      raise ESocketError.Create('No user name specified');
  except
    on Exception do
      begin
        Disconnect;
        raise;
      end;
  end;
end;

procedure TMailChecker.CancelAsyncRequest;
// This helper function cancels the ASyncRequest
// if the FApiRequestHandle is not 0
begin
  if FApiRequestHandle <> 0 then
  begin
    WSACancelAsyncRequest(FApiRequestHandle);
    FApiRequestHandle := 0;
  end;
end;

function TMailChecker.GetEmailHeader(Index: Integer): TEmailHeader;
begin
  Result := FEmailHeaders[Index];
end;

procedure TMailChecker.SetHost(const Value: string);
begin
  FHost := Value;
  TrimLeft(FHost);
  TrimRight(FHost);
end;

procedure TMailChecker.SetUserName(const Value: string);
begin
  FUserName := Value;
  TrimLeft(FUserName);
  TrimRight(FUserName);
end;

end.
