require 'rubygems'
require 'rspec'
require 'pry-debugger'
require_relative '../war.rb'


describe Card do

  before do
    @c = Card.new("J", 11, "hearts")
    @d = Deck.new
  end
  it "should initialize a card with rank" do
      expect(@c.rank).to eq("J")

  end

  it "should initialize a card wtih a value" do
      expect(@c.value).to eq(11)

  end

  it "should initialize a card with a suit" do
    expect(@c.suit).to eq("hearts")
  end

  it "should initialize a deck with an empty array" do
    expect(@d.deck).to eq([])
  end

  it "should add a card to the bottom of the deck" do
    @d.add_card(@c)
    expect(@d.deck).to eq([@c])
  end

  xit "should shuffle the cards around" do
    @d.create_52_card_deck
    first = @d.deck[0]
    @d.shuffle
    @d.first
    expect(@d.deck[0]).to_not eq(first)
  end
end

