local util = require("pandoc_vim_help.util")

local M = {}

function M.new(metadata, output_file)
  metadata = metadata or {}
  output_file = output_file or ""
  return {
    header_text = metadata.header_text or "",
    textwidth = metadata.textwidth or 78,
    tabstop = metadata.tabstop or 8,
    tag_prefix = metadata.tag_prefix or util.splitted_last(output_file, "/"),
  }
end

return M
