require_relative "../spec_helper"
require_relative "../../src/model/character"
require_relative "../../src/repository"

describe Character do
  after(:each) do
    Repository.delete_all(Character)
  end

  describe "column" do
    it "should have columns" do
      character = Character.new
      character.name = "Morty Smith"
      character.status = "Alive"
      character.species = "Human"
      character.gender = "Male"

      changeset = Repository.insert(character)
      expect(changeset.errors).to be_empty
    end
  end

  describe "validation" do
    it "should validate presence" do
      character = Character.new

      changeset = Repository.insert(character)
      expect(changeset.errors).not_to be_empty
      expect(changeset.valid?).to be_falsey
      error_fields = changeset.errors.map { |error| error[:field] }
      expect(error_fields).to include("name")
      expect(error_fields).to include("status")
      expect(error_fields).to include("species")
      expect(error_fields).to include("gender")
    end
  end

  it "should validate name uniqueness" do
    character1 = Character.new
    character1.name = "Morty Smith"
    character1.status = "Alive"
    character1.species = "Human"
    character1.gender = "Male"
    Repository.insert(character1)

    character2 = Character.new
    character2.name = "Morty Smith"
    character2.status = "Alive"
    character2.species = "Human"
    character2.gender = "Male"
    changeset = Repository.insert(character2)

    expect(changeset.errors).not_to be_empty
    expect(changeset.valid?).to be_falsey
    error_fields = changeset.errors.map { |error| error[:field] }
    expect(error_fields).to include("name")
  end
end
