# painless | 100%
# https://codility.com/programmers/task/odd_occurrences_in_array/

def solution(a)
  counters = Hash.new(0)
  ret = nil

  a.each do |e|
    counters[e] += 1
  end

  counters.each do |k,v|
    ret = k if v.odd?
  end

  ret
end
