setlocal
set VS2015=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\UnitTest
set INCLUDE=%INCLUDE%;%VS2015%\include;
set LIB=%LIB%;%VS2015%\lib;

cl /EHsc /LD /Fe:test.dll test.cpp ..\emit-x.cpp ^
  && vstest.console test.dll /Platform:x64 /InIsolation

endlocal
