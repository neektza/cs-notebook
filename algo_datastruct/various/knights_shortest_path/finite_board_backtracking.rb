START = [0,0]
FINISH = [7,7]
POSSIBLE_HOPS = [1,2].permutation.to_a + [-1,2].permutation.to_a + [1,-2].permutation.to_a + [-1,-2].permutation.to_a

def memoize(memo, pos, h)
  memo[pos] = [] unless memo[pos]
  memo[pos].push(h)
end

def memoized?(memo, pos, h)
  memo[pos] && memo[pos].include?(h)
end

def hop(x, y, memo)
  if x < 0 || x >= 7 || y < 0 || y >= 7
    if x == 7 && y == 7
      puts "I'm there! (#{x},#{y})"
      return true
    end
    return false
  else
    POSSIBLE_HOPS.each do |h|
      nx, ny = x + h[0], y + h[1]

      if memoized?(memo, [x,y], h)
        return false
      else
        if hop(nx, ny, memo)
          p h
          return true 
        end
        memoize(memo, [x, y], h)
      end
    end
    return false
  end
end

hop(*START, memo = {})
