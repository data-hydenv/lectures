# Install mandatory Software

## QGis

### Linux

Run:

```
sudo apt install qgis
```

If you have any other 3.X version installed, that is fine as well. The command
above might not install the latest version and no GRASSgis and SAGA Gis support.
Instructions can be found online

### Windows
Visit [qgis.org](https://qgis.org) and download a LTS of QGis 3.
Follow the instructions.

### Mac

Installers for at Mac High Sierra (10.13) can be found at: [https://qgis.org/en/site/forusers/download.html](https://qgis.org/en/site/forusers/download.html).

## PgAdmin4

### Python

If you have Python installed on your system, simply run:

```
pip install pgadmin4
```
This works on all OS.

### Linux

Run:
```
sudo apt install pgadmin4
```

### Windows

PgAdmin4 should have been installed along with your PostgreSQL installation.
If not, visit [pgadmin.org](https://pgadmin.org) and follow the instructions.

### Mac

If PgAdmin was not installed along with PostgreSQL, it is highly recommended to
use Python for installing PgAdmin4.

## Hydenv tools

We wrote an application that installs data structures, handles data or uploads
example data to any connected local or remote PostgreSQL database. It is written
in Python. If Python 3 is installed on your system, run:

```
pip install hydenv
```

If Python is not installed, check out Anaconda (there is a session on installing)
or checkout this repository on [Github](https://github.com/data-hydenv/hydenv-database) if there is an executable availble for you OS.
