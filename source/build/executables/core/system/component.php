<?

class TComponent extends TObject {
	public function __construct($owner = 0){
		$this->handle = (is_object($owner)) ? gui_create(get_class($this), $owner->handle) : gui_create(get_class($this), $owner);
	}

	public function saveToFile($fileName){
		gui_componentToFile($this->handle, $fileName);
	}

	public function loadFromFile($fileName){
		$this->handle = gui_componentFromFile($fileName);
	}

	public function is($className){
		return gui_is($this->handle, $className);
	}

	public function on($event, $func){
		
	}
}

?>