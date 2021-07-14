class ScrapeRecipes
  attr_reader :title, :description, :rating, :url, :prep_time

  def initialize(ingredient)
    @ingredient = ingredient
    @title = []
    @description = []
    @rating = []
    @url = []
    @prep_time = ''
  end

  def call
    url = "https://www.allrecipes.com/search/results/?search=#{@ingredient}"
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('.card__detailsContainer"').each do |element|
      @title << element.search('.card__title').first.text.strip
      @description << element.search('.card__summary').first.text.strip
      @rating << element.search('.review-star-text').text.strip.slice(/(\d.?\d*)/)
      @url << element.search('.card__titleLink').first.attribute('href').value
    end
  end

  def get_prep_time(index)
    html_file = URI.open(@url[index]).read
    doc = Nokogiri::HTML(html_file)

    doc.search('.recipe-meta-item').each do |item|
      if item.search('.recipe-meta-item-header').first.text.strip == 'total:'
        @prep_time = element.search('.recipe-meta-item-body').first.text.strip
      end
    end

    @prep_time
  end
end
