initialization
initialize
	| s |
	" register object in pool "
	self class pool: self.
	" assign instance type as lower case of class name "
	s := self class asString asLowercase.
	self type: (s copyFrom: 2 to: s size).