require_relative './lib/enumerable.rb'

# puts 'my_each Array'
# [2, 5, 6, 7].my_each do |n|
#   puts n
# end

# puts 'my_each Range'
# (1..5).my_each do |n|
#   puts n
# end

# puts 'my_each_with_index Array'
# [2, 5, 6, 7].my_each_with_index do |n, i|
#   puts i.to_s + ': ' + n.to_s
# end

# puts 'my_each_with_index Range'
# (1..5).my_each_with_index do |n, i|
#   puts i.to_s + ': ' + n.to_s
# end

# puts 'my_select'
# [2, 5, 6, 7].my_select do |n|
#   n > 5
# end

# puts 'my_all'
# [2, 4, 6, 7, 8, 4].my_all? do |n|
#   n < 9
# end

# puts 'my_any'
# ([4, 5, 6].my_any? { |n| n < 3 })

# puts 'my_none'
# ([4, 5, 6].my_none? { |n| n > 5 })

# puts 'my_count Array'
# [2, 3, 56, 6, 3, 2, 9, 1, 2, 3, 3, 5].my_count(3)

# puts 'my_count Range'
# (0..5).my_count(2)

# puts 'my_map Range'
# ((0..5).my_map { |i| i * i })

# puts 'my_map Array'
# ([2, 5, 7, 4, 2].my_map { |i| i + 8 })

# puts 'my_map proc'
# my_proc = proc { |i| i * i }
# [2, 5, 7, 4, 2].my_map(&my_proc)

# puts 'my_inject Range'
# ((5..10).my_inject { |x, y| x + y })

puts 'my_inject Array'
puts [2, 2, 3, 2].my_inject { |x, y| x * y }

puts 'multiply_els'
puts multiply_els([2, 4, 5])

# h = { 'player1' => 'Uduak', 'player2' => 'Elijah' }
# h.my_each { |x| pp x }
# h.each { |x| pp x }

# puts [nil, false, nil].my_none?
