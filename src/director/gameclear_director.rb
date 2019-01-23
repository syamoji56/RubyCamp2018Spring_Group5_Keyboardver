module Gameclear
  class Director

    def initialize
      @haikei=Haikei.new #背景
      @logo=Image.load("images/gameclear.png")#ロゴ
      @player_image=Image.load("images/player/player_ruby.png")#ルビーを持ったプレイヤー
      @font=Font.new(32,font_name="MS 明朝")#フォント
    end

    def play
      #シーンが切り替わった直後は変数はnilのため、ゲッターから値を受け取る。
      #２回目以降は値が入っていてイコールが成り立つため、スルーされる。
      @haikei.kumo_x = @haikei.kumo_x || Scene.kumo_x_getter
      @haikei.tatemono_x ||= Scene.tatemono_x_getter

      @haikei.draw #背景の表示

      Window.draw(200,100,@logo)#ロゴ表示
      Window.draw(350,300,@player_image)#プレイヤー表示

      Window.draw_font(250,420,"Enterキーでタイトルへ",@font,:color=>[0,0,0])
      Window.draw_font(280,480,"Escキーで終了",@font,:color=>[0,0,0])


      if Input.key_push?(K_RETURN)
        #背景の座標情報の受け渡し
        Scene.kumo_x_setter(@haikei.kumo_x)
        Scene.tatemono_x_setter(@haikei.tatemono_x)
        Scene.move_to(:title)#クリアシーンへ切り替え
        #変数の初期化
        @haikei=Haikei.new #背景
      end

    end

  end
end
