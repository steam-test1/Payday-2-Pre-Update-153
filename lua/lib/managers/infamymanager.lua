InfamyManager = InfamyManager or class()
InfamyManager.VERSION = 1

function InfamyManager:init()
end

function InfamyManager:owned(item)
	return false
end

function InfamyManager:check_reset_message()
end

function InfamyManager:save(data)
end

function InfamyManager:load(data, version)
end

function InfamyManager:reset()
end
