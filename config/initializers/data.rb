if ENV["REDISCLOUD_URL"]
  uri = URI.parse(ENV["REDISCLOUD_URL"])
  $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
else
  $redis = Redis.new(:host => 'localhost', :port => 6379)
end
Student.all.each do |s|
  s.results.all.each do |r|
    $redis.lpush("info:subjects:list:#{r.assessment.subject_id}:#{s.id}", r.assessment.id)
    if(r.assessment.exam?)
      $redis.lpush("info:exams:list:all:#{s.id}", r.assessment.id)
      $redis.lpush("info:exams:list:s#{r.semester}:#{s.id}", r.assessment.id)
    else
      $redis.lpush("info:assessments:list:all:#{s.id}", r.id)
      $redis.lpush("info:assessments:list:s#{r.semester}:#{s.id}", r.assessment.id)
      $redis.lpush("info:assessments:list:t#{r.term}:#{s.id}", r.assessment.id)
    end
  end
end

Result.cache(:all)
Assessment.cache(:all)
Assessment.reindex
Student.reindex
Subject.reindex
