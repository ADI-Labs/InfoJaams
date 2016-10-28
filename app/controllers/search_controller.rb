class SearchController < ApplicationController
  def index
    if params[:q]
      page = params[:page] || 1

      @results = GoogleCustomSearchApi.search(params[:q], page: page)
    end
  end

  def returnResults
    results = GoogleCustomSearchApi.search("Hank Aaron")

    puts results["items"]
    results["items"].each do |result|
      puts result["title"]
    end 
    #   results.each do |result|
    #     puts result
    # end
  end
end
