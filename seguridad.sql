select user, host
from mysql.user;

create user 'nuevo' @localhost identified by 'nuevo2024';


grant select, insert, update on prueba.* to "nuevo"@localhost;

show grants for 'nuevo'@localhost;

drop user 'nuevo'@localhost;

grant insert on prueba.empleados to 'nuevo'@localhost;
revoke insert on prueba.empleados from "nuevo"@localhost;


grant usage on prueba.* to 'nuevo'@'localhost';
alter user 'nuevo'@'localhost' with max_queries_per_hour 100;

select user,  host
from mysql.user
where user = '';

show databases;
use mysql;
show tables;
use prueba;

alter user 'nuevo'@localhost identified by 'c@c@s2024';

revoke all privileges on *.* from "cacas"@localhost;
grant select on prueba.* to 'cacas'@localhost;


create user 'admin'@'%' identified by 'campus2024';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION;

REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'admin'@'%';


CREATE USER camilo@localhost identified by 'bucaroscampeon';

grant select (id, codigo_empleado) on prueba.empleados to camilo@localhost;


use world;
select * from city where countrycode = 'COL';

prepare stmt from 'select * from city where countrycode = ?';

set @pais = 'COL';
execute stmt using @pais;

deallocate prepare stmt;
