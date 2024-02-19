class GamesController < ApplicationController
  require 'json'
  require 'open-uri'
  def new
    @letters = []
    alpha = ("A".."Z").to_a
    10.times do
      @letters << alpha.sample
    end
  end

  def score
    letters = params[:letters].delete(" ").split("")
    statut = true
    attempt = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    attempt_tab = attempt.upcase.chars
    attempt_tab.each do |letter|
      letters.include?(letter) ? letters.delete_at(letters.index(letter)) : statut = false
    end
    statut == true ? statut = JSON.parse(URI.open(url).read)["found"] : @message = "not in the grid"
    statut ? @score = (attempt_tab.length * 10) : @score = 0
    statut ? @message = "well done" : (@message = "not an english word" if @message.nil?)
  end
end
