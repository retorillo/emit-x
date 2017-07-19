# Emit X

[![Build status](https://ci.appveyor.com/api/projects/status/215tndv748iwpxh4?svg=true)](https://ci.appveyor.com/project/retorillo/emit-x)

Emit X allows to assign keyboard shortcut to Surface Pen Button (click, double
click, press and hold). Good for digital-painting.

Duplicate `x64\emit-x.exe` (for 64bit) or `x86/emit-x.exe` (for 32bit), and
change its name as below, finally register as "Launch as classic app" on "Pen
and Windows Ink" setting.

- To assign `B` key, change to `emit-b.exe`
- To assign `F11` key, change to `emit-f11.exe`
- To assign `Alt + Ctrl + Z` key combination, change to `emit-alt-ctrl-z.exe`

Name is case-insensitive. Currently, supports the following keys and its combinations:

- Modifiers keys `Ctrl` (or `Ctl`), `Alt`, `Shift`
- Function keys `F1`-`F12`
- Numerical keys `0` - `9`
- Alphabetical keys `A` - `Z`.

This is "workaround" app. I'm expecting Microsoft implement genuine feature.

Tested on Surface Pro 4 + Windows 10 + Photoshop CC. Works on Windows 8.1 and later.

## Downloads

Executable file is no longer included in this repository. Please download at:

- [Github Releases](https://github.com/retorillo/emit-x/releases) (Recommended)
- [AppVeyor Artifacts](https://ci.appveyor.com/project/retorillo/emit-x)

## License

MIT License

Copyright (C) 2017 Retorillo
