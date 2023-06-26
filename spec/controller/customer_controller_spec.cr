require "json"
require "http/headers"
require_relative "../spec_helper"
require_relative "../../src/server"
require_relative "../../src/repository"
require_relative "../../src/model/customer"
require "http"

describe "CharacterController" do
  describe "GET /api/characters" do
    it "should return 200 and array of characters" do
      response = HTTP.get("https://rickandmortyapi.com/api/character")
      data = JSON.parse(response.body)
      characters = data["results"]

      get "/api/characters"

      expect(response.status_code).to eq 200
      expect(response.body).to eq characters.to_json
    end
  end

  describe "GET /api/characters/:id" do
    it "should return 200 and character object when id exists" do
      response = HTTP.get("https://rickandmortyapi.com/api/character")
      data = JSON.parse(response.body)
      character = data["results"].first

      get "/api/characters/#{character["id"]}"

      expect(response.status_code).to eq 200
      expect(response.body).to eq character.to_json
    end

    it "should return 404 when id does not exist" do
      not_exists_id = 9999

      get "/api/characters/#{not_exists_id}"

      expect(response.status_code).to eq 404
    end
  end

  describe "POST /api/characters" do
    it "should return 201 and created character object" do
      new_character = {
        "name" => "Morty Smith",
        "status" => "Alive",
        "species" => "Human",
        "type" => "",
        "gender" => "Male",
        "origin" => {
          "name" => "Earth"
        },
        "location" => {
          "name" => "Earth"
        },
        "image" => "https://rickandmortyapi.com/api/character/avatar/2.jpeg"
      }
      headers = { "Content-Type" => "application/json" }

      post "/api/characters", headers: headers, body: new_character.to_json

      expect(response.status_code).to eq 201
      expect(response.body).to eq new_character.to_json
    end
  end

  describe "PUT /api/characters/:id" do
    it "should return 200 and updated character object" do
      response = HTTP.get("https://rickandmortyapi.com/api/character")
      data = JSON.parse(response.body)
      character = data["results"].first
      updated_character = character.merge("name" => "Updated Name")
      headers = { "Content-Type" => "application/json" }

      put "/api/characters/#{character["id"]}", headers: headers, body: updated_character.to_json

      expect(response.status_code).to eq 200
      expect(response.body).to eq updated_character.to_json
    end

    it "should return 404 when id does not exist" do
      not_exists_id = 9999

      put "/api/characters/#{not_exists_id}"

      expect(response.status_code).to eq 404
    end
  end

  describe "DELETE /api/characters/:id" do
    it "should return 204 when successfully deleted" do
      response = HTTP.get("https://rickandmortyapi.com/api/character")
      data = JSON.parse(response.body)
      character = data["results"].first

      delete "/api/characters/#{character["id"]}"

      expect(response.status_code).to eq 204
    end

    it "should return 404 when id does not exist" do
      not_exists_id = 9999

      delete "/api/characters/#{not_exists_id}"

      expect(response.status_code).to eq 404
    end
  end
end
