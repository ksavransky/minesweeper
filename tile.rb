class Tile
  attr_reader :value, :revealed, :flagged

  def initialize(value)
    @value = value
    @revealed = false
    @flagged = false
  end
end
