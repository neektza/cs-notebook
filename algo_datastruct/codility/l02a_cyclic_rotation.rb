# painless | 100%
# https://codility.com/programmers/task/cyclic_rotation/

def solution(a, k)
  ret = []; len = a.length

  if len > 0
    a.each_with_index do |e, i|
      if i + k < len
        ret[i+k] = e
      elsif i + k >= len
        ret[(i+k) % (len)] = e
      end
    end
  end

  ret
end
