<?

require_once('system/object.php');
require_once('system/component.php');
require_once('system/application.php');
require_once('system/class.php');

foreach (new DirectoryIterator('core/controls') as $controlfileInfo) {
    if ($controlfileInfo->getFilename() != '.' && $controlfileInfo->getFilename() != '..')
    	require_once('controls/' . $controlfileInfo->getFilename());
}

foreach (new DirectoryIterator('core/classes') as $controlfileInfo) {
    if ($controlfileInfo->getFilename() != '.' && $controlfileInfo->getFilename() != '..')
    	require_once('classes/' . $controlfileInfo->getFilename());
}

?>