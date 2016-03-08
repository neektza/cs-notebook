# painless | 100%
# https://codility.com/programmers/task/frog_river_one/

require 'set'

def solution(pos, array)
  path = Set.new []; time = -1

  array.each_with_index do |el, i|
    path.add(el);

    if path.size == pos
      time = i
      break
    end
  end

  time
end

p solution 5, [3]
p solution 2, [1, 1, 1, 1]
p solution 5, [1,3,1,4,2,3,5,4]
p solution 5, [1,3,1,2,3,5,4,4]
