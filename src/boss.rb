class Boss < Enemy

  attr_accessor :boss_life

  def initialize
    self.x=600#ボスのｘ座標
    self.y=210#ボスのｙ座標
    self.image = Image.load("images/boss.png")#ボスの画像

    @boss_life=10#ボスのライフ、初期設定は１０
    @y_move=2#ｙ座標の移動量
    @ruby_image=Image.load("images/ruby.png").set_color_key(C_WHITE)#ルビーの画像
  end

  #ボス情報を更新
  def update
    self.y += @y_move#上下に移動
  end

  #ボスとルビーを表示
  def draw
    super
    Window.draw(self.x+50,self.y-15,@ruby_image,0)
  end

  #床か天井に当たった時
  def hit_floor_ceiling
    @y_move *= -1#移動方向を上下反転
  end
  #ショットかビームに当たった時
  def hit_shot_beam
    @boss_life -= 1#ボスのライフを１減らす
    EXPLOSION_SOUND.play#ダメージ音
  end

end
