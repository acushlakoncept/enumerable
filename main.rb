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


p [2, 5, 6, 7].my_select { |n| n > 5 }