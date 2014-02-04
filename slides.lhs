Type-level natural
---

Should `head` return a more precise type?

> :t safeHead
safeHead :: List a -> Maybe a


...or request a more precise argument?

> :t preciseHead
preciseHead :: List a (n + 1) -> a
