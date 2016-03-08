START = [0,0]
FINISH = [7,7]
POSSIBLE_HOPS = [1,2].permutation.to_a + [-1,2].permutation.to_a + [1,-2].permutation.to_a + [-1,-2].permutation.to_a

def dist(p1, p2)
  (p2[0] - p1[0]) + (p2[1] - p1[1])
end

def hop(x, y)
  if x == 7 && y == 7
    puts "I'm there! (#{x}, #{y})"
    return true
  end

  POSSIBLE_HOPS.each do |h|
    nx, ny = x + h.first, y + h.last
    new_dist = dist([nx, ny], FINISH)
    curr_dist = dist([x, y], FINISH)
    if new_dist.abs < curr_dist.abs
      if hop(nx, ny)
        puts h.inspect
        return true
      end
    end
  end

  return false
end

hop(*START)
