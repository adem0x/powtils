{ Modified March 2008 by Lars Olson. Aservia (web server).
  Based on nYume Server 

+-----------------------------------------------+------------+
 ������ zserver 1.1                            | 17.02.2006 
+-----------------------------------------------+------------+
 ��������:                                                  
   � ������ ���������� ����� ��� �������� ������� �� ������ 
   TCP ����������                                           
                                                            
 �������������:                                             
   ������ ������������ ��� ������������� � ���������������  
   �������������.                                           
   �� ������ ����� ������������ �/��� �������������� ������ 
   �� ������ ����������. �� �� ������ ����� ��������������  
   ���� ������ � ���������� ����.                           
                                                            
 �����:                                      
   Alexander N Zubakov                       
                                             
 � 2006 Alexander N Zubakov (original author)
 � 2008 Lars Olson (modifications)
 All Rights Reserved                                      
+------------------------------------------------------------+
}
unit zserver;
{$mode Delphi}
{$SMARTLINK ON}
{$LONGSTRINGS ON}
interface
uses
  Sockets;
  
const
  packet_size = 56000;
  
type
  TzServer = class(TObject)
  private
    sAddr     : TINetSockAddr;
    MainSocket: longint;
    conn  : array of longint;
    ip    : array of string;
    ccount: longint;
    csock : longint;
    function TryBind: boolean;
  public
    constructor Create;
    function InitConnection(const ip: string; port: word): boolean;
    function  Connect: longint;
    procedure Disconnect(socket_index: longint);
    procedure Stop;
    procedure sWrite(str: string);
    function  sRead: string;
    procedure select(socket_index: longint);
    function getip(socket_index: longint): string;
  end;

implementation
uses
  {$ifdef unix}baseunix, unix,{$endif}
  {$ifdef windows}windows,{$endif}
  pwstrutil, pwtypes;

function TzServer.TryBind: boolean;
begin
  result:= Bind(MainSocket, saddr, SizeOf(saddr));
end;

constructor TzServer.Create;
begin
  inherited Create;
  ccount := 0;
end;

{ User must call this after constructing, to bind IP and Port. 
  Returns false if problem }
function TzServer.InitConnection(const ip: string; port: word): boolean;
begin
  result:= false;
  MainSocket := Socket(AF_INET, SOCK_STREAM, 0);
  saddr.Family := AF_INET;
  saddr.Port   := htons(port);
  saddr.Addr   := LongWord(StrToNetAddr(ip));
  if TryBind then begin Listen(MainSocket,1); result:= true; end;
end;

function TzServer.Connect;
var sock     : longint;
    sAddrSize: longint;
begin
  sAddrSize := SizeOf(sAddr);
  sock := Accept(MainSocket, sAddr, sAddrSize);
  if sock <> -1 then begin
    inc(ccount); setLength(conn, ccount); setLength(ip, ccount);
    ip[ccount - 1] := NetAddrToStr(in_addr(sAddr.Addr));
    conn[ccount - 1] := sock; 
    csock := sock;
  end;
  Result := ccount - 1;
end;

procedure TzServer.Disconnect;
begin
  if socket_index < ccount then CloseSocket(conn[socket_index]);
end;
  
procedure TzServer.Stop;
var i: cardinal;
begin
  if ccount > 0 then for i := 0 to ccount - 1 do CloseSocket(conn[i]);
  Shutdown(MainSocket, 2);
  CloseSocket(MainSocket);
end;

procedure TzServer.select;
begin
  if socket_index < ccount then csock := conn[socket_index];
end;

function TzServer.getip;
begin
  if socket_index < ccount then Result := ip[socket_index] else Result := '';
end;

procedure TzServer.sWrite;
var i: cardinal;
    s: integer;
begin
  s:= Length(str);
  if s < packet_size then i := s else i := packet_size;
  while s > 0 do begin
    Send(csock, pointer(str)^, i, 0);
    delete(str, 1, i);
    s:= s - packet_size;
    if s < packet_size then i := s;
  end;
end;
  
function TzServer.sRead;
var buf  : string;
    count: integer;
begin
  setLength(buf, packet_size);
  count := Recv(csock, pointer(buf)^, packet_size, 0);
  setLength(buf, count);
  Result := buf;
end;  

end.
