class Song 
  extend Concerns::Findable
  attr_accessor :name, :artist
  attr_reader :genre
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name 
    if artist != nil 
      self.artist= artist
    end
    if genre != nil 
      self.genre= genre 
    end 
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
    Song.new(name)
  end
  
  def genre=(genre)
    @genre = genre
    Genre.all.each do |genr|
      if genr == genre
        if genr.songs.none?(self)
          genr.songs << self 
        end 
      end 
    end
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def self.new_from_filename(filename)
    name = filename.split('-')[1].strip 
    artist = Artist.find_or_create_by_name(filename.split(' - ')[0].strip)
    genre = Genre.find_or_create_by_name(filename.split(' - ')[2].gsub(".mp3", '').strip)
    song = self.new(name, artist, genre)
    song
  end
  
  def self.create_from_filename(filename)
    new_from_filename(filename)
  end
  
end

