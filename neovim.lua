-- Turbo Pascal keeps the editor to three colours: reserved words in white,
-- everything else in yellow, comments in grey. aether's own mapping spreads
-- code over the full palette, so on_highlights folds it back.
return {
  {
    "bjarneo/aether.nvim",
    branch = "v3",
    name = "aether",
    priority = 1000,
    opts = {
      styles = {
        comments = {},
        keywords = {},
        functions = {},
        variables = {},
        -- Turbo Vision separated a window from the field by its frame, not by
        -- a different fill. "dark" would paint floats in a navy that the IDE
        -- never had on screen.
        sidebars = "normal",
        floats = "normal",
      },
      colors = {
        bg = "#010378",
        dark_bg = "#010556",
        darker_bg = "#01033c",
        lighter_bg = "#152b92",

        fg = "#ffff55",
        dark_fg = "#c4c6d1",
        light_fg = "#ffff9c",
        bright_fg = "#ffffff",
        muted = "#aaaaaa",

        red = "#ff7a66",
        yellow = "#f7ee0b",
        orange = "#ffa94d",
        green = "#5bc98a",
        cyan = "#0bdfea",
        blue = "#9fbeff",
        magenta = "#e07ce0",
        brown = "#c08a3e",

        bright_red = "#ffab9c",
        bright_yellow = "#fdf78a",
        bright_green = "#96e0b5",
        bright_cyan = "#b0f5fb",
        bright_blue = "#cfdcff",
        bright_magenta = "#f0aef0",

        accent = "#0bdfea",
        cursor = "#ffffff",
        foreground = "#ffff55",
        background = "#010378",
        selection = "#152b92",
        selection_foreground = "#010378",
        selection_background = "#f7ee0b",
      },
      on_highlights = function(hl, c)
        local code = { fg = "#ffffff" }
        local word = { fg = c.fg }
        local note = { fg = c.muted }

        -- Reserved words, and nothing else: yellow.
        local keywords = {
          "Statement", "Keyword", "Conditional", "Repeat", "Label",
          "Operator", "Exception", "StorageClass", "Structure", "Typedef",
          "PreProc", "Include", "Define", "Macro", "PreCondit", "Boolean",
          "@keyword", "@keyword.function", "@keyword.operator",
          "@keyword.return", "@keyword.import", "@keyword.repeat",
          "@keyword.conditional", "@keyword.exception", "@keyword.type",
          "@keyword.modifier", "@keyword.coroutine", "@keyword.directive",
          "@conditional", "@repeat", "@boolean", "@type.builtin",
          "@type.qualifier", "@storageclass", "@include", "@preproc",
          "@define", "@exception", "@label",
        }

        -- Everything the compiler does not own: white.
        local names = {
          "Identifier", "Function", "Type", "Constant", "String", "Character",
          "Number", "Float", "SpecialChar", "Delimiter", "Special", "Tag",
          "@variable", "@variable.builtin", "@variable.parameter",
          "@variable.member", "@field", "@property", "@parameter",
          "@function", "@function.call", "@function.builtin",
          "@function.method", "@function.method.call", "@constructor",
          "@method", "@method.call", "@type", "@type.definition",
          "@constant", "@constant.builtin", "@constant.macro",
          "@string", "@string.escape", "@string.special", "@string.regexp",
          "@character", "@number", "@number.float", "@float", "@operator",
          "@punctuation.bracket", "@punctuation.delimiter",
          "@punctuation.special", "@attribute", "@module", "@namespace",
          "@tag", "@tag.attribute", "@tag.delimiter", "@markup.raw",
        }

        for _, group in ipairs(keywords) do hl[group] = vim.tbl_extend("force", {}, word) end
        for _, group in ipairs(names) do hl[group] = vim.tbl_extend("force", {}, code) end

        hl.Normal = { fg = "#ffffff", bg = c.bg }

        -- Every framed surface sits on the editor field and is bounded by the
        -- cyan frame, the way a Turbo Vision window was.
        local field = { fg = "#ffffff", bg = c.bg }
        local frame = { fg = c.accent, bg = c.bg }
        for _, group in ipairs({
          "NormalFloat", "NormalSB", "Pmenu", "PmenuExtra", "PmenuKind",
          "WhichKeyFloat", "TelescopeNormal", "NoiceCmdlinePopup",
          "NoicePopup", "NoicePopupmenu", "SnacksNormal", "SnacksPickerNormal",
          "BlinkCmpMenu", "BlinkCmpDoc", "BlinkCmpSignatureHelp",
        }) do hl[group] = vim.tbl_extend("force", {}, field) end
        for _, group in ipairs({
          "FloatBorder", "FloatTitle", "WinSeparator", "VertSplit",
          "TelescopeBorder", "NoiceCmdlinePopupBorder", "NoicePopupBorder",
          "SnacksPickerBorder", "WhichKeySeparator", "BlinkCmpMenuBorder",
          "BlinkCmpDocBorder", "BlinkCmpDocSeparator",
          "BlinkCmpSignatureHelpBorder",
        }) do hl[group] = vim.tbl_extend("force", {}, frame) end

        -- The highlight bar of a Turbo Vision list: yellow ground, blue text.
        hl.PmenuSel               = { fg = c.bg, bg = c.fg }
        hl.BlinkCmpMenuSelection  = { fg = c.bg, bg = c.fg }
        hl.PmenuSbar              = { bg = c.lighter_bg }
        hl.PmenuThumb             = { bg = c.accent }
        hl.BlinkCmpScrollBarGutter = { bg = c.lighter_bg }
        hl.BlinkCmpScrollBarThumb  = { bg = c.accent }

        -- snacks.nvim derives lazygit's selectedLineBgColor from Visual and
        -- keeps each line's own foreground. A yellow bar would therefore carry
        -- white text there, so the selection is the lifted blue.
        hl.Visual = { bg = c.lighter_bg }

        -- And its activeBorderColor comes from MatchParen. Yellow is the frame
        -- colour of an active Turbo Vision window.
        hl.MatchParen = { fg = "#f7ee0b", bold = true }

        -- aether computes its own shade for the cursor line, a slate the
        -- palette does not contain. The lifted blue belongs to the theme.
        hl.CursorLine   = { bg = c.lighter_bg }
        hl.CursorColumn = { bg = c.lighter_bg }
        hl.CursorLineNr = { fg = c.fg, bold = true }
        hl.Comment = note
        hl["@comment"] = note
        hl["@comment.documentation"] = note
      end,
    },
  },
  {
    -- A frame, not a fill, is what separated a window from the field in Turbo
    -- Vision. blink.cmp draws none by default, so its menu ran into the
    -- cmdline box below it. This is behaviour rather than colour - move it to
    -- your own config if you would rather the theme did not touch it.
    "saghen/blink.cmp",
    opts = {
      completion = {
        menu = { border = "single" },
        documentation = { window = { border = "single" } },
      },
      signature = { window = { border = "single" } },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "aether",
    },
  },
}
