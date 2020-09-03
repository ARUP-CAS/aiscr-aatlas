# Archatlas



## Collation issue
``
locale -a
sudo locale-gen cs_CZ.UTF-8
sudo update-locale
sudo /etc/init.d/postgresql restart

pqsl#
select * from pg_collation;
CREATE COLLATION "czech" ( locale = 'cs_CZ.utf8' );
ALTER TABLE places ALTER COLUMN title_cs  TYPE varchar COLLATE "czech";
``
