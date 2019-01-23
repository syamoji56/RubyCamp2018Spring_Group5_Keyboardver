class Beam < Sprite

  @@image=Image.new(300,50).box_fill(0,0,300,50,C_YELLOW)#ビームの画像

  def initialize(x,y)
    self.x=x#ショットのｘ座標
    self.y=y#ショットのｙ座標
    self.image = @@image
    PLAYER_SHOT_SOUND.play#ショット音
  end

  #ショット情報の更新
  def update
    self.x += 4#右に移動

    #もし画面外に出たら消去
    if self.x > Window.width
      self.vanish
    end
  end

end
