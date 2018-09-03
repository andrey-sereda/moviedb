require 'rest-client'

class MovieDataRetriever
  API_BASE_URL = 'https://pairguru-api.herokuapp.com/api/v1'
  @@cached_data = {}

  def call(movie_title)
    return @@cached_data[movie_title] if @@cached_data.key?(movie_title)

    @movie_title = movie_title
    movie_uri = [API_BASE_URL, 'movies', ERB::Util.url_encode(movie_title)].join('/')

    begin
      result = JSON.parse(RestClient.get(movie_uri))['data']['attributes']
      success_response(result)
    rescue
      # primitive error handling
      empty_response
    end
  end

  private

  def success_response(result)
    poster_url = result['poster'] && URI.join(API_BASE_URL, result['poster'])

    form_response(result['plot'], result['rating'], poster_url)
  end

  def empty_response
    form_response(nil, nil, nil)
  end

  def form_response(plot, rating, poster)
    response = {
        plot: plot || '',
        rating: rating || '-',
        poster: poster
    }

    @@cached_data[@movie_title] = response

    response
  end
end