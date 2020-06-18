module Enumerable
  def my_each
    return to_enum unless block_given?

    arr = self.class == Array ? self : to_a
    counter = 0
    while counter < arr.length
      yield arr[counter]
      counter += 1
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    arr = self.class == Array ? self : to_a
    counter = 0
    while counter < arr.length
      yield(arr[counter], counter)
      counter += 1
    end
  end

  def my_select
    return to_enum unless block_given?

    new_arr = []
    my_each { |item| new_arr << item if yield(item) }
    new_arr
  end

  def my_all?
    return to_enum unless block_given?

    my_each do |item|
      return false if yield(item) == false
    end
    true
  end

  def my_any?
    return to_enum unless block_given?

    my_each { |item| return true if yield(item) }
    false
  end

  def my_none?
    return to_enum unless block_given?

    my_any? { |item| return false if yield(item) }
    true
  end

  def my_count(num = nil)
    arr = self.class == Array ? self : to_a
    return arr.length unless block_given? || num

    count = 0
    if num
      my_each { |item| count += 1 if item == num }
    else
      my_each { |item| count += 1 if yield(item) }
    end

    count
  end

  def my_map
    return to_enum unless block_given?

    new_arr = []
    my_each { |item| new_arr << yield(item) }
    new_arr
  end

  def my_inject(num = 0)
    return to_enum unless block_given? || num

    accumulator = 0

    if num
      accumulator = num
      my_each do |item|
        accumulator = yield(accumulator, item)
      end
    else
      my_each do |item|
        accumulator = yield(accumulator, item)
      end
    end
  

    accumulator
  end


  def multiply_els(arr)
    arr.my_inject { |result, element| result * element }
  end
end


# [2, 5, 6, 7].my_each do |n|
#   puts n
# end

# (1..5).my_each do |n|
#   puts n
# end

# [2, 5, 6, 7].my_each_with_index do |n, i|
#   puts i.to_s + ': ' + n.to_s
# end

# (1..5).my_each_with_index do |n, i|
#   puts i.to_s + ': ' + n.to_s
# end

# result = [2, 5, 6, 7].my_select do |n|
#   n > 5
# end

# result = [2, 4, 6, 7, 8, 4].my_all? do |n|
#   n < 6
# end

# p [4,5,6].my_any?{ |n| n<3 }

# [4, 5, 6].my_none? { |n| n > 5 }

# p [2,3,56, 6, 3,2,9,1,2,3,3,5].my_count(2)
# p (0..5).my_count(2)

# p (0..5).my_map { |i| i * i }
# p [2, 5, 7, 4, 2].my_map { |i| i + 8 }

# p (5..10).my_inject(1) { |result, element| result + element }
# p [5,5,7,8].my_inject(1) { |result, element| result * element }
puts multiply_els([2, 4, 5])
