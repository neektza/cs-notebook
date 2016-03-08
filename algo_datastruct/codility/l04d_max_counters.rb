# respectable | 100% 88% sam, 100% s gledanjem
# https://codility.com/programmers/task/max_counters/

def solution(n, a)
  counters = Array.new(n, 0)
  running_max = 0; counter_max = 0

  for idx in a
    if idx < 0 || idx > n+1
      next
    elsif idx == n+1
      counter_max = running_max
    else
      counters[idx-1] = counter_max if counter_max > counters[idx-1]
      counters[idx-1] += 1
      running_max = counters[idx-1] if counters[idx-1] > running_max
    end
  end

  counters.each_with_index do |el, i|
    counters[i] = counter_max if el < counter_max
  end

  counters
end

p solution(5, [3,4,4,6,1,4,4])
p solution(n = 15, Array.new(n) { rand(1...(n+1)) })
