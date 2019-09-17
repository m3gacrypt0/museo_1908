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

end
