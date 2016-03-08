# painless | 100% 100%
# https://codility.com/programmers/task/count_div/

def solution(a,b,k)
  offset = (a % k == 0) ? 1 : 0
  b/k - a/k + offset
end
