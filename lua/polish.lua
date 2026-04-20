if vim.loop.os_uname().version:match "Windows" then
  vim.o.shell = "powershell.exe"
  vim.o.shellxquote = ""
  vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command "
  vim.o.shellquote = ""
  -- vim.o.shellpipe = "| Out-File -Encoding UTF8 %s"
  -- vim.o.shellredir = "| Out-File -Encoding UTF8 %s"
end
-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here
