require 'dxopal'
include DXOpal

GROUND_Y = 400
Image.register(:player, 'images/player.png')
Image.register(:apple, 'images/apple.png')
Image.register(:bomb, 'images/bomb.png')
Image.register(:special, 'images/special.png')

Sound.register(:get, 'sounds/get.wav')
Sound.register(:explosion, 'sounds/explosion.wav')

GAME_INFO = {
  scene: :title,
  score: 0,
  bonus: 0,
}

require_remote "player.rb"
require_remote "items.rb"
require_remote "game.rb"

Window.load_resources do
  game = Game.new
  game.run
end
