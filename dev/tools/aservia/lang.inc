const
{$define lang_en}
{$ifdef lang_en}
  str_server = 'Aservia 1.0 (en) / Alexander N Zubakov, 2006; Lars Olson, 2008';
  str_qcom = 'Type q or quit to shutdown server';
  str_close = '#####Shutdown Server';
  str_wait = '#####Wait for connection... ';
  str_connection = '#####Connection!';
  str_socket = '#####Socket: ';
  str_runserver = '#####Run server: ';
  str_requestfrom = '#####Request from ';
  str_denied = '#####Denied!'#13#10;
  str_request = '#####Request: ';
{$else}
  str_server = 'Aservia 1.0 (ru) / Alexander N Zubakov, 2006; Lars Olson, 2008';
  str_qcom = '������ q ��� quit �⮡� ��⠭����� �ࢥ�';
  str_close = '#####�����襭�� ࠡ��� �ࢥ�';
  str_wait = '#####�������� ᮥ�������...';
  str_connection = '#####����������!';
  str_socket = '#####�����: ';
  str_runserver = '#####����� �ࢥ�: ';
  str_requestfrom = '#####����� �� ';
  str_denied = '#####����� ����饭!'#13#10;
  str_request = '#####�����: ';
{$endif}