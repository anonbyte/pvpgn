--[[
	Copyright (C) 2014 HarpyWar (harpywar@gmail.com)
	
	This file is a part of the PvPGN Project http://pvpgn.pro
	Licensed under the same terms as Lua itself.
]]--


function handle_user_whisper(account_src, account_dst, text)
	--api.eventlog(eventlog_level_gui, __FUNCTION__, account_src.name.."->"..account_dst.name.. ": ".. text)
	--return 1;
end
function handle_user_login(account)
	--api.eventlog(eventlog_level_gui, __FUNCTION__, account.name.." logged in")
	--return 1;
end
function handle_user_disconnect(account)
	--api.eventlog(eventlog_level_gui, __FUNCTION__, account.name.." disconnected")
end

