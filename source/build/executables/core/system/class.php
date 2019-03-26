<?

class TClass {
	public $handle;

	public function __construct($class = null){
		$this->handle = ($class == null) ? class_create(get_class($this)) : class_create($class);
	}

	public function __get($name)
	{
		if (gui_propExists($this->handle, $name))
			return class_propGet($this->handle, $name);
	}
	
	public function __set($name, $value)
	{
		if (gui_propExists($this->handle, $name))
			($value instanceof TObject) ? class_propSet($this->handle, $name, $value->handle) : class_propSet($this->handle, $name, $value);
	}
	
	public function __call($method, $args)
	{
        gui_invokeMethod($this->handle, $method, ...$args);
	}
}

?>