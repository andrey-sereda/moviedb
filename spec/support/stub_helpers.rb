module StubHelpers
  def define_stubs
    valid_movies = %w(Godfather Kill%20Bill Non%20Existing%20Movie)
    valid_movies.each do |movie_title|
      movie_uri = "#{MovieDataRetriever::API_BASE_URL}/movies/#{movie_title}"

      stub_request(:get, movie_uri).
          to_return(body: movie_response_body(movie_title))
    end

    valid_movies << 'TimeoutMovie'
    movie_uri = "#{MovieDataRetriever::API_BASE_URL}/movies/#{valid_movies.last}"

    stub_request(:get, movie_uri).to_timeout

    movie_uri = %r{#{MovieDataRetriever::API_BASE_URL}/movies/*}

    stub_request(:get, movie_uri).with do |request|
      movie_requested = URI(request.uri).path.split('/').last
      ! valid_movies.include?(movie_requested)
    end.to_return(body: movie_response_body('unknown'))
  end

  def movie_response_body(title)
    case title
    when 'Godfather'
      {"data": {"id": "6", "type": "movie", "attributes": {"title": "Godfather", "plot": "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.", "rating": 9.2, "poster": "/godfather.jpg"}}}.to_json
    when 'Kill%20Bill'
      {"data": {"id": "3", "type": "movie", "attributes": {"title": "Kill Bill", "plot": "The Bride wakens from a four-year coma. The child she carried in her womb is gone. Now she must wreak vengeance on the team of assassins who betrayed her - a team she was once part of.", "rating": 8.1, "poster": "/kill_bill.jpg"}}}.to_json
    else
      {"message": "Couldn't find Movie"}.to_json
    end
  end
end