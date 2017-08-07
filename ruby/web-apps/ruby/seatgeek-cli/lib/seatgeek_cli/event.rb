class SeatgeekCli::Event
  attr_accessor :title, :url, :local_time, :venue_time, :venue_address, :venue_city, :venue_state, :venue_url
  @@all = []

  def save
    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.clear_all
    self.all.clear
  end

  # def self.load_from_seatgeek
  #
  # end
end
