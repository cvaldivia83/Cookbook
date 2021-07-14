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

ingredient = 'chocolate'

url = "https://www.allrecipes.com/search/results/?search=#{ingredient}"
html_file = URI.open(url).read
html_doc = Nokogiri::HTML(html_file)


titles = []
description = []
ratings = []
url = []
prep_time = ''

# html_doc.search('.card__title').each do |title|
#   titles << title.text.strip
# end

# html_doc.search('.card__summary').each do |element|
#   description << element.text
# end

# html_doc.search('.review-star-text').each do |rating|
#   puts rating.text.strip.slice(/(\d.?\d*)/)
# end

# html_doc.search('.card__titleLink').each do |element|
#   url << element.attribute('href').value
# end

html_doc.search('.card__detailsContainer').each do |element|
      titles << element.search('.card__title').first.text.strip
      description << element.search('.card__summary').first.text.strip
      ratings << element.search('.review-star-text').text.strip.slice(/(\d.?\d*)/)
      url << element.search('.card__titleLink').first.attribute('href').value
end

# index = 1

# new_url = url[index]
# html = URI.open(new_url).read
# new_doc = Nokogiri::HTML(html)

# new_doc.search('.recipe-meta-item').each do |element|
#   if element.search('.recipe-meta-item-header').first.text.strip == 'total:'
#     prep_time = element.search('.recipe-meta-item-body').first.text.strip
#   end
# end

p titles[2]
p url[2]
