pico-8 cartridge // http://www.pico-8.com
version 15
__lua__

-- class --
actor = {}
actor.new = function()
	local obj = {}

	obj.init = function(self)
	end
	obj.update = function(self)
	end

	return obj
end

chara = {}
chara.new = function()
	local obj = actor.new()
	obj.actor_init = obj.init
	obj.actor_update = obj.update

	-- variables
	obj.x = 0
	obj.y = 0
	obj.spr = 0

	-- function
	obj.init = function(self)
		self:actor_init()
	end
	obj.update = function(self)
		self:actor_update()
		self:update_control()
		self:update_animation()
	end
	obj.draw = function(self)
		spr(self.spr,self.x,self.y)
	end

	obj.update_control = function(self)
	end
	obj.update_animation = function(self)
	end

	return obj
end

player = {}
player.new = function()
	local obj = chara.new()
	obj.chara_update_control = obj.update_control
	obj.chara_update_animation = obj.update_animation

	-- function
	obj.update_control = function(self)
		self:chara_update_control()
		self:update_by_button()
	end

	obj.update_animation = function(self)
		self:chara_update_animation()
	end

	obj.update_by_button = function(self)
		if(btn(0))then
			self.x -= 1
		elseif(btn(1))then
			self.x += 1
		elseif(btn(2))then
			self.y -= 1
		elseif(btn(3))then
			self.y += 1
		end
	end

	return obj
end

-- global --
local player = player.new()

-- system --
function _init()
	player:init()
end

function _update()
	player:update()
end

function _draw()
	-- background
	rectfill(0, 0, 580, 540, 0)

	player:draw()
end

