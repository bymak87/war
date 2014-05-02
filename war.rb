# This class is complete. You do not need to alter this
class Card
  # Rank is the rank of the card, 2-10, J, Q, K, A
  # Value is the numeric value of the card, so J = 11, A = 14
  # Suit is the suit of the card, Spades, Diamonds, Clubs or Hearts
  attr_reader :rank, :value, :suit
  def initialize(rank, value, suit)
    @rank = rank
    @value = value
    @suit = suit
  end
end

# TODO: You will need to complete the methods in this class
class Deck
  attr_accessor :deck
  def initialize
    @deck = [] # Determine the best way to hold the cards

  end


  # Given a card, insert it on the bottom your deck
  def add_card(card) #O(1)
    @deck << card

  end

  # Mix around the order of the cards in your deck
  def shuffle # You can't use .shuffle!
    @deck.sort!{rand}

  end

  # Remove the top card from your deck and return it
  def deal_card
  @deck.shift


  end

  # Reset this deck with 52 cards
  def create_52_card_deck
    value = (2..14).to_a
    ["Spades", "Hearts", "Diamonds", "Clubs"].each do |suit|
     ((2..10).to_a + ["J", "Q", "K", "A"]).each_with_index do |rank, index|
      @deck << Card.new(rank, value[index], suit)
    end
  end

  end
end

# You may or may not need to alter this class
class Player
  attr_reader :name, :hand
  def initialize(name)
    @name = name
    @hand = Deck.new
  end
end


class War
  def initialize(player1, player2)
    @game_deck = Deck.new
    @player1 = Player.new(player1)
    @player2 = Player.new(player2)
    # You will need to shuffle and pass out the cards to each player
    @game_deck.create_52_card_deck
    @game_deck.shuffle

    26.times do |x|
      @player1.hand.add_card(@game_deck.deal_card)
    end

    26.times do |x|
      @player2.hand.add_card(@game_deck.deal_card)
    end

  end

  # You will need to play the entire game in this method using the WarAPI
  def play_game
    turns = 0
    while @player1.hand.deck.length < 52 && @player2.hand.deck.length < 52
     res = WarAPI.play_turn(@player1, @player1.hand.deal_card, @player2, @player2.hand.deal_card)
      res[@player1].each do |card|
        @player1.hand.add_card(card)
      end
      res[@player2].each do |card|
          @player2.hand.add_card(card)
        end
        turns +=1
        res

    end
    if @player1.hand.deck.length == 52
      puts "#{@player1.name} wins!"
    elsif @player2.hand.deck.length == 52
      puts "#{@player2.name} wins!"
    end
    puts "It took #{turns} turns."
  end
end

class WarAPI
  # This method will take a card from each player and
  # return a hash with the cards that each player should receive
  def self.play_turn(player1, card1, player2, card2)
    if card1.value > card2.value
      {player1 => [card1, card2], player2 => []}
    elsif card2.value > card1.value || rand(100).even?
      {player1 => [], player2 => [card2, card1]}
    else
      {player1 => [card1, card2], player2 => []}
    end
  end
end
