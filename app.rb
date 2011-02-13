require 'sinatra'
require 'json'

set :public, File.dirname(__FILE__)

get '/results' do
  content_type :json

  params[:page] ||= 1

  {
    :total   => params[:page].to_i,
    :results => [{ :name => "Bob Jones" }]
  }.to_json
end
