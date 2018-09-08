require "rails_helper"
include StubHelpers

describe MovieDataRetriever do
  subject {MovieDataRetriever.new.call(movie.title)}

  before do
    define_stubs
  end

  context "retrieves the correct data" do
    let(:movie) {Movie.new(title: 'Godfather')}

    it 'retrieves correct rating' do
      expect(subject).to include(rating: 9.2)
    end

    it 'retrieves correct plot' do
      expect(subject[:plot]).to start_with('The aging patriarch')
    end

    it 'retrieves correct poster' do
      expect(subject[:poster].to_s).to end_with('/godfather.jpg')
    end
  end

  context "handles spaces in movie name" do
    let(:movie) {Movie.new(title: 'Kill Bill')}

    it 'retrieves correct data' do
      expect(subject).to include(rating: 8.1)
    end
  end

  context "handles incorrect data" do
    let(:movie) {Movie.new(title: 'Non Existing Movie')}

    it 'retrieves correct default rating' do
      expect(subject[:rating]).to eq('-')
    end

    it 'retrieves correct default plot' do
      expect(subject[:plot]).to eq('')
    end

    it 'retrieves correct default poster' do
      expect(subject[:poster].to_s).to eq('')
    end
  end

  context "handles API timeouts" do
    let(:movie) {Movie.new(title: 'TimeoutMovie')}

    it 'uses default data' do
      expect(subject).to include(rating: '-')
    end
  end
end