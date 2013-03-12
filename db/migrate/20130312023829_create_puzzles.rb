class CreatePuzzles < ActiveRecord::Migration
  def change
    create_table :puzzles do |t|

      t.timestamps
    end
  end
end
