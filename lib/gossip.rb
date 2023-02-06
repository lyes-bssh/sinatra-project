class Gossip

	attr_accessor :author, :content

	def initialize(author, content)
		@author = author
		@content = content
	end

	def save
		CSV.open("db/gossip.csv", "ab") { |csv| csv << [@author, @content] }
	end

	def self.all
	all_gossips = []

	CSV.read("db/gossip.csv").each do |ligne|
		tmp = Gossip.new(ligne.first, ligne.last)
		all_gossips << tmp
		end
		all_gossips
	end

	def self.find(id)
		gossips = self.all
		gossips[id.to_i]
	end

	def self.update(new_author, new_content, id)
		gossips = self.all
		gossips[id].author = new_author
		gossips[id].content = new_content
#Je vide le fichier et je le rempli avec les nouvelles valeurs
		CSV.open("db/gossip.csv", "w") { |csv| }
		CSV.open("db/gossip.csv", "w") { |csv| gossips.each { |gossip| gossip.save }}
	end

end