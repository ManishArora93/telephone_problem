s = "00:01:07,400-234-090\n00:05:01,701-080-080\n00:01:00,400-234-090\n00:05:01,701-080-081\n00:03:01,701-080-083\n00:03:01,701-080-083"

def solution(s)
  # write your code in Ruby 2.2
  if s.length > 0
    new_call_logs =  s.split("\n").collect{ |aa| aa.split(',')}.group_by{|time_number| [time_number[1]]}.map{|aa, dd| {aa[0] => dd.collect {|ind| ind[0]}}}
    number_with_longest_duration = {phone_number: 0}
    new_call_logs.each do |number|
      total_duration = 0
      number.values.each do |t|        
        t.each do |y|
          total_duration+= y.split(':').map { |a| a.to_i }.inject(0) { |a, b| a * 60 + b}
        end
      end
      if total_duration > number_with_longest_duration.values[0]
        number_with_longest_duration = {}
        number_with_longest_duration[number] = total_duration
      elsif total_duration == number_with_longest_duration.values[0]
        if number.keys[0].gsub('-', '').to_i < number_with_longest_duration.keys[0].keys[0].gsub('-', '').to_i
          number_with_longest_duration = {}
          number_with_longest_duration[number] = total_duration
        end
      end
    end
    new_call_logs.delete(number_with_longest_duration.keys[0])
    total_cost = 0
    new_call_logs.each do |key|
      key.values.each do |t|
        t.each do |x|
          time_value = x.split(':').map { |a| a.to_i }.inject(0) { |a, b| a * 60 + b}
          if  time_value >= 300
            time_value_in_minutes = (time_value/60.0).ceil
            total_cost += time_value_in_minutes*150
          else
            total_cost += time_value*3
          end
        end
      end
    end
    return total_cost
  else
    return 0
  end
end