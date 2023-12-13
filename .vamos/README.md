# ToDo

* move vamos to an official locatio https://github.com/vamos/install.git
* make toy playground at @vamos/toy
* autocheck if vamos is running in a sourced mode, otherwise
  show a message '... $ source vamos'
* provide a tutorial at @vamos/tutorial
* think about the clockwork of a vamos shell. Think about the syntax how
  to launch a shell, an consider using `venv` alias to mange virtual
  environments similat to the `ve` script


# Done

* initial version v0.1.2


# Package Development History

## Prerequisites

As a prerequisite we need Python package 'poetry', which is recommended to be installed in the Python system environment.

```
    $ pip install poetry
    $ poetry --version
    Poetry (version 1.7.1)
```

# 1 How package `Vamos` has been created

## 1.1 Use Poetry for Package Management

## 1.2 Create Initial Package Structure

In the git repo's root directory (where .git is located) we use `poetry`
to initialize package `vamos`. Here we follow closely the instructions in [1]

```
    $ poetry new --src vamos
    $ tree vamos
    .
    └── vamos
        ├── README.md
        ├── pyproject.toml
        ├── src
        │   └── vamos
        │       └── __init__.py
        └── tests
            └── __init__.py
```

The --src option creates a `src` subdirectory where our python sources will
be located. The created file structure is shown above.


## 1.3 Create and Activate a Virtual Environment

In a next step we create a virtual Python environment. A good reading about virtual environments can be found in [2]. Poetry provides a feature
for the creation of a virtual environment, which we definitely avoid to use. Vamos strongly depends on a standard naming of a virtual environment folder as `venv`, which is usually located in the root directory of a git repository - keep this in mind.

```
   $ python3 -m venv venv       # create virtual environment
   $ source venv/bin/activate   # activate virtual environment
   (venv) $                     # prompt `(venv) $` indicates activation
```

The first command instructs Python 3 to execute module `venv`
to create a virtual environment kept in directory `venv` (that's
why `venv` shows up two times). The second part activates the virtual environment by sourcing the script `venv/bin/activate`. `Sourcing` enables the script to modify (or add additional) settings of the current shell environment.

After activation you see your prompt beginning with the characters `(venv)` to indicate that you work now in an activated virtual environment. Always make sure in the following to work in an activated environent (to deactivate use `(venv) $ deactivate`).

Important: You never shouldn’t commit your virtual environment to version control,
and you shouldn’t ship it with your project (the provided `.gitignore` file of the
vamos repository is well prepared for that).

Make `vamos`your current working directory (`$ cd vamos`)!

```
    (venv) $ cd vamos
    (venv) $ ls
    README.md	pyproject.toml	src		tests
```

## 1.4 Provide Version String and First Unit Test

The package initialization file is found under `./vamos/src/vamos/__init__.py` and is execute in a Python statement like `import vamos`.

```
# vamos/__init__.py

__version__ = "0.1.0"
```

Add a unit test file `./vamos/tests/test_version.py` in order to provide our first unit test.

```
# tests/test_version.py

from vamos import __version__

def test_version():
    assert __version__ == "0.1.0"
```

When we later increase the version we have to modify at three locations:

1) in the __init__.py file of the `vamos` package

2) in the test_version.py file of the `tests` folder

3) in the `pyproject.toml` file (we come to that soon)

This is not very convenient for maintainance, but we will accept such
inconvenience at this point, as we want to see package testing and building
with a minimum of efforts.


## 1.5 Configure the Package

Let us start this section with a quote from [1]:

*One of the most important files for working with Poetry is the pyproject.toml file. This file isn’t an invention of Poetry. It’s a configuration file standard that was defined in PEP 518:*

*This PEP specifies how Python software packages should specify what build dependencies they have in order to execute their chosen build system. As part of this specification, a new configuration file is introduced for software packages to use to specify their build dependencies (with the expectation that the same configuration file will be used for future configuration details). (Source)*

*The authors considered a few file formats for the “new configuration file” mentioned in the quote above. In the end, they decided on the TOML format, which stands for Tom’s Obvious Minimal Language. In their opinion, TOML is flexible enough, with better readability and less complexity than the other options, which are YAML, JSON, CFG, or INI.*


To see how TOML looks, open the pyproject.toml file:

```
[tool.poetry]
name = "vamos"
version = "0.1.0"
description = ""
authors = ["ihux <hugo.pristauz@gmail.com>"]
readme = "README.md"
packages = [{include = "vamos", from = "src"}]

[tool.poetry.dependencies]
python = "^3.11"

[build-system]
requires = ["poetry-core"]
build-backend = "poetry.core.masonry.api"
```

