require 'sinatra'
require 'httparty'

BASE_URL = 'https://rickandmortyapi.com/api'

get "/" do |env|
  env.redirect "/", 403
end

error 404 do
  {"error": "Resource not found!"}.to_json
end

error 403 do
  {"error": "Access forbidden!"}.to_json
end

error 401 do
  {"error": "Unauthorized!"}.to_json
end

error 500 do
  {"error": "Oops! Something went wrong."}.to_json
end

get "/api/characters" do |env|
  env.response.content_type = "application/json"
  response = HTTParty.get("#{BASE_URL}/character")
  response.body
end

get "/api/characters/:id" do |env|
  id = env.params.url["id"]
  env.response.content_type = "application/json"
  response = HTTParty.get("#{BASE_URL}/character/#{id}")
  if response.code == 200
    response.body
  else
    env.response.status_code = response.code
  end
end

get "/api/episodes" do |env|
  env.response.content_type = "application/json"
  response = HTTParty.get("#{BASE_URL}/episode")
  response.body
end

get "/api/episodes/:id" do |env|
  id = env.params.url["id"]
  env.response.content_type = "application/json"
  response = HTTParty.get("#{BASE_URL}/episode/#{id}")
  if response.code == 200
    response.body
  else
    env.response.status_code = response.code
  end
end

get "/api/locations" do |env|
  env.response.content_type = "application/json"
  response = HTTParty.get("#{BASE_URL}/location")
  response.body
end

get "/api/locations/:id" do |env|
  id = env.params.url["id"]
  env.response.content_type = "application/json"
  response = HTTParty.get("#{BASE_URL}/location/#{id}")
  if response.code == 200
    response.body
  else
    env.response.status_code = response.code
  end
end
