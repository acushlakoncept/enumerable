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

[4, 5, 6].my_none? { |n| n > 5 }
