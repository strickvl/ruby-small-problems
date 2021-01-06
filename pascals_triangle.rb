class Triangle
  def initialize(max_rows)
    @max_rows = max_rows
  end

  def rows
    rows = [[1], [1, 1]]
    return [[1]] if @max_rows == 1
    return rows if @max_rows == 2
    new_row = []
    (@max_rows - 2).times do
      new_row << 1
      index = 0
      loop do
        break if index == rows.last.size - 1
        new_row << (rows.last[index] + rows.last[index + 1])
        index += 1
      end
      new_row << 1
      rows << new_row
      new_row = []
    end
    rows
  end
end
