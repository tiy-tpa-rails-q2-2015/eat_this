require 'rubygems'
require 'bundler/setup'
require 'tilt'
require 'erb'
require 'webrick'
require 'yaml'

ROOT = File.dirname(__FILE__)

server = WEBrick::HTTPServer.new(:Port => ENV["PORT"])

server.mount '/assets', WEBrick::HTTPServlet::FileHandler, "#{ROOT}/public"

server.mount_proc '/' do |req, res|
  @data = YAML.load_file('data.yml')
  template = Tilt.new("#{ROOT}/index.slim")
  res.body = template.render
end

trap 'INT' do
  server.shutdown
end

server.start
