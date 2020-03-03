class MusicLibraryController 

  def initialize(path = './db/mp3s')
    @path = path 
    @new = MusicImporter.new(@path)
    @new.import
  end 
  
  def call 
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets.strip
    case input 
      when "list songs"
        list_songs 
      when "list artists"
        list_artists 
      when "list genres"
        list_genres 
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre 
      when "play song"
        play_song
      end
    while input.strip != "exit"
      call 
      return
    end
  end
  
  def list_songs 
    song_list = Song.all.sort {|a, b| a.name <=> b.name}
    fix_list = []
    i = 1
    song_list.each do |song| 
      fix_list << "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      i +=1 
    end 

    fix_list.each do |song|
      puts song 
    end 
  end 
  
  def list_artists
    list =  Artist.all.sort {|artist_a, artist_b| artist_a.name <=> artist_b.name}
    i = 0
    list.each do |artist|
      i += 1
      puts "#{i}. #{artist.name}" 
    end
  end 
  
  def list_genres 
    genre_list = @new.files.sort{|file_a, file_b|
      file_a.split(' - ')[2] <=> file_b.split(' - ')[2]}
      
    fix_list = []
    
    genre_list.each do |song| 
      if fix_list.none?("#{song.split(' - ')[2].gsub(".mp3", '').strip}")
        fix_list << "#{song.split(" - ")[2].gsub(".mp3", '').strip}"
      end
    end
    
    i = 0
    fix_list.each do |genre|
      i += 1
      puts "#{i}. #{genre}"
    end
  end 
  
  def list_songs_by_artist 
    puts "Please enter the name of an artist:"
    artist = gets.strip
    song_list = []
    Song.all.each do |song| 
      if song.artist.name == artist 
        song_list << (song.name + ' - ' + song.genre.name)
      end
    end
    i = 0
    song_list.sort.each do |song|
      i += 1
      puts "#{i}. #{song}"
    end

  end 
  
  def list_songs_by_genre 
    puts "Please enter the name of a genre:"
    genre = gets.strip
    song_list = {}
    Song.all.each do |song| 
      if song.genre.name == genre 
        song_list[song.artist.name] = song.name
      end
    end
    sort_list = song_list.sort{|a,b| a[1]<=> b[1]}

    i = 0
    sort_list.each do |song|
      i += 1
      puts "#{i}. #{song[0]} - #{song[1]}"
    end
  end 
  
  def play_song
    puts "Which song number would you like to play?"
    song_number = gets.strip.to_i

    if song_number >= 1 && song_number <= Song.all.length
      solution = Song.all.sort!{|a, b| a.name <=> b.name}[song_number-1]
      puts "Playing #{solution.name} by #{solution.artist.name}"
    end
    
  end 
  
  def exit 
    exit
  end 
  
end 

