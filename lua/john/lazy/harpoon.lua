return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        -- REQUIRED
        harpoon.setup()

        vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end, { desc = "Add current file to Harpoon list" })
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Toggle Harpoon list" })

        vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, { desc = "Navigate to Harpoon list item 1" })
        vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end, { desc = "Navigate to Harpoon list item 2" })
        vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end, { desc = "Navigate to Harpoon list item 3" })
        vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end, { desc = "Navigate to Harpoon list item 4" })
    end,
}
