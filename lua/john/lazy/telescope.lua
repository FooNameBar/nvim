return {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Telescope find files" })
        vim.keymap.set("n", "<leader>df", function()
            local path = vim.fn.expand("%:p:h")
            path = string.gsub(path, "oil://", "")
            builtin.find_files({
                cwd = path,
                hidden = true,
                no_ignore_parent = true,
            })
        end, { desc = "Telescope find files of current buffer directory" })
        vim.keymap.set("n", "<leader>ht", builtin.help_tags, { desc = "Telescope help tags" })
        vim.keymap.set("n", "<leader>gd", builtin.git_status, { desc = "Telescope git status" })
        vim.keymap.set("n", "<leader>km", builtin.keymaps, { desc = "Telescope keymaps" })
        vim.keymap.set("n", "<leader>cw", function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end, { desc = "Telescope search word under cursor" })
        vim.keymap.set("n", "<leader>cW", function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end, { desc = "Telescope search word under cursor between non-white space chars" })
        vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "Telescope live grep search project directory" })
        vim.keymap.set("n", "<leader>ds", function()
            local path = vim.fn.expand("%:p:h")
            path = string.gsub(path, "oil://", "")
            builtin.live_grep({ cwd = path, })
        end, { desc = "Telescope live grep search current buffer directory" })

        local actions = require("telescope.actions")
        local trouble = require("trouble.sources.telescope")
        local telescope = require("telescope")

        telescope.setup {
            defaults = {
                mappings = {
                    i = { ["<C-t>"] = trouble.open, ["<Esc>"] = actions.close, ["<C-Space>"] = { "<Esc>", type = "command" } },
                    n = { ["<C-t>"] = trouble.open, ["<Esc>"] = actions.close },
                },
                layout_config = { width = 0.9, preview_width = 0.65 },
            },
        }
    end,
}
