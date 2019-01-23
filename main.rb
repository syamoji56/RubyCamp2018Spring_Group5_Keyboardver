require "dxruby"
require_relative "scene"
require_relative "src/director/title_director"
require_relative "src/director/game_director"
require_relative "src/director/gameclear_director"
require_relative "src/director/gameover_director"

require_relative "src/haikei"

#ウインドウ名
Window.caption = "Super Ruby Brothers"

#ウインドウの大きさ　X800,Y600
Window.width = 800
Window.height = 600

#シーンの作成
Scene.add(Title::Director.new, :title)
Scene.add(Game::Director.new, :game)
Scene.add(Gameclear::Director.new, :gameclear)
Scene.add(Gameover::Director.new, :gameover)

#Sound
BGM_SOUND = Sound.new("sound/bgm.wav")#プレイ中BGM
GAME_CLEAR_SOUND = Sound.new("sound/gameclear.wav")#ゲームクリア音
GAME_OVER_SOUND = Sound.new("./sound/gameover.wav")#ゲームオーバー音

JUMP_SOUND = Sound.new("sound/jump.wav")#プレイヤージャンプ時
PLAYER_SHOT_SOUND = Sound.new("sound/playershot.wav") #プレイヤー弾発射時
DAMAGE_SOUND = Sound.new("sound/damage.wav")#ダメージを受けた時
EXPLOSION_SOUND = Sound.new("sound/explosion.wav")#敵破壊、ダメージ時
GET_SIJIMI_SOUND = Sound.new("sound/getsijimi.wav")#しじみ汁を捕った時


#タイトル画面へ移行
Scene.move_to(:title)

#メインループ
Window.loop do

  #シーンの実行
  Scene.play
  #スペースキーで終了
  break if Input.key_push?(K_ESCAPE)

end
