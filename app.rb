require 'sinatra'
require 'aws/s3'
require 'json'

include AWS::S3

get '/bomb/:count' do |count|
  connect_to_s3
  corgis = Bucket.objects('Corgi')
  randomcorgis = corgis.shuffle![1..[corgis.count,count.to_i].min]
  corgi_urls = randomcorgis.map {|corgi| corgi.url}
  corgi_urls.to_json
end

get '/random' do
  connect_to_s3
  corgis = Bucket.objects('Corgi')
  randomcorgis = corgis[rand(corgis.count)].url
end

private

def connect_to_s3
  Base.establish_connection!(
    :access_key_id     => '',
    :secret_access_key => ''
  )
end
