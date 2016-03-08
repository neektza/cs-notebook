#!/usr/bin/env ruby

# Score 0/5

$file_path = File.join(File.expand_path(File.dirname(__FILE__)), ARGV[0])
$debug = false

def pptree(heap, lvl=0)
  return nil if 2**lvl >= heap.length
  fst = 2**lvl-1; lst = fst+(2**lvl)-1
  p "LVL#{lvl}: #{heap[fst..lst]}"
  pptree(heap, lvl+1)
end

def swap(heap, i1, i2)
  heap[i1], heap[i2] = heap[i2], heap[i1]
end

def bubble_up(heap, idx, op)
  if !op.call(heap[idx/2], heap[idx]) #heap property not yet restored
    swap(heap, idx, idx/2)
    bubble_up(heap, idx/2, op)
  end
end

def push_down(heap, idx, op)
  # TODO
end

def root(heap)
  heap[0]
end

def empty?(heap)
  heap.length == 0
end

def insert(heap, el, op)
  # p heap
  heap << el
  eidx = heap.length-1
  # p "c: #{heap[eidx]}, p: #{heap[eidx/2]}"
  # p op.call(heap[eidx], heap[eidx/2])
  if heap.length == 1
    return
  elsif !op.call(heap[eidx/2], heap[eidx])
    bubble_up(heap, eidx, op)
  end
end

max_op = lambda {|x,y| x >= y}
min_op = lambda {|x,y| x <= y}

low_heap = []
high_heap = []

File.readlines($file_path).each do |line|
  nmb = line.to_i

  if empty?(low_heap) || nmb < root(low_heap)
    insert(low_heap, nmb, max_op)

  elsif empty?(high_heap) || nmb > root(high_heap)
    insert(high_heap, nmb, min_op)

  end
end

p "LOW"
pptree(low_heap)

p "HIGH"
pptree(high_heap)
