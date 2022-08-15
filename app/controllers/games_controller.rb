require "json"
require "open-uri"
require 'set'

class GamesController < ApplicationController

  def new
    @letters = ('a'..'z').to_a.shuffle.first(10);
  end

  def score
    @word = params[:word]

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_serialized = URI.open(url).read
    guess_word = JSON.parse(word_serialized)

    @letter = params[:letters]
    letters_array = @letter.chars.to_set
    word_array = @word.chars.to_set

    if !word_array.subset?(letters_array)
      @answer = "Sorry but #{@word} can't be built out of #{@letter}"
    else
      if guess_word['found'] == true
        @answer = "Congratulations! #{@word.upcase} is a valid English word!"
      else
        @answer = "Sorry but <strong>#{@word}</strong> does not seem to be a valid English word..."
      end
    end
  end
end
