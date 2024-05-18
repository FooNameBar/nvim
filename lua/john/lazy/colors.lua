function ColorMyPencils(color)
    color = color or "tokyonight-storm"

    vim.cmd.colorscheme(color)
end

return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require('tokyonight').setup({
            style = "storm",
            terminal_colors = true,
            styles = {
                comments = { italic = false },
                floats = "dark",
                sidebars = "dark",
            },
            dim_inactive = true,
        })
        ColorMyPencils()
    end,
}
