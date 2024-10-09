local M = {}

-- TODO: Make this better, so better
M.setup_select_mode_in_type = function(name)
  -- vim.fn.search(name)
  -- vim.cmd("normal! viw")
  -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-g>", true, false, true), "n", true)
end

-- Função para obter o tipo
M.get_type = function()
  local filename = vim.fn.expand("%:t")

  if filename:sub(1, 1) == "I" then
    return "interface"
  else
    return "class"
  end
end

local function find_csproj_dir_recursive(dir, dirs_traversed)
  local current_dir_name = vim.fn.fnamemodify(dir, ":t")
  table.insert(dirs_traversed, current_dir_name)

  local csproj = vim.fn.glob(dir .. "/*.csproj")

  if csproj ~= "" then
    return dir
  end

  if dir == "/" or dir:match("^%a:[\\/]*$") then
    return nil
  end

  local parent_dir = vim.fn.fnamemodify(dir, ":h")
  return find_csproj_dir_recursive(parent_dir, dirs_traversed)
end

local function reverse_table(t)
  local reversed = {}
  for i = #t, 1, -1 do
    table.insert(reversed, t[i])
  end
  return reversed
end

M.get_namespace = function()
  local current_dir = vim.fn.expand("%:p:h")

  local dirs_traversed = {}

  local csproj_dir = find_csproj_dir_recursive(current_dir, dirs_traversed)
  if not csproj_dir then
    return "NamespaceNotFound"
  end

  local reversed = reverse_table(dirs_traversed)

  return table.concat(reversed, ".")
end

M.get_classname = function()
  return vim.fn.expand("%:t:r")
end

local function find_java_dir_recursive(dir, dirs_traversed)
  local current_dir_name = vim.fn.fnamemodify(dir, ":t")

  if current_dir_name == "java" then
    return dir
  end

  if dir == "/" or dir:match("^%a:[\\/]*$") then
    return nil
  end

  table.insert(dirs_traversed, current_dir_name)

  local parent_dir = vim.fn.fnamemodify(dir, ":h")
  return find_java_dir_recursive(parent_dir, dirs_traversed)
end

M.get_package = function()
  local current_dir = vim.fn.expand("%:p:h")
  local dirs_traversed = {}

  local java_dir = find_java_dir_recursive(current_dir, dirs_traversed)
  if not java_dir then
    return "packageNotFound"
  end

  local reversed = reverse_table(dirs_traversed)

  local package_parts = {}
  -- TODO: Why java_dir is comming in this array?
  for _, dir in ipairs(reversed) do
    if dir ~= java_dir then
      table.insert(package_parts, string.lower(dir))
    end
  end

  return table.concat(package_parts, ".")
end

return M
