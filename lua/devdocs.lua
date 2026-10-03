local function cpp_word()
    local isk = vim.bo.iskeyword
    vim.bo.iskeyword = isk .. ",:"
    local word = vim.fn.expand("<cword>")
    vim.bo.iskeyword = isk
    return (word:gsub("^::", ""):gsub(":+$", ""))
end

local function devgrep(args)
    vim.fn.jobstart({ "x-terminal-emulator", "-e", "devgrep", unpack(args) })
end

vim.api.nvim_create_user_command("DevGrep",
    function(opts) devgrep(opts.fargs) end, { nargs = "*" }
)

if type(create_alias) == "function" then
    create_alias("dg", "DevGrep")
end

vim.keymap.set("n", "<leader>k", function() devgrep({ cpp_word() }) end)
