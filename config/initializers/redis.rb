if(Rails.env.development?)
  $redis = Redis.new(:host => 'localhost', :port => 6379)
else
  configure do
      services = JSON.parse(ENV['VCAP_SERVICES'])
      redis_key = services.keys.select { |svc| svc =~ /redis/i }.first
      redis = services[redis_key].first['credentials']
      redis_conf = {:host => redis['hostname'], :port => redis['port'], :password => redis['password']}
      $redis = Redis.new redis_conf
  end
end
