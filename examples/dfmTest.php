<?php

$form = gui_create('TForm', 0);
gui_componentToFile($form, 'test.dfm');

$newForm = gui_componentFromFile('test.dfm');

application_initialize();

gui_formSetMain($newForm);
gui_invokeMethod($newForm, 'show', null);

application_run();

?>