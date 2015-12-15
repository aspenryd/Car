unit WinsockError;

interface

uses Windows;

procedure ShowWinsockError(Handle: HWND; ErrorCode: Integer);
function GetWinsockErrorString(ErrorCode: Integer): string;


implementation

uses Winsock, SysUtils;

procedure ShowWinsockError(Handle: HWND; ErrorCode: Integer);
const
  cErrorFormat = 'Winsock error (%d):'+#13#10;
var
  ErrorMessage: string;
begin
  ErrorMessage := Format(cErrorFormat, [ErrorCode]);
  ErrorMessage := ErrorMessage + '"' + GetWinsockErrorString(ErrorCode) + '"';
  MessageBox(Handle, PChar(ErrorMessage), 'Winsock Error',
    MB_ICONEXCLAMATION or MB_OK);
end;

function GetWinsockErrorString(ErrorCode: Integer): string;
begin
  case ErrorCode of
    WSAEACCES: Result := 'Permission denied.';
    WSAEADDRINUSE: Result := 'Address already in use.';
    WSAEADDRNOTAVAIL: Result := 'Cannot assign requested address.';
    WSAEAFNOSUPPORT: Result := 'Address family not supported by protocol family.';
    WSAEALREADY: Result := 'Operation already in progress.';
    WSAECONNABORTED: Result := 'Software caused connection abort.';
    WSAECONNREFUSED: Result := 'Connection refused.';
    WSAECONNRESET: Result := 'Connection reset by peer.';
    WSAEDESTADDRREQ: Result := 'Destination address required.';
    WSAEFAULT: Result := 'Bad address.';
    WSAEHOSTDOWN: Result := 'Host is down.';
    WSAEHOSTUNREACH: Result := 'No route to host.';
    WSAEINPROGRESS: Result := 'Operation now in progress.';
    WSAEINTR: Result := 'Interrupted function call.';
    WSAEINVAL: Result := 'Invalid argument.';
    WSAEISCONN: Result := 'Socket is already connected.';
    WSAEMFILE: Result := 'Too many open files.';
    WSAEMSGSIZE: Result := 'Message too long.';
    WSAENETDOWN: Result := 'Network is down.';
    WSAENETRESET: Result := 'Network dropped connection on reset.';
    WSAENETUNREACH: Result := 'Network is unreachable.';
    WSAENOBUFS: Result := 'No buffer space available.';
    WSAENOPROTOOPT: Result := 'Bad protocol option.';
    WSAENOTCONN: Result := 'Socket is not connected.';
    WSAENOTSOCK: Result := 'Socket operation on non-socket.';
    WSAEOPNOTSUPP: Result := 'Operation not supported.';
    WSAEPFNOSUPPORT: Result := 'Protocol family not supported.';
    WSAEPROCLIM: Result := 'Too many processes.';
    WSAEPROTONOSUPPORT: Result := 'Protocol not supported.';
    WSAEPROTOTYPE: Result := 'Protocol wrong type for socket.';
    WSAESHUTDOWN: Result := 'Cannot send after socket shutdown.';
    WSAESOCKTNOSUPPORT: Result := 'Socket type not supported.';
    WSAETIMEDOUT: Result := 'Connection timed out.';
    WSAEWOULDBLOCK: Result := 'Resource temporarily unavailable.';
    WSAHOST_NOT_FOUND: Result := 'Host not found.';
//    WSA_INVALID_HANDLE: Result := 'Specified event object handle is invalid.';
//    WSA_INVALID_PARAMETER: Result := 'One or more parameters are invalid.';
//    WSAINVALIDPROCTABLE: Result := 'Invalid procedure table from service provider.';
//    WSAINVALIDPROVIDER: Result := 'Invalid service provider version number.';
//    WSA_IO_PENDING: Result := 'Overlapped operations will complete later.';
//    WSA_IO_INCOMPLETE: Result := 'Overlapped I/O event object not in signaled state.';
//    WSA_NOT_ENOUGH_MEMORY: Result := 'Insufficient memory available.';
    WSANOTINITIALISED: Result := 'Successful WSAStartup not yet performed.';
    WSANO_DATA: Result := 'Valid name, no data record of requested type.';
    WSANO_RECOVERY: Result := 'This is a non-recoverable error.';
//    WSAPROVIDERFAILEDINIT: Result := 'Unable to initialize a service provider.';
//    WSASYSCALLFAILURE: Result := 'System call failure.';
    WSASYSNOTREADY: Result := 'Network subsystem is unavailable.';
    WSATRY_AGAIN: Result := 'Non-authoritative host not found.';
    WSAVERNOTSUPPORTED: Result := 'WINSOCK.DLL version out of range.';
    WSAEDISCON: Result := 'Graceful shutdown in progress.';
//    WSA_OPERATION_ABORTED: Result := 'Overlapped operation aborted.';
  end; // case
  if Result = '' then Result := 'Unknown Error';
end;

end.
 