class Tile < ApplicationRecord
  belongs_to :play
  scope :by_game, -> (game_id) { joins(:play).where('plays.game_id = ?', game_id) }
  validate :exists?

  def exists?
    if Tile.by_game(play.game_id).where('x = ? AND y = ?', x, y).any?
      errors.add(:base, :tile_exists)
    end
  end

  def adjacent
    Tile.by_game(play.game_id).where('abs(x - ?) + abs(y - ?)', x, y)
  end

  def center?
    x == 0 && y == 0
  end

  def inv(x_or_y)
    x_or_y == :x ? { y: y } : { x: x }
  end

  def overlaps_any?(tiles)
    tiles.any? { |m| m.x == x && m.y == y }
  end

  def any_adjacent?
    adjacent.count > 0
  end
end
