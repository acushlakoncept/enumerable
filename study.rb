module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    size = self.size
    while i < size
      is_a?(Range) ? yield(min + i) : yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    my_each do |elem|
      yield(elem, i)
      i += 1
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    select = []
    my_each { |elem| select << elem if yield(elem) }
    select
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def my_all?(arg = nil, &prc)
    return true if !block_given? && arg.nil? && include?(nil) == false && include?(false) == false
    return false unless block_given? || !arg.nil?

    if block_given?
      my_each { |elem| return false if prc.call(elem) == false }
    elsif arg.class == Regexp
      my_each { |elem| return false if arg.match(elem).nil? }
    elsif arg.class <= Numeric || arg.class <= String
      my_each { |elem| return false if elem != arg }
    else
      my_each { |elem| return false if (elem.is_a? arg) == false }
    end
    true
  end

  def my_any?(arg = nil, &prc)
    return true if !block_given? && arg.nil? && my_each { |elem| return true if elem == true } && empty? == false
    return false unless block_given? || !arg.nil?

    if block_given?
      my_each { |elem| return true if prc.call(elem) }
    elsif arg.class == Regexp
      my_each { |elem| return true unless arg.match(elem).nil? }
    elsif arg.class <= Numeric || arg.class <= String
      my_each { |elem| return true if elem == arg }
    else
      my_each { |elem| return true if elem.class <= arg }
    end
    false
  end

  def my_none?(arg = nil, &prc)
    !my_any?(arg, &prc)
  end

  def my_count(arg = nil, &prc)
    count = 0
    my_each do |elem|
      if block_given?
        count += 1 if prc.call(elem)
      elsif !arg.nil?
        count += 1 if elem == arg
      else
        count = length
      end
    end
    count
  end

  def my_map(prc = nil)
    return enum_for(:map) unless block_given?

    mapped = []
    my_each { |elem| mapped << prc.call(elem) } if block_given? && prc
    my_each { |elem| mapped << yield(elem) } if prc.nil?
    mapped
  end

  def my_inject(memo = nil, sym = nil, &prc)
    memo = memo.to_sym if memo.is_a?(String) && !sym && !prc

    if memo.is_a?(Symbol) && !sym
      prc = memo.to_proc
      memo = nil
    end

    sym = sym.to_sym if sym.is_a?(String)
    prc = sym.to_proc if sym.is_a?(Symbol)

    my_each { |elem| memo = memo.nil? ? elem : prc.yield(memo, elem) }
    memo
  end
  end
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

def multiply_els(array)
  array.my_inject { |mult, elem| mult * elem }
end

# puts multiply_els([2, 4, 5]) # => 40
# puts

# # 1. my_each
# puts 'my_each'
# puts '-------'
# puts [1, 2, 3].my_each { |elem| print "#{elem + 1} " } # => 2 3 4
# puts

# # 2. my_each_with_index
# puts 'my_each_with_index'
# puts '------------------'
# print [1, 2, 3].my_each_with_index { |elem, idx| puts "#{elem} : #{idx}" } # => 1 : 0, 2 : 1, 3 : 2
# puts

# # 3. my_select
# puts 'my_select'
# puts '---------'
# p [1, 2, 3, 8].my_select(&:even?) # => [2, 8]
# p [0, 2018, 1994, -7].my_select { |n| n > 0 } # => [2018, 1994]
# p [6, 11, 13].my_select(&:odd?) # => [11, 13]
# puts

# # 4. my_all? (example test cases)
# puts 'my_all?'
# puts '-------'
# p [3, 5, 7, 11].my_all?(&:odd?) # => true
# p [-8, -9, -6].my_all? { |n| n < 0 } # => true
# p [3, 5, 8, 11].my_all?(&:odd?) # => false
# p [-8, -9, -6, 0].my_all? { |n| n < 0 } # => false
# # test cases required by tse reviewer
# p [1, 2, 3, 4, 5].my_all? # => true
# p [1, 2, 3].my_all?(Integer) # => true
# p %w[dog door rod blade].my_all?(/d/) # => true
# p [1, 1, 1].my_all?(1) # => true
# puts

# # 5. my_any? (example test cases)
# puts 'my_any?'
# puts '-------'
# p [7, 10, 3, 5].my_any?(&:even?) # => true
# p [7, 10, 4, 5].my_any?(&:even?) # => true
# p %w[q r s i].my_any? { |char| 'aeiou'.include?(char) } # => true
# p [7, 11, 3, 5].my_any?(&:even?) # => false
# p %w[q r s t].my_any? { |char| 'aeiou'.include?(char) } # => false
# # test cases required by tse reviewer
# p [1, nil, false].my_any?(1) # => true
# p [1, nil, false].my_any?(Integer) # => true
# p %w[dog door rod blade].my_any?(/z/) # => false
# p [1, 2, 3].my_any?(1) # => true
# puts

# # 6. my_none? (example test cases)
# puts 'my_none?'
# puts '--------'
# p [3, 5, 7, 11].my_none?(&:even?) # => true
# p %w[sushi pizza burrito].my_none? { |word| word[0] == 'a' } # => true
# p [3, 5, 4, 7, 11].my_none?(&:even?) # => false
# p %w[asparagus sushi pizza apple burrito].my_none? { |word| word[0] == 'a' } # => false
# # test cases required by tse reviewer
# p [nil, false, nil, false].my_none? # => true
# p [1, 2, 3].my_none? # => false
# p [1, 2, 3].my_none?(String) # => true
# p [1, 2, 3, 4, 5].my_none?(2) # => false
# p [1, 2, 3].my_none?(4) # => true
# puts

# # 7. my_count (example test cases)
# puts 'my_count'
# puts '--------'
# p [1, 4, 3, 8].my_count(&:even?) # => 2
# p %w[DANIEL JIA KRITI dave].my_count { |s| s == s.upcase } # => 3
# p %w[daniel jia kriti dave].my_count { |s| s == s.upcase } # => 0
# # test cases required by tse reviewer
# p [1, 2, 3].my_count # => 3
# p [1, 1, 1, 2, 3].my_count(1) # => 3
# puts

# # 8. my_map
# puts 'my_map'
# puts '------'
# p [1, 2, 3].my_map { |n| 2 * n } # => [2,4,6]
# p %w[Hey Jude].my_map { |word| word + '?' } # => ["Hey?", "Jude?"]
# p [false, true].my_map(&:!) # => [true, false]
# my_proc = proc { |num| num > 10 }
# p [18, 22, 5, 6].my_map(my_proc) { |num| num < 10 } # => true true false false
# puts

# 9. my_inject
# puts 'my_inject'
# puts '---------'
# p [1, 2, 3, 4].my_inject(10) { |accum, elem| accum + elem } # => 20
# p [1, 2, 3, 4].my_inject { |accum, elem| accum + elem } # => 10
# p [5, 1, 2].my_inject('+') # => 8
# p (5..10).my_inject(2, :*) # should return 302400
# p (5..10).my_inject(4) { |prod, n| prod * n } # should return 604800

# puts 'my_inject Range'
# p ((5..10).my_inject { |x, y| x + y })
# puts 'my_inject Array'
# p [5, 5, 7, 8].my_inject { |x, y| x * y }

p [5, 5, 7, 8].my_inject(:*)
