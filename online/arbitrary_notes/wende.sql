create materialized view energiewende as 
select 
	gas.name, gas.geom, 
	gas."Gas Stations", electric."Charging Stations",
	gas."Gas Abdeckung 1.5km", electric."Electric Abdeckung 1.5km",
	gas."Gas Abdeckung 5km", electric."Electric Abdeckung 5km"
from 
(with 
	fuel as (select * from osm_nodes where node_type='fuel')
select c.id, c.name, c.geom , 
	count(fuel) as "Gas Stations",
	round(st_area(st_intersection(st_union(st_buffer(st_transform(fuel.geom, 25832), 1500)), st_transform(c.geom, 25832))) / st_area(st_transform(c.geom, 25832)) * 100) as "Gas Abdeckung 1.5km",
	round(st_area(st_intersection(st_union(st_buffer(st_transform(fuel.geom, 25832), 5000)), st_transform(c.geom, 25832))) / st_area(st_transform(c.geom, 25832)) * 100) as "Gas Abdeckung 5km"
from (select * from osm_nodes where node_type='county') as c 
right join fuel on st_within(fuel.geom, c.geom)
group by c.id, c.name, c.geom) as gas
join 
(with 
	fuel as (select * from osm_nodes where node_type='charging_station')
select c.id, c.name, c.geom , 
	count(fuel) as "Charging Stations",
	round(st_area(st_intersection(st_union(st_buffer(st_transform(fuel.geom, 25832), 1500)), st_transform(c.geom, 25832))) / st_area(st_transform(c.geom, 25832)) * 100) as "Electric Abdeckung 1.5km",
	round(st_area(st_intersection(st_union(st_buffer(st_transform(fuel.geom, 25832), 5000)), st_transform(c.geom, 25832))) / st_area(st_transform(c.geom, 25832)) * 100) as "Electric Abdeckung 5km"
from (select * from osm_nodes where node_type='county') as c 
right join fuel on st_within(fuel.geom, c.geom)
group by c.id, c.name, c.geom) as electric
on gas.id=electric.id;
