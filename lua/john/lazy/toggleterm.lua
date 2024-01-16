return {
    'akinsho/toggleterm.nvim',
    version = "*",
    event = "VeryLazy",
    config = function()
        require('toggleterm').setup({
            size = 20,
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 4,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = "horizontal",
            close_on_exit = true,
            shell = vim.o.shell,
            on_open = function()
                vim.cmd("startinsert!")
            end,
        })

        local node = require('toggleterm.terminal').Terminal:new({ cmd = "node", hidden = true })
        vim.keymap.set("n", "<leader>tn", function() node:toggle() end)
        vim.keymap.set("v", "<C-p>",  "<cmd>lua require('toggleterm').send_lines_to_terminal('visual_selection', true, { args = vim.v.count })<cr>")

        vim.api.nvim_create_autocmd('TermOpen', {
            desc = 'Terminal Keymaps',
            callback = function(event)
                local opts = { buffer = event.buf }

                vim.keymap.set("t", "<C-space>", [[<C-\><C-n>]], opts)
                vim.keymap.set("n", "<C-space>", "<cmd>startinsert!<cr>", opts)
                vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
                vim.keymap.set("n", "<C-h>", "<cmd>wincmd h<cr>", opts)
                vim.keymap.set("n", "<C-j>", "<cmd>wincmd j<cr>", opts)
                vim.keymap.set("n", "<C-k>", "<cmd>wincmd k<cr>", opts)
                vim.keymap.set("n", "<C-l>", "<cmd>wincmd l<cr>", opts)
            end
        })
        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = { "*#toggleterm#*" },
            callback = function()
                vim.cmd("startinsert!")
            end,
        })
    end,
}