The TOML file is a configuration file for our `vamos`
package. It shows three sections which are called `tables`.

# 1.8 Add Some Project Dependencies

For the `vamos` application we want to use packages `typer`, `colorama` and
`shellingham`. We use Poetry to add these dependencies as `project dependencies`
to our TOML file. These dependencies are so-called `project dependencies`, since
these packages need to be co-installed in a package deployment.

```
    (venv) $ poetry add typer
    (venv) $ poetry add colorama
    (venv) $ poetry add shellingham
```


# 1.7 Add Some Development Dependencies

Once everything is setup well, during each package build we want our package to
be automatically unit tested (using `pytest`), and that each source file is
automatically formatted using PEP standards.

To explicitly tell Poetry that a package is a development dependency, we run
poetry add with the --D option (same as  --dev):

```
    (venv) $ poetry add pytest -D
    (venv) $ poetry add black -D
```

Finally our TOML file has got an additional table and looks as follows:

```
[tool.poetry]
name = "vamos"
version = "0.1.0"
description = ""
authors = ["ihux <hugo.pristauz@gmail.com>"]
readme = "README.md"
packages = [{include = "vamos", from = "src"}]

[tool.poetry.dependencies]
python = "^3.11"
typer = "^0.9.0"
colorama = "^0.4.6"
shellingham = "^1.5.4"

[tool.poetry.group.dev.dependencies]
pytest = "^7.4.3"
black = "^23.11.0"

[build-system]
requires = ["poetry-core"]
build-backend = "poetry.core.masonry.api"
```

# 2 Test and Build Vamos Package

## 2.1 Resolve Dependencies and Install

According to the TOML configuration there are two dependencies:

```
# vamos/pyproject.toml (excerpt)

[tool.poetry.dependencies]
python = "^3.11"
typer = "^0.9.0"
colorama = "^0.4.6"
shellingham = "^1.5.4"

[tool.poetry.group.dev.dependencies]
pytest = "^7.4.3"
black = "^23.11.0"
```

There are currently four dependencies declared for our project. One is Python itself, followed by project dependencies on packages `typer`, `colorama` and `shellington`. The others are `pytest`, a widely used testing framework and `black`, a source text formatter. As you’ve seen
before, our project contains a `tests` folder with a unit test defined in
`tests.__init__.py`. With `pytest` as a dependency, Poetry can run our tests
immediately after installation.

With the install command, Poetry checks our `pyproject.toml` file for
dependencies then resolves and installs them. The resolving part is especially
important when you have many dependencies that require different third-party
packages with different versions of their own. Before installing any packages,
Poetry figures out which version of a package fulfills the version constraints
that other packages set as their requirements. Besides pytest and its
requirements, Poetry also installs the project itself.

```
    (venv) $ poetry install
    Updating dependencies
    Resolving dependencies... (0.1s)

    Package operations: 13 installs, 0 updates, 0 removals

      • Installing click (8.1.7)
      • Installing iniconfig (2.0.0)
      • Installing mypy-extensions (1.0.0)
      • Installing packaging (23.2)
      • Installing pathspec (0.11.2)
      • Installing platformdirs (4.1.0)
      • Installing pluggy (1.3.0)
      • Installing typing-extensions (4.8.0)
      • Installing black (23.11.0)
      • Installing colorama (0.4.6)
      • Installing pytest (7.4.3)
      • Installing shellingham (1.5.4)
      • Installing typer (0.9.0)

    Writing lock file

    Installing the current project: vamos (0.1.0)
```

## 2.2 Check the Installation

Run the python interpreter and invoke the following
commands.

```
    (venv) $ python
    >>> import vamos, typer, colorama, shellingham
    >>> vamos.__version__
    '0.1.0'
    >>>
```

If the import statement executes fine (without errors) and
the version string shows up correctly, we can be sure that
Poetry did a good installation job


## 2.3 Test the Package

Use Poetry to run `pytest`:

```
    (venv) $ poetry run pytest
    ============================= test session starts ==============================
    platform darwin -- Python 3.11.5, pytest-7.4.3, pluggy-1.3.0
    rootdir: /Users/hux/Bluenetics/Git/Python/vamos-develop/vamos
    collected 1 item                                                               

    tests/test_version.py .                                                  [100%]

    ============================== 1 passed in 0.00s ===============================
    (venv) vamos $ poetry run pytest
    ============================= test session starts ==============================
    platform darwin -- Python 3.11.5, pytest-7.4.3, pluggy-1.3.0
    rootdir: /Users/hux/Bluenetics/Git/Python/vamos-develop/vamos
    collected 1 item                                                               

    tests/test_version.py .                                                  [100%]

    ============================== 1 passed in 0.00s ===============================    
```

