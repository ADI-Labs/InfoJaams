class SearchController < ApplicationController
  def index
    if params[:q]
      page = params[:page] || 1

      @results = GoogleCustomSearchApi.search(params[:q], page: 1)
    end
  end

  def returnResults
    @results = GoogleCustomSearchApi.search("Hank Aaron")

    puts @results["items"]
    @results["items"].each do |item|
      puts item["title"], item["link"]

    end
  end

end
