
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


def normalizeSet(
  strings: Set[String], partialMatch: Boolean
): Future[Set[String]] =
  Future.sequence(
    strings.map { str =>
      normalizeString(str, partialMatch)
    }
  )
 
def normalizeHelper(
  strings: Set[String]
): Future[Set[String]] =
  normalizeSet(strings, false)




































































































