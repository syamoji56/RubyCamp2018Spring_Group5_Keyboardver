module Boss_life
  def main(boss_life,life_image,font)
    #ボスのライフを表示
    Window.draw_font(480,50,"boss",font)

    if boss_life>=9
      Window.draw(550,50,life_image)
      Window.draw_font(580,50,"×#{boss_life}",font)
    else
      boss_life.times do |i|#ボスのライフの数だけ繰り返す
        x = i * 30 + 550
        Window.draw(x,50,life_image)#ハートを表示
      end
    end

  end
  module_function :main
end
