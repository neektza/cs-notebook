#!/usr/bin/env ruby

# Score	5.00 / 5.00

file_path = File.join(File.expand_path(File.dirname(__FILE__)), ARGV[0])
vert_adj_list = File.readlines(file_path).map{|line| line.split.map(&:to_i)}

def deep_copy(o)
  Marshal.load(Marshal.dump(o))
end

$debug = false

$edge_name = :a
def edge_name
  $edge_name
end

def next_edge_name
  $edge_name = $edge_name.succ
end

def construct_graph(adj_vertices)
  graph = { edges: {}, vertices: {} }

  for row in adj_vertices
    graph[:vertices][row[0]] = Array.new
  end

  for row in adj_vertices
    head = row[0]; rest = row[1..-1]
    for vert in rest
      graph[:vertices][head] << edge_name
      graph[:vertices][vert] << edge_name
      graph[:edges][edge_name] = [head, vert]
      adj_vertices[vert-1].delete(head)
      next_edge_name
    end
  end

  graph
end

def pick_edge(graph)
  edges = graph[:edges].keys
  edges[rand(edges.size)]
end

def collapse_edge(graph, edge)
  v1, v2 = graph[:edges][edge]
  puts "contracting e:#{edge} | v:#{v2} to v:#{v1}" if $debug
  puts "all v:#{v2}'s edges #{graph[:vertices][v2]}" if $debug
  for e in graph[:vertices][v2]
    if graph[:edges][e].include?(v1) # it will make a self loop, or it's the edge we're collapsing, remove it
      puts "removing e:#{e} because #{graph[:edges][e]}" if $debug
      graph[:vertices][v1].delete(e)
      graph[:edges].delete(e)
    else # no self loop, just repoint it
      print "repointing e:#{e}:#{graph[:edges][e]} -> " if $debug
      index_v2 = graph[:edges][e].index(v2)
      graph[:edges][e][index_v2] = v1
      puts "#{graph[:edges][e]}" if $debug
      graph[:vertices][v1] << e
    end
  end
  graph[:vertices].delete(v2)
  graph
end

def min_cuts(graph)
  while graph[:vertices].length > 2
    collapse_edge(graph, pick_edge(graph))
  end
  graph
end

graph = construct_graph vert_adj_list
results = []

200.times do
  g = deep_copy(graph)
  res = min_cuts(g)[:edges].count
  puts res
  results << res
end

p "MINIMUM #{results.min}"
