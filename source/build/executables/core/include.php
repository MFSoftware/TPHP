<?
test();
$form = gui_create('TForm', 0);
gui_propSet($form, 'width', 300);
gui_propSet($form, 'height', 300);

$btn1 = gui_create('TButton', $form);
gui_setParent($btn1, $form);
gui_propSetEnum($btn1, 'align', 'alLeft');

$btn2 = gui_create('TButton', $form);
gui_setParent($btn2, $form);
gui_propSetEnum($btn2, 'align', 'alRight');

application_initialize();

gui_formSetMain($form);
gui_invokeMethod($form, 'show', null);

application_run();

?>