return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "leoluz/nvim-dap-go",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-neotest/nvim-nio",
        "williamboman/mason.nvim",
    },
    config = function()
        local dap = require "dap"
        local ui = require "dapui"

        require("dapui").setup({
            layouts = {
                {
                    elements = {
                        {id = "scopes", size = 1},
                    },
                    position = "bottom",
                    size = 20,
                },
                {
                    elements = {
                        {id = "stacks", size = 0.50},
                        {id = "breakpoints", size = 0.20},
                        {id = "repl", size = 0.30},
                    },
                    position = "right",
                    size = 80,
                },
            },
        })
        require("dap-go").setup()

        require("nvim-dap-virtual-text").setup()

        -- Customizing the colors for breakpoints in the sign column
        vim.cmd([[highlight DapBreakpoint guifg=#ff0000 guibg=NONE]])          -- Red for regular breakpoints
        vim.cmd([[highlight DapBreakpointCondition guifg=#ff9900 guibg=NONE]]) -- Orange for conditional breakpoints
        vim.cmd([[highlight DapLogPoint guifg=#00ff00 guibg=NONE]])            -- Green for log points

        -- Customizing the icons for breakpoints
        vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
        vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
        vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint', linehl = '', numhl = '' })

        vim.keymap.set("n", "<leader>bp", dap.toggle_breakpoint, { desc = "dap: Toggle debugger breakpoint" })
        vim.keymap.set("n", "<leader>rc", dap.run_to_cursor, { desc = "dap: Run debugger to cursor" })

        vim.keymap.set("n", "<leader>?", function()
            ui.eval(nil, { enter = true })
        end, { desc = "" })

        vim.keymap.set("n", "<F1>", dap.continue, { desc = "dap: Debugger start/continue" })
        vim.keymap.set("n", "<F5>", dap.step_out, { desc = "dap: Debugger step out" })
        vim.keymap.set("n", "<F6>", dap.step_back, { desc = "dap: Debugger step back" })
        vim.keymap.set("n", "<F7>", dap.step_into, { desc = "dap: Debugger step into" })
        vim.keymap.set("n", "<F8>", dap.step_over, { desc = "dap: Debugger step over" })
        vim.keymap.set("n", "<F11>", dap.restart, { desc = "dap: Debugger restart" })
        vim.keymap.set("n", "<F12>", dap.terminate, { desc = "dap: Debugger terminate" })

        --Handled by nvim-dap-go
        dap.adapters.delve = {
            type = "server",
            port = "${port}",
            executable = {
                command = "dlv",
                args = { "dap", "-l", "127.0.0.1:${port}" },
            },
        }

        dap.configurations.go = {
            {
                type = "delve",
                name = "Debug",
                request = "launch",
                program = "${workspaceFolder}"
            },
            {
                type = "delve",
                name = "Debug w/Args",
                request = "launch",
                program = "${workspaceFolder}",
                args = function()
                    local input = vim.fn.input("Arguments: ")
                    return vim.split(input, " ")
                end,
            },
            {
                type = "delve",
                name = "Debug test",
                request = "launch",
                mode = "test",
                program = "${workspaceFolder}"
            },
            {
                type = "delve",
                name = "Debug test (go.mod)",
                request = "launch",
                mode = "test",
                program = "./${relativeFileDirname}"
            },
        }

        dap.listeners.before.attach.dapui_config = function()
            ui.open()
        end

        dap.listeners.before.launch.dapui_config = function()
            ui.open()
        end

        dap.listeners.before.event_terminated.dapui_config = function()
            ui.close()
        end

        dap.listeners.before.event_exited.dapui_config = function()
            ui.close()
        end
    end,
}
