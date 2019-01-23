require_relative "../player"
require_relative "../shot"
require_relative "../beam"
require_relative "../enemy"
require_relative "../kurage"
require_relative "../boss"
require_relative "../sijimi"
require_relative "../floor"
require_relative "../ceiling"
require_relative "../info/player_life"
require_relative "../info/boss_life.rb"
require_relative "../info/power_gage"

module Game
  class Director

    def initialize
      setup#セットアップメソッドの実行
    end

    def play

      #シーンが切り替わった直後は変数はnilのため、ゲッターから値を受け取る。
      #２回目以降は値が入っていてイコールが成り立つため、スルーされる。
      @haikei.kumo_x = @haikei.kumo_x || Scene.kumo_x_getter
      @haikei.tatemono_x ||= Scene.tatemono_x_getter

      @haikei.move #背景の移動
      @haikei.draw #背景の表示

      #パワーの増加、ただし、上限まで
      @power += 1.0
      if @power >=@power_limit
        @power = @power_limit
      end

      #もしＶキーが押されたら、ショットを生成
      if Input.key_push?(K_V)&&@power>=@shot_need_power
        @shot << Shot.new(@player.x+@player.image.width,@player.y+20)
        @power -= @shot_need_power
      end

      #もしＣキーが押されたら、ビームを生成
      if Input.key_push?(K_C)&&@power>=@beam_need_power
        @beam << Beam.new(@player.x+@player.image.width,@player.y+5)
        @power -= @beam_need_power
      end

      #もしクラゲカウントが０ならクラゲ出現
      if @kurage_count <=0
        @kurage << Kurage.new(rand(@ceiling.image.height..@floor.y-50))
        @kurage_count = @kurage_interval#クラゲ再出現間隔
      end
      @kurage_count -= 1

      #もししじみカウントが０ならしじみ汁出現
      if @sijimi_count <=0
        @sijimi << Sijimi.new(rand(@ceiling.image.height..@floor.y-100))
        @sijimi_count = @sijimi_interval#しじみ汁再出現間隔
      end
      @sijimi_count -= 1

      @player.update#(@shot)#ショット生成用#プレイヤーを更新
      Sprite.update(@shot)#ショットを更新
      Sprite.update(@beam)#ビームを更新

      Sprite.update(@kurage)#クラゲを更新
      @boss.update#ボスを更新
      Sprite.update(@sijimi)#しじみ汁を更新

      Sprite.check(@floor,@player,shot=nil,hit=:hit_floor)#床とプレイヤーの判定
      Sprite.check(@sijimi,@player,shot=:sijimi_vanish,hit=:hit_sijimi)#しじみ汁とプレイヤーの判定
      Sprite.check(@kurage,@player,shot=:kurage_vanish,hit=:hit_enemy)#クラゲとプレイヤーの判定

      Sprite.check(@shot,@kurage,shot=:shot_vanish,hit=:kurage_vanish)#ショットとクラゲの判定
      Sprite.check(@shot,@boss,shot=:shot_vanish,hit=:hit_shot_beam)#ショットとボスの判定

      Sprite.check(@beam,@kurage,shot=nil,hit=:kurage_vanish)#ビームとクラゲの判定
      Sprite.check(@beam,@boss,shot=nil,hit=:hit_shot_beam)#ビームとボスの判定

      Sprite.check(@floor,@kurage,shot=nil,hit=:hit_floor)#床とクラゲの判定
      Sprite.check(@ceiling,@kurage,shot=nil,hit=:hit_ceiling)#天井とクラゲの判定

      Sprite.check(@floor,@boss,shot=nil,hit=:hit_floor_ceiling)#床とボスの判定
      Sprite.check(@ceiling,@boss,shot=nil,hit=:hit_floor_ceiling)#天井とボスの判定

      @floor.draw#床を描画
      @ceiling.draw#天井を描画
      Sprite.draw(@sijimi)
      Sprite.draw(@beam)#ビームを描画
      Sprite.draw(@shot)#ショットを描画
      @player.draw#プレイヤーを描画
      Sprite.draw(@kurage)#クラゲを描画
      @boss.draw#ボスを描画

      Player_life.main(@player.player_life,@life_image)#プレイヤーのライフを表示
      Boss_life.main(@boss.boss_life,@life_image,@font)#ボスのライフを表示

      Power_gage.main(@power,@power_limit,@power_gage_box,@font)#パワーゲージを表示

      Sprite.clean([@kurage,@sijimi])#vanishされたクラゲの削除

      #もしボスを倒したら、ゲームクリアシーンへ
      if @boss.boss_life<=0
        #背景の座標情報の受け渡し
        Scene.kumo_x_setter(@haikei.kumo_x)
        Scene.tatemono_x_setter(@haikei.tatemono_x)
        Scene.move_to(:gameclear)#クリアシーンへ切り替え
        BGM_SOUND.stop#ＢＧＭストップ
        GAME_CLEAR_SOUND.play#クリア音

        setup#セットアップメソッドを実行し、変数を初期化
      end

      #もしプレイヤーのライフが０なら、ゲームオーバーシーンへ
      if @player.player_life<=0
        #背景の座標情報の受け渡し
        Scene.kumo_x_setter(@haikei.kumo_x)
        Scene.tatemono_x_setter(@haikei.tatemono_x)
        Scene.move_to(:gameover)#ゲームオーバーシーンへ切り替え
        BGM_SOUND.stop#ＢＧＭストップ
        GAME_OVER_SOUND.play#ゲームオーバー音

        setup#セットアップメソッドを実行し、変数を初期化
      end

    end

    private#ここより下のメソッドはプライベートメソッド（自分以外呼び出せない）

    def setup
      @haikei=Haikei.new#背景
      @player=Player.new#プレイヤー
      @shot=[]#ショット
      @beam=[]#ビーム
      @kurage=[]#クラゲ
      @boss=Boss.new#ボス
      @sijimi=[]#しじみ汁
      @floor=Floor.new#床
      @ceiling=Ceiling.new#天井

      @life_image=Image.load("images/life.png",0,0,30,30)#ライフの画像
      @power_gage_box=Image.new(300,30).box(0,0,300,30,C_WHITE)#パワーゲージの外枠

      @font=Font.new(32)#フォント

      @kurage_count=0#最初のクラゲが出現するまでの時間
      @kurage_interval=90#クラゲ出現間隔
      @sijimi_count=600#最初のしじみ汁が出現するまでの時間
      @sijimi_interval=900#しじみ汁出現間隔

      @power=0#パワーの初期値
      @power_limit=600#パワーの上限

      @shot_need_power = 60#ショットに必要なパワー
      @beam_need_power = @power_limit#ビームに必要なパワー
    end

  end
end
