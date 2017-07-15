#include <sstream>
#include <regex>
#include <windows.h>
#pragma comment(lib, "user32.lib")
#include <pathcch.h>
#pragma comment(lib, "pathcch.lib")
#include <shlwapi.h>
#pragma comment(lib, "shlwapi.lib")
#include <algorithm>

int WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int);
bool translate(std::wstring, std::vector<std::wstring>*);
bool send(std::vector<std::wstring>);
LPARAM vk(std::wstring);
std::wstring module();
std::wstring leaf(std::wstring);
std::wstring lower(std::wstring);
std::wstring env(std::wstring name);
std::wstring join(std::wstring x, std::wstring y);
