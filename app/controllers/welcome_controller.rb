class WelcomeController < ApplicationController
  require 'open-uri'
  require 'open-uri-s3'

  def index
  end

  def stream

    url = "http://api.soundcloud.com/tracks/#{params[:soundcloud_location]}/stream?client_id=c280d0c248513cfc78d7ee05b52bf15e"
    s3_url = UrlResolver.resolve(url)
    puts s3_url
    puts 'really?'
    file = s3_url


    render json: {file:file}


    puts 'dude?'
  end
end
