# Remote installations

For a remote installation of PostgreSQL, you first have to login to the remote
machine via SSH and run the [local installation for Linux OS](local.md).

There are a few additional steps necessary to allow incoming connections to
the database server, which are disabled by default. There are two levels of
security, the request to the database server and the authentication in the
management system. Both are disabled for remote connections by default.  

## Steps

* The location of PostgreSQL's configuration files varies with Postgres's version and the used host system.
You may need to search for files to find the exact location.

* On Ubuntu 19 and 20 the configuration files are located at:
`/etc/postgresql/10/main`, where `10` will be your major version number.

* To allow incoming requests from other physical machines, open `postgresql.conf`
and change the following line:
```
#listen_addresses = 'localhost'
```
to
```
listen_addresses = '*'
```

* To allow authentication, you need to open `pg_hba.conf` and **append** this
line to the end of the file:
```
host  all   all       0.0.0.0/0     md5       
```
You will need administrator rights on Windows or root privileges on Linux and
Mac to edit this file.

* restart the PostgreSQL service (on Linux). One of the following commands will
get the job done:
```
sudo service postgresql restart
sudo systemctl restart postgresql
```
On Windows, there is a PostgreSQL system icon and in the context menu you will find a
restart option.

## NOTE

The shown changes of the configuration allows **anyone** to connect from
**anywhere** to the PostgreSQL server. Thus, the only thing preventing others
from accessing your Server are the **Postgres user role passwords**.
Thus, use these settings only if absolutely necessary or during development and
be more restrictive in production systems.

Usually, you will put some kind of REST middleware between incoming HTTP requests
and database responses. 
