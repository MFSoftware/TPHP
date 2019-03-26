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
  RttiProcedures in 'src\RttiProcedures.pas',
  EngineController in 'src\EngineController.pas',
  DelphiFunctions in 'src\DelphiFunctions.pas',
  AZendApi in 'src\packages\core\AZendApi.pas',
  HZendTypes in 'src\packages\core\HZendTypes.pas',
  PHPAPI in 'src\packages\core\PHPAPI.pas',
  About in 'src\packages\About.pas',
  PHPApplication in 'src\controls\PHPApplication.pas',
  PHPMessages in 'src\controls\PHPMessages.pas',
  PHPControls in 'src\packages\PHPControls.pas',
  PHPCommons in 'src\packages\core\PHPCommons.pas',
  PHPConsole in 'src\controls\PHPConsole.pas',
  AboutForm in 'src\forms\AboutForm.pas' {Form1},
  ZendArray in 'src\packages\core\ZendArray.pas';

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
  Php: TpsvCustomPHP;
  Tmp: Pointer;

begin
  try
    SetConsoleTitle('TPHP Engine');

    Engine := TPHPEngine.Create(nil);
    Engine.IniPath := 'php.ini';

    DefineAllFunctions(Engine);
    DefineAllClasses(Engine);

    Engine.StartupEngine;

    Php := GetPHPEngine();

    Tmp := GetProcAddress(PHP5dll, 'zend_error_cb');
    asm
      mov edx, dword ptr [tmp]
      mov dword ptr [edx], offset zend_error_cb2
    end;

    if ParamCount = 0 then
    begin
      if FileExists('core/include.php') then
        Write(php.RunFile('core/include.php'))
      else
      begin
        WriteLn('TPHP by MagicFun (based on CodeThurst)');
        WriteLn('Usage: TPHP <filename.php>');
        WriteLn('');
        WriteLn('Comand line interface:');
        WriteLn(' Show this help message: TPHP -h');
        Halt(1);
      end;
    end
    else if (ParamCount = 1) then
    begin
      if (ParamStr(1) = '-h') or (ParamStr(1) = '-help') or (ParamStr(1) = '-?') or (ParamStr(1) = '/h') or (ParamStr(1) = '/help') or (ParamStr(1) = '/?') then
      begin
        WriteLn('_____________________  ___ _____________ ');
        WriteLn('\__    ___/\______   \/   |   \______   \');
        WriteLn('  |    |    |     ___/    ~    \     ___/');
        WriteLn('  |    |    |    |   \    Y    /    |    ');
        WriteLn('  |____|    |____|    \___|_  /|____|    ');
        WriteLn('                            \/           ');
        WriteLn(' by MagicFun (based on CodeThurst)');
        WriteLn('Usage: TPHP <filename.php>');
        WriteLn('');
        WriteLn('Comand line interface:');
        WriteLn(' Show this help message: TPHP -h');
      end;
    end
    else
    begin
      if FileExists('core/include.php') then
        Write(Php.RunFile('core/include.php'))
      else
      begin
        if FileExists(ParamStr(1)) then
          Write(Php.RunFile(AnsiString(ParamStr(1))))
        else
          WriteLn('File "'+ ParamStr(1) +'" not found.');
      end;
    end;

    Php.ShutdownRequest;
  except
    on E: Exception do
      MessageDlg(E.ClassName + ': ' + E.Message, mtError, [mbOk], 0);
  end;
end.
