require_relative '../lib/enumerable.rb'

describe "#my_each" do
  let(:test_arr) {[3,5,6]}
  let(:test_range) {(1..5)}
  
  context "Where an array and block is given" do
    let(:my_test){[]}
    let(:orig_test){[]}
    it "should loop through the array" do
      test_arr.my_each{|x| my_test<<x}
      test_arr.each{|x| orig_test<<x}
      expect(my_test).to eq(orig_test)
    end
  end

  context "Where a range and block is given" do
    let(:my_test){[]}
    let(:orig_test){[]}
    it "should loop through the array" do
      test_range.my_each{|x| my_test<<x}
      test_range.each{|x| orig_test<<x}
      expect(my_test).to eq(orig_test)
    end
  end

end

describe "#my_each_with_index" do
  let(:test_arr){%w(my each with index)}
  let(:test_res){[]}
  it 'should return the index of the elements' do
    test_arr.my_each_with_index{ |val, index| test_res << index }
    expect(test_res).to eq([0, 1, 2, 3])
  end
end

describe "#my_select" do
  let(:test_arr){[2,5,6,7,2,3,1,2]}
  it 'returns a new array base on selected condition' do
    expect(test_arr.my_select{ |x| x == 2}).to eq([2,2,2])
  end
end
