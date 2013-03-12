class PuzzlesController < ApplicationController

  def index
  end

  def solve
    grid = params[:puzzle].map{|i| i.empty? ? 0 : i.to_i}
    @puzzle = Puzzle.new(grid)
    @puzzle.solve
    redirect_to puzzles_path, notice: 'Invalid Puzzle' if @puzzle.invalid?
  end

end
