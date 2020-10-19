# Recommended Software

## Anaconda

If you don't have it anyway, it is most helpful to manage the Python and R
environments on your system using Anaconda. It is available for all OS.
It basically bundles the whole environment into one folder and gives you the
ability to *activate* or *deactivate* this environment. This way you can run
an arbitrary amount of different Python and R versions simultaneously on your
system and version conflicts won't steal your valuable time anymore.
If you provide code for others on CRAN or PyPI, you should only do that, if you
tested the code against different versions. Anaconda is a very easy way to do
so.
The latest download links can always be found on the Anaconda website:
https://anaconda.com/products/individual

### Anaconda vs. Miniconda

You will find two different installers on [anaconda.com](https://anaconda.com):
Anaconda and Miniconda. Although there are more differences, you can think of
Anaconda as a Miniconda with a predefined environment. You can use both the same
way. Anaconda has kind of every useful Python package already installed, while
Miniconda is smaller.

### Linux

```
curl https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh --output anaconda .sh
bash anaconda.sh
```

Follow the instructions and be sure to add the Anaconda location to your path.
The install script will ask you that.

### Windows

```
curl https://repo.anaconda.com/archive/Anaconda3-2020.07-Windows-x86_64.exe --output anaconda.exe
anaconda.exe
```

Follow the instructions of the graphical installer.

### Mac

Yeah, whatever you have to do.

## Hydenv

There is a tool available, solely for helping you to download and install data
for the lecture or start practicing some exercises.
Hydenv should work cross-platform with no significant differences between the
main OS (Linux, Windows, Mac). The recommended way to install it, is as a
Python package, although you need Python first. Then, simply run

```
pip install hydenv
```

You may also find a compiled version for your OS in the Github repository:
[https://github.com7data-hydenv/hydenv-database](https://github.com7data-hydenv/hydenv-database). Then, you just call the downloaded executable, instead of the
Python module.

Example:
To verify, that it's working by asking the tool for the help text.

As Python module:
```
python -m hydenv --help
```

As Windows executable:

```
hydenv.ext --help
```
