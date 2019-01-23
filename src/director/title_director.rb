module Title
  class Director

    def initialize
      @haikei=Haikei.new(Window.width) #背景
      @logo=Image.load("images/title.png")#タイトルロゴ
      @flag = 0#テキストメッセージ変更管理フラグ
      @font=Font.new(32,font_name="MS 明朝")#フォント

      @kyaputya1=Image.load("images/kyaputya/kyaputya1.png")
      @kyaputya2=Image.load("images/kyaputya/kyaputya2.png")
      @kyaputya3=Image.load("images/kyaputya/kyaputya3.png")
    end

    def play
      #シーンが切り替わった直後は変数はnilのため、ゲッターから値を受け取る。
      #２回目以降は値が入っていてイコールが成り立つため、スルーされる。
      @haikei.kumo_x = @haikei.kumo_x || Scene.kumo_x_getter
      @haikei.tatemono_x ||= Scene.tatemono_x_getter

      @haikei.move #背景の移動
      @haikei.draw #背景の表示

      #スペースキーが押されたらフラグを増やす
      if Input.key_push?(K_SPACE)==true
        @flag += 1
      end

      case @flag
      when 0
        Window.draw(100,100,@logo)#タイトルロゴ表示
        Window.draw_font(200,400,"盗まれたルビーを取り返そう！!",@font,:color=>[0,0,0])
        Window.draw_font(200,460,"SPACEキーで次へ",@font,:color=>[0,0,0])
      when 1
        Window.draw(0,0,@kyaputya1)
        Window.draw_font(250,0,"チュートリアル",@font,:color=>[0,0,0])
      when 2
        Window.draw(0,0,@kyaputya2)
        Window.draw_font(250,0,"チュートリアル",@font,:color=>[0,0,0])
      when 3
        Window.draw(0,0,@kyaputya3)
        Window.draw_font(250,0,"チュートリアル",@font,:color=>[0,0,0])
      when 4
        #シーンを切り替える
        #背景の座標情報の受け渡し
        Scene.kumo_x_setter(@haikei.kumo_x)
        Scene.tatemono_x_setter(@haikei.tatemono_x)
        Scene.move_to(:game)#ゲームシーンへ切り替え
        BGM_SOUND.play#ＢＧＭスタート
        #変数の初期化
        @haikei=Haikei.new#背景
        @flag = 0
      end

    end

  end
end
