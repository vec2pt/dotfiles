-- lua/custom/plugins/mini.lua
return {
    {
        'echasnovski/mini.nvim',
        enabled = false,
        config = function()
            local statusline = require 'mini.statusline'
            statusline.setup { use_icons = true }
        end
    },
}
