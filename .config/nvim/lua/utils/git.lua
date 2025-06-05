-- Git utility functions (共通化)
local git_utils = {}

function git_utils.is_git_repo()
  local handle = io.popen('git rev-parse --is-inside-work-tree 2>/dev/null')
  local result = handle:read("*a")
  handle:close()
  return result:match("true") ~= nil
end

function git_utils.has_uncommitted_changes()
  if not git_utils.is_git_repo() then
    return false
  end
  
  local handle = io.popen('git status --porcelain 2>/dev/null')
  local git_status = handle:read("*a")
  handle:close()
  
  return git_status ~= ""
end

function git_utils.get_current_branch()
  if not git_utils.is_git_repo() then
    return nil
  end
  
  local handle = io.popen('git rev-parse --abbrev-ref HEAD 2>/dev/null')
  local branch_name = handle:read("*a"):gsub("%s+", "")
  handle:close()
  
  if branch_name == "" then
    return nil
  end
  
  return branch_name
end

return git_utils
