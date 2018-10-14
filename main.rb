require 'dxopal'
include DXOpal

GROUND_Y = 400
Image.register(:player, 'images/player.png')
Image.register(:apple, 'images/apple.png')
Image.register(:bomb, 'images/bomb.png')

class Player < Sprite
  def initialize
    x = Window.width / 2
    y = GROUND_Y - Image[:player].height
    image = Image[:player]
    super(x, y, image)
  end
  
  def update
    if Input.key_down?(K_LEFT) and x > 0
      self.x -= 8
    elsif Input.key_down?(K_RIGHT) and x < (Window.width - Image[:player].width)
      self.x += 8
    end
  end
end

class Item < Sprite
  def initialize (image)
    x = rand(Window.width - image.width)
    y = 0
    super(x, y, image)
    @speed_y = rand(9) + 4
  end
  
  def update
    self.y += @speed_y
    self.vanish if self.y > Window.height
  end
end

class Apple < Item
  def initialize
    super(Image[:apple])
  end
end

class Bomb < Item
  def initialize
    super(Image[:bomb])
  end
end

class Items
  N = 5
  
  def initialize
    @items = []
  end
  
  def update
    Sprite.update(@items)
    Sprite.clean(@items)
    
    (N - @items.size).times do
      if rand(1..100) < 40
        @items.push(Apple.new)
      else
        @items.push(Bomb.new)
      end
    end
  end
  
  def draw
    Sprite.draw(@items)
  end
end

Window.load_resources do
  player = Player.new
  items = Items.new
  
  Window.loop do
    player.update
    items.update
    
    Window.draw_box_fill(0, 0,Window.width, GROUND_Y, [128, 255, 255])
    Window.draw_box_fill(0, GROUND_Y, Window.width, Window.height, [0, 128, 0])
    
    player.draw
    items.draw
  end
end
