unit EngineController;

interface

uses
  TPHPFunction, RttiProcedures, GUIWorks, ZendTypes, ZendApi, HZendTypes, Vcl.Buttons, PHPControls, Vcl.ExtCtrls,
  PHPApplication, PHPMessages, Classes, Vcl.Forms, Vcl.StdCtrls, CommCtrl, About, Vcl.Dialogs, Vcl.Graphics,
  PHPConsole, ZendArray, SysUtils;

procedure DefineAllFunctions(Engine: TPHPEngine);
procedure DefineAllClasses(Engine: TPHPEngine);

implementation

procedure DefineAllFunctions;
begin
  Engine.DefineFunction('core_about', @core_about);

  Engine.DefineFunction('gui_propGet', @gui_propGet);
  Engine.DefineFunction('gui_propSet', @gui_propSet);
  Engine.DefineFunction('gui_propExists', @gui_propExists);
  Engine.DefineFunction('gui_propList', @gui_propList);
  Engine.DefineFunction('gui_methodExists', @gui_methodExists);
  Engine.DefineFunction('gui_methodsList', @gui_methodsList);
  Engine.DefineFunction('gui_invokeMethod', @gui_invokeMethod);
  Engine.DefineFunction('gui_destroy', @gui_destroy);
  Engine.DefineFunction('gui_create', @gui_create);
  Engine.DefineFunction('gui_class', @gui_class);
  Engine.DefineFunction('gui_is', @gui_is);
  Engine.DefineFunction('gui_getHandle', @gui_getHandle);
  Engine.DefineFunction('gui_setParent', @gui_setParent);
  Engine.DefineFunction('gui_componentToString', @gui_componentToString);
  Engine.DefineFunction('gui_stringToComponent', @gui_stringToComponent);
  Engine.DefineFunction('gui_componentFromFile', @gui_componentFromFile);
  Engine.DefineFunction('gui_componentToFile', @gui_componentToFile);
  Engine.DefineFunction('gui_propSetEnum', @gui_propSetEnum);
  Engine.DefineFunction('gui_propGetEnum', @gui_propGetEnum);
  Engine.DefineFunction('gui_setObjectEvent', @gui_setObjectEvent);
  Engine.DefineFunction('gui_eventExists', @gui_eventExists);
  Engine.DefineFunction('gui_findControl', @gui_findControl);
  Engine.DefineFunction('gui_propType', @gui_propType);
  Engine.DefineFunction('gui_methodParams', @gui_methodParams);

  Engine.DefineFunction('class_create', @class_create);
  //Engine.DefineFunction('class_propGet', @class_propGet);

  Engine.DefineFunction('application_showConsoleWindow', @application_showConsoleWindow);
  Engine.DefineFunction('application_setterHandler', @application_setterHandler);
  Engine.DefineFunction('application_getterHandler', @application_getterHandler);
  Engine.DefineFunction('application_invokeMethod', @application_invokeMethod);
  Engine.DefineFunction('application_formSetMain', @application_formSetMain);

  Engine.DefineFunction('readLn', @console_readLn);
  Engine.DefineFunction('writeLn', @console_writeLn);

  Engine.DefineFunction('messageBox', @gui_messagebox_show);
  Engine.DefineFunction('showMessage', @gui_showmessage);
end;

procedure DefineAllClasses;
begin
  RegisterClasses([TButton, TForm, TLabel, TBitBtn, TStringList, TPanel, TFont, TImage]);
end;

end.
