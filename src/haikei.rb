class Haikei

  #シーンクラスから変数を読み込みを許可
  attr_accessor :kumo_x,:tatemono_x

  #引数はタイトルではクラス生成時に受け取り、それ以外は受け取りを行わずnilが入る
  def initialize(x=nil)
    #相対パスがあっているか分からない
    @aozora=Image.load("images/haikei/aozora.png")#青空
    @kumo=Image.load("images/haikei/kumo.png")#雲
    @tatemono=Image.load("images/haikei/tatemono.png")#建物（緑の物体）
    @kumo_x = x#雲の初期位置
    @tatemono_x = x#建物の初期位置
  end

  #雲と建物の移動
  def move
    @kumo_x = @kumo_x - 9#雲を左に移動
    if @kumo_x <= -400#もし雲が左端で見えなくなったら
      @kumo_x = Window.width#初期位置（右側）に移動
    end

    @tatemono_x = @tatemono_x - 14#建物を左に移動
    if @tatemono_x <= -400#もし建物が左端で見えなくなったら
      @tatemono_x = Window.width#初期位置（右側）に移動
    end
  end

  #背景の表示
  def draw
    Window.draw(0,0,@aozora)#青空の表示
    Window.draw(@kumo_x,0,@kumo)#雲の表示
    Window.draw(@tatemono_x,250,@tatemono)#建物の表示
  end

end
