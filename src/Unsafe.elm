module Unsafe exposing (infiniteLoop, stackOverflow, exception)

{-| Unsafe functions that CRASH when called.


# DO NOT USE!

Really. It's for educational purposes. So go ahead and read the source and meditate on it. Don't use it.


### How to use

OK OK. There is only one legitimate use case: when you have a logical proof that calling a function is impossible.


### Which one to use

Do you have a logical proof? If not, use Maybe.


## Crash!

@docs infiniteLoop, stackOverflow, exception

-}


{-| Go into an infinite loop.

The browser tab will become unresponsive. CPU use will increase, potentially impacting machine usability and battery life.
Because of Tail Call Optimization, the stack will not overflow, instead the browser will show a button to reload the tab after a timeout.

-}
infiniteLoop : a -> b
infiniteLoop x =
    infiniteLoop x


{-| Create a stack overflow which throws a javascript exception.

Briefly uses a lot of CPU and memory so interactivity suffers. You should use `exception` instead.

Throws the following exception:

```text
Internal Error: Too much recursion
```

-}
stackOverflow : a -> b
stackOverflow msg =
    let
        -- Avoid tail call optimization by performing a computation on the result.
        -- The only thing we can do in Elm with a type we know nothing about is compare it for equality.
        _ =
            stackOverflow msg == stackOverflow msg
    in
    stackOverflow msg


{-| Throws a javascript exception immediately.

This is achieved by comparing two functions.

The error is even more cryptic than `stackOverflow`, but the CPU, memory and interactivity are not stressed.

Throws the following exception:

```text
Error: Trying to use `(==)` on functions.
There is no way to know if functions are "the same" in the Elm sense.
Read more about this at https://package.elm-lang.org/packages/elm/core/latest/Basics#== which describes why it is this way and what the better version will look like.
```

-}
exception : a -> b
exception msg =
    let
        _ =
            (\x -> x) == (\x -> x)
    in
    infiniteLoop msg
