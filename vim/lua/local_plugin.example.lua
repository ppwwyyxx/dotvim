local plugins = {}
local use = function(x) table.insert(plugins, x) end

use {'a/b', lazy = true }
vim.cmd [[source /c/d.vim]]

return plugins
