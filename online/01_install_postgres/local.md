# Local installation

Linux is the recommended operating system for database application. Consider
running a Linux OS in a virtual machine, if you use Windows or Mac.

## Linux

Install the available PostgreSQL and PostGIS version from the
sources. On Ubuntu/Debian based systems you can do that in one command

```
sudo apt install postgresql postgresql-client postgis
```

## Windows

Download the installer bundle from the [Postgesql website](https://www.postgresql.org/download/). Use a version `>= 10 && < 13`. Download the EDB
installer, which also already includes PgAdmin4. Run the installer.

* be sure to select the `StackBuilder` option during installation.

* After the PostgreSQL installation, the installer will start the `StackBuilder`.
  Open the option `spatial extensions` and select `PostGIS`. Install that as well.

## Mac

Follow the instructions for Windows, but download the correct bundle.
