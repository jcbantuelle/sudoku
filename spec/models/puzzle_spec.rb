require "spec_helper"

describe Puzzle do

  let(:valid_sudoku) { Puzzle.new('800000009007090040092008100000004900060070020003100000004600830010020500200000001'.split(//).map(&:to_i)) }
  let(:invalid_sudoku) { Puzzle.new('888000009007090040092008100000004900060070020003100000004600830010020500200000001'.split(//).map(&:to_i)) }
  let(:sudoku_solution) { '831746259657291348492538167725384916168975423943162785574619832316827594289453671'.split(//).map(&:to_i) }

  describe '.solve' do
    context "a valid sudoku puzzle" do
      it "returns the solution" do
        valid_sudoku.solve.should eq(sudoku_solution)
      end
    end

    context "an invalid sudoku puzzle" do
      it "returns nil" do
        invalid_sudoku.solve.should eq(nil)
      end
    end
  end

end
