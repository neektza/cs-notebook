#!/usr/bin/env ruby

# Score 5.00 / 5.00

file_path = File.join(File.expand_path(File.dirname(__FILE__)), ARGV[0])
integer_array = File.readlines(file_path).map{|line| line.strip}.map {|n| n.to_i}

def split_array(a, which_part = :both)
  n = a.length

  if n.odd?
    limit = n/2 + 1;
  else
    limit = n/2
  end
  
  if which_part == :left
    return a[0..limit-1]
  elsif which_part == :right
    return a[limit..n-1]
  else
    return [a[0..limit-1], a[limit..n-1]]
  end
end

def merge_and_count_split_inversions(left_half, right_half)
  inv_cnt = 0; merged_array = []
  nl = left_half.length; nr = right_half.length; n = nl + nr;
  i = 0; j = 0;

  while merged_array.length < n
    if i <= nl-1 and j <= nr-1
      if left_half[i] <= right_half[j]
        merged_array << left_half[i]; i += 1
      else
        merged_array << right_half[j]; j += 1
        inv_cnt += left_half[i..nl-1].length
      end
    elsif i == nl and j <= nr-1
      merged_array += right_half[j..nr-1]
    elsif j == nr and i <= nl-1
      merged_array += left_half[i..nl-1]
    end
  end
  
  return [merged_array, inv_cnt]
end

def sort_and_count_inversions(a)
  return [a, 0] if a.length == 1
  
  left_half, right_half = split_array(a, :both)
  sorted_left_half, left_count = sort_and_count_inversions(left_half)
  sorted_right_half, right_count = sort_and_count_inversions(right_half)
  sorted_whole, split_count = merge_and_count_split_inversions(sorted_left_half, sorted_right_half)

  return [sorted_whole, left_count + right_count + split_count]
end

sorted, cnt = sort_and_count_inversions(integer_array)

puts sorted
puts
puts cnt
