class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word, guesses, wrong_guesses)
    @word = word
    @guesses = guesses
    @wrong_guesses = wrong_guesses
  end

  def word
    return @word
  end

  def wrong_guesses
    return @wrong_guesses
  end

  def guesses
    return @guesses
  end

  def guess(letter)
    raise ArgumentError if letter.nil? || letter.empty? || !letter.match?(/[A-Za-z]/)
    letter.downcase!
    if @guesses.include?(letter) || @wrong_guesses.include?(letter)
      return false
    end
    if @word.include?(letter)
      @guesses += letter
    else
      @wrong_guesses += letter
    end
    return true
  end

  def word_with_guesses
    partial = ""

    @word.each_char do |x|
      
      if guesses.include?(x)
        partial += x
      else
        partial += "-"
      end
    end
    return partial
  end
      

  def check_win_or_lose()
    if @wrong_guesses.length >= 7
      return :lose
    elsif @word == word_with_guesses
      return :win
    else
      return :play
    end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start do |http|
      return http.post(uri, "").body
    end
  end
end
