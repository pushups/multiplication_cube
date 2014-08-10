require 'json'

class Integer
  def to_base(base=10)
    return [0] if zero?
    raise ArgumentError, 'base must be greater than zero' unless base > 0
    num = abs
    return [1] * num if base == 1
    [].tap do |digits|
      while num > 0
        digits.unshift num % base
        num /= base
      end
    end
  end
end

class Integer
  old_to_s = instance_method(:to_s)
  define_method :to_s do |base=10, mapping=nil, sep=''|
    return old_to_s.bind(self).(base) unless mapping || base > 36
    mapping ||= '0123456789abcdefghijklmnopqrstuvwxyz'
    return to_base(base).map {|digit| mapping[digit].to_s }.join(sep)
  end
end

BASES = (2..16).to_a
VALUES = (1..16).to_a

cube = []

base_ten_table = []

VALUES.each do |row_value|
	row = []
	VALUES.each do |column_value|
		row << row_value * column_value
	end
	base_ten_table << row
end

def print_as_grid(table)
	table.each do |row|
		puts " %3s " * row.size % row
	end
end

def convert_table(table, base)
	table.map do |row|
		row.map do |value|
			value.to_s base
		end
	end
end

BASES.each do |base|
	cube << convert_table(base_ten_table, base)
end

File.open('cube.json', 'w') do |f|
	f.write(cube.to_json)
end




# BASES.each do |base|
# 	VALUES.each do |a|

# 	end
# end
