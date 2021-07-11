# Test parsing a html file downloaded from allrecipes.com
require 'nokogiri'
require 'open-uri'

file = 'strawberry.html'
doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')

# doc.search('.card__title').each do |element|
#   puts element.text
# end

# doc.search('.card__summary').each do |description|
#   puts description.text
# end

#Test parsing an url from allrecipes.com

ingredient = 'strawberry'

url = "https://www.allrecipes.com/search/results/?search=#{ingredient}"
html_file = URI.open(url).read
html_doc = Nokogiri::HTML(html_file)

titles = []
# html_doc.search('.card__title').each do |title|
#   titles << title.text.strip
# end

# html_doc.search('.card__summary').each do |description|
#   descriptions << description.text
# end

html_doc.search('.review-star-text').each do |rating|
  puts rating.text.strip.slice(/(\d.?\d*)/)
end
