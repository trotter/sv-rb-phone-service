require 'rubygems'
require 'sinatra'
require 'builder'

get '/' do
  '<html><head><title>SV.rb Phone Service</title></head><body><h1>Call (650) 318-6254</h1></body></html>'
end

post '/when-is-meeting' do
  xml = Builder::XmlMarkup.new
  xml.Response do |resp|
    resp.Say "Jose Valim Speaks about Rails 3.1 on Thursday September 15th at Carnegie Mellon, Building 23 at NASA"
  end
end
