program TPHP;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  WinApi.Windows,
  Vcl.Forms,
  TPHPFunction,
  PHPLoader,
  ZendTypes,
  Vcl.Dialogs,
  System.UITypes,
  ZendApi,
  RttiProcedures in 'RttiProcedures.pas',
  EngineController in 'EngineController.pas',
  DelphiFunctions in 'DelphiFunctions.pas',
  AZendApi in 'packages\core\AZendApi.pas',
  HZendTypes in 'packages\core\HZendTypes.pas',
  PHPAPI in 'packages\core\PHPAPI.pas',
  About in 'packages\About.pas',
  PHPVcl in 'packages\PHPVcl.pas',
  PHPApplication in 'controls\PHPApplication.pas',
  PHPMessages in 'controls\PHPMessages.pas';

procedure zend_error_cb2(AType: Integer; const AFname: PAnsiChar; const ALineNo: UINT; const AFormat: PAnsiChar; Args: va_list)cdecl;
var
  LText: string;
  LBuffer: array [0 .. 4096] of AnsiChar;
begin
  case AType of
    E_ERROR:
      LText := 'Fatal Error in ';
    E_WARNING:
      LText := 'Warning in ';
    E_CORE_ERROR:
      LText := 'Core Error in ';
    E_CORE_WARNING:
      LText := 'Core Warning in ';
    E_COMPILE_ERROR:
      LText := 'Compile Error in ';
    E_COMPILE_WARNING:
      LText := 'Compile Warning in ';
    E_USER_ERROR:
      LText := 'User Error in ';
    E_USER_WARNING:
      LText := 'User Warning in ';
    E_RECOVERABLE_ERROR:
      LText := 'Recoverable Error in ';
    E_PARSE:
      LText := 'Parse Error in ';
    E_NOTICE:
      LText := 'Notice in ';
    E_USER_NOTICE:
      LText := 'User Notice in ';
    E_STRICT:
      LText := 'Strict Error in ';
    E_CORE:
      LText := 'Core Error in ';
  else
    LText := 'Unknown Error(' + inttostr(AType) + '): ';
  end;

  wvsprintfA(LBuffer, AFormat, Args);

  LText := LText + UTF8ToAnsi(AFname) + '(' + inttostr(ALineNo) + '): ' + String(LBuffer);

  case AType of
    E_WARNING, E_CORE_WARNING, E_COMPILE_WARNING, E_USER_WARNING:
      MessageDlg(LText, mtWarning, [mbOk], 0);
    E_NOTICE, E_USER_NOTICE:
      MessageDlg(LText, mtInformation, [mbOk], 0);
  else
    begin
      MessageDlg(LText, mtError, [mbOk], 0);
      _zend_bailout(AFname, ALineNo);
    end;
  end;
end;

var
  Engine: TPHPEngine;
  PHP: TpsvCustomPHP;
  Tmp: Pointer;

begin
  try
    Engine := TPHPEngine.Create(nil);
    Engine.IniPath := 'php.ini';

    EngineController.DefineAllFunctions(Engine);
    EngineController.DefineAllClasses(Engine);

    Engine.StartupEngine;
    php := TEngineCt();

    tmp := GetProcAddress(PHP5dll, 'zend_error_cb');
    asm
      mov edx, dword ptr [tmp]
      mov dword ptr [edx], offset zend_error_cb2
    end;

    if ParamCount = 0 then
    begin
      if FileExists('core/include.php') then
        php.RunFile('core/include.php')
      else
      begin
        WriteLn('Usage: TPHP <filename.php>');
        Halt(1);
      end;
    end
    else
    begin
      if FileExists('core/include.php') then
        php.RunFile('core/include.php')
      else
      begin
        if FileExists(ParamStr(1)) then
          Write(php.RunFile(AnsiString(ParamStr(1))))
        else
          WriteLn('File "'+ ParamStr(1) +'" not found.');
      end;
    end;

    php.ShutdownRequest;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
