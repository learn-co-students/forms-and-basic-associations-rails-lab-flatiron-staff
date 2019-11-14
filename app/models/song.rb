class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
  end

  def genre_name
    self.genre ? genre.name : nil
  end

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    self.artist ? artist.name : nil
  end

  def note_contents=(array)
    self.save

    array.each do |item|
      unless item.empty?
        note = Note.find_or_create_by(content: item, song_id: self.id)
      end
    end
  end

  def note_contents
    self.notes.pluck(:content)
  end
end
