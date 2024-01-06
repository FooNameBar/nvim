function ColorMyPencils(color)
    color = color or "tokyonight-storm"

    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        style = "storm",
        transparent = true,
        terminal_colors = true,
        styles = {
            comments = { italic = false },
            floats = "dark",
            sidebars = "dark",
        },
        dim_inactive = true,
    },
}
