class Scene

  #シーン配列の作成
  @@scenes={}

  #シーンの初期位置をnil
  @@current_scene_name=nil

  # #初期設定
  @@scene_kumo_x=nil
  @@scene_tatemono_x=nil

  #シーンを追加
  def self.add(scene_obj,scene_name)
    @@scenes[scene_name.to_sym] = scene_obj
  end

  #シーンを移動
  def self.move_to(scene_name)
    @@current_scene_name = scene_name.to_sym
  end

  #シーンを実行
  def self.play
    @@scenes[@@current_scene_name].play
  end

  #今のシーンの、雲のｘ座標を保存
  def self.kumo_x_setter(val)
    @@scene_kumo_x = val
  end

  #今のシーンの、建物のｘ座標を保存
  def self.tatemono_x_setter(val)
    @@scene_tatemono_x = val
  end

  #保存した雲のｘ座標を読み込む
  def self.kumo_x_getter
    @@scene_kumo_x
  end

  #保存した建物のｘ座標を読み込む
  def self.tatemono_x_getter
    @@scene_tatemono_x
  end

end
