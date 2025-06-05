-- Git utility functions (共通化・軽量化版)
local git_utils = {}

-- キャッシュ機能追加
local cache = {
  is_repo = nil,
  branch = nil,
  has_changes = nil,
  last_check = 0,
  cache_duration = 5000, -- 5秒キャッシュ
}

local function should_refresh_cache()
  local now = vim.loop.now()
  return now - cache.last_check > cache.cache_duration
end

function git_utils.is_git_repo()
  if cache.is_repo ~= nil and not should_refresh_cache() then
    return cache.is_repo
  end
  
  local handle = io.popen('git rev-parse --is-inside-work-tree 2>/dev/null')
  local result = handle:read("*a")
  handle:close()
  
  cache.is_repo = result:match("true") ~= nil
  cache.last_check = vim.loop.now()
  return cache.is_repo
end

function git_utils.has_uncommitted_changes()
  if not git_utils.is_git_repo() then
    return false
  end
  
  if cache.has_changes ~= nil and not should_refresh_cache() then
    return cache.has_changes
  end
  
  local handle = io.popen('git status --porcelain 2>/dev/null')
  local git_status = handle:read("*a")
  handle:close()
  
  cache.has_changes = git_status ~= ""
  return cache.has_changes
end

function git_utils.get_current_branch()
  if not git_utils.is_git_repo() then
    return nil
  end
  
  if cache.branch ~= nil and not should_refresh_cache() then
    return cache.branch
  end
  
  local handle = io.popen('git rev-parse --abbrev-ref HEAD 2>/dev/null')
  local branch_name = handle:read("*a"):gsub("%s+", "")
  handle:close()
  
  if branch_name == "" then
    cache.branch = nil
  else
    cache.branch = branch_name
  end
  
  return cache.branch
end

return git_utils
