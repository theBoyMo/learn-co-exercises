require "spec_helper"

RSpec.describe SeatgeekCli::Event do
  let(:event){SeatgeekCli::Event.new}

  context 'properties' do
    it 'has a title' do
      event.title = "Event title"
      expect(event.title).to eq('Event title')
    end

    it 'has a url' do
      event.url = 'Event url'
      expect(event.url).to eq('Event url')
    end

    it 'has a local_time' do
      event.local_time = 'Event time'
      expect(event.local_time).to eq('Event time')
    end

    it 'has venue_time' do
      event.venue_time = 'Event venue time'
      expect(event.venue_time).to eq('Event venue time')
    end

    it 'has a venue_address' do
      event.venue_address = 'Event venue address'
      expect(event.venue_address).to eq('Event venue address')
    end

    it 'has a venue_city' do
      event.venue_city = 'Event venue city'
      expect(event.venue_city).to eq('Event venue city')
    end

    it 'has a venue_state' do
      event.venue_state = 'Event venue state'
      expect(event.venue_state).to eq('Event venue state')
    end

    it 'has a venue_url' do
      event.venue_url = 'Event venue url'
      expect(event.venue_url).to eq('Event venue url')
    end
  end

  describe '#save' do
    it 'saves the event to all events' do
      event.save
      expect(SeatgeekCli::Event.all).to include(event)
    end
  end

  describe '.all' do
    it 'returns all my event instances' do
      event.save
      expect(SeatgeekCli::Event.all).to include(event)
    end
  end

  describe '.clear_all' do
    it 'clears all the events from @@all' do
      SeatgeekCli::Event.clear_all
      expect(SeatgeekCli::Event.all).to eq([])
    end
  end

  # describe '.load_from_seatgeek' do
  #   it "loads events from seatgeek" do
  #     SeatgeekCli::Event.clear_all
  #
  #     SeatgeekCli::Event.load_from_seatgeek
  #     expect(SeatgeekCli::Event.all).not_to eq([])
  #   end
  # end

end
