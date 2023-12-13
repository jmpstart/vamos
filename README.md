![Vamos](./.vamos/image/vamos-a-la-playa.jpg)

# Vamos

Can we download a repository from git hub and setup a playground in a similar
simple manner as we are used from installing a smartphone app?

```
    Let's go, vamos a la play(a)
```

With an installed `vamos` environment (see below, how to install in a few
seconds) assume a git
repository https://github.com/jmpstart/three-samples.git hosting three demo
samples. Here's how a novice user gets running with
a one-liner using `vamos`:  

```
     $ vamos @jmpstart/toy-samples  # let's go ...
     Playground Toy Samples: (type `$ ?` or `$ help for more info)
         fibo:   print 1st ten fibonacchi numbers
         primes: print 1st ten prime   numbers  
         lol:    laugh out loud
     (venv) $
```

If a user invokes this command line, `vamos` performs the following actions:

* download repository https://github.com/myhub/toy-samples.git
* change working directory to repository root `./toy-samples` and activate
  virtual python environment
* print some `playground quickstart help` about how to run installed
  samples/utilities

Inspired by the `playground initial help` the user might try:

```
    (venv) $ fibo
    The 1st ten Fibonacci numbers: 0 1 1 2 3 5 8 13 21 34
    (venv) $ primes
    The 1st ten prime numbers: 2 3 5 7 11 13 17 19 23 29
    (venv) $ lol
    Laugh out loud: Hahaha, Hahaha, Hahahahahaha
```

In order to understand what's going on in the background, the user can consult
the (playground specific) help information to find out which sample programs
are executed (and in which way), when invoking the aliases:
```
    (venv) $ alias fibo
    alias fibo='python samples/fibonaccy.py'
    (venv) $ alias primes
    alias primes='python samples/primes.py'
    (venv) $ alias lol
    alias lol='bash .vamos/bin/lol'
```

# Vamos - A Playground Manager

`Vamos` is a so-called `play ground manager` for setting up git repository based
playgrounds with minimal user interaction. Invoking `vamos` performs the
following tasks:

* clones a git repository
* changes current working directory to the git root of the downloaded repository
* creates and activates virtual python environments
* installs required Python packages
* print welcome message to tell the user what to do next
* provides a BASH alias for a help command
* can provide BASH aliases for invocation of samples
* preinstalles utilities for a specific playground
* management of simple databases, e.g. to define shorthands for working
  directories, IoT-board types, interface configurations


# Installing Vamos

Vamos runs in a BASH environment. This is natural for Linux and MacOS (OSX)
operating systems. On Windows 10++ you can install a Windows Subsystem for
Linux (WSL) to support a BASH environment.

Further `vamos` expects a well running system python3 environment. If you work
with an active virtual Python environment, you have to deactivate this, before
installing `vamos`.

```
    (venv) $ deactivate    # deactivate a potential virtual Python environment
    $                      # venv is now deactivated
```

To install `vamos` enxecute the following `curl` command:

```
   $ curl https://raw.githubusercontent.com/jmpstart/vamos/main/install >~vamos; . ~vamos -s
```

This installs a `vamos` (BASH) script in the python3 system
