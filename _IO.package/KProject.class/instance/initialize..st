initialization
initialize: V
	super initialize: V.
	dir := ( FileSystem disk workingDirectory / value ).
	dir exists ifFalse: [ dir createDirectory ].
	mk     := ( dir / 'Makefile'  ) writeStream.
	readme := ( dir / 'README.md' ) writeStream.
	
