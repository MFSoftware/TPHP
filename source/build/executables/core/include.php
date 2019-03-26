<?

require_once('core/start.php');

application::initialize();

$mainForm = new TForm();
$mainForm->caption = 'Form Caption';
$mainForm->show();

$panel = new TPanel();

file_put_contents('test.txt', gui_methodParams($mainForm->handle, 'show'));

$button = new TButton($mainForm);
$button->align = 'alLeft';
$button->width = $mainForm->width / 2;
$button->caption = 'PHP Version: ' . phpversion();
gui_setParent($button->handle, $panel->handle);
gui_setParent($panel->handle, $mainForm->handle);

application::setMainForm($mainForm);

application::run();

?>