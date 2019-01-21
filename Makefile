PlatformToolset=v141
XML=build.xml
Release=/p:Configuration=Release
Debug=/p:Configuration=Debug
Arch_x64=/p:Platform=x64
Arch_x86=/p:Platform=x86
PTS=/p:PlatformToolset=v141

build:
	msbuild ${XML} ${Release} ${Arch_x64} ${PTS} /t:Build
	msbuild ${XML} ${Release} ${Arch_x86} ${PTS} /t:Build
debug:
	msbuild ${XML} ${Debug} ${Arch_x64} ${PTS} /t:Build
	msbuild ${XML} ${Debug} ${Arch_x86} ${PTS} /t:Build
clean:
	msbuild ${XML} ${Release} ${Arch_x64} ${PTS} /t:Clean
	msbuild ${XML} ${Debug} ${Arch_x64} ${PTS} /t:Clean
	msbuild ${XML} ${Release} ${Arch_x86} ${PTS} /t:Clean
	msbuild ${XML} ${Debug} ${Arch_x86} ${PTS} /t:Clean
