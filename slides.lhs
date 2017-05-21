Binary codecs

> data Codec a { encode :: a -> ByteString
>              , decode :: ByteString -> Maybe a
>              }

> utf8CharCodec :: Codec Char

> utf16CharCodec :: Codec Char

> -- [...]
> -- If there are two different ways of doing something, PSD will do both, in
> -- different places. It will then make up three more ways no sane human would
> -- think of, and do those too. PSD makes inconsistency an art form.
> -- [...]
> -- PSD is not my favourite file format.
> psdCodec :: Codec
> psdCodec = ... utf8CharCodec ... utf16CharCodec
>            ... weirdCharCodec1 ... weirdCharCodec2 ... weirdCharCodec3
>   where
>     weirdCharCodec1, weirdCharCodec2, weirdCharCodec3 :: Codec Char
>     weirdCharCodec1 = ...
>     weirdCharCodec2 = ...
>     weirdCharCodec3 = ...















































































































                   Combinator libraries

          Benefits                      Costs

        * Shorter                     * Need some up-front design to find
          (work hidden in combinators)  the proper primitives and combinators
        * More self-documenting
          (intermediate names)
        * Fewer mistakes
          (each system is consistent)








































































































