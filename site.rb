require 'rubygems'
require 'bundler/setup'
require 'tilt'
require 'erb'
require 'webrick'
require 'yaml'

ROOT = File.dirname(__FILE__)

PORT = ENV["PORT"] || 8000

server = WEBrick::HTTPServer.new(:Port => PORT)

server.mount '/assets', WEBrick::HTTPServlet::FileHandler, "#{ROOT}/public"

server.mount_proc '/' do |req, res|
  data = YAML.load_file('data.yml')
  template = Tilt.new("#{ROOT}/index.slim")
  res.body = template.render({:data => data})
end

trap 'INT' do
  server.shutdown
end

server.start
