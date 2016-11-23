require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef") }
  let(:pastry) { Dessert.new("pastry", 3, chef) }

  describe "#initialize" do
    it "sets a type" do
      expect(pastry.type).to eql("pastry")
    end

    it "sets a quantity" do
    expect(pastry.quantity).to be(3)
  end

    it "starts ingredients as an empty array" do
    expect(pastry.ingredients).to eql([])
  end

    it "raises an argument error when given a non-integer quantity" do
    expect { Dessert.new("pastry", "three", "chef") }.to raise_error(ArgumentError)
  end
end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
    pastry.add_ingredient("sugar")
    expect(pastry.ingredients).to include("sugar")
  end
end


  describe "#mix!" do
    it "shuffles the ingredient array" do
    ingredients = ["flour", "egg", "sugar", "butter"]

     ingredients.each do |ingredient|
       pastry.add_ingredient(ingredient)
     end
     pastry.mix!
     expect(pastry.ingredients.sort).to eq(ingredients.sort)
  end
end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
    expect(pastry.eat(1)).to eq(2)
  end

    it "raises an error if the amount is greater than the quantity" do
    expect{pastry.eat(4)}.to raise_error("not enough left!")
  end
end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
    allow(chef).to receive(:titleize)
    pastry.serve
  end
end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
    expect(chef).to receive(:bake).with(pastry)
    pastry.make_more
    end
  end
end
