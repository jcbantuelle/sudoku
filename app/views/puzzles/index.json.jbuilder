json.array!(@puzzles) do |puzzle|
  json.extract! puzzle, 
  json.url puzzle_url(puzzle, format: :json)
end