local function find_closest_quote()
    local line = vim.fn.getline('.')
    local col = vim.fn.col('.')
    local single_quote = line:find("'", col)
    local double_quote = line:find('"', col)
    if single_quote and double_quote then
        return single_quote < double_quote and "'" or '"'
    elseif single_quote then
        return "'"
    elseif double_quote then
        return '"'
    else
        return nil
    end
end

local function quote_motion(motion_type)
    local quote = find_closest_quote()
    if quote then
      if motion_type == "i" then
        vim.cmd('normal! ' .. motion_type .. quote)
      else
        vim.cmd('normal! f'.. quote .. motion_type .. quote)
      end
    end
end

-- Operator-pending mode mappings
vim.keymap.set('o', 'iq', function() quote_motion('vi') end, {silent = true, desc = "Select inside closest quote"})
vim.keymap.set('o', 'aq', function() quote_motion('va') end, {silent = true, desc = "Select around closest quote"})

-- Visual mode mappings
vim.keymap.set('x', 'iq', function() quote_motion('i') end, {silent = true, desc = "Select inside closest quote"})
vim.keymap.set('x', 'aq', function() quote_motion('a') end, {silent = true, desc = "Select around closest quote"})

-- Normal mode mappings to initiate visual selection
vim.keymap.set('n', 'viq', function() quote_motion('vi') end, {silent = true, desc = "Select inside closest quote"})
vim.keymap.set('n', 'vaq', function() quote_motion('va') end, {silent = true, desc = "Select around closest quote"})
