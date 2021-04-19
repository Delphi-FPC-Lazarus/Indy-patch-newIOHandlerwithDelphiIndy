unit IdOpenSSLConsts;

interface

{$i IdCompilerDefines.inc}

const
  CLibCryptoRaw = 'libcrypto';
  CLibSSLRaw = 'libssl';

  SSLDLLVers: array [0..1] of string = ('', '.1.1');

  CLibCrypto =
    {$IFDEF CPU32}CLibCryptoRaw + '-1_1.dll'{$ENDIF}
    {$IFDEF CPU64}CLibCryptoRaw + '-1_1-x64.dll'{$ENDIF}
    ;
  CLibSSL =
    {$IFDEF CPU32}CLibSSLRaw + '-1_1.dll'{$ENDIF}
    {$IFDEF CPU64}CLibSSLRaw + '-1_1-x64.dll'{$ENDIF}
    ;


//
// Modify PL 04/2021
// Fehlende Defs aus IdGlobal/IdCTypes - Kompilierbarkeit mit älterer Indy Version
//
const
  IdNilHandle = THandle(0);

type
  TIdLibHandle = THandle;

  TIdC_SIZET = NativeUInt;
  PIdC_SIZET = ^TIdC_SIZET;

  TIdC_TIMET = NativeUInt;
  PIdC_TIMET = ^TIdC_TIMET;

  TIdLibFuncName = String;
  PIdLibFuncNameChar = PChar;

  PPIdAnsiChar = PPAnsiChar;
  PPPIdAnsiChar = ^PPIdAnsiChar;

  PPByte = ^PByte;
  PPPByte = ^PPByte;

  TIdC_INT   = Integer;
  PIdC_INT   = ^TIdC_INT;
  PPIdC_INT  = ^PIdC_INT;
  TIdC_UINT  = Cardinal;
  PIdC_UINT  = ^TIdC_UINT;

  TIdC_TM = record
    tm_sec: TIdC_INT;         (* seconds,  range 0 to 59          *)
    tm_min: TIdC_INT;         (* minutes, range 0 to 59           *)
    tm_hour: TIdC_INT;        (* hours, range 0 to 23             *)
    tm_mday: TIdC_INT;        (* day of the month, range 1 to 31  *)
    tm_mon: TIdC_INT;         (* month, range 0 to 11             *)
    tm_year: TIdC_INT;        (* The number of years since 1900   *)
    tm_wday: TIdC_INT;        (* day of the week, range 0 to 6    *)
    tm_yday: TIdC_INT;        (* day in the year, range 0 to 365  *)
    tm_isdst: TIdC_INT;       (* daylight saving time             *)
  end;
  PIdC_TM = ^TIdC_TM;
  PPIdC_TM = ^PIdC_TM;

function LoadLibFunction(const ALibHandle: TIdLibHandle; const AProcName: TIdLibFuncName): Pointer;

implementation

uses Windows;

function LoadLibFunction(const ALibHandle: TIdLibHandle; const AProcName: TIdLibFuncName): Pointer;
begin
  {$I IdRangeCheckingOff.inc}
  Result := {$IFDEF WINDOWS}Windows.{$ENDIF}GetProcAddress(ALibHandle, PIdLibFuncNameChar(AProcName));
  {$I IdRangeCheckingOn.inc}
end;

end.
