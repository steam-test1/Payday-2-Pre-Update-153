require("lib/utils/Messages")
MessageSystem = MessageSystem or class()

function MessageSystem:init()
	self._listeners = {}
	self._remove_list = {}
	self._add_list = {}
end

function MessageSystem:register(message, uid, func)
	table.insert(self._add_list, {
		message = message,
		uid = uid,
		func = func
	})
end

function MessageSystem:unregister(message, uid)
	table.insert(self._remove_list, {message = message, uid = uid})
end

function MessageSystem:notify(message, uid, ...)
	self:flush()
	if self._listeners[message] then
		if uid then
			if self._listeners[message][uid] then
				self._listeners[message][uid](unpack(arg))
			end
		else
			for key, value in pairs(self._listeners[message]) do
				value(unpack(arg))
			end
		end
	end
end

function MessageSystem:flush()
	if #self._remove_list > 0 then
		self:_remove()
	end
	if 0 < #self._add_list then
		self:_add()
	end
end

function MessageSystem:_remove()
	local count = #self._remove_list
	for i = 1, count do
		local data = self._remove_list[i]
		self:_unregister(self._remove_list[i].message, self._remove_list[i].uid)
		self._remove_list[i].message = nil
		self._remove_list[i].uid = nil
	end
	self._remove_list = nil
	self._remove_list = {}
end

function MessageSystem:_add()
	local count = #self._add_list
	for i = 1, count do
		local data = self._add_list[i]
		self:_register(data.message, data.uid, data.func)
		self._add_list[i].message = nil
		self._add_list[i].uid = nil
		self._add_list[i].func = nil
	end
	self._add_list = nil
	self._add_list = {}
end

function MessageSystem:_register(message, uid, func)
	if not self._listeners[message] then
		self._listeners[message] = {}
	end
	if not self._listeners[message][uid] then
		self._listeners[message][uid] = func
	end
end

function MessageSystem:_unregister(message, uid)
	if self._listeners[message] then
		self._listeners[message][uid] = nil
	end
end
