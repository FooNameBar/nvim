vim.keymap.set("n", "<leader>ds", function()
    vim.cmd.FZF { vim.fn.input("dir > ") }
end, { silent = true })
