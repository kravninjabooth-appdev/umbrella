p "Where are you located?"

user_location = gets.chomp

#user_location = "Memphis"

p user_location

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=AIzaSyAgRzRHJZf-uoevSnYDTf08or8QFS_fb3U"

p gmaps_url

require "open-uri"

raw_data =  URI.open(gmaps_url).read

#p raw_data.length

require "json"

parsed_data = JSON.parse(raw_data)

#p parsed_data.keys

results_array = parsed_data.fetch("results")

first_result = results_array.at(0)

geo = first_result.fetch("geometry")

loc = geo.fetch("location")

latitude = loc.fetch("lat")
longitude = loc.fetch("lng")

p latitude
p longitude
# Use the coords from Gmaps to compose the right 
# Dark Sky endpoint URL
# Read it, parse it, and print the current temp
user_latitude = latitude
user_longitude = longitude
dark_sky_key = ENV.fetch("DARK_SKY_KEY")
darksky_url = "https://api.darksky.net/forecast/#{dark_sky_key}/#{user_latitude},#{user_longitude}"

raw_data_ds =  URI.open(darksky_url).read
parsed_data_ds = JSON.parse(raw_data_ds)
results_array_ds = parsed_data_ds.fetch("currently")
temp = results_array_ds.fetch("temperature")
p temp
