printing
dump: depth
	" dump any object in full tree form /recursive/ "
	| tree |
	" headers "
	tree := ( self pad: depth ) , ( self head ).
	" return ready tree dump "
	^ tree