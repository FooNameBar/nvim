return {
    "mbbill/undotree",
    event = "VeryLazy",
    config = function()
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undotree open panel"})
        vim.g.undotree_WindowLayout = 2
        vim.g.undotree_DiffAutoOpen = 0
        vim.g.undotree_SetFocusWhenToggle = 1
        vim.g.undotree_HighlightSyntaxAdd = "NeogitDiffAddHighlight"
        vim.g.undotree_HighlightSyntaxChange = "diffChange"
        vim.g.undotree_HighlightSyntaxDelete = "NeogitDiffDeleteHighlight"
    end,
}
