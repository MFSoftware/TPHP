<?php

application_showConsoleWindow(false);

$form = gui_create('TForm');
gui_propSet($form, 'caption', 'PHP Version: ' . phpversion());

$btn = gui_create('TBitBtn');
gui_propSet($btn, 'caption', 'Hello, world!');
gui_setParent($btn, $form);

application_initialize();

gui_formSetMain($form);
form_show($form);

application_run();

?>