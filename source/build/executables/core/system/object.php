<?

class TObject {
	public $handle;

	public function __construct($class = null, $owner = 0){
		$this->handle = ($class == null) ? gui_create(get_class($this), $owner) : gui_create($class, $owner);
	}

	public function __get($name)
	{
		if (gui_propExists($this->handle, $name))
			return gui_propGet($this->handle, $name);
		else if (substr($name, -2) == 'on')
            return gui_getObjectEvent($this->handle, substr($name, 0, -2));
	}
	
	public function __set($name, $value)
	{
		if (gui_propExists($this->handle, $name) && substr($name, 0, 2) != 'on')
			($value instanceof TObject) ? gui_propSet($this->handle, $name, $value->handle) : gui_propSet($this->handle, $name, $value);
		else if (substr($name, 0, 2) === 'on')
			(gui_eventExists($this->handle, $name)) ? gui_setObjectEvent($this->handle, $name, $value) : showMessage('Error: event didnt exists.');
	}
	
	public function __call($method, $args)
	{
        gui_invokeMethod($this->handle, $method, ...$args);
	}
}

?>