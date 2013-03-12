class Puzzle

  attr_accessor :grid

  def initialize(grid)
    @grid = grid
    @invalid = false
    @stuck = false
  end

  def solve
    until solved? || stuck?
      @stuck = true
      @grid.each_with_index do |value, index|
        solve_square(index) if value == 0
        return if invalid?
      end
    end

    guess if stuck?
  end

  def invalid?
    @invalid
  end

  def solved?
    !@grid.include?(0)
  end

  private

  def guess
    guess_index = @grid.index(0)
    options = valid_options(guess_index)
    options.each do |guess_value|
      new_grid = @grid.dup
      new_grid[guess_index] = guess_value
      sudoku = Puzzle.new(new_grid)
      sudoku.solve
      if sudoku.solved?
        @grid = sudoku.grid
        break
      end
    end
  end

  def solve_square(index)
    options = valid_options(index)

    @invalid = options.length == 0
    if options.length == 1
      @stuck = false
      @grid[index] = options[0]
    end
  end

  def valid_options(index)
    possible_options = [1,2,3,4,5,6,7,8,9]
    invalid_options = column_values(index)
    invalid_options += row_values(index)
    invalid_options += grid_values(index)
    invalid_options.uniq!
    possible_options.reject {|i| invalid_options.include?(i) }
  end

  def column_values(index)
    values = []
    (index % 9).step(80, 9) do |column_index|
      values << @grid[column_index] unless @grid[column_index] == 0
    end
    values
  end

  def row_values(index)
    values = []
    row_index = index - (index % 9)
    9.times {
      values << @grid[row_index] unless @grid[row_index] == 0
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
        values << @grid[grid_index] unless @grid[grid_index] == 0
      end
    end
    values
  end

  def stuck?
    @stuck
  end

end