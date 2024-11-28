return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = function()
        local diagSection = {
            'diagnostics',
            symbols = { error = ' ', warn = ' ', hint = ' ', info = ' ' },
        }

        local filenameSection = {
            'filename',
            path = 4,
            symbols = {
                modified = '',
                readonly = '',
                unnamed = '󰡯',
                newfile = '󰝒',
            }
        }

        local diffSection = {
            'diff',
            -- Is it me or the symbol for modified us really weird
            symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
            diff_color = {
                added = { fg = '#98BE65' },
                modified = { fg = '#FF8800' },
                removed = { fg = '#EC5f67' },
            },
        }

        local fileformatSection = {
            'fileformat',
            symbols = {
                unix = ' unix', -- e712
                dos = ' dos', -- e70f
                mac = ' mac', -- e711
            },
            color = { gui = 'bold' },
        }

        return {
            options = {
                icons_enabled = true,
                theme = 'tokyonight',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                -- always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 50,
                    tabline = 50,
                    winbar = 50,
                }
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'progress', 'location' },
                lualine_c = { diagSection, filenameSection },
                lualine_x = { 'encoding', fileformatSection, 'filetype' },
                lualine_y = { diffSection },
                lualine_z = { 'branch' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }
    end,
}
