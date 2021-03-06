--[[
	Copyright (C) 2014 HarpyWar (harpywar@gmail.com)
	
	This file is a part of the PvPGN Project http://pvpgn.pro
	Licensed under the same terms as Lua itself.
]]--


-- List of available lua commands
--  (To create a new command - create a new file in directory "commands")
local lua_command_table = {
	[1] = {
		["/w3motd"] = command_w3motd,

		-- Quiz
		["/quiz"] = command_quiz,
	},
	[8] = {
		["/redirect"] = command_redirect,
	},
}


-- Global function to handle commands
--   ("return 1" from a command will break next C++ code execution)
function handle_command(account, text)
	-- find command in table
	for cg,cmdlist in pairs(lua_command_table) do
		for cmd,func in pairs(cmdlist) do
			if string.starts(text, cmd) then
				
				-- check if command group is in account.commandgroups
				if not math_and(account.commandgroups, cg) then
					api.message_send_text(account.name, message_type_error, account.name, "This command is reserved for admins.")
					return 1
				end
				
				-- FIXME: we can use _G[func] if func is a text but not a function, 
				--        like ["/dotastats"] = "command_dotastats"
				--        and function command_dotastats can be defined below, not only before
				return func(account, text) 
			end
		end
	end
	return 0
end


-- Split command to arguments, 
--  index 0 is always a command name without a slash 
--  return table with arguments
function split_command(text, args_count)
	local count = args_count
	local result = {}
	local tmp = ""
	
	-- remove slash from the command
	if not string:empty(text) then
		text = string.sub(text, 2)
	end

	i = 0
	-- split by space
	for token in string.split(text) do
		if not string:empty(token) then 
			if (i < count) then
				result[i] = token 
				i = i + 1
			else
				if not string:empty(tmp) then
					tmp = tmp .. " "
				end
				tmp = tmp .. token
			end
		end
	end
	-- push remaining text at the end
	if not string:empty(tmp) then
    	result[count] = tmp
	end
	return result
end

