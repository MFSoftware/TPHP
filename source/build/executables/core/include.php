<?php

$form = gui_create('TForm', 0);
gui_propSet($form, 'width', 300);
gui_propSet($form, 'height', 300);

$btn = gui_create('TButton', $form);
gui_setParent($btn, $form);
gui_propSetEnum($btn, 'Align', 'alLeft');

application_initialize();

gui_formSetMain($form);
gui_invokeMethod($form, 'show', null);

application_run();

?>