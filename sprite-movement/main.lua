_G.love = require("love")

function love.load()
	_G.wizard = {
		x = 0,
		y = 0,
		image = {
			move = love.graphics.newImage("images/wizard-move.png"),
		},
		animation = {
			direction = "left",
			idle = true,
			frame = 1,
			max_frames = 6,
			speed = 5,
			timer = 0.1,
		},
	}
	_G.moveQuad = {}

	local SPRITE_WIDTH, SPRITE_HEIGHT = 768, 512
	local QUAD_WIDTH = 128
	local QUAD_HEIGHT = 128
	local QUAD_ROWS = 4
	local QUAD_COLUMNS = 6

	for column = 1, QUAD_COLUMNS do
		for row = 0, QUAD_ROWS do
			if moveQuad[column] == nil then
				moveQuad[column] = {}
			end

			moveQuad[column][row + 1] = love.graphics.newQuad(
				QUAD_WIDTH * (column - 1),
				QUAD_HEIGHT * row,
				QUAD_WIDTH,
				QUAD_HEIGHT,
				SPRITE_WIDTH,
				SPRITE_HEIGHT
			)
		end
	end

	print(moveQuad)
end

function love.update(dt)
	wizard.animation.timer = wizard.animation.timer + dt

	if love.keyboard.isDown("w") then
		wizard.animation.idle = false
		wizard.animation.direction = "up"
	elseif love.keyboard.isDown("s") then
		wizard.animation.idle = false
		wizard.animation.direction = "down"
	elseif love.keyboard.isDown("a") then
		wizard.animation.idle = false
		wizard.animation.direction = "left"
	elseif love.keyboard.isDown("d") then
		wizard.animation.idle = false
		wizard.animation.direction = "right"
	else
		wizard.animation.idle = true
		wizard.animation.frame = 1
	end

	if not wizard.animation.idle then
		if wizard.animation.timer > 0.2 then
			wizard.animation.timer = 0.1
			wizard.animation.frame = wizard.animation.frame + 1

			if wizard.animation.direction == "up" then
				wizard.y = wizard.y - wizard.animation.speed
			elseif wizard.animation.direction == "down" then
				wizard.y = wizard.y + wizard.animation.speed
			elseif wizard.animation.direction == "left" then
				wizard.x = wizard.x - wizard.animation.speed
			elseif wizard.animation.direction == "right" then
				wizard.x = wizard.x + wizard.animation.speed
			end

			if wizard.animation.frame > wizard.animation.max_frames then
				wizard.animation.frame = 1
			end
		end
	end
end

function love.draw()
	love.graphics.scale(4, 4)

	if wizard.animation.direction == "down" then
		love.graphics.draw(wizard.image.move, moveQuad[wizard.animation.frame][1], wizard.x, wizard.y)
	elseif wizard.animation.direction == "left" then
		love.graphics.draw(wizard.image.move, moveQuad[wizard.animation.frame][2], wizard.x, wizard.y)
	elseif wizard.animation.direction == "right" then
		love.graphics.draw(wizard.image.move, moveQuad[wizard.animation.frame][3], wizard.x, wizard.y)
	elseif wizard.animation.direction == "up" then
		love.graphics.draw(wizard.image.move, moveQuad[wizard.animation.frame][4], wizard.x, wizard.y)
	end
end
