module Power_gage
  def main(power,power_limit,power_gage_box,font)
    #パワーゲージの長さを求める
    power_gage=Image.new(300,30).box_fill(0,0,300*(power/power_limit),30,C_WHITE)
    Window.draw(100,10,power_gage)#ゲージを表示
    Window.draw(100,10,power_gage_box)#ゲージの外枠を表示

    Window.draw_font(10,10,"Power",font)#テキスト（Power）を表示
  end
  module_function :main
end
