
vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Crunch into one line
vim.keymap.set("n", "J", "mzJ`z")

-- Scroll half pages
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy and paste from clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({"n", "v"}, "<leader>p", [["+p]])
vim.keymap.set("n", "<leader>P", [["+P]])

-- Paste without re-yank
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make bash script executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Go errors
vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

-- Buffers
vim.keymap.set("n", "<C-l>", ":bn<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-h>", ":bp<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-y>", ":bd<CR>", { noremap = true, silent = true })

-- Editing vimrc
vim.keymap.set("n", "<leader>vk", ":e ~/.config/nvim/lua/keymaps.lua<CR>", { silent = false })
vim.keymap.set("n", "<leader>vs", ":e ~/.config/nvim/lua/sets.lua<CR>", { silent = false })
vim.keymap.set("n", "<leader>vp", ":e ~/.config/nvim/lua/plugins.lua<CR>", { silent = false })

