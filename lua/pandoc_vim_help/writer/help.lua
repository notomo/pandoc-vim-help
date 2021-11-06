local util = require("pandoc_vim_help.util")

local M = {}

function M.header(output_file)
  return M.tag("", util.splitted_last(output_file, "/"))
end

function M.separator(textwidth)
  return ("="):rep(textwidth)
end

function M.footer(textwidth, tabstop)
  return ([[vim:tw=%d:ts=%d:ft=help]]):format(textwidth, tabstop)
end

function M.tag(prefix, str)
  if prefix ~= "" then
    str = prefix .. "-" .. str
  end
  str = str:gsub(" ", "-")
  return ("*%s*"):format(str)
end

return M
