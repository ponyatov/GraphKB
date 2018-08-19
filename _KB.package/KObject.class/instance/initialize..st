initialization
initialize: V
	| s |
	" register object in pool "
	self class pool: self.
	" assign instance type as lower case of class name "
	s := self class asString asLowercase.
	self type: (s copyFrom: 2 to: s size).
	" value "
	value := V.
	" attr{}ibutes "
	attr := Dictionary new.
	" nest[]ed elements and data in containers "
	nest := OrderedCollection new.
	
	