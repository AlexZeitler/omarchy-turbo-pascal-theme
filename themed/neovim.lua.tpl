-- Omarchy generates this file from the current theme's colors.toml. It
-- replaces the built-in template, so it has to carry everything that one
-- carried, plus the part below.
--
-- A theme that ships a file named `neovim.syntax` containing `three-colour`
-- asks for its syntax to be folded onto three colours instead of spread over
-- the palette: foreground for reserved words, bright_foreground for
-- everything else, muted for comments. Every other theme falls through to
-- aether's own mapping and is unaffected.
--
-- Why a template and not a file in the theme: omarchy-theme-set refuses any
-- *.lua that comes out of a cloned theme repository. A template lives in the
-- user's own config and is not subject to that.

local state = vim.fn.expand("~/.local/state/omarchy/current/theme")

local function theme_flag(name)
  local handle = io.open(state .. "/" .. name, "r")
  if not handle then return nil end
  local value = handle:read("*l")
  handle:close()
  return value and value:gsub("%s+$", "")
end

local fold = theme_flag("neovim.syntax") == "three-colour"

local opts = {
  colors = {
    bg = "{{ background }}",
    dark_bg = "{{ dark_background }}",
    darker_bg = "{{ darker_background }}",
    lighter_bg = "{{ lighter_background }}",

    fg = "{{ foreground }}",
    dark_fg = "{{ dark_foreground }}",
    light_fg = "{{ light_foreground }}",
    bright_fg = "{{ bright_foreground }}",
    muted = "{{ muted }}",

    red = "{{ red }}",
    yellow = "{{ yellow }}",
    orange = "{{ orange }}",
    green = "{{ green }}",
    cyan = "{{ cyan }}",
    blue = "{{ blue }}",
    magenta = "{{ magenta }}",
    brown = "{{ brown }}",

    bright_red = "{{ bright_red }}",
    bright_yellow = "{{ bright_yellow }}",
    bright_green = "{{ bright_green }}",
    bright_cyan = "{{ bright_cyan }}",
    bright_blue = "{{ bright_blue }}",
    bright_magenta = "{{ bright_magenta }}",

    accent = "{{ accent }}",
    cursor = "{{ bright_foreground }}",
    foreground = "{{ foreground }}",
    background = "{{ background }}",
    selection = "{{ selection }}",
    selection_foreground = "{{ selection_foreground }}",
    selection_background = "{{ selection_background }}",
  },
}

if fold then
  local FIELD  = "{{ background }}"
  local WORD   = "{{ foreground }}"
  local PLAIN  = "{{ bright_foreground }}"
  local NOTE   = "{{ muted }}"
  local FRAME  = "{{ gradient_start hyprland_active_border accent }}"
  local LIFTED = "{{ lighter_background }}"
  local BAR    = "{{ yellow }}"

  -- A text-mode IDE separated a window from the field by its frame, not by a
  -- different fill. "dark" would paint floats in a shade of its own.
  opts.styles = {
    comments = {},
    keywords = {},
    functions = {},
    variables = {},
    sidebars = "normal",
    floats = "normal",
  }

  opts.on_highlights = function(hl)
    local plain = { fg = PLAIN }
    local word = { fg = WORD }
    local note = { fg = NOTE }

    -- Reserved words, and nothing else.
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

    -- Everything the compiler does not own.
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
    for _, group in ipairs(names) do hl[group] = vim.tbl_extend("force", {}, plain) end

    hl.Normal = { fg = PLAIN, bg = FIELD }

    -- Every framed surface sits on the editor field, bounded by the frame.
    local field = { fg = PLAIN, bg = FIELD }
    local frame = { fg = FRAME, bg = FIELD }
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

    -- The highlight bar of a text-mode list.
    hl.PmenuSel                = { fg = FIELD, bg = WORD }
    hl.BlinkCmpMenuSelection   = { fg = FIELD, bg = WORD }
    hl.PmenuSbar               = { bg = LIFTED }
    hl.PmenuThumb              = { bg = FRAME }
    hl.BlinkCmpScrollBarGutter = { bg = LIFTED }
    hl.BlinkCmpScrollBarThumb  = { bg = FRAME }

    -- snacks.nvim derives lazygit's selected row from Visual and keeps each
    -- line's own foreground, so a bright bar there would carry bright text.
    -- Its active border comes from MatchParen.
    hl.Visual = { bg = LIFTED }
    hl.MatchParen = { fg = BAR, bold = true }

    -- aether computes its own shade for the cursor line.
    hl.CursorLine = { bg = LIFTED }
    hl.CursorColumn = { bg = LIFTED }
    hl.CursorLineNr = { fg = WORD, bold = true }

    hl.Comment = note
    hl["@comment"] = note
    hl["@comment.documentation"] = note
  end
end

local spec = {
  {
    "bjarneo/aether.nvim",
    branch = "v3",
    name = "aether",
    priority = 1000,
    opts = opts,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "aether",
    },
  },
}

if fold then
  -- blink.cmp draws no frame by default, so its menu runs into whatever sits
  -- below it. This is behaviour rather than colour.
  table.insert(spec, {
    "saghen/blink.cmp",
    opts = {
      completion = {
        menu = { border = "single" },
        documentation = { window = { border = "single" } },
      },
      signature = { window = { border = "single" } },
    },
  })
end

return spec
