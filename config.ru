require 'rack'
require_relative 'app/app'

app = Rack::Builder.new do
  use Rack::ConditionalGet
  use Rack::ETag
  use Rack::Deflater
  use Rack::Static,
      root: 'public',
      urls: ['/css', '/favicon.ico', '/404.html'],
      headers_rules: [
        [%w[html], { 'content-type' => 'text/html; charset=utf-8' }],
        [:all, { 'cache-control' => 'public, max-age=31536000' }]
      ]
  run App.new
end

run app
