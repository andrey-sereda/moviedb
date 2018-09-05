class TopCommentersController < ApplicationController
  def index
    @commenters_hash = User.top_commenters
  end
end
