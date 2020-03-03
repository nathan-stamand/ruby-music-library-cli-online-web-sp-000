class Genre 
  extend Concerns::Findable
  attr_accessor :name, :songs
  @@all = []
  
  
  def initialize(name)
    @name = name 
    @songs = []
    @@all << self 
    self
  end 
  
  def self.all 
    @@all 
  end
  
  def self.destroy_all 
    @@all.clear 
  end 
  
  def save 
    @@all << self 
  end 
  
  def self.create(name)
    Genre.new(name)
  end
    
  def songs 
    @songs 
  end 
  
  def artists
    songs = Song.all.select{|song| song.genre == self}
    artists = songs.map {|song|song.artist}
    artists.uniq
  end
  
end 