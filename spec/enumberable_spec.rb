require_relative '../lib/enumerable.rb'

describe "#my_each" do
  let(:test_arr) {[3,5,6]}
  let(:test_range) {(1..5)}
  context "Where an Array and block is given" do
    it "should loop through the array" do
      expect(test_arr.my_each{|x| x }).to eq([3,5,6])
    end
  end
  context "Where a range and block is given" do
    it "should loop through the array" do
      expect(test_range.my_each{|x| x }).to eq((1..5))
    end
  end
end