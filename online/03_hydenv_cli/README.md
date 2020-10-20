# Hydenv CLI

The usage of the Hydenv CLI is **strongly recommended**.

Please be aware, that the software was written during the shift of the lecture
to an online event, to make your life easier. Thus, it was not yet tested in
classroom situations. That means you can run into bugs and unclear or even missing
documentation.

**Don't panic!**

Drop an [Issue](https://github.com/data-hydenv/hydenv-database/issues/new) on Github
and I will take care of it.

## Call the ClI

Depending on your installation, you can either call the CLI as a Python module
(Pthon installation) or an executable (downloaded). In both cases, you have to
call the CLI from the command line (thus **C**ommand **L**ine **I**nterface).
The difference is only how you have to call the CLI. For these lecture note,
we will use the Python module. Therefore, whenever you read something like this:

```
python -m hydenv --help
```

The executable on Windows will be run like:

```
C:/path/to/hydenv.exe --help
```

So, don't double click on the executable, that will run and instantly close
the application again.

On Windows, you can open a command prompt with `[Win] + [R]`, or search for `cmd.exe`.

## Build database schema

Install the schema like:

```
python -m hydenv init
```

Add the `--clean` flag, to drop existing tables first and populate default lookup values

```
python -m hydenv init --clean
```
