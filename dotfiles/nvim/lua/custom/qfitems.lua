-- based on a mixture from
-- https://stackoverflow.com/a/77181885
-- https://stackoverflow.com/a/74675717
function RemoveQFItem(mode)
  local qf_list = vim.fn.getqflist()

  -- Distinguish mode for getting delete index and delete count
  local del_qf_idx
  local del_ct
  if mode == 'v' then
    del_qf_idx = vim.fn.getpos("'<")[2] - 1
    del_ct = vim.fn.getpos("'>")[2] - del_qf_idx
  else
    del_qf_idx = vim.fn.line('.') - 1
    del_ct = vim.v.count > 1 and vim.v.count or 1
  end

  -- Delete lines and update quickfix
  for _ = 1, del_ct do
    table.remove(qf_list, del_qf_idx + 1)
  end

  vim.fn.setqflist(qf_list, 'r')

  if #qf_list > 0 then
    -- vim.cmd(tostring(del_qf_idx + 1) .. 'cfirst')
    vim.cmd('copen')
  else
    vim.cmd('cclose')
  end

  -- If not at the end of the list, stay at the same index, otherwise, go one up.
  local new_idx = del_qf_idx < #qf_list and del_qf_idx+1 or math.max(del_qf_idx, 1)
  local winid = vim.fn.win_getid() -- Get the window ID of the quickfix window
  vim.api.nvim_win_set_cursor(winid, {new_idx, 0})
end

function AddQFItem(path)
  vim.fn.setqflist({
    {
      bufnr = vim.fn.bufnr(path),
      text = path
    }
  }, 'a')
end


vim.api.nvim_command("autocmd FileType qf nnoremap <buffer> dd :lua RemoveQFItem('n')<cr>")
vim.api.nvim_command("autocmd FileType qf vnoremap <buffer> d :lua RemoveQFItem('v')<cr>")

vim.keymap.set('n', '<leader>q', function ()
  if vim.bo[0].buftype == "quickfix" then
  -- if vim.api.nvim_buf_get_option(0, "buftype") == "quickfix" then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end)

-- add this file location to the end of quickfix list
vim.keymap.set('n', '<leader>a', function ()
  AddQFItem(vim.fn.expand("%:p"))
end)

