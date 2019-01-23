class Kurage < Enemy

  @@image=Image.load("images/kurage.png")#クラゲの画像

  def initialize(y)
    self.x=590#クラゲのｘ座標
    self.y=y#クラゲのｙ座標
    self.image = @@image#クラゲの画像

    @y_move = rand(-4..4)
  end

  #クラゲ情報を更新
  def update
    self.x -= 3#左に移動
    self.y +=@y_move#上下に移動

    #画面外に出たら消滅
    if self.x < -self.image.width
      self.vanish
    end

  end

  #プレイヤーかショットに当たった時
  def kurage_vanish
    self.vanish#消滅
    EXPLOSION_SOUND.play#破壊音
  end

  #床に当たった時
  def hit_floor
    @y_move -= rand(2)#ランダムに上に加速
  end

  #天井に当たった時
  def hit_ceiling
    @y_move += rand(2)#ランダムに下に加速
  end

end
