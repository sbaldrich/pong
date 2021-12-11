--[[ push allows to draw to the screen in a virtual resolution,
    which will help
    transmit a more retro aesthetic
    https://github.com/Ulydev/push
    (not actively maintained as of Dec 2021)
--]]

push = require 'lib/push'
Class = require 'lib/class'

require 'src/Ball'
require 'src/Paddle'
require 'src/util'

require 'src/StateMachine'
require 'src/states/BaseState'
require 'src/states/StartState'
require 'src/states/PlayState'
require 'src/states/DoneState'
require 'src/states/GlobalState'

-- set up the sound effects table
gSounds = {
    ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
    ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
    ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
}

-- Set up the fonts
gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32)   
}