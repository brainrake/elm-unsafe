module Unsafe exposing (infiniteLoop, stackOverflow, exception)

{-| Unsafe functions that CRASH when called.


# DO NOT USE!

This library is for educational purposes. Feel free to read the source and meditate on it. Don't `elm install` it.


### When to use

There is only one legitimate use case: when you have a logical proof that calling a function is impossible.


### How to use

    Just x |> Maybe.withDefault (infiniteLoop "the impossible happened")


### Which one to use

Do you have a logical proof? If not, use Maybe.

If you do, you can implement an infinite loop yourself, there is no need to install this library.


## Crash!

@docs infiniteLoop, stackOverflow, exception

-}


{-| Go into an infinite loop.

    infiniteLoop : a -> b
    infiniteLoop x =
        infiniteLoop x

The browser tab will become unresponsive. CPU use will increase, potentially impacting machine usability and battery life.
Because of Tail Call Optimization, the stack will not overflow, instead the browser will show a button to reload the tab after a timeout.

-}
infiniteLoop : a -> b
infiniteLoop x =
    infiniteLoop x


{-| Create a stack overflow which throws a javascript exception.

Briefly uses a lot of CPU and memory so interactivity suffers.

You never need this. Use `Maybe.withDefault` or `Debug.todo`.

Throws the following exception:

```text
Internal Error: Too much recursion
```

-}
stackOverflow : a -> b
stackOverflow msg =
    let
        -- Avoid Tail Call Optimization by performing an operation on the result of the recursive call
        aux x =
            aux x + 0

        _ =
            aux 0
    in
    stackOverflow msg


{-| Throws a javascript exception immediately.

This is achieved by comparing two functions.

The error is even more cryptic than `stackOverflow`, but the CPU, memory and interactivity are not stressed.

You never need this. Use `Maybe.withDefault` or `Debug.todo` and see `Unsafe.infiniteLoop`.

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
