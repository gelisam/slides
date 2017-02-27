
data Start
data Ready
data Waiting

data Protocol a b
handshake  ::            Protocol Start   Ready
send       :: Message -> Protocol Ready   Waiting
waitForAck ::            Protocol Waiting Ready
disconnect ::            Protocol a       Start






















data Message
handshake  = undefined
send       = undefined
waitForAck = undefined
disconnect = undefined







































main :: IO ()
main = putStrLn "done."
