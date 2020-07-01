module Enumerable
  def my_each
    return to_enum unless block_given?

    arr = self if self.class == Array
    arr = to_a if self.class == Range
    arr = flatten if self.class == Hash

    counter = 0
    while counter < arr.length
      yield(arr[counter])
      counter += 1
    end

    arr
  end
end

p (0..5).my_each { |x| puts x }
p [3, 4, 5, 6].my_each { |x| puts x }
hs = { 'hello' => 'hi', 'hey' => 'yo' }
p hs.my_each { |x| puts x }
