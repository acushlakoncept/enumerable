require_relative '../lib/enumerable.rb'

describe "#my_each" do
  let(:test_arr) {[3,5,6]}
  let(:test_range) {(1..5)}
  
  context "Where an Array and block is given" do
    let(:my_test){[]}
    let(:orig_test){[]}
    it "should loop through the array" do
      test_arr.my_each{|x| my_test<<x}
      test_arr.each{|x| orig_test<<x}
      expect(my_test).to eq(orig_test)
    end
  end

  # context "Where a range and block is given" do
  #   it "should loop through the array" do
  #     expect(test_range.my_each{|x| x }).to eq((1..5))
  #   end
  # end
end

# let(:arr) { [4, 5, 8, 2, 1, 9, 3, 7, 6] }
# describe '#my_each' do
#   let(:new_arr_each) { [] }
#   it 'iterate through array elements' do
#     my_array = []
#     original_array = []
#     arr.my_each { |n| my_array << n * 2 }
#     arr.each { |n| original_array << n * 2 }
#     expect(my_array).to eql(original_array)
#   end
# end