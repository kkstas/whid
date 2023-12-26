-- lua/whid.lua
local buf, win

local buf_initial_content = {
  'first line',
  'second line',
  '    third line',
}

local function open_window()
  buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

  -- get dimensions
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")

  -- calculate our floating window size
  local win_height = math.ceil(height * 0.8 - 4)
  local win_width = math.ceil(width * 0.8)

  -- and its starting position
  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)

  local opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
  }
  win = vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, buf_initial_content)
end

local function update_view()
  vim.api.nvim_buf_set_option(buf, 'modifiable', true)
  local result = vim.fn.systemlist('ls -al')
  vim.api.nvim_buf_set_lines(buf, 3, -1, false, result)
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
end

local function whid()
  open_window()
  print("hello from whid")
end

return {
  whid = whid,
  ls = update_view,
}
