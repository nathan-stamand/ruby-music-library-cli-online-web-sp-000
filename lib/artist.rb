class Artist 
  extend Concerns::Findable
  attr_accessor :name, :artist
  @@all = []

  def initialize(name)
    @name = name 
    @@all << self 
    @songs = []
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
    Artist.new(name)
  end
    
  def add_song(song)
    if song.artist == nil 
      song.artist=self 
      self.songs << song
    end
  end
  
  def songs 
    @songs 
  end 
  
  def genres 
    songs = Song.all.select{|song| song.artist == self}
    genres = songs.map {|song|song.genre}
    genres.uniq
  end
  
end 