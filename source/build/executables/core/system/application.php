<?

class Application {
	public static function __callStatic($method, $args)
	{
		if (substr($method, 0, 3) == 'set')
			(count($args) == 1) ? application_setterHandler(substr($method, 3), $args[0]) : messageBox('', 'Error', 16);
		else if (substr($method, 0, 3) == 'get')
			return application_getterHandler(substr($method, 3));
		else
			application_invokeMethod($method, $args);
	}

	public static function showConsoleWindow(bool $value){
		application_showConsoleWindow($value);
	}

	public static function setMainForm($form){
		($form instanceof TForm) ? application_formSetMain($form->handle) : application_formSetMain($value);
	}
}

?>