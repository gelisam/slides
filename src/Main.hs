-------------------------------------------------------------------------------
-- 2.2.2. Using it to generate programs                                      --
-------------------------------------------------------------------------------
openAiCodex :: Model

-- suggest code completions from code so far
githubCopilot :: [LineOfCode] -> [LineOfCode]

-- gradually create e.g. a web game via natural language commands
codexJavascriptSandbox :: [Text] -> JavaScript

-- generate test cases from the code to be tested
testCode :: [LineOfCode] -> [LineOfCode]

codeTranslator :: JavaScript -> Python

explainCode :: [LineOfCode] -> Text


































type LineOfCode = ()
type Text = ()

type JavaScript = [Float]
type Python = [Float]

type Model = [Float]

openAiCodex = undefined

githubCopilot = undefined
codexJavascriptSandbox = undefined
testCode = undefined
explainCode = undefined
codeTranslator = undefined

main :: IO ()
main = do
  let _openAiCodex = openAiCodex
  let _githubCopilot = githubCopilot
  let _codexJavascriptSandbox = codexJavascriptSandbox
  let _testCode = testCode
  let _explainCode = explainCode
  let _codeTranslator = codeTranslator
  putStrLn "-------------------------"
  putStrLn "--                     --"
  putStrLn "--                     --"
  putStrLn "--     typechecks.     --"
  putStrLn "--                     --"
  putStrLn "--                     --"
  putStrLn "-------------------------"
