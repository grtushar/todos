class Todo {
	int _id;
	String _title;
	String _description;
	String _date;
	int _priority;
	
	Todo(this._title, this._date, this._priority, [this._description]);
	
	Todo.withId(this._id, this._title, this._date, this._priority, [this._description]);
	
	int get id => _id;
	
	String get title => _title;
	
	int get priority => _priority;
	
	String get date => _date;
	
	String get description => _description;
	
	set title(String newTitle) {
		if(newTitle.length <= 255) {
			_title = newTitle;
		}
	}
	
	set priority(int newPriority) {
		if(newPriority >= 1 && newPriority <= 3) {
			_priority = newPriority;
		}
	}
	
	set description(String newDescription) {
		if(newDescription.length <= 255) {
			_description = newDescription;
		}
	}
	
	set date(String newDate) {
		_date = newDate;
	}
	
	Map<String, dynamic> toMap() {
		Map<String, dynamic> mp = Map<String, dynamic>();
		mp["title"] = _title;
		mp["description"] = _description;
		mp["date"] = _date;
		mp["priority"] = _priority;
		
		if(_id != null) mp["id"] = _id;
		
		return mp;
	}
	
	Todo.fromObject(dynamic o) {
		this._id = o["id"];
		this.title = o["title"];
		this.description = o["description"];
		this.date = o["date"];
		this.priority = o["priority"];
	}
}