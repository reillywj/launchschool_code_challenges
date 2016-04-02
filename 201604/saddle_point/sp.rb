# Matrix is a class that is used to find saddle points within a given matrix.
class Matrix
  attr_reader :rows
  def initialize(matrix)
    rows = matrix.split("\n")
    @rows = []
    rows.each_with_index do |row, index|
      @rows[index] = row.split(' ').map(&:to_i)
    end
  end

  def columns
    @columns || find_columns
  end

  def saddle_points
    points = []

    @rows.each_with_index do |row, row_number|
      row.each_with_index do |_value, column_number|
        points << [row_number, column_number] if saddle_point?(row_number, column_number)
      end
    end

    points
  end

  private

  def find_columns
    cols = []
    rows.each_with_index do |row, row_number|
      row.each_with_index do |value, column_number|
        cols[column_number] = [] unless cols[column_number]
        cols[column_number][row_number] = value
      end
    end
    @columns = cols
  end

  def saddle_point?(row_number, column_number)
    greatest_in_row?(@rows[row_number], column_number) && smallest_in_column?(columns[column_number], row_number)
  end

  def greatest_in_row?(row, column_number)
    greatest = true
    value = row[column_number]
    row.each_with_index do |other_value, col_num|
      greatest &&= (value >= other_value) unless col_num == column_number
    end
    greatest
  end

  def smallest_in_column?(column, row_number)
    smallest = true
    value = column[row_number]
    column.each_with_index do |other_value, row_num|
      smallest &&= (value <= other_value) unless row_number == row_num
    end
    smallest
  end
end
