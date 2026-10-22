#let max-iter-count = 25

#let layout-limiter(document, max-iterations: auto) = context {
  let max-iterations = if max-iterations == auto {
    int(sys.inputs.at("max-layout-iterations", default: max-iter-count))
  } else {
    max-iterations
  }
  assert(max-iterations <= max-iter-count, message: "max-iterations must be <= " + str(max-iter-count))
  let iters = counter("__layout-ltd-iterations")
  if iters.final().first() != max-iter-count - max-iterations {
    iters.update(iters.final().first() + 1)
  } else {
    iters.update(max-iter-count - max-iterations)
    document
  }
}
