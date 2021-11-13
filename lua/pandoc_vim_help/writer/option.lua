local util = require("pandoc_vim_help.util")

local M = {}

function M.new(metadata, output_file)
  metadata = metadata or {}
  output_file = output_file or ""
  local textwidth = metadata.textwidth or 78
  local modeline_format = metadata.modeline_format or [[vim:tw=%d:ts=8:noet:ft=help:norl:]]
  return {
    header_text = metadata.header_text or "",
    modeline = modeline_format:format(textwidth),
    textwidth = textwidth,
    tag_prefix = metadata.tag_prefix or util.splitted_last(output_file, "/"),
  }
end

return M