Now change the version in `tests/test_version.py` to "0.1.1"

```
# tests/test_version.py

from vamos import __version__

def test_version():
    assert __version__ == "0.1.1"
```

and use poetry to run pytest again:

```
    (venv) $ poetry run pytest
    ============================= test session starts ==============================
    platform darwin -- Python 3.11.5, pytest-7.4.3, pluggy-1.3.0
    rootdir: /Users/hux/Bluenetics/Git/Python/vamos-develop/vamos
    collected 1 item                                                               

    tests/test_version.py F                                                  [100%]

    =================================== FAILURES ===================================
    _________________________________ test_version _________________________________

        def test_version():
    >       assert __version__ == "0.1.1"
    E       AssertionError: assert '0.1.0' == '0.1.1'
    E         - 0.1.1
    E         ?     ^
    E         + 0.1.0
    E         ?     ^

    tests/test_version.py:6: AssertionError
    =========================== short test summary info ============================
    FAILED tests/test_version.py::test_version - AssertionError: assert '0.1.0' == '0.1.1'
    ============================== 1 failed in 0.01s ===============================    
```

This time `pytest` fires an error, which gives us confidence that our test framework
works well. Being sure about this we change the version string back to ``"0.1.0"``.


## 2.4 Updating the Package

Finally we update the package to make sure to have an updated lock file. The
update command will update all yur packages and their dependencies within their
version constraints. Afterward, Poetry will update our `poetry.lock` file.

```
    (venv) $ poetry update
```

After providing a README.md file in the repository's root directory We are ready
to install our new created Vamos package at `PyPi`.

```
    (venv) $ cd ..
    (venv) $ head README.md
```



# 3 Publish Vamos Package

# 3.1 Configure Poetry with Proper API Token for PyPi Hub

Go to PyPi to create an API token. Configure Poetry to use this token [4]

```
    (venv) $ poetry config pypi-token.pypi pypi-xxx-xxxx-...
```

# 3.2 Configure Poetry with Proper API Token for Test PyPi Hub

Go to Test PyPi to create an API token. Configure Poetry to use this token [5]

```
    (venv) $ poetry config repositories.test-pypi https://test.pypi.org/legacy/
    (venv) $ poetry config pypi-token.test-pypi pypi-xxx-xxxx-...
```

# 3.3 Build and Publish to TestPyPi

Since we have configured Poetry now with an API token for TestPyPi we are ready
to publish packages to TestPyPi. Before actual publishing we should always make
an obligatory final build of our package.

```
    (venv) $ poetry build      # final package build
    (venv) $ poetry publish    # publish to PyPi
```

If all this works we can publish to Pypi (next section).


# 3.4 Build and Publish to PyPi

Since we have configured Poetry now with an API token for PyPi we are ready to
publish packages to PyPi. Before actual publishing we should always make an
obligatory final build of our package.

```
    (venv) $ poetry build      # final package build
    (venv) $ poetry publish    # publish to PyPi
```

To test package installation we perform the following steps:

```
    (venv) $ pip uninstall vamos
    Found existing installation: vamos 0.1.0
    ...
    Proceed (Y/n)?
      Successfully uninstalled vamos-0.1.0
    (venv) $ pip install vamos
    ...
    (venv) python
    ...
    >>> import vamos
    >>> vamos.__version__
    '0.1.0'
    >>> exit()
    (venv) $
```


# References

[1] Philipp Acsany: Real PythonDependency Management With Python Poetry;
    RealPython Blog
    https://realpython.com/dependency-management-python-poetry

[2] Martin Breuss: Python Virtual Environments: A Primer
    RealPython Blog
    https://realpython.com/python-virtual-environments-a-primer

[3] Leodanis Pozo Ramos: Build a Command-Line To-Do App With Python and Typer
    RealPython Blog
    https://realpython.com/python-typer-cli

[4] Tony Tran: How To Publish Python Packages to PyPI using Poetry on Ubuntu
    22.04; web tutorial
    https://www.digitalocean.com/community/tutorials/how-to-publish-python-packages-to-pypi-using-poetry-on-ubuntu-22-04

[5] Stack Overflow: using Python-poetry to publish to test.pypi.org
    https://stackoverflow.com/questions/68882603/using-python-poetry-to-publish-to-test-pypi-org
