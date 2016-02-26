# 100%
# https://codility.com/programmers/task/perm_missing_elem/

def solution(array)
  ((1..array.length+1).to_a - array).first
end
