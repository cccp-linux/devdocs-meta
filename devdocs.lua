function CppWord()
   local isk0 = vim.opt.iskeyword
   vim.opt.iskeyword:append(":")
   local cppword = vim.fn.expand("<cword>")
   vim.opt.iskeyword = isk0
   return cppword
end

vim.api.nvim_create_user_command("DevGrep", function(opts)
   local command = vim.list_extend({"x-terminal-emulator", "-e", "devgrep"}, opts.fargs)
   vim.fn.jobstart(command)
end, {nargs = "*"})

if type(create_alias) == "function" then
   create_alias("devgrep", "DevGrep")
end

vim.keymap.set("n", "<leader>k", function() vim.cmd("DevGrep " .. CppWord()) end, {noremap = true})
