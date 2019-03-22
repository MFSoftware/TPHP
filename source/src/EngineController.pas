unit EngineController;

interface

uses
  TPHPFunction, RttiProcedures, GUIWorks, ZendTypes, ZendApi, HZendTypes, Vcl.Buttons, PHPControls, Vcl.ExtCtrls,
  PHPApplication, PHPMessages, Classes, Vcl.Forms, Vcl.StdCtrls, CommCtrl, About, Vcl.Dialogs, Vcl.Graphics;

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
  Engine.DefineFunction('gui_formSetMain', @gui_formSetMain);
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

  Engine.DefineFunction('class_create', @class_create);
  Engine.DefineFunction('class_propGet', @class_propGet);

  Engine.DefineFunction('application_initialize', @application_initialize);
  Engine.DefineFunction('application_showConsoleWindow', @application_showConsoleWindow);
  Engine.DefineFunction('application_terminate', @application_terminate);
  Engine.DefineFunction('application_minimize', @application_minimize);
  Engine.DefineFunction('application_restore', @application_restore);
  Engine.DefineFunction('application_setTitle', @application_set_title);
  Engine.DefineFunction('application_getTitle', @application_get_title);
  Engine.DefineFunction('application_run', @application_run);
  Engine.DefineFunction('application_setterHandler', @application_setterHandler);
  Engine.DefineFunction('application_getterHandler', @application_getterHandler);

  Engine.DefineFunction('messageBox', @gui_messagebox_show);
  Engine.DefineFunction('showMessage', @gui_showmessage);
end;

procedure DefineAllClasses;
begin
  RegisterClasses([TButton, TForm, TLabel, TBitBtn, TStringList, TPanel]);
end;

end.
