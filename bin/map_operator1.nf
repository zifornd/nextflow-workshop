Channel
    .of('hello', 'world')
    .map { it -> it.reverse() }
    .view()