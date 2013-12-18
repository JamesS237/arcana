class Average < ActiveRecord::Base
	belongs_to :student

	def overall
		total = 0
		count = 0 
		metrics = [self.t1, self.t2, self.t3, self.t4, self.exams_s1, self.exams_s2]
		metrics.each do |val|
			next unless val != 0 && val != nil
			count += 1
			total += val
		end
		count = 1 unless count != 0
		return (total / count).round(2)
	end

	def rank(type)
		case(type)
		when 'overall'
			Average.where(:overall => true).each do |avg|
				
			end
		when 'assessment'
		when 'exam'
		when 'subject'
		end
	end

	def overall_assessment
		total = 0
		count = 0 
		metrics = [self.t1, self.t2, self.t3, self.t4]
		metrics.each do |val|
			next unless val != 0 && val != nil
			count += 1
			total += val
		end
		count = 1 unless count != 0
		return (total / count).round(2)
	end

	def overall_exam
		total = 0
		count = 0 
		metrics = [self.exams_s1, self.exams_s2]
		metrics.each do |val|
			next unless val != 0 && val != nil
			count += 1
			total += val
		end
		count = 1 unless count != 0
		return (total / count).round(2)
	end


end
