#!/usr/bin/env ruby

# Score 5.00 / 5.00

file_path = File.join(File.expand_path(File.dirname(__FILE__)), ARGV[0])
integer_array = File.readlines(file_path).map{|line| line.strip}.map {|n| n.to_i}

$how = ARGV[1]
$nmb_of_comparisons = 0;

def median(choices)
  n = choices.length
  if n > 2
    m = n.even? ? n/2-1 : n/2
    pickfrom = choices.sort
    return pickfrom[m]
  else
    return choices[0]
  end
end


def choose_and_place_pivot(a, l, r, how)
  if how == 'leftmost'
    idx = l
  elsif how == 'rightmost'
    idx = r
  elsif how == 'median'
    n = r-l+1; m = n.even? ? l+n/2-1 : l+n/2
    med = median([a[l], a[m], a[r]])
    if a[l] == med
      idx = l
    elsif a[m] == med
      idx = m
    elsif a[r] == med
      idx = r
    end
  elsif how == 'random'
    idx = l + rand(r-l+1)
  elsif how == 'sample'
    # TODO
  end
  a[l], a[idx] = a[idx], a[l]
end

def partition(a, l, r)
  pivot = a[l]; i = l+1; n = r-l+1;
  $nmb_of_comparisons += n-1

  for j in (l+1..r)
    if a[j] < pivot
      a[i], a[j] = a[j], a[i]
      i+=1
    end
  end

  # Swap pivot with rightmost element less than pivot
  a[l], a[i-1] = a[i-1], a[l]
  return i-1
end

def sort_and_count_comparisons(a, l, r)
  return if a.length == 1
  return if l >= r

  choose_and_place_pivot(a, l, r, $how)
  pi = partition(a, l, r)
  sort_and_count_comparisons(a, l, pi-1)
  sort_and_count_comparisons(a, pi+1, r)

  return a
end

# Sorts in place : space = O(n)
sort_and_count_comparisons(integer_array, 0, integer_array.length-1)

puts integer_array
puts
puts $nmb_of_comparisons
