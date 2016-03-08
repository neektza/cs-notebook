# painless | 100%
# https://codility.com/programmers/task/tape_equilibrium/

def solution(array)
  left_chunk = array[0..0]
  right_chunk = array[1..-1]
  lsum = left_chunk.reduce(:+)
  rsum = right_chunk.reduce(:+)
  diff = (rsum - lsum).abs
  min = diff

  1.upto(array.length-2).each do |p|
    lsum += array[p]
    rsum -= array[p]
    diff = (rsum - lsum).abs
    min = diff if diff < min
  end

  min
end
