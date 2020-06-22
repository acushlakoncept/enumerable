module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    arr = self.class == Array ? self : to_a
    counter = 0
    while counter < arr.length
      yield arr[counter]
      counter += 1
    end
    arr
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    arr = self.class == Array ? self : to_a
    counter = 0
    while counter < arr.length
      yield(arr[counter], counter)
      counter += 1
    end
    arr
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    new_arr = []
    my_each { |item| new_arr << item if yield(item) }
    new_arr
  end

  def my_all?(arg = nil)
    if !block_given? && arg.nil?
      my_each { |n| return false if n.nil? || n == false }
      return true
    end

    if !block_given? && !arg.nil?
      if arg.is_a? Class
        my_each { |n| return false if n.class != arg }
        return true
      end

      if arg.class == Regexp
        my_each { |n| return false unless arg.match(n) }
        return true
      end

      my_each { |n| return false if n != arg }
      return true
    end

    my_each do |item|
      return false if yield(item) == false
    end
    true
  end

  def my_any?(arg = nil)
    if !block_given? && arg.nil?
      my_each { |n| return true if n.nil? || n == true }
      return false
    end

    if !block_given? && !arg.nil?
      if arg.is_a? Class
        my_each { |n| return true if n.class == arg }
        return false
      end

      if arg.class == Regexp
        my_each { |n| return true if arg.match(n) }
        return false
      end

      my_each { |n| return true if n == arg }
      return false
    end

    my_each { |item| return true if yield(item) }
    false
  end

  def my_none?(arg = nil)
    if !block_given? && arg.nil?
      my_each { |n| return true if n }
      return false
    end

    if !block_given? && !arg.nil?

      if arg.is_a? Class
        my_each { |n| return false if n.class == arg }
        return true
      end

      if arg.class == Regexp
        my_each { |n| return false if arg.match(n) }
        return true
      end

      my_each { |n| return false if n == arg }
      return true
    end

    my_any? { |item| return false if yield(item) }
    true
  end

  def my_count(num = nil)
    arr = self.class == Array ? self : to_a
    return arr.length unless block_given? || num

    return arr.my_select { |item| item == num }.length if num

    arr.my_select { |item| yield(item) }.length
  end

  def my_map(proc = nil)
    return to_enum unless block_given? || proc

    new_arr = []
    if proc
      my_each { |item| new_arr << proc.call(item) }
    else
      my_each { |item| new_arr << yield(item) }
    end
    new_arr
  end

  def my_inject(num = nil, sym = nil)
    return to_enum(:my_inject) unless block_given? || num

    accumulator = num

    my_each do |item|
      accumulator = accumulator.nil? ? item : yield(accumulator, item)
    end
    return accumulator
  end

end

def multiply_els(arr)
  arr.my_inject(1) { |result, element| result * element }
end

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

# puts 'my_inject Array'
# [5, 5, 7, 8].my_inject(1) { |x, y| x * y }

# puts 'multiply_els'
# multiply_els([2, 4, 5])

# p [2, 2, 3].my_all?(Integer)
# p [2, 2, 3].my_all?(2)
# p [2, 2, 2].my_all?(2)
# # p ["hello", "hi", "hey"].my_all?(/m/)

# p ['dog', 'door'].my_all?(/d/) #should return true
# p ['dog', 'door', 'ant'].my_all?(/d/) #should return false

# # p [1, 2, 3, nil].my_all?
# # p [2, 4, 6, 7, 8, 4].my_all? { |n| n > 2 }

# p [1, 2, 'a'].my_any?(Integer) # should return true
# p %w[a b a].my_any?(Integer) # should return false
# p %w[dog door ant].my_any?(/d/) # should return true
# p %w[hey book ant].my_any?(/d/) # should return false
# p [2, 2, 3].my_any?(2) # should return true
# p [1, 3, 3].my_any?(2) # should return false

# p [1, 2, 3].my_none? # should return true
# p [nil, nil, false].my_none? # should return false
# p %w[a b a].my_none?(Integer) # should return true
# p [1, 2, 'a'].my_none?(Integer) # should return false
# p %w[rot not ant].my_none?(/d/) # should return true
# p %w[door dog ant].my_none?(/d/) # should return false
# p [1, 3, 3].my_none?(2) # should return true
# p [1, 2, 3].my_none?(2) # should return false

# p [3, 6, 10, 13].my_inject(:+)
puts 'my_inject Range'
p (5..10).my_inject { |sum, n| sum + n } 
puts 'my_inject Array'
p [3, 6, 10].my_inject(1) {|sum, number| sum + number}

# p [1, 2, 3, 4].my_inject(10) { |accum, elem| accum + elem } # => 20
# p [1, 2, 3, 4].my_inject { |accum, elem| accum + elem } # => 10
# p [5, 1, 2].my_inject('+') # => 8
# p (5..10).my_inject(2, :*) # should return 302400
# p (5..10).my_inject(4) { |prod, n| prod * n } # should return 604800