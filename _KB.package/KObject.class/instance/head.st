printing
head
	" dump in a short <tag:value> form "
	^ '<' , self type asString , ':' , self value asString , '>'