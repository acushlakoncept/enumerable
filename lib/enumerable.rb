# rubocop: disable Metrics/ModuleLength
# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

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

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    arr = self if self.class == Array
    arr = to_a if self.class == Range
    arr = flatten if self.class == Hash
    
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
    if block_given?
      my_each { |item| return false if yield(item) == false }
      return true
    elsif arg.nil?
      my_each { |n| return false if n.nil? || n == false }
    elsif !arg.nil? && (arg.is_a? Class)
      my_each { |n| return false if n.class != arg }
    elsif !arg.nil? && arg.class == Regexp
      my_each { |n| return false unless arg.match(n) }
    else
      my_each { |n| return false if n != arg }
    end
    true
  end

  def my_any?(arg = nil)
    if block_given?
      my_each { |item| return true if yield(item) }
      false
    elsif arg.nil?
      my_each { |n| return true if n.nil? || n == true }
    elsif !arg.nil? && (arg.is_a? Class)
      my_each { |n| return true if n.class == arg }
    elsif !arg.nil? && arg.class == Regexp
      my_each { |n| return true if arg.match(n) }
    else
      my_each { |n| return true if n == arg }
    end
    false
  end

  def my_none?(arg = nil)
    if !block_given? && arg.nil?
      my_each { |n| return true if n }
      return false
    end

    if !block_given? && !arg.nil?

      if arg.is_a?(Class)
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
    if block_given?
      accumulator = num
      my_each do |item|
        accumulator = accumulator.nil? ? item : yield(accumulator, item)
      end
      accumulator
    elsif !num.nil? && (num.is_a?(Symbol) || num.is_a?(String))
      accumulator = nil
      my_each do |item|
        accumulator = accumulator.nil? ? item : accumulator.send(num, item)
      end
      accumulator
    elsif !sym.nil? && (sym.is_a?(Symbol) || sym.is_a?(String))
      accumulator = num
      my_each do |item|
        accumulator = accumulator.nil? ? item : accumulator.send(sym, item)
      end
      accumulator
    end
  end
end
# rubocop: enable Metrics/ModuleLength
# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

def multiply_els(arr)
  arr.my_inject { |result, element| result * element }
end