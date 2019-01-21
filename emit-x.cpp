#include "emit-x.h"

int WINAPI WinMain(HINSTANCE i, HINSTANCE p, LPSTR c, int s) {
  std::vector<std::wstring> keys;
  if (!translate(leaf(module()), &keys))
    return -1;
  return !send(keys);
}
bool translate(std::wstring s, std::vector<std::wstring>* v) {
  std::wregex r(L"^emit(?:-(alt|ctr?l|shift|win(?:dows)?))*-([0-9a-z]+|f1[0-2]|f[1-9]).exe",
    std::regex_constants::icase);
  s = lower(s);
  if (!std::regex_match(s, r))
    return false;
  std::wregex R(L"-(\\w+)");
  std::wsregex_iterator i(s.begin(), s.end(), R), end;
  for (;i != end; i++)
    v->push_back((*i)[1]);
  return true;
}
bool send(std::vector<std::wstring> keys) {
  auto L = keys.size();
  auto L2 = L * 2;
  auto inputs = new INPUT[L2];
  for (auto c = 0; c < L; c++){
    inputs[c + L].type = inputs[c].type = INPUT_KEYBOARD;
    inputs[c + L].ki.wVk = inputs[c].ki.wVk = vk(keys[c]);
    inputs[c + L].ki.wScan = inputs[c].ki.wScan = 0;
    inputs[c].ki.dwFlags = 0;
    inputs[c + L].ki.dwFlags = KEYEVENTF_KEYUP;
    inputs[c + L].ki.time = inputs[c].ki.time = 0;
    inputs[c + L].ki.dwExtraInfo = inputs[c].ki.dwExtraInfo = NULL;
  }
  bool affected = L2 != SendInput(L2, inputs, sizeof(INPUT));
  delete [] inputs;
  return affected;
}
LPARAM vk(std::wstring str) {
  std::wregex ctrl(L"^ctr?l$");
  if (std::regex_match(str, ctrl))
    return VK_CONTROL;
  if (str == L"shift")
    return VK_SHIFT;
  if (str == L"alt")
    return VK_MENU;
  std::wregex win(L"^win(dows)?$");
  if (std::regex_match(str, win))
    return VK_LWIN;
  std::wregex prtscr(L"^(prt|print)(scr|screen)$");
  if (std::regex_match(str, prtscr))
    return VK_SNAPSHOT;
  std::wregex fkey(L"^f([0-9]+)$");
  std::wsmatch fkey_match;
  if (std::regex_match(str, fkey_match, fkey)) {
    auto fnr = std::stoi(fkey_match[1]);
    return VK_F1 + (fnr - 1);
  }
  if (str.length() > 1) return NULL;
  TCHAR ch = str[0];
  if (L'0' <= ch && ch <= L'1' || L'A' <= ch && ch <= L'Z')
    return ch;
  if (L'a' <= ch && ch <= L'z')
    return ch - 32;
  return NULL;
}
std::wstring module() {
  WCHAR* b = NULL;
  for (unsigned int c = 256, n = c; c < INT_MAX; c <<= 2) {
    if (b) delete [] b;
    b = new WCHAR[c];
    n = GetModuleFileNameW(NULL, b, c);
    if (c != n)
      break;
  }
  std::wstring s(b);
  delete [] b;
  return s;
}
std::wstring lower(std::wstring s) {
  std::transform(s.begin(), s.end(), s.begin(), towlower);
  return s;
}
std::wstring env(std::wstring name) {
  auto l = GetEnvironmentVariableW(name.c_str(), NULL, 0) + 1;
  auto b = new WCHAR[l];
  auto r = GetEnvironmentVariableW(name.c_str(), b, l);
  std::wstring s(b);
  delete [] b;
  return s;
}
std::wstring leaf(std::wstring path) {
  auto L = path.length() + 1;
  auto b = new WCHAR[L];
  memcpy(b, path.c_str(), sizeof(WCHAR) * L);
  PathStripPathW(b);
  std::wstring s(b);
  delete [] b;
  return s;
}
std::wstring join(std::wstring x, std::wstring y){
  WCHAR* b;
  auto r = PathAllocCombine(x.c_str(), y.c_str(),
    PATHCCH_ALLOW_LONG_PATHS, &b);
  std::wstring s(b);
  LocalFree(b);
  return s;
}
