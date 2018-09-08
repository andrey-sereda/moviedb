require "rails_helper"

describe "Movies API requests", type: :request do

  before do
    @movies = FactoryBot.create_list(:movie, 15)
  end

  it "sends correct list of movies" do
    get '/api/v1/movies'

    expect(response).to be_successful

    expect(json_response['movies'].size).to eq(@movies.size)
  end

  it "sends no genre by default" do
    get '/api/v1/movies'

    expect(json_response['movies'][0]).not_to include('genre')

    get "/api/v1/movies/#{@movies.sample.id}"

    expect(json_response['movie']).not_to include('genre')
  end

  it "sends genre if requested" do
    get "/api/v1/movies_with_genre"

    expect(json_response['movies'][0]).to include('genre')

    get "/api/v1/movies_with_genre/#{@movies.sample.id}"

    expect(json_response['movie']).to include('genre')
  end

  it "sends correct movie by id" do
    movie = @movies.sample

    get "/api/v1/movies/#{movie.id}"

    expect(response).to be_successful

    expect(json_response['movie']['title']).to eq(movie.title)
  end
end
