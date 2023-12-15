![Vamos](./.vamos/image/vamos-a-la-playa.jpg)

# Curl Installation Formula

In a BASH shell with installed `git`, `curl` and `python3` execute the following
one-liner to quick install `vamos`

```
  curl -s https://raw.githubusercontent.com/jmpstart/vamos/main/install >~vamos; source ~vamos -s
```

and check for a successful installation message, otherwise follow the troublehooting
in the appendix.

----------------------------------------------------------------------------------------------

# Vamos - A Playground Managing Tool

Can we download a repository from git hub and setup a playground in a similar
simple manner as we are used from installing a smartphone app? Yes we can!

```
    Let's go, vamos a la play(a)|ground
```

With installed `git`, `python3` and `vamos` environment (see appendix/troubleshooting if you miss one of them)
assume a git repository https://github.com/jmpstart/toy-samples.git hosting a `vamos` playground with three demo
samples. Here's how to clone/activate such playground with a one-liner using `vamos`:  

```
     $ vamos @jmpstart/toy-samples  # let's go ...
     Playground Toy Samples: (type `$ ?` or `$ help for more info)
         fibo:   print 1st ten fibonacchi numbers
         primes: print 1st ten prime   numbers  
         lol:    laugh out loud
     (venv) $
```

Once cloned and installed on your computer the `vamos` playground is hosted in avirtual Python environment
which is activated, whenvever ever command `. vamos` is invoked somewhere in the file tree of the playground's
git repository. 


If a user invokes command `$ vamos @jmpstart/toy-samples` the following actions are performed:

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


# How Vamos Works

`vamos` operates on the basis a local directory `.vamos`, containing
blueprints and stuff to be copied to a virtual Python environment folder. Usually
(but not mandatory) the `.vamos` directory is located next to the `.git` directory of 
a `git` repository.

`vamos` is able to identify virtual Python environment directories, which have usually
names like `venv`or `.venv` (but can have any name), for which we use the generic
symbol `$VENV` in this context. `vamos` identifies a virtual python environment
by the fact that it contains an activation script $VENV/bin/activate.

The role of `vamos` is: 

1) To automatically create a non existing `$VENV` directory (called `venv`) if a `.vamos`
directory has been found in the current directory.

2) To setup a playground controlled by a virtual Python environment, if by investigation
of `$VENV` it is concluded, that the playground has not yet been setup.

3) To activate always the `right` virtual Python environment, i.e., the environment
with a valid `$VENV` directory found in the current directory, or the parent of the
current directory, or else in the parent of the parent directory and so forth. 


# How Vamos is Implemented

It is crucial to understand that `vamos` needs to activate virtual Python environments,
i.e., needs to `source` activation scripts like `$ source $VENV/bin/activate`. To
`source` a BASH script means, that no child process is created for script execution,
which allows the script to create/modify environment variables and to install aliases
or shell functions in the current (BASH) process.

In this sense `vamos` must be implemented either as an `alias` or a `BASH function` 
(the specific implementation detail is left open as a private implementation detail).
Denoting `$PYDIR` as the system python3 path, a BASH script `$PYDIR/vamos` is installed
with execution attributes in the `System Python3` binary directory.

After opening a new console/terminal running a BASH shell, running `vamos` generates an error

```
    $ vamos
    error: activate must be sourced before further usage!
    run `source activate` or `. activate` before (consider to add to ~/.bashrc, ~/.bash_profile)
```

Thus, we have to run one of the following two commands 

```
    $ source vamos    # necessary to install a alias/function `vamos`
    $ . vamos         # short hand form (same as `source vamos`)
```

in order to source `vamos`, which enables `vamos` to install an alias or a function called `vamos` 
which subsequently will always source script `$PYDIR/vamos`. It is recommended to add
one of the two commands above to the bASh startup scripts, which is `~/.bashprofile` on MacOS or
`~/.bashrc` on Linux or Windows WSL. Notably the `vamos` installation process automatically
invokes `source vamos` such that an additional sourcing is not required for an ongoing BASH session.




# How Vamos Works in Detail

1) If the current directory contains a `.vamos` directory (storing blueprints and
stuff to be copied) and no virtual Python environment directory exists in the
current directory, it automatically creates a virtual Python environment.

2) If `vamos` finds a virtual Python environment directory (e.g., `venv`, `.venv`,
or other name) in the current directory which is not activated, it activates it.
This implies, that a different activated virtual environment will implicitely be
deactivated before. This works only if `vamos`
has beens launched with `source vamos` (or equivalently `. vamos`).

3) If `vamos` detects an activated virtual Python environment with the stuff in
`.vamos` not copied to the virtual Python environment folder, it copies that
stuff and, if provided, executes script `.vamos/bin/setup` to setup the playground
with proper actions.


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

This installs a `vamos` (BASH) script in the directory where system python3 binaries
are located.

# Appendix - Troubleshooting

... to be done
