class Assessment < ActiveRecord::Base
  has_many :results
  has_one :type
end
