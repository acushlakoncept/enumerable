require_relative '../lib/enumerable.rb'

describe '#my_each' do
  let(:test_arr) { [3, 5, 6] }
  let(:test_range) { (1..5) }

  context 'Where an array and block is given' do
    let(:my_test) { [] }
    let(:orig_test) { [] }
    it 'should loop through the array' do
      test_arr.my_each { |x| my_test << x }
      test_arr.each { |x| orig_test << x }
      expect(my_test).to eq(orig_test)
    end
  end

  context 'Where a range and block is given' do
    let(:my_test) { [] }
    let(:orig_test) { [] }
    it 'should loop through the array' do
      test_range.my_each { |x| my_test << x }
      test_range.each { |x| orig_test << x }
      expect(my_test).to eq(orig_test)
    end
  end
end

describe '#my_each_with_index' do
  let(:test_arr) { %w[my each with index] }
  let(:test_res) { [] }
  it 'should return the index of the elements' do
    test_arr.my_each_with_index { |_val, index| test_res << index }
    expect(test_res).to eq([0, 1, 2, 3])
  end
end

describe '#my_select' do
  let(:test_arr) { [2, 5, 6, 7, 2, 3, 1, 2] }
  it 'returns a new array base on selected condition' do
    expect(test_arr.my_select { |x| x == 2 }).to eq([2, 2, 2])
  end
end

describe '#my_all?' do
  let(:test1) { [2, 5, 6, 7, 2, 3, 1, 2] }
  let(:test2) { [nil, 1, 2, 3] }
  let(:test3) { [1, 2, 'a'] }
  let(:test4) { %w[dog door] }
  let(:test5) { %w[dog door ant] }

  context 'where value is given as argument' do
    it 'returns true or false base on arg given' do
      expect(test1.my_all?(2)).to be(false)
    end
  end

  context 'where Class is given as argument' do
    it 'returns true or false base on arg given' do
      expect(test1.my_all?(Integer)).to be(true)
      expect(test3.my_all?(Integer)).to be(false)
    end
  end

  context 'where Regex is given as argument' do
    it 'returns true or false base on arg given' do
      expect(test4.my_all?(/d/)).to be(true)
      expect(test5.my_all?(/d/)).to be(false)
    end
  end

  context 'where no block is given' do
    it 'returns true or false base on condition given' do
      expect(test1.my_all?).to be(true)
      expect(test2.my_all?).to be(false)
    end
  end

  context 'where block is given' do
    it 'returns true or false base on condition given' do
      expect(test1.my_all? { |x| x >= 1 }).to be(true)
    end
  end
end

describe '#my_any' do
  let(:test1) { [2, 5, 6, 7, 2, 3, 1, 2] }
  let(:test2) { [nil, 1, 2, 3] }
  let(:test3) { [nil, false, nil] }
  let(:test4) { %w[brad hood ladder] }
  let(:test5) { %w[dog door ant] }

  context 'where a value is given as an argument' do
    it 'returns true or false base on arg given' do
      expect(test1.my_any?(9)).to be(false)
    end
  end

  context 'where block is given' do
    it 'returns true or false base on condition given' do
      expect(test1.my_any? { |x| x >= 5 }).to be(true)
    end
  end

  context 'where a class is given as argument' do
    it 'should return true or false based on given arg' do
      expect(test1.my_any?(Integer)).to be(true)
      expect(test6.my_any?(Integer)).to be(false)
    end
  end

  context 'where Regex is given as argument' do
    it 'returns true or false base on arg given' do
      expect(test4.my_any?(/d/)).to be(true)
      expect(test5.my_any?(/^d/)).to be(true)
    end
  end

  context 'where no block is given' do
    it 'returns true or false base on condition given' do
      expect(test2.my_any?).to be(true)
      expect(test3.my_any?).to be(false)
    end
  end
  
end

describe '#my_none' do
  # let(:test_arr) { [2, 5, 6, 7, 2, 3, 1, 2] }
  # let(:test_arr) { (1..10) }
  let(:test_arr) { (1..10) }

  context 'where an argument is given' do
    it 'returns true or false base on arg given' do
      expect(test_arr.my_none?(9)).to be(false)
    end
  end

  context 'where block is given' do
    it 'returns true or false base on condition given' do
      expect(test_arr.my_none? { |x| x > 10 }).to be(true)
    end
  end
end

# --------------------------------------------------------
# [1, 2, "a"].my_any?(Integer) should return true
# ["a",  "b",  "a"].my_any?(Integer) should return false
# ['dog', 'door', 'ant'].my_any?(/d/) should return true
# ['hey', 'book', 'ant'].my_any?(/d/) should return false
# [2, 2, 3].my_any?(2) should return true
# [1, 3, 3].my_any?(2) should return false
