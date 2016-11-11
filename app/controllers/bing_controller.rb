class BingController < ApplicationController
  def getResults
    BingSearch.account_key = 'HBqI/Aby4J6YoPBqgXHNTcvSoQzfXdrmDTykSeoBb0U'

    results = BingSearch.web('Oprah',limit: 5)
    count = 1
    results.each do |r|
      puts r.title
      puts r.summary
      puts r.url
      puts count
      count += 1
    end
  end
end
