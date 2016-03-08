# painless | 100%
# https://codility.com/programmers/task/missing_integer/

require 'set'

def solution(a)
  seen = a.to_set # Faster contains checks
  missing = 1

  1.upto(seen.size + 1) do |i|
    if !seen.include?(i)
      missing = i
      break
    end
  end

  missing
end

p solution [-1]
p solution [1]
p solution [1, 3, 6, 4, 1, 2] 
