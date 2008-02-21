unit pwtypes;

{$IFDEF FPC}{$MODE OBJFPC}{$H+}{$ENDIF}
{$IFDEF WIN32}{$DEFINE WINDOWS}{$ENDIF}
interface

type
  // obsolete
  TStrArray = array of string;

  // Below aliases reduce verbose line noise in long procedure declarations.
  // This goes against pascal's verbosity heritage, but extremely long 
  // declarations, (esp. ones with CONST and VAR in them) span far too wide
  // to remain redable. AStr is also safer than abstract "string" type with 
  // regards to {$H+} not being on due to a bug or programmer mistake
  astr = ansistring;
  AstrArray = array of astr;
  bln = boolean;

const // platform specific directory slash (Mac not supported yet)
  {$IFDEF UNIX}SLASH = '/';{$ENDIF}
  {$IFDEF WINDOWS}SLASH = '\';{$ENDIF}
  SLASHES = ['\', '/'];

const
  // CGI uses #13#10 no matter what OS
  CGI_CRLF = #13#10; 
  // default program extension
  EXT={$IFDEF WINDOWS}'.exe'{$ENDIF} {$IFDEF UNIX}''{$ENDIF};

{$IFNDEF FPC} // delphi compatability

const
  DirectorySeparator = '\';  // TODO:  delphi VERSION check & KYLIX compat
  PathDelim = DirectorySeparator;
  DriveDelim = ':';          // ...
  PathSep = ';';             // .. 


type
  UInt64 = Int64;  

  {$EXTERNALSYM INT_PTR}
  {$EXTERNALSYM UINT_PTR}
  {$EXTERNALSYM LONG_PTR}
  {$EXTERNALSYM ULONG_PTR}
  {$EXTERNALSYM DWORD_PTR}
  INT_PTR = Longint;
  UINT_PTR = LongWord;
  LONG_PTR = Longint;
  ULONG_PTR = LongWord;
  DWORD_PTR = LongWord;
  PINT_PTR = ^INT_PTR;
  PUINT_PTR = ^UINT_PTR;
  PLONG_PTR = ^LONG_PTR;
  PULONG_PTR = ^ULONG_PTR;

  PtrInt = Longint;
  PtrUInt = Longword;
  PPtrInt = ^PtrInt;
  PPtrUInt = ^PtrUInt;

  {$EXTERNALSYM SIZE_T}
  {$EXTERNALSYM SSIZE_T}
  SIZE_T = ULONG_PTR;
  SSIZE_T = LONG_PTR;
  PSIZE_T = ^SIZE_T;
  PSSIZE_T = ^SSIZE_T;

  SizeInt = SSIZE_T;
  SizeUInt = SIZE_T;
  PSizeInt = PSSIZE_T;
  PSizeUInt = PSIZE_T;
{$ENDIF}

{$IFDEF FPC}
const
// commenting is VP fix. These idents are in a different unit there.
  PathDelim={System.}DirectorySeparator;
  DriveDelim={System.}DriveSeparator;
  PathSep={System.}PathSeparator;
  MAX_PATH={System.}MaxPathLen;
{$ENDIF}


implementation

end.

