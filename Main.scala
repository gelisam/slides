
def normalizeString(
  string: String, partialMatch: Boolean
): Future[String] =
  normalizer.results.normalizeFromCorpus(datasetId, string, partialMatch)
 
def normalizeMany[M[X] <: TraversableLike[X, M[X]]](
  strings: M[String],
  partialMatch: Boolean
)(implicit
  cbfa: CanBuildFrom[M[String], Future[String], M[Future[String]]],
  cbfb: CanBuildFrom[M[Future[String]], String, M[String]]
)
: Future[M[String]] =
  Future.sequence(
    strings.map { str =>
      normalizeString(str, partialMatch)
    }
  )
 
def normalizeHelper[M[X] <: TraversableLike[X, M[X]]](
  strings: M[String]
)(implicit
  cbfa: CanBuildFrom[M[String], Future[String], M[Future[String]]],
  cbfb: CanBuildFrom[M[Future[String]], String, M[String]]
)
: Future[M[String]] =
  normalizeList(strings, false)




































































































