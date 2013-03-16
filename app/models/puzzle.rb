class Puzzle

  attr_accessor :grid, :error

  def initialize(grid)
    @grid = grid
    @valid = true
    @stuck = false
    @error = nil
  end

  def self.generate

  end

  def solve
    return unless valid_grid?
    solve_squares
    guess if stuck? && valid?
    valid? ? @grid : nil
  end

  private

  def valid_grid?
    valid_grid_size? && valid_grid_values?
  end

  def valid_grid_size?
    if grid.length != 81
      @valid = false
      @error = "Grid is not 9x9"
    end
    valid?
  end

  def valid_grid_values?
    @grid.each_with_index do |value, index|
      unless value == 0
        used_values = values_for_square index
        if used_values.include? value
          @valid = false
          @error = "Grid has conflicting values"
          return false
        end
      end
    end
    true
  end

  def guess
    guess_index = @grid.index(0)
    options = valid_options(guess_index)
    options.each do |guess_value|
      new_grid = @grid.dup
      new_grid[guess_index] = guess_value
      sudoku = Puzzle.new(new_grid)
      if sudoku.solve
        @grid = sudoku.grid
        return
      end
    end
    @valid = false
  end

  def solve_squares
    until solved? || stuck?
      @stuck = true
      @grid.each_with_index do |value, index|
        solve_square(index) if value == 0
        return unless valid?
      end
    end
  end

  def solve_square(index)
    options = valid_options(index)

    @valid = options.length != 0
    if options.length == 1
      @stuck = false
      @grid[index] = options[0]
    end
  end

  def valid_options(index)
    [1,2,3,4,5,6,7,8,9] - values_for_square(index)
  end

  def values_for_square(index)
    column_values(index) + row_values(index) + grid_values(index)
  end

  def column_values(index)
    values = []
    (index % 9).step(80, 9) do |column_index|
      values << @grid[column_index] unless column_index == index || @grid[column_index] == 0
    end
    values
  end

  def row_values(index)
    values = []
    row_index = index - (index % 9)
    9.times {
      values << @grid[row_index] unless row_index == index || @grid[row_index] == 0
      row_index += 1
    }
    values
  end

  def grid_values(index)
    values = []
    row_start = (index / 27) * 3 * 9
    column_start = ((index % 9) / 3) * 3
    grid_start = row_start + column_start
    0.step(18, 9) do |row|
      0.step(2) do |column|
        grid_index = grid_start + row + column
        values << @grid[grid_index] unless grid_index == index || @grid[grid_index] == 0
      end
    end
    values
  end

  def stuck?
    @stuck
  end

  def valid?
    @valid
  end

  def solved?
    !@grid.include?(0)
  end
end
