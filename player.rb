class Player < Sprite
  attr_reader :level
  
  def initialize
    x = Window.width / 2
    y = GROUND_Y - Image[:player].height
    image = Image[:player]
    super(x, y, image)
    self.collision = [image.width / 2, image.height / 2, 16]
    @get = 0
    @level = 1
  end
  
  def update
    if Input.key_down?(K_LEFT) and x > 0
      self.x -= 8
    elsif Input.key_down?(K_RIGHT) and x < (Window.width - Image[:player].width)
      self.x += 8
    end
  end
  
  def shot
    @get += 1
    @level += 1 if @get % 10 == 0
  end
end
