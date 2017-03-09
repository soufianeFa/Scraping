#!/usr/bin/ruby -w
require 'open-uri'
require 'nokogiri'
price = 0
compteur = 0
value = 200
the_url ="https://www.leboncoin.fr/telephonie/offres/ile_de_france/?f=a&th=1&ps=8&pe=11&q=iphone"

page = Nokogiri::HTML(open(the_url))  #url must specify the protocol
html_doc = page.css('h2.item_title')
#html_lines = html_doc.split('\n')

# puts "================"
html_doc.each do |i|
 	the_line = i.content
	if the_line.include? "5c" or the_line.include? "5C"
		puts the_line.strip!
	end
end

html_doc = page.css('h3.item_price')
#html_lines = html_doc.split('\n')

# puts "================"
html_doc.each do |i|
 	the_line = i.text
 	price_unique = the_line.to_i

 	if price_unique==value  
 		compteur+=1
 	end

	price += price_unique
end

 puts "le prix de tous les articles = #{price}"
 puts "le nombre des articles ayant un prix égal à 200 est : #{compteur}"



