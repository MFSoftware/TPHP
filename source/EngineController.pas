unit EngineController;

interface

uses
  TPHPFunction, RttiProcedures, GUIWorks, ZendTypes, ZendApi, HZendTypes, Vcl.Buttons,
  PHPApplication, PHPMessages, Classes, Vcl.Forms, Vcl.StdCtrls, CommCtrl, About, PHPVcl, Vcl.Dialogs;

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
  //Engine.DefineFunction('gui_invokeMethod', @gui_invokeMethod);
  Engine.DefineFunction('gui_destroy', @gui_destroy);
  Engine.DefineFunction('gui_create', @gui_create);
  Engine.DefineFunction('gui_class', @gui_class);
  Engine.DefineFunction('gui_getHandle', @gui_getHandle);
  Engine.DefineFunction('gui_setParent', @gui_setParent);

  Engine.DefineFunction('form_show', @form_show);

  Engine.DefineFunction('application_initialize', @application_initialize);
  Engine.DefineFunction('application_showConsoleWindow', @application_showConsoleWindow);
  Engine.DefineFunction('application_terminate', @application_terminate);
  Engine.DefineFunction('application_minimize', @application_minimize);
  Engine.DefineFunction('application_restore', @application_restore);
  Engine.DefineFunction('application_set_title', @application_set_title);
  Engine.DefineFunction('application_get_title', @application_get_title);
  Engine.DefineFunction('application_run', @application_run);
  Engine.DefineFunction('application_setterHandler', @application_setterHandler);
  Engine.DefineFunction('application_getterHandler', @application_getterHandler);

  Engine.DefineFunction('messagebox', @gui_messagebox_show);
  Engine.DefineFunction('showMessage', @gui_showmessage);
end;

procedure DefineAllClasses;
begin
  RegisterClasses([TButton, TForm, TLabel, TBitBtn]);
end;

end.
