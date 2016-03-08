#!/usr/bin/env ruby

# Score 0/5

file_path = File.join(File.expand_path(File.dirname(__FILE__)), ARGV[0])
integer_array = File.readlines(file_path).map{|line| line.strip}.map {|n| n.to_i}

$debug = false
$cnt = 0
$found = {} 

def add_to_bucket(buckets, elem, hashing_fn)
  bidx = hashing_fn.call(elem)
  if buckets[bidx]
    buckets[bidx] << elem
  else
    buckets[bidx] = [elem]
  end
  p "#{bidx}: #{buckets[bidx]}" if $debug
end

def construct(xs, hfn)
  buckets = Hash.new

  for x in xs
    add_to_bucket(buckets, x, hfn)
  end

  return buckets
end

def in_range(sum)
  sum < 10000 && sum > -10000
end

def not_found(sum)
  $found[sum].eql? false
end

def doall(sum)
  if in_range(sum) && not_found(sum)
    $cnt+=1
    $found[sum] = true
  end
end


def two_sum(xs, buckets, hfn)

  for x in -10000..10000
    $found[x] = false
  end

  for x in xs 
    l = hfn.call(-x-10000)
    h = hfn.call(-x+10000)
    buckets[l].each {|y| doall(x+y)} if buckets[l]
    buckets[h].each {|y| doall(x+y)} if buckets[h]
    buckets[l+1].each {|y| doall(x+y)} if buckets[l+1] && !(l+1==h)
  end

  return $cnt
end

h0 = lambda {|x| x}
h1 = lambda {|x| x / 10000}
h2 = lambda {|x| x / 10}

buckets = construct(integer_array, h1)
cnt = two_sum(integer_array, buckets, h1)
p cnt
p $found
