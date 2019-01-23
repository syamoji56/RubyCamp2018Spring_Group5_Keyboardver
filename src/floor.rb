class Floor < Sprite

  def initialize
    self.x=0#床のｘ座標
    self.y=400#床のｙ座標
    self.image = Image.new(800,600,[160,82,45])#床の画像
  end

end
