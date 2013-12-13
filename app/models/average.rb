class Average < ActiveRecord::Base
	belongs_to :student

	def overall
		total = 0
		count = 0 
		metrics = [self.t1, self.t2, self.t3, self.t4, self.exam_s1, self.exam_s2]
		metrics.each do |val|
			next unless val != 0 && val != nil
			count += 1
			total += val
		end
		return (total / count).round(2)
	end
end
