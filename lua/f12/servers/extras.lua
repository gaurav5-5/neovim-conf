local M = {
  -- servers
  'cssls',
  'cmake',
  'csharp_ls',
  'emmet_language_server',
  'jdtls',
  'rust_analyzer',
  'texlab',
  'ts_ls',
  'verible',
  'vhdl_ls',
  'volar',
  'yamlls',
  'zls',

  -- tools
  'black',
  'stylua',
  'cpptools',
  'markdownlint',
  'vale',
  'cpptools',
  'clang-format',
}

local function get_files_in_directory(path)
  local entries = {}
  local scanner, err = vim.uv.fs_scandir(path)
  if not scanner then
    print('Error opening directory: ' .. (err or 'Unknown error'))
    return entries
  end

  while true do
    local name, file_type = vim.uv.fs_scandir_next(scanner)
    if not name then
      break
    end
    if file_type == 'file' and name ~= 'extras.lua' then
      table.insert(entries, name:match '^(.*)%.')
    end
  end

  return entries
end

vim.list_extend(M, get_files_in_directory(vim.fn.stdpath 'config' .. '/lua/f12/servers/'))

return M
