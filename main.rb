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

  #   When no block or argument is given to my_any? it should return true if there is at least one element in the given enumerable that is a truthy, otherwise, it should return false.
  # example [1, 2, false].my_any? should return true and [nil, false nil].my_any? should return false.

  # my_any? should be able to receive an optional argument. If the argument is a class, then it should return true if there is at least one member of the given enumerable that is a member of that class, otherwise it should return false. If the argument is a regex, then it should return true if there is at least one member of the enumerable that matches the regex, otherwise it should return false. If the argument is any other pattern besides a class or regex, a similar logic holds.
  # Example

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

  def my_none?
    return to_enum(:my_none?) unless block_given?

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

  def my_inject(num = 0)
    return to_enum(:my_inject) unless block_given? || num

    if num
      accumulator = num
      my_each do |item|
        accumulator = yield(accumulator, item)
      end
      return accumulator
    end

    sum = 0
    my_each do |item|
      sum = yield(sum, item)
    end
    sum
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

p [1, 2, 'a'].my_any?(Integer) # should return true
p %w[a b a].my_any?(Integer) # should return false
p %w[dog door ant].my_any?(/d/) # should return true
p %w[hey book ant].my_any?(/d/) # should return false
p [2, 2, 3].my_any?(2) # should return true
p [1, 3, 3].my_any?(2) # should return false
