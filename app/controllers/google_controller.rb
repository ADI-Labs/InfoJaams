class GoogleController < ApplicationController
  def index
    @results = GoogleCustomSearch.search("Hank Aaron")
  end


  def getResults
    @results = GoogleCustomSearch.search("dog")

    puts @results
    @results.pages.each do |r|
      puts r.description
    end
  end
end
