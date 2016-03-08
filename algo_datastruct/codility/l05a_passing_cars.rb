# painless | 100 %
# https://codility.com/programmers/task/passing_cars/

# Smisleno rjesenje
OP_DIR = { 0 => 1, 1 => 0 }
def solution_b(a)
  passed_ew = [0, 0]
  total = 0

  a.each_with_index do |direction, car|
    passed_ew[direction] += 1
    total += passed_ew[OP_DIR[direction]]
    return -1 if total > 1_000_000 
  end

  total
end

# Tocno rjesenje
def solution(a)
  a.shift if a == 1

  p = a.first
  pqs = 0
  total = 0

  a.each_with_index do |direction, car|
    if direction == 0
      p = car 
      pqs += 1
    end

    q = car if direction == 1

    if p && q && p <= q
      total += pqs
    end

    return -1 if total > 1_000_000_000
  end

  total
end


p solution([0,0])
p solution([1,1])
p solution([0,1])
p solution([1,0])
p solution([0,1,0,1,1])
p solution([0,1,0,1,1,0,0,0,1,0])


# A[0] = 0
# A[1] = 1
# A[2] = 0
# A[3] = 1
# A[4] = 1
# 
# P0: 01, 03, 04
# P2: 23, 24

# A[0] = 0
# A[1] = 1
# A[2] = 0
# A[3] = 1
# A[4] = 1
# A[5] = 0
# A[6] = 0
# A[7] = 0
# A[8] = 1
# A[9] = 0

# P0: Q1, Q3, Q4, Q8              | 4
# P2: Q3, Q4, Q8                  | 3
# P5: Q8                          | 1
# P6: Q8                          | 1
# P7: Q8                          | 1
# P9:                             | 0
# -------------------------------------
#                                  | 10
