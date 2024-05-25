function string:startswith(start)
    return self:sub(1, #start) == start
end

-- Add OSC8 URL to plugin name
local function add_github_url()
  local ns = vim.api.nvim_create_namespace('my_vim_url')
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  for i, line in ipairs(lines) do
    if line:startswith('use ') then
      local startcol, endcol = line:find("'%g+/%g+'")
      if startcol ~= nil then
        local url = 'https://github.com/' .. line:sub(startcol + 1, endcol - 1)
        vim.api.nvim_buf_set_extmark(
          0, ns, i - 1, startcol,
          { end_col = endcol - 1, url = url}
        )
      end
    end
  end
end

local basename = vim.fs.basename(vim.api.nvim_buf_get_name(0))
if basename == "init.vim" or basename == ".vimrc" then
  add_github_url()
end
