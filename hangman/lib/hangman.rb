
class HangmanGame
  attr_accessor :number_of_wrong_guesses

  HANGMAN_DISPLAY = 
   ["  +---+\n  |   |\n      |\n      |\n      |\n      |\n=========", 
    "  +---+\n  |   |\n  O   |\n      |\n      |\n      |\n=========",
    "  +---+\n  |   |\n  O   |\n  |   |\n      |\n      |\n=========",
    "  +---+\n  |   |\n  O   |\n (|   |\n      |\n      |\n=========", 
    "  +---+\n  |   |\n  O   |\n (|)  |\n      |\n      |\n=========",
    "  +---+\n  |   |\n  O   |\n (|)  |\n |    |\n      |\n=========",
    "  +---+\n  |   |\n  O   |\n (|)  |\n | |  |\n      |\n========="]
  @@dictionary = File.read("5desk.txt")
  @@word_list = @@dictionary.split
  @@ready_word_list = []

  def initialize
    @secret_word = ""
    @hangman = HANGMAN_DISPLAY[0]
    @lives_left = 6
    @letters_guessed = []
    @word_dashes = ""
    @number_of_wrong_guesses = 0
    @game_over = false
    @win_game = false
    @lose_game = false
  end

  def create_word_dashes
    @word_dashes = ("_" * @secret_word.length)
  end
  
  def update_word_dashes
    @secret_word.each_char.with_index do |char, i|
      if char == @letter
        @word_dashes[i] = char
      end
    end
  end
    
  def guess_letter
    puts "Type your letter guess and press 'enter/return':"
    @letter = gets.chomp.to_s.downcase
    @letters_guessed << @letter
    if @secret_word.to_s.include?(@letter) == false
      puts "Sorry, there are no #{@letter}'s in the secret word. :("
      @lives_left -= 1
      @number_of_wrong_guesses += 1
      self.update_hangman
    else
      puts "Yes! There is at least one '#{@letter}' in the secret word!"
      self.update_word_dashes
    end
  end

  def update_hangman
    @hangman = HANGMAN_DISPLAY[@number_of_wrong_guesses]
  end

  def show_display
    puts "word: #{@word_dashes.split('').join(' ')}"
    puts @hangman
    puts "Letters guessed so far: #{@letters_guessed}"
    puts "lives left: #{@lives_left}"
  end

  def prepare_word_list
    @@ready_word_list = @@word_list.delete_if {|word| word.length < 5 || word.length > 12 }
    @@ready_word_list
  end

  def select_secret_word
    puts "Selecting secret word..."
    @secret_word = @@ready_word_list[rand(52453)].downcase
    puts "Secret word selected."
    @secret_word
  end

  def play_again_option
    puts "Want to play again? Type 'Y' or 'N' and press 'enter/return'"
    answer = gets.chomp.to_s.upcase
    if answer == "Y"
      self.new
      self.prep_game
      self.play_game
    else
      puts "Come back soon!"
    end
  end

  def lose_game?
    if @hangman == HANGMAN_DISPLAY[6]
      @lose_game = true
    else
      @lose_game = false
    end
  end

  def win_game?
    if @secret_word == @word_dashes
      @win_game = true
    else
      @win_game = false
    end
  end

  def display_end_message
    if @win_game ==  true
      self.show_display
      puts "~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
      puts "Congratulations! You guessed the secret word, #{@secret_word}!"
      puts "Lil' Billy will live to hang another day thanks to you!"
      self.play_again_option
    elsif @lose_game == true
      self.show_display
      puts "You lose! The word was: #{@secret_word}!"
      puts "Sorry brah, better luck next time! :("
      self.play_again_option
    end
  end

  def prep_game
    self.prepare_word_list
    self.select_secret_word
    self.create_word_dashes
  end

  def play_game
    until @win_game == true || @lose_game == true
      self.show_display
      self.guess_letter
      self.win_game?
      self.lose_game?
    end
    self.display_end_message
  end 

end

def intro_game
  puts " "
  puts "~*~*~*~*~*~*~ Welcome to Hangman! ~*~*~*~*~*~*~"
  puts " "
  puts "The rules are simple, guess letters in the secret word before lil' Billy dies!"
  puts "After 6 incorrect guesses, you lose and you'll need"
  puts "to explain that your responsibility for lil' Billy's death to his loved ones!"
  puts "The pressure is ON!"
  puts " "
  puts "Ready to play a new game? Type 'Y' or 'N' and press 'enter/return'"
  answer = gets.chomp.to_s.upcase
  if answer == "Y"
    puts "Cool let's get it started!"
    puts "Initializing new game..."
    puts "Ready to start! Hang in there lil' Billy!!!"
    game = HangmanGame.new
    game.prep_game
    game.play_game
  else
    puts "Okiedokie... well... see you later?"
  end
end

intro_game