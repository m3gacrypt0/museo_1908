require 'csv'

class Curator
  attr_reader :photographs, :artists

  def initialize
    @photographs  = []
    @artists      = []
  end

  def add_photograph(photograph)
    @photographs << photograph
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find {|artist| artist.id == id}
  end

  def find_photograph_by_id(id)
    @photographs.find {|photograph| photograph.id == id}
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all {|photograph| photograph.artist_id == artist.id}
  end

  def artists_with_multiple_photographs
    artists_output = []
    @artists.each do |artist|
      artists_output << artist if (find_photographs_by_artist(artist).length > 1)
    end
    artists_output
  end

  def photographs_taken_by_artists_from(country)
    @photographs.find_all {|photograph|   find_artist_by_id(photograph.artist_id).country == country}
  end

  def load_photographs(filepath)
    CSV.foreach(filepath, headers: true) do |row|
      new_photo = Photograph.new({
           id: row["id"],
           name: row["name"],
           artist_id: row["artist_id"],
           year: row["year"]
      })
      @photographs << new_photo
    end
  end

  def load_artists(filepath)
    CSV.foreach(filepath, headers: true) do |row|
      new_artist = Artist.new({
           id: row["id"],
           name: row["name"],
           born: row["born"],
           died: row["died"],
           country: row["country"]
      })
      @artists << new_artist
    end
  end

end
