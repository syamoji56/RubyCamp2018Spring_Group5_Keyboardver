class Sijimi < Sprite

  @@image=Image.load("images/sijimi.png").set_color_key(C_WHITE)#しじみ汁の画像

  def initialize(y)
    self.x=Window.width#しじみ汁のｘ座標
    self.y=y#しじみ汁のｙ座標
    self.image = @@image#しじみ汁の画像
  end

  #しじみ汁情報を更新
  def update
    self.x -= 2#左に移動

    #画面外に出たら消滅
    if self.x < -self.image.width
      self.vanish
    end
  end

  #プレイヤーに当たった時
  def sijimi_vanish
    self.vanish#消滅
    GET_SIJIMI_SOUND.play#しじみ汁を捕った音
  end

end
