
data Start
data Ready
data Waiting

data Protocol a b
handshake  ::            Protocol Start   Ready
send       :: Message -> Protocol Ready   Waiting
waitForAck ::            Protocol Waiting Ready
disconnect ::            Protocol a       Start
multiplex  ::            Protocol a       (a, Start)

doubleSend :: Message -> Protocol (Ready, Ready) (Waiting, Ready)
              -- (Ready, Ready)
doubleSend msg = first (send msg)
              -- (Waiting, Ready)
             >>> arr (\(_,r) -> (r,r))
              -- (Ready, Ready)
             >>> first (send msg)



















data Message
handshake  = undefined
send       = undefined
waitForAck = undefined
disconnect = undefined
multiplex  = undefined

(>>>) :: Protocol a b -> Protocol b c -> Protocol a c
(>>>) = undefined

arr :: (a -> b) -> Protocol a b
arr = undefined

first :: Protocol a b -> Protocol (a,r) (b,r)
first = undefined






































main :: IO ()
main = putStrLn "done."
