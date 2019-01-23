module Player_life
  def main(player_life,life_image)
    #プレイヤーのライフを表示
    player_life.times do |i|#プレイヤーのライフの数だけ繰り返す
      x = i * 30
      Window.draw(x,50,life_image)#ハートを表示
    end
  end
  module_function :main
end
