#k::
{
  if WinExist("ahk_exe KeePassXC.exe")
    WinActivate
  else
    Run "C:\Program Files\KeePassXC\KeePassXC.exe"
}

#+c::
{
  WinClose "A"
}

#Enter::
{
   Run "C:\msys64\msys2_shell.cmd -mingw64"
}

#Tab::
{
  Send "!{Tab}"
}
