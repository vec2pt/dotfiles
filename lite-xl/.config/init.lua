-- put user settings here
-- this module will be loaded after everything else when the application starts
-- it will be automatically reloaded when saved

local core = require "core"
local keymap = require "core.keymap"
local config = require "core.config"
local style = require "core.style"

config.transitions = false
config.indent_size = 4
config.keep_newline_whitespace = false

------------------------------ Themes ----------------------------------------

-- core.reload_module("colors.github-dark-dimmed")
core.reload_module("colors.onedark")

--------------------------- Key bindings -------------------------------------

-- key binding:
-- keymap.add { ["ctrl+escape"] = "core:quit" }

-- pass 'true' for second parameter to overwrite an existing binding
-- keymap.add({ ["ctrl+pageup"] = "root:switch-to-previous-tab" }, true)
-- keymap.add({ ["ctrl+pagedown"] = "root:switch-to-next-tab" }, true)

------------------------------- Fonts ----------------------------------------

style.font = renderer.font.load(USERDIR .. "/fonts/Ubuntu-R.ttf", 14 * SCALE)
style.code_font = renderer.font.load(USERDIR .. "/fonts/Hack-Regular.ttf", 15 * SCALE)

-- customize fonts:
-- style.font = renderer.font.load(DATADIR .. "/fonts/FiraSans-Regular.ttf", 14 * SCALE).
-- style.code_font = renderer.font.load(DATADIR .. "/fonts/JetBrainsMono-Regular.ttf", 14 * SCALE)
--
-- DATADIR is the location of the installed Lite XL Lua code, default color
-- schemes and fonts.
-- USERDIR is the location of the Lite XL configuration directory.
--
-- font names used by lite:
-- style.font          : user interface
-- style.big_font      : big text in welcome screen
-- style.icon_font     : icons
-- style.icon_big_font : toolbar icons
-- style.code_font     : code
--
-- the function to load the font accept a 3rd optional argument like:
--
-- {antialiasing="grayscale", hinting="full", bold=true, italic=true, underline=true, smoothing=true, strikethrough=true}
--
-- possible values are:
-- antialiasing: grayscale, subpixel
-- hinting: none, slight, full
-- bold: true, false
-- italic: true, false
-- underline: true, false
-- smoothing: true, false
-- strikethrough: true, false

------------------------------ Plugins ----------------------------------------

-- disable plugin loading setting config entries:

-- disable plugin detectindent, otherwise it is enabled by default:
-- config.plugins.detectindent = false
config.plugins.toolbarview = false


config.plugins.autoreload = true

config.plugins.drawwhitespace.enabled = true
config.plugins.drawwhitespace.show_leading = true
config.plugins.drawwhitespace.show_middle = true
config.plugins.drawwhitespace.show_middle_min = 2

config.plugins.lineguide.enabled = true

config.plugins.trimwhitespace.enabled = true
config.plugins.trimwhitespace.trim_empty_end_lines = true

-- WIP
config.plugins.indentguide.enabled = false
config.plugins.indentguide.highlight = false

-- lsp_json lsp_lua lsp_python lsp_c lsp_rust lsp_yaml

-- autoinsert
-- eofnewline
-- nonicons
-- indentguide
-- selectionhighlight

--[[

scm (???)
gitdiff_highlight gitstatus

--]]

------------------------- (formatter) Plugin -----------------------------------

local formatter = require "plugins.formatter"

config.format_on_save = false

-- formatter.add_formatter {
--     name = "Python formatter",
--     file_patterns = {"%.pyi?$"},
--     command = "black --line-length=80 $FILENAME && isort --profile=black --line-length=80 $FILENAME",
-- }

formatter.add_formatter {
    name = "Python formatter",
    file_patterns = {"%.pyi?$"},
    command = "ruff check --select I --fix $FILENAME && ruff format $FILENAME",
}

formatter.add_formatter {
    name = "JSON formatter",
    file_patterns = {"%.json$"},
    -- command = "tmpfile=$(mktemp) && jq . $FILENAME > $tmpfile && cat $tmpfile > $FILENAME && rm -f $tmpfile",
    command = "tmpfile=$(mktemp) && jq . t3.json > $tmpfile && mv -f $tmpfile t3.json"
}

config.shfmt_args = {"-i 4"}

formatter.add_formatter {
    name = "shfmt",
    file_patterns = {"%.sh$"},
    command = "shfmt $ARGS -w $FILENAME",
    args = config.shfmt_args
}


---------------------------- Miscellaneous -------------------------------------

-- modify list of files to ignore when indexing the project:
-- config.ignore_files = {
--   -- folders
--   "^%.svn/",        "^%.git/",   "^%.hg/",        "^CVS/", "^%.Trash/", "^%.Trash%-.*/",
--   "^node_modules/", "^%.cache/", "^__pycache__/",
--   -- files
--   "%.pyc$",         "%.pyo$",       "%.exe$",        "%.dll$",   "%.obj$", "%.o$",
--   "%.a$",           "%.lib$",       "%.so$",         "%.dylib$", "%.ncb$", "%.sdf$",
--   "%.suo$",         "%.pdb$",       "%.idb$",        "%.class$", "%.psd$", "%.db$",
--   "^desktop%.ini$", "^%.DS_Store$", "^%.directory$",
-- }

