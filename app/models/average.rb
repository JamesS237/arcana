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
			averages = []
			Average.where(:overall => true).each do |avg|
				averages.push({:id => avg.student_id, :average => avg.overall})
			end
			averages = averages.sort{|a,b| b[:average] <=> a[:average]}
			count = 1
			averages.each do |a|
				break if a[:id] = self.student.id
				count += 1
			end
		when 'assessment'
			averages = []
			Average.where(:overall => true).each do |avg|
				averages.push({:id => avg.student_id, :average => avg.overall_assessment})
			end
			averages = averages.sort{|a,b| b[:average] <=> a[:average]}
			count = 1
			averages.each do |a|
				break if a[:id] = self.student.id
				count += 1
			end
		when 'exam'
			averages = []
			Average.where(:overall => true).each do |avg|
				averages.push({:id => avg.student_id, :average => avg.overall_exam})
			end
			averages = averages.sort{|a,b| b[:average] <=> a[:average]}
			count = 1
			averages.each do |a|
				break if a[:id] = self.student.id
				count += 1
			end
		when 'subject'
			averages = []
			Average.where(:subject_id => self.subject_id).each do |avg|
				averages.push({:id => avg.student_id, :average => avg.overall})
			end
			averages = averages.sort{|a,b| b[:average] <=> a[:average]}
			count = 1
			averages.each do |a|
				break if a[:id] = self.student.id
				count += 1
			end
		end
		return count.ordinalize
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
