initialization
initialize: V
	super initialize: V.
	
	dir := ( FileSystem disk workingDirectory / value ).
	dir exists ifFalse: [ dir createDirectory ].
	
	mk     := ( dir / 'Makefile'  ) writeStream. mk lineEndConvention: #lf.
	mk nextPutAll: KMakefile headline ; flush.
	
	readme := ( dir / 'README.md' ) writeStream. mk lineEndConvention: #lf.
	bat    := ( dir / 'bat.bat' )   writeStream. mk lineEndConvention: #crlf.
	bat nextPutAll: '@gvim -p '.
	rc     := ( dir / 'rc.rc' )     writeStream. mk lineEndConvention: #lf.
	rc  nextPutAll: 'gvim -p '.
	
	hpp := ( dir / 'hpp.hpp' ) writeStream. hpp lineEndConvention: #lf.
	hpp nextPutAll: ( KClike headline ) , '
#ifndef _H_HPP
#define _H_HPP

#include <iostream>
using namespace std;

' ; flush.
	
	cpp := ( dir / 'cpp.cpp' ) writeStream. cpp lineEndConvention: #lf.
	cpp nextPutAll: ( KClike headline ) , '
#include "hpp.hpp"
' ; flush.
	
	gitignore := ( dir / '.gitignore' ) writeStream. mk lineEndConvention: #lf.
	gitignore nextPutAll: '
*~
*.swp
*.log
*.exe
*.o
*.pyc

' ; flush.
