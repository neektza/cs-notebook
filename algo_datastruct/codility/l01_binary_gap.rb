# 100%
# https://codility.com/programmers/task/binary_gap/

def solution(n)
  n_str = n.to_s(2)

  l = n_str.index('1')
  r = n_str.rindex('1')

  n_str_bounded = n_str[l..r]
  slices = n_str_bounded.split('1')

  (slices.length > 0) ?  slices.max.length : 0
end
