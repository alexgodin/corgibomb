require 'sinatra'
require 'aws/s3'
require 'json'

include AWS::S3

get '/bomb/:count' do |count|
  corgis = all_corgis

  number_of_pictures_to_return = [corgis.count, count.to_i].min

  random_corgis = corgis.shuffle![1..number_of_pictures_to_return]

  random_corgis.map(&:url).to_json
end

get '/random' do
  all_corgis.sample.url
end

private

def connect_to_s3
  Base.establish_connection!(
    :access_key_id     => '',
    :secret_access_key => ''
  )
end

def all_corgis
  connect_to_s3
  Bucket.objects('Corgi')
end
