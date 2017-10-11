class Play < ApplicationRecord
  belongs_to :game
  belongs_to :user

  has_many :tiles, autosave: true
  validates_associated :tiles
  validate :touches_tiles_or_center
  validate :linear_placement

  def tile_at(x, y)
    self.tiles << Tile.new(x: x, y: y, play: self)
  end

  def tiles_at(coords)
    self.tiles = []
    coords.map { |a| self.tile_at(a[0], a[1]) }
  end

  def touches_tiles_or_center
    unless tiles.map(&:center?).any? || tiles.map(&:any_adjacent?).any?
      errors.add(:tiles, 'Tile must touch one of existing tiles ot have tiles places on center')
    end
  end

  def linear_placement
    if tiles.map(&:x).uniq.length != 1 && tiles.map(&:y).uniq.length != 1
      errors.add(:tiles, 'Must be in one line')
    end
  end

end
