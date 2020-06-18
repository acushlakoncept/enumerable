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
    return to_enum unless block_given? || num

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

puts 'my_each Array'
[2, 5, 6, 7].my_each do |n|
  puts n
end

puts 'my_each Range'
(1..5).my_each do |n|
  puts n
end

puts 'my_each_with_index Array'
[2, 5, 6, 7].my_each_with_index do |n, i|
  puts i.to_s + ': ' + n.to_s
end

puts 'my_each_with_index Range'
(1..5).my_each_with_index do |n, i|
  puts i.to_s + ': ' + n.to_s
end

puts 'my_select'
result = [2, 5, 6, 7].my_select do |n|
  n > 5
end


puts 'my_all'
result = [2, 4, 6, 7, 8, 4].my_all? do |n|
  n < 9
end


puts 'my_any'
([4, 5, 6].my_any? { |n| n < 3 })

puts 'my_none'
([4, 5, 6].my_none? { |n| n > 5 })

puts 'my_count Array'
<<<<<<< HEAD
[2, 3, 56, 6, 3, 2, 9, 1, 2, 3, 3, 5].my_count(3)
=======
p [2, 3, 56, 6, 3, 2, 9, 1, 2, 3, 3, 5].my_count(3)
>>>>>>> 9ac0c0278e8dab7bc342ad6ee6fd0931b63c00e4

puts 'my_count Range'
(0..5).my_count(2)

puts 'my_map Range'
<<<<<<< HEAD
((0..5).my_map { |i| i * i })
=======
p((0..5).my_map { |i| i * i })
>>>>>>> 9ac0c0278e8dab7bc342ad6ee6fd0931b63c00e4

puts 'my_map Array'
([2, 5, 7, 4, 2].my_map { |i| i + 8 })

puts 'my_map proc'
my_proc = proc { |i| i * i }
[2, 5, 7, 4, 2].my_map(&my_proc)

puts 'my_inject Range'
<<<<<<< HEAD
((5..10).my_inject { |x, y| x + y })
=======
puts((5..10).my_inject { |x, y| x + y })
>>>>>>> 9ac0c0278e8dab7bc342ad6ee6fd0931b63c00e4

puts 'my_inject Array'
[5, 5, 7, 8].my_inject(1) { |x, y| x * y }

puts 'multiply_els'
multiply_els([2, 4, 5])
