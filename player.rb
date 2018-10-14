class Player < Sprite
  def initialize
    x = Window.width / 2
    y = GROUND_Y - Image[:player].height
    image = Image[:player]
    super(x, y, image)
    self.collision = [image.width / 2, image.height / 2, 16]
  end
  
  def update
    if Input.key_down?(K_LEFT) and x > 0
      self.x -= 8
    elsif Input.key_down?(K_RIGHT) and x < (Window.width - Image[:player].width)
      self.x += 8
    end
  end
end
