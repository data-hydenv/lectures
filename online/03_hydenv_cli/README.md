# Hydenv CLI

The usage of the Hydenv CLI is **strongly recommended**.

This document is more like a cheat sheet, don't learn it by heart.

Please be aware, that the software was written during the shift of the lecture
to an online event, to make your life easier. Thus, it was not yet tested in
classroom situations. That means you can run into bugs and unclear or even missing
documentation.

**Don't panic!**

Drop an [Issue](https://github.com/data-hydenv/hydenv-database/issues/new) on Github
and I will take care of it.

## Call the ClI

Depending on your installation, you can either call the CLI as a Python module
(Python installation) or an executable (downloaded). In both cases, you have to
call the CLI from the command line (thus **C**ommand **L**ine **I**nterface).
The difference is only how you have to call the CLI. For these lecture notes,
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

## Create the database

The recommended method is using the CLI here. However, you can also install the
database manually. But keep in mind that the cli will do more than just installing
the database. In case you do not use it, you have to create tables and upload
data on your own, which will drastically increase your workload. Therefore, install
the CLI and get in touch if anything goes wrong.

### Use PgAdmin

Creating the database is a more complicated step, as you need root privileges
to create new database instances. In case you feel a bit comfortable with
PgAdmin4, you can use it, as it gives you more control. This is the way how any
new database (e.g. for other projects) is created.
There are four steps that have to be taken:

1. Create a new database called `hydenv`.
2. Create the PostGIS extension in that database.
3. Create a new user called `hydenv` (or whatever you want to use)
4. Grant all permissions on the new database to the new user.

In PgAdmin4 you can do all these steps using the GUI, or with the SQL prompt.
In both cases, you have to **connect** to the new database after **step 1**.
In the SQL prompt run the following commands.

```SQL
CREATE DATABASE hydenv;
```
And then connected to that database:

```SQL
CREATE EXTENSION postgis;
CREATE ROLE hydenv WITH PASSWORD 'hydenv';
GRANT ALL PRIVILEGES ON DATABASE hydenv TO hydenv;
```

### Use hydenv CLI

You can also use the CLI, although the command is a bit confusing. You need to
pass a connection with root privileges and specify how the new user should be
named at the same time (the CLI will create the new user):

```
python -m hydenv database install --user=hydenv --password=hydenv --db-name=hydenv --connection=postgresql://postgres:<password>@localhost:5432/postgres
```

Here, `<password>` is the root password you chose during the installation of postgres.
With the three flags `--user=hydenv --password=hydenv --db-name=hydenv` you can
specify the database name, user name and user password for the database used in this
lecture.

Another advantage of using the CLI, is that you can skip the next point
'Saving connections' as that was already done by the CLI.

## Saving connections

Whenever you run a command with the CLI, you need to specify the connection to
the database using the `--connection` flag. That is cumbersome. Thus, the CLI can
save the connection for you to the disk. If done so, it will load it automatically,
whenever needed.

```
python -m database save --user=hydenv --password=hydenv --host=localhost --port=5432 --dbname=hydenv
```

**Note:** This will save the password into a text-file in your home directory.

**Only use this in a trusted environment**. Alternatively, you could omit the
password and set it as an Environment variable on every startup of the command line
tool.

Windows:
```powershell
set POSTGRES_PASSWORD=hydenv
```

Linux:
```bash
export POSTGRES_PASSWORD=hydenv
```

## Build database schema

Install the schema like:

```
python -m hydenv init
```

Add the `--clean` flag, to drop existing tables first and populate default lookup values

```
python -m hydenv init --clean
```

On first run, you should add the `--clean` flag, to have all lookup tables filled.

## Execute any command

To verify that installation and initialization were fine so far, you can use
the `execute` command to run any SQL query. With the following example, you
can count one of the prefilled tables:

```
python -m hydenv database execute --sql="SELECT count(*) as amount FROM terms"
```

This should return something like: `(48,)`.

## Upload sample data

Uploading data into the database is a multi-step process. First, you need to
create metadata entries. Then upload the actual data and link it to the correct
metadata. Finally, you have to decide how to react to integrity issues of your
data.

The `hydenv` has you covered here. It allows low-level access to the database
by writing records one at a time. On top of that you can script any upload logic
you need, in your preferred scripting language.
Alternatively, there are so-called *examples*, which do all of this in one step.
To get started with exercises, you can load one of last years HOBO campaigns,
that took place during lecture in Freiburg.

```
python -m hydenv exercises --help
```

To upload all data collected in Winterterm 2018/2019 you can run this command:

```
python -m hydenv exercises hobo --terms=WT18
```

It will look up the metadata in a collaborative google sheet and import that.
Then, the actual data is downloaded from Github and imported as well.
