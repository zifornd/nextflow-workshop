left = Channel.of(['A', 1], ['B', 2], ['A', 3])
right = Channel.of(['B', 'x'], ['B', 'y'], ['A', 'z'], ['A', 'w'])

left
    .combine(right, by: 0)
    .view()