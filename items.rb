class Item < Sprite
  def initialize (image, level)
    x = rand(Window.width - image.width)
    y = 0
    super(x, y, image)
    @speed_y = rand(level+1) + 3
  end
  
  def update
    self.y += @speed_y
    self.vanish if self.y > Window.height
  end
end

class Apple < Item
  def initialize (level)
    super(Image[:apple], level)
    self.collision = [image.width / 2, image.height / 2, 56]
  end
  
  def hit
    Sound[:get].play
    self.vanish
    GAME_INFO[:score] += 10
  end
end

class Bomb < Item
  def initialize (level)
    super(Image[:bomb], level)
    self.collision = [image.width / 2, image.height / 2, 32]
  end
  
  def hit
    Sound[:explosion].play
    self.vanish
    GAME_INFO[:scene] = :game_over
  end
end

class Special < Item
  def initialize
    super(Image[:special], 0)
    self.collision = [image.width / 2, image.height / 2, 32]
  end
  
  def hit
    Sound[:get].play
    self.vanish
    GAME_INFO[:bonus] = rand(10..100)
  end
end

class Items
  N = 5
  
  def initialize
    @items = []
  end
  
  def update (player)
    @items.each do |item|
      item.update(player)
    end
    
    Sprite.check(player, @items)
    Sprite.clean(@items)
    
    (N - @items.size).times do
      r = rand(100)
      if r == 0
        @items.push(Special.new)
      elsif rand(1..100) < 40 || GAME_INFO[:bonus] > 0
        @items.push(Apple.new(player.level))
        GAME_INFO[:bonus] -= 1 if GAME_INFO[:bonus] > 0
      else
        @items.push(Bomb.new(player.level))
      end
    end
  end
  
  def draw
    Sprite.draw(@items)
  end
end
