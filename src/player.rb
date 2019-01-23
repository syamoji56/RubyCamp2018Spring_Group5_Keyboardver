class Player < Sprite

  attr_accessor :jump_ok,:player_life

  def initialize
    self.x=50#プレイヤーのｘ座標
    self.y=0#プレイヤーのｙ座標
    @image=[]

    @image[0]=Image.load("images/player/player1.png")
    @image[1]=Image.load("images/player/player2.png")
    @image[2]=Image.load("images/player/player3.png")
    self.image = @image[0]#プレイヤーの画像

    #画像差し替え用配列
    @hairetu=[]
    @hairetu[0]=0
    @hairetu[1]=1
    @hairetu[2]=2
    @hairetu[3]=1

    @gravity_initial=7#重力の初期値（最大値）
    @gravity_now=@gravity_initial#現在の重力
    @jump_ok=false#ジャンプ可能かどうか（地面についているか）

    @player_life = 5#プレイヤーのライフ、初期設定は５

    @image_count=0#プレイヤー画像を差し替えるカウント
    @image_num=0#プレイヤー画像番号
    @image_interval=10#プレイヤー画像の更新間隔
  end

  #プレイヤー情報の更新
  def update
    if Input.key_push?(K_SPACE) && @jump_ok == true#もしスペースキーが押されて、ジャンプ可能なら
      @gravity_now = -15.5#重力を減らしてジャンプする
      @jump_ok=false#ジャンプを不可能にする
      JUMP_SOUND.play#ジャンプ音
    end

    @gravity_now += 0.5#重力を増やす
    if @gravity_now > @gravity_initial#もし今の重力が初期値（最大値）を超えるなら
      @gravity_now = @gravity_initial#重力を初期値（最大値）にする（超えないようにする）
    end

    self.y = self.y + @gravity_now#プレイヤーのｙ座標を計算する

    #カウントがインターバル以上になれば、画像を差し替え
    if @image_count >=@image_interval
      @image_count = 0
      @image_num += 1
      if @image_num >=4
        @image_num = 0
      end
      self.image=@image[@hairetu[@image_num]]
    end

    @image_count += 1
  end

  #床とプレイヤーが当たった時
  def hit_floor(o)
    #プレイヤーの高さを床からプレイヤーの画像の高さ分だけ引いた値にする
    self.y=o.y-self.image.height
    self.jump_ok=true#ジャンプできるようにする
  end

  #エネミーとプレイヤーが当たった時
  def hit_enemy
    @player_life -= 1#ライフを１減らす
    DAMAGE_SOUND.play#ダメージ音
  end

  #しじみ汁とプレイヤーが当たった時
  def hit_sijimi
    @player_life += 1#ライフを１増やす
  end

end
