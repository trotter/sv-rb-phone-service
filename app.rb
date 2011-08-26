require 'rubygems'
require 'sinatra'
require 'builder'
require 'nokogiri'
require 'open-uri'

RSS_FEED = "http://www.meetup.com/silicon-valley-ruby/events/rss/Silicon+Valley+Ruby+Meetup/"

get '/' do
  '<html><head><title>SV.rb Phone Service</title></head><body><h1>Call (650) 318-6254</h1></body></html>'
end

post '/when-is-meeting' do
  xml = Builder::XmlMarkup.new
  xml.Response do |resp|
    rss = Nokogiri::XML(open(RSS_FEED))
    event_url = rss.xpath('//guid').first.text
    html = Nokogiri::HTML(open(event_url))

    about_event = html.xpath('//h1[@itemprop="summary"]').text
    about_event << " on "
    about_event << html.xpath('//p[@class="headline"]').text.gsub("\n", " ")
    about_event << " at "
    about_event << html.xpath('//div[@id="event-where-display"]/span[@itemprop="locality"]').text.gsub("\n", " ")

    resp.Say about_event
  end
end
