-------------------------------------------------------------------------------
-- 2.2.2. Using it to generate programs                                      --
-------------------------------------------------------------------------------
openAiCodex :: Model

-- suggest code completions from code so far
githubCopilot :: [LineOfCode] -> [LineOfCode]

-- gradually create e.g. a web game via natural language commands
codexJavascriptSandbox :: [Text] -> JavaScript



































type LineOfCode = ()
type Text = ()

type JavaScript = [Float]

type Model = [Float]

openAiCodex = undefined

githubCopilot = undefined
codexJavascriptSandbox = undefined

main :: IO ()
main = do
  let _openAiCodex = openAiCodex
  let _githubCopilot = githubCopilot
  let _codexJavascriptSandbox = codexJavascriptSandbox
  putStrLn "-------------------------"
  putStrLn "--                     --"
  putStrLn "--                     --"
  putStrLn "--     typechecks.     --"
  putStrLn "--                     --"
  putStrLn "--                     --"
  putStrLn "-------------------------"
