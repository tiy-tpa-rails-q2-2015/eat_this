require 'rubygems'
require 'bundler/setup'
require 'tilt'
require 'erb'
require 'webrick'
require 'yaml'
require 'slim'
require 'tilt/sass'

require './review'

class App
  ROOT = File.dirname(__FILE__)
  PORT = ENV["PORT"] || 8000

  def self.run
    server = WEBrick::HTTPServer.new(:Port => PORT)

    server.mount '/assets', WEBrick::HTTPServlet::FileHandler, "#{ROOT}/public"

    server.mount_proc '/' do |req, res|
      template = Tilt.new("#{ROOT}/index.slim")
      res.body = template.render(self, {:reviews => Review.all})
    end

    server.mount_proc '/stylesheet.css' do |req, res|
      res.body = Tilt.new("#{ROOT}/stylesheet.sass").render
    end

    server.mount_proc '/review/' do |req, res|
      id = req.path.match(/\/review\/(\d+)/)[1].to_i
      data = YAML.load_file('data.yml')
      review = data["fresh_reviews"].find { |review| review["id"] == id }

      template = Tilt.new("#{ROOT}/review.slim")
      res.body = template.render(self, { :review => review })
    end


    trap 'INT' do
      server.shutdown
    end

    server.start
  end
end

App.run