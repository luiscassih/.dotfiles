vim.g.mapleader = " "
vim.keymap.set('n', '<c-j>', ":bNext<cr>", { noremap = true })
vim.keymap.set('n', '<c-k>', ":bnext<cr>", { noremap = true })

vim.keymap.set("n", "<leader>h", '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "8j")
vim.keymap.set("n", "<C-u>", "8k")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Use once to exit, and twice to send C-c (cancel command)
vim.keymap.set("t", "<C-c>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-c><C-c>", "<C-c>")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<leader>P", [["+p]])

-- prevent x to rewrite yanked register
vim.keymap.set({ "n", "v" }, "x", [["_x]])

-- uncomment this to have d the same as x
-- vim.keymap.set({ "n", "v" }, "d", [["_d]])
-- vim.keymap.set({ "n", "v" }, "c", [["_c]])
-- vim.keymap.set({ "n", "v" }, "<leader>d", [["0d]])

-- have leader d to do the same as x
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+ygv]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")

-- yank ñ to the clipboard
-- vim.cmd('command! -nargs=0 Enie :call setreg("+", "ñ")')
vim.cmd('command! -nargs=0 Enie :let @+ = "ñ"')
vim.cmd('command! -nargs=0 EnieN :let @+ = "Ñ"')
-- copy ñ
vim.keymap.set("n", "<leader>cn", ":Enie<CR>")
vim.keymap.set("n", "<leader>cN", ":EnieN<CR>")

vim.keymap.set('n', '>>', '<C-w>10>', { noremap = true })
vim.keymap.set('n', '<<', '<C-w>10<', { noremap = true })
vim.keymap.set('n', '<C-w>,', '<C-w>5+', { noremap = true })
vim.keymap.set('n', '<C-w>.', '<C-w>5-', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })
vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', 'y', 'ygv', { noremap = true })

-- Let's make it easier to move in wrapped lines
vim.keymap.set('n', 'j', [[v:count? 'j' : 'gj']], { noremap = true, expr = true })
vim.keymap.set('n', 'k', [[v:count? 'k' : 'gk']], { noremap = true, expr = true })


-- View help for the word under the cursor
vim.keymap.set('n', '<leader>vh', [[:h <C-r><C-w><Enter>]], { noremap = true })

-- cd to current file
vim.keymap.set('n', '<leader>cd', ':cd %:p:h<cr>:pwd<cr>')

vim.keymap.set('i', '<S-tab>', '<c-d>')

-- backspace to go back last file
vim.keymap.set('n', '<bs>', '<C-^>')
