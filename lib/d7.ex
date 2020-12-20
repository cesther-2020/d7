defmodule D7 do
  # vibrant lime bags contain 1 dotted turquoise bag, 5 dotted magenta bags, 5 light black bags.
  # faded blue bags contain no other bags.
  def d7() do
    parsed_file =
      File.stream!("input.txt")
      |> Stream.map(&String.replace(&1, [".", "\n", "bags", "bag"], ""))
      |> Stream.map(&String.split(&1, "contain"))
      |> Stream.map(&create_record(&1))
      |> Enum.take(600)

    graph = create_graph(parsed_file)
    IO.inspect(graph)
  end

  def create_record([vert, edgestr]) do
    edges =
      edgestr
      |> String.split(",")
      |> Enum.map(&String.trim(&1, " "))
      |> Enum.reject(fn x -> x == "no other" end)
      |> Enum.map(&create_edge(&1))

    IO.inspect(edges)

    {vert, edges}
  end

  def create_edge(edgelst) do
    edgelst
    |> IO.inspect()
    |> String.split(" ")
    |> IO.inspect()
    |> Enum.map(fn [h | t] -> {Enum.join("_"), h} end)
  end

  def create_graph(record_list) do
    verts =
      record_list
      |> Enum.map(fn {x, lst} -> x end)
      |> Enum.map(&String.trim(&1, " "))
      |> Enum.map(&String.replace(&1, [" "], "_"))
      |> Enum.map(&String.to_atom(&1))

    edges =
      Graph.new()
      |> create_verts(verts)

    # |> create_edges(record_list)
  end

  def create_verts(graph_id, vlist) do
    Graph.add_vertices(graph_id, vlist)
  end
end
