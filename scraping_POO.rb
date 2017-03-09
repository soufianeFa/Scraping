#!/usr/bin/ruby -w
require 'open-uri'
require 'nokogiri'
$price = 0
$compteur = 0
$value = 200
=begin 
	cette classe me permet de scraper le lien donné on peut utiliser l'argument des méthodes pour changer le lien cible
=end
class Scraper

	def thescraper_title(the_url="https://www.leboncoin.fr/telephonie/offres/ile_de_france/?f=a&th=1&ps=8&pe=11&q=iphone")
		page = Nokogiri::HTML(open(the_url))  
			html_doc = page.css('h2.item_title')

			html_doc.each do |i|
			 	the_line = i.content
				if the_line.include? "5c" or the_line.include? "5C"
					puts the_line.strip!
				end
			end

	end

	def thescraper_info(the_url="https://www.leboncoin.fr/telephonie/offres/ile_de_france/?f=a&th=1&ps=8&pe=11&q=iphone")
		page = Nokogiri::HTML(open(the_url)) 
		html_doc = page.css('h3.item_price')

		# puts "================"
		html_doc.each do |i|
		 	the_line = i.text
		 	price_unique = the_line.to_i
		 	if price_unique==$value  
		 		$compteur+=1
		 	end

			$price += price_unique
		end
	end
end
=begin 
	cette classe va me permettere d'afficher les résultats selectionnés depuis le site et les afficher
	les valeurs cherchées sont stockées dans des vars globales on peut utiliser des vars de classes '@@'
	mais il faut que la classe Diplayer hérite de la classe scraper si on met ses vars dans 'Scraper'

=end
class Displayer
	def afficheur
		 puts "le prix de tous les articles = #{$price}" 
		 puts "le nombre des articles ayant un prix égal à 200 est : #{$compteur}"
	end	
end

begin
scrap = Scraper.new
scrap.thescraper_title
scrap.thescraper_info
the_display = Displayer.new
the_display.afficheur 
end