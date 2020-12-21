# Local installation

Linux is the recommended operating system for database applications. It is
possible to run a Linux OS in a virtual machine, if you use Windows or Mac, or
use a Postgres container. To keep things simple, install Postgres on your system
directly. VMs and container are useful in a real-world project or productive
environment.

## Linux

Install the available PostgreSQL and PostGIS version from the
sources. On Ubuntu/Debian based systems you can do that in one command

```
sudo apt install postgresql postgresql-client postgis
```

## Windows

Luckily, on Windows there is a enterprise-edition installer that can be used
to install Postgres. Installing from source directly is more complicated and in
case the installer does not work, it's recommended to run a Linux virtual machine.
Download the installer bundle from the [Postgesql website](https://www.postgresql.org/download/). Use a version `>= 10 && < 13`. Download the EDB
installer, which also already includes PgAdmin4. Run the installer.

* be sure to select the `StackBuilder` option during installation.

* After the PostgreSQL installation, the installer will start the `StackBuilder`.
  Open the option `spatial extensions` and select `PostGIS`. Install that as well.

## Mac

Follow the instructions for Windows, but download the correct bundle.
