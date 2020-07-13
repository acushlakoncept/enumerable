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
  let(:test1) { [2, 5, 6, 7, 2, 3, 1, 2] }
  let(:test2) { [nil, 1, 2, 3] }
  let(:test3) { [nil, false, nil] }

  context 'where an argument is given' do
    it 'returns true or false base on arg given' do
      expect(test1.my_none?(9)).to be(true)
    end
  end

  context 'where block is given' do
    it 'returns true or false base on condition given' do
      expect(test1.my_none? { |x| x <= 10 }).to be(false)
    end
  end

  context 'where no block is given' do
    it 'returns true or false based on condition given' do
      expect(test3.my_none?).to be(true)
      expect(test1.my_none?).to be(false)
    end
  end
end

describe '#my_count' do
  let(:test1) { [2, 5, 6, 7, 2, 3, 1, 2] }

  context 'where arguments are given' do
    it 'should return the number of arguments' do
      expect(test1.my_count(2)).to eq(3)
    end
  end

  context 'where block is given' do
    it 'return the number of elements that matches the block condition' do
      expect(test1.my_count { |x| x > 3 }).to eq(3)
    end
  end
end

describe '#my_map' do
  let(:test_arr) { [3, 5, 6] }

  context 'Where an array and block is given' do
    let(:my_test) { [] }
    it 'returns a new array containing of the values returned by the block' do
      test_arr.my_map { |x| my_test << x * 2 }
      expect(my_test).to eq([6, 10, 12])
    end
  end

  context 'when the argument is passed a proc' do
    it 'should call the proc' do
      new_proc = proc { |x| x * 2 }
      expect(test_arr.my_map(&new_proc)).to eq([6, 10, 12])
    end
  end
end

describe '#my_inject' do
  let(:test_arr) { [3, 5, 6] }

  context 'Where an array is given' do
    it 'returns a new array containing the values returned by the block' do
      my_test = test_arr.my_inject { |x, y| x * y }
      expect(my_test).to eq(90)
    end
  end

  context 'when a symbol is given as an argument' do
    it 'returns the operation of the given symbol' do
      expect(test_arr.my_inject(:+)).to eq(14)
    end
  end

  context 'when a string is given as an argument' do
    it 'returns the operation of the given string' do
      expect(test_arr.my_inject('+')).to eq(14)
    end
  end

  context 'when both initial value and symbol are given as an argument' do
    it 'returns the operation of the given symbol plus value' do
      expect(test_arr.my_inject(2, :+)).to eq(16)
    end
  end
end

describe '#multiply_els' do
  let(:my_test) { [2, 2, 3, 2] }
  it 'should return the multiple of numbers in an array' do
    expect(multiply_els(my_test)).to eq(24)
  end
end

# --------------------------------------------------------
