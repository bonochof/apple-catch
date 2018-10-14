require 'dxopal'
include DXOpal

GROUND_Y = 400
Image.register(:player, 'images/player.png')

Window.load_resources do
  x = Window.width / 2
  
  Window.loop do
    if Input.key_down?(K_LEFT)
      x -= 8
    elsif Input.key_down?(K_RIGHT)
      x += 8
    end
    
    Window.draw_box_fill(0, 0,Window.width, GROUND_Y, [128, 255, 255])
    Window.draw_box_fill(0, GROUND_Y, Window.width, Window.height, [0, 128, 0])
    
    Window.draw(x, GROUND_Y - Image[:player].height, Image[:player])
  end
end
