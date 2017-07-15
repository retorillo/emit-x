VCVARSALL="${ProgramFiles(x86)}\Microsoft Visual Studio 14.0\VC\vcvarsall"
build:
	${VCVARSALL} amd64 && cl /EHsc emit-x.cpp /Fox64\emit-x.obj /Fex64\emit-x.exe
	${VCVARSALL} amd64_x86 && cl /EHsc emit-x.cpp /Fox86\emit-x.obj /Fex86\emit-x.exe
