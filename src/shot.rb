class Shot < Sprite

  @@image=Image.new(20,20).circle_fill(10,10,10,C_WHITE)#ショットの画像

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

  #もし当たった場合
  def shot_vanish
    self.vanish#消去
  end

end
