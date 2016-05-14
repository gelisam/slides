
def normalizeString(
  string: String, partialMatch: Boolean
): Future[String] =
  normalizer.results.normalizeFromCorpus(datasetId, string, partialMatch)

def normalizeList(
  strings: List[String], partialMatch: Boolean
): Future[List[String]] =
  Future.sequence(
    strings.map { str =>
      normalizeString(str, partialMatch)
    }
  )
 
def normalizeHelper(
  strings: List[String]
): Future[List[String]] =
  normalizeList(strings, false)




































































































