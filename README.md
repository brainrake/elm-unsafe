# DANGER! DO NOT USE!

## The functions in this module WILL CRASH YOUR APP. Do not use them!

## YOU NEVER NEED THIS PACKAGE. DO NOT INSTALL IT! Use `Maybe.withDefault`!

Really. It's for reading, not installing.

## WAT?

These are functions that crash your app in the various ways possible in Elm. They also return an arbitrary type, creating it out of nothing, at least as far as the type system is concerned. Not really, because they crash.

## Why?

Education. Fun. Some serious stuff.

## ... but ... WHY???

There is only one legitimate use, when all of the following are true:

- You have a logical proof that a crashing function will not be called
- AND there is no way to express it in the type system
- AND you can't use `Maybe.withDefault` becuse the type is abstract (like `Maybe a`, unlike `Maybe Int`).

This happens when you are writing a library, and some of the exported types have type parameters and guarantee some invariants that can not be expressed in the type system. Smart constructors are used and regular constructors are not exposed to avoid breaking invariants.

## How?

The goal is to return a value of arbitrary type, which could be anything at all, which is normally impossible because we know nothing about it and we don't already have one.

This beautiful recursive function does the job, convincing the type system that it can return anything we wish for, if we only give it something it knows nothing about:

```elm
infiniteLoop : a -> b
infiniteLoop x =
    infiniteLoop x
```

The other functions `stackOverflow` and `exception` all use this function to return an arbitrary type, but crash in various ways before looping. Why crash if they will never be called? Good point. Maybe as a demonstration of **what not to do**.

# DO NOT USE!

You never actually need this library. DO NOT `elm install` it!

## How to use

```elm
x |> Maybe.withDefault (infiniteLoop ())
```

## Which one to use

Do you need to return an abstract type? If not, use `Maybe.withDefault`.

Do you have a logical proof that the function is impossible to call? If not, use `Maybe`.

So if the function will never be called, does it matter which one you use? Not really. `infiniteLoop` is the cleanest though. You could just implement it yourself, maybe in a `let`, no need to add a dependency.

Read more about the functions in the [module documentation](Unsafe)

## Why have `exception` if it is never called?

You can use `exception` instead of `infiniteLoop` while developing your library to avoid freezing the browser tab and instead throwing an exception immediately. Make sure to prove correctness before publishing.

## Why `stackOverflow` ?

It's a stepping stone to `exception` and I wanted to catalog all the ways to crash.
