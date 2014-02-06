if ENV["REDISCLOUD_URL"]
  uri = URI.parse(ENV["REDISCLOUD_URL"])
  $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
else
  $redis = Redis.new(:host => 'localhost', :port => 6379)
end

Assessment.all.each do |a|
  $redis.lpush("info:subjects:list:#{a.subject_id}", a.id)
  if(a.exam?)
    $redis.lpush("info:exams:list:all", a.id)
    $redis.lpush("info:exams:list:s#{a.semester}", a.id)
  else
    $redis.lpush("info:assessments:list:all", a.id)
    $redis.lpush("info:assessments:list:s#{a.semester}", a.id)
    $redis.lpush("info:assessments:list:t#{a.term}", a.id)
  end
end

Result.cache(:all)
Assessment.cache(:all)
Assessment.reindex
Student.reindex
Subject.reindex
