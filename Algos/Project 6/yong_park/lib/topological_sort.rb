require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  inner_counts = {}
  queue = []
  vertices.each do |v|
    inner_counts[v] = v.in_edges.count
    queue << v if v.in_edges.empty?
  end
  sorted_vertices = []
  until queue.empty?
    vertex = queue.shift
    sorted_vertices << vertex
    vertex.out_edges.each do |e|
      to_vertex = e.to_vertex
      inner_counts[to_vertex] -= 1
      queue << to_vertex if inner_counts[to_vertex] == 0
    end
  end
  sorted_vertices
end
