local catui = require("user.catui")

return {
  plugins = {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.motion.flash-nvim" },
--     { import = "astrocommunity.colorscheme.tokyonight-nvim" },
--     {
--       "tokyonight",
--       opts = {
--         transparent = true,
--         style = "moon"
--       },
--     },
--     { import = "astrocommunity.color.transparent-nvim" }
--   },
--
--   colorscheme = "tokyonight"
    catui
  },

  colorscheme = "catppuccin"
}
