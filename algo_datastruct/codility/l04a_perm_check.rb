# 100%
# https://codility.com/programmers/task/perm_check/

def solution(a)
  len = a.uniq.length
  a.reduce(:+) == (len*(len+1)/2) ? 1 : 0
end

p solution [5,3,2,4,1]
p solution [1]
p solution [0]
