require 'yaml'

class Review

  attr_accessor :name, :id, :body, :image

  def self.all
    data = YAML.load_file('./data.yml')
    data['fresh_reviews'].map do | datum |
      Review.new(datum)
    end
  end

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
    @body = attributes['body']
    @image = attributes['image']
  end
end