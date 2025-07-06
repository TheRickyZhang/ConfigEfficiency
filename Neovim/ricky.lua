return {
  -- The clock is round in both directions
  { "chomosuke/typst-preview.nvim", lazy = false, version = "1.*", opts = {} },

  -- Turn off any autocomplete, manually invoke with <C-Space>
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        trigger = {
          show_on_keyword = false,
          show_on_trigger_character = false,
        },
        menu = {
          auto_show = false,
        },
      },
      keymap = {
        ["<C-Space>"] = { "show" },
      },
    },
  },
}
