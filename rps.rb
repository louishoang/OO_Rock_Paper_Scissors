require "pry"

# A game of choice between two or more players.
# Each player randomly choose rock, paper or scissor.
# Game play : rock > scissor; scissor > paper; paper > rock
# or tie if two hands are the same.

class Hand
  include Comparable

  attr_reader :value

  def initialize(v)
    @value = v
  end

  def <=> (another_hand)
    if @value == another_hand.value
      0
    elsif (@value == 'p' && another_hand.value == 'r') || (@value == 'r' && another_hand.value == 's') || (@value == 's' && another_hand.value == 'p')
      1
    else
      -1
    end

  end


end

class Player

  attr_accessor :hand
  attr_reader :name

  def initialize(n)
    @name = n
  end

  def to_s
    "#{name} currently has a choice of #{self.hand.value}!"
  end

end



class Human < Player
  def pick_hand
    begin
    puts " Please choose your hand."
    puts " p = Paper -- r = Rock -- s = Scissor"
    c = gets.chomp.downcase
    end until Game::CHOICES.keys.include?(c)

    self.hand = Hand.new(c)
  end
end



class Computer < Player
  def pick_hand
    self.hand = Hand.new(Game::CHOICES.keys.sample)
  end
end

class Game
  CHOICES = {'p' => 'Paper', 'r' => 'Rock', 's' => 'Scissor'}

  attr_reader :player, :computer

  def initialize
    @player = Human.new("You")
    @computer = Computer.new("Zbot")
  end

  def compare_hands
    if player.hand == computer.hand
      puts "It's a tie!"
    elsif player.hand > computer.hand
      puts "#{player.name} won!"
    else
      puts "#{computer.name} won!"
    end
  end

  def play
    player.pick_hand
    computer.pick_hand
    puts player
    puts computer
    compare_hands
    play_again?
  end

  def play_again?
    puts" Do you want to play again?"
    puts "1 =  Yes; 2 = No"
    answer = gets.chomp
    if answer.downcase == "1"
      game = Game.new.play
    end
  end

end

game = Game.new.play
