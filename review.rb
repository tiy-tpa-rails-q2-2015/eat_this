require 'yaml'

class Review

  attr_accessor :name, :id, :body, :image

  def self.all
    data = YAML.load_file('./reviews.yml')
    data.map do | datum |
      Review.new(datum)
    end
  end

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
    @body = attributes['body']
    @image = attributes['image']
  end

  def url
    "/review/#{self.id}"
  end

  def image_url
    "/assets/images/#{self.image}"
  end

  def self.find(id)
    Review.all.find { |review| review.id == id }
  end

  def ==(other)
    self.id == other.id
  end

  def to_hash
    {
        "id" => self.id,
        "name" => self.name,
        "body" => self.body,
        "image" => self.image
    }
  end

  def save
    data = YAML.load_file('./reviews.yml')
    index = data.find_index { |datum| datum["id"] == self.id }
    if index
      data[index] = self.to_hash
    else
      self.id = data.size + 1
      data[data.size] = self.to_hash
    end

    File.write('./reviews.yml', data.to_yaml)
    self
  end
end