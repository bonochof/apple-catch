class Game
  def initialize
    reset
  end
  
  def reset
    @player = Player.new
    @items = Items.new
    GAME_INFO[:score] = 0
    GAME_INFO[:bonus] = 0
  end

  def run
    Window.loop do
      Window.draw_box_fill(0, 0, Window.width, GROUND_Y, [128, 255, 255])
      Window.draw_box_fill(0, GROUND_Y, Window.width, Window.height, [0, 128, 0])
      Window.draw_font(0, 0, "SCORE: #{GAME_INFO[:score]}", Font.default, :color=>[0, 0, 0])
      
      case GAME_INFO[:scene]
      when :title
        Window.draw_font(240, 120, "PRESS SPACE", Font.default, :color=>[200, 0, 0])
        GAME_INFO[:scene] = :playing if Input.key_push?(K_SPACE)
      when :playing
        @player.update
        @items.update(@player)
        @player.draw
        @items.draw
      when :game_over
        @player.draw
        @items.draw
        Window.draw_font(240, 120, "PRESS SPACE", Font.default, :color=>[200, 0, 0])
        if Input.key_push?(K_SPACE)
          reset
          GAME_INFO[:scene] = :playing
        end
      end
    end
  end
end
