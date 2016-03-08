#!/usr/bin/env ruby

# Score0.00 / 5.00

file_path = File.join(File.expand_path(File.dirname(__FILE__)), ARGV[0])

def deep_copy(o)
  Marshal.load(Marshal.dump(o))
end

class Array
  def rjust(n, x); Array.new([0, n-length].max, x)+self end
  def ljust(n, x); dup.fill(x, length...n) end
end

class Graph
  attr_accessor :edges, :verts
  def initialize
    @edges = Hash.new
    @verts = Hash.new
  end
end

$debug = false

# Grap construction
# =================

def construct_graph(file_path)
  g = Graph.new

  e_iter = :a; cnt = 0; step = 100000
  File.readlines(file_path).each do |line|
    v1, v2 = line.strip.split.map(&:to_i); cnt += 1
    g.edges[e_iter] = [v1, v2]

    if g.verts[v1]
      g.verts[v1] << e_iter
    else
      g.verts[v1] = [false, false, e_iter]
    end

    if g.verts[v2]
      g.verts[v2] << e_iter
    else
      g.verts[v2] = [false, false, e_iter]
    end

    puts "#{cnt} lines read" if (cnt%step==0)
    e_iter = e_iter.succ
  end

  return g
end


# Helpers
# =======

def explored_vert?(vertice, pass)
  if pass == :fst
    vertice[0]
  else
    vertice[1]
  end
end

def mark_explored!(vertice, pass)
  if pass == :fst
    vertice[0] = true
  else
    vertice[1] = true
  end
end

def edges_of(vertice)
  vertice[2..-1]
end

# Main
# ====

def dfs_iter(g, i, pass)
  idx = (pass == :fst) ? 1 : 0;
  acc = []

  mark_explored!(g.verts[i], pass)
  s = []; s.push(i); v = i;
  while s.length > 0
    for edge in edges_of(g.verts[v])
      w = g.edges[edge][idx]
      if !explored_vert?(g.verts[w], pass)
        mark_explored!(g.verts[w], pass)
        s.push w
      end
    end
    v = s.pop
    acc.push(v)
  end

  return acc
end

def dfs_loop(g, pass, order)
  if pass == :fst
    g.verts.length.downto(1) do |v|
      if !explored_vert?(g.verts[v], pass)
        order += dfs_iter(g, v, pass)
      end
    end
    return order

  else
    sccs = []
    order.length.downto(1) do |i|
      v = order[i-1]
      if !explored_vert?(g.verts[v], pass)
        sccs << dfs_iter(g, v, pass)
      end
    end
    return sccs
  end
end

read = Time.now
g = construct_graph(file_path)
puts "File read in #{Time.now-read}"
puts g

order = dfs_loop(g, :fst, [])
sccs = dfs_loop(g, :snd, order).map!(&:length).sort!.reverse!.first(5).ljust(5, 0).join(',')

p sccs
