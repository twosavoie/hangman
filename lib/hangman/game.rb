module Hangman
  class Game
    attr_reader :chances, :word, :wrong_tries, :guess

    def initialize
      @chances = 5
      @wrong_tries = 0
      @guess = ""
      @word = Dictionary.random
    end

    def play
      Graphics.clear_screen
      puts 'Guess this word: ' + Graphics.obfuscate_word(word, '')

      while true
        print "[#{chances - wrong_tries} chances left]: "

        char = gets.chomp
        Graphics.clear_screen

        if word.include? char
          if guess.include? char
            if char == ""
              puts 'Enter a letter to play! ' + Graphics.obfuscate_word(word, guess)
              placeholder = Graphics.obfuscate_word(word, guess)
            else
              puts "You already entered '#{char}'. Yes, it is still correct.. 🙄"
              puts 'Try again: ' + Graphics.obfuscate_word(word, guess)
            end
          else
            guess << char
            placeholder = Graphics.obfuscate_word(word, guess)
            puts 'Whoop Whoop!! ' + placeholder
          end

          unless placeholder.include? Graphics::OBFUSCATION_CHAR
            puts Graphics::ALIVE
            puts "\n\nWELL DONE!! YOU SURVIVED"
            break
          end
        else
            if guess.include? char
              puts "That's the same letter. Try a different letter"
              @wrong_tries = @wrong_tries
            elsif !char.match(/^[[:alpha:]]$/) == true
              puts "A letter please!"
              @wrong_tries = @wrong_tries
            else
              puts "OH NOES! The word doesn't contain '#{char}'"
              @wrong_tries = @wrong_tries + 1
              guess << char
            end

          if wrong_tries == chances
            puts Graphics::DEAD
            puts "\nARRRRGGGGGGGGGGG YOU LOST! 😭  😵  ☠️"
            break
          else
            puts 'Try another: ' + Graphics.obfuscate_word(word, guess)
          end
        end
      end
    end
  end
end
