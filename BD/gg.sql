select * from "DWH"."DM_ESTABLECIMIENTO";
select count(*) from "DWH"."DM_ESTABLECIMIENTO"; 

select * from "DWH"."DM_ZONA_GEOGRAFICA";
select count(*) from "DWH"."DM_ZONA_GEOGRAFICA"; 

select * from "DWH"."DM_LOCALIDAD";
select count(*) from "DWH"."DM_LOCALIDAD"; 

select * from "DWH"."DM_MUNICIPIO";
select count(*) from "DWH"."DM_MUNICIPIO"; 

select * from "DWH"."DM_ENTIDAD";
select count(*) from "DWH"."DM_ENTIDAD"; 

select * from "DWH"."DM_MES";
select count(*) from "DWH"."DM_MES"; 

select "SA".pro_dim_tiempo(2010);
select "SA".pro_dim_tiempo(2011);
select "SA".pro_dim_tiempo(2012);
select "SA".pro_dim_tiempo(2013);
select "SA".pro_dim_tiempo(2014);
select "SA".pro_dim_tiempo(2015);
select "SA".pro_dim_tiempo(2016);
select "SA".pro_dim_tiempo(2017);
select "SA".pro_dim_tiempo(2018);
select "SA".pro_dim_tiempo(2019);
select "SA".pro_dim_tiempo(2021);

select * from "SA".tmp_zona_geografica;
select count(*) from  "SA".TMP_ZONA_GEOGRAFICA; 


CREATE TABLE TMP_ZONA_GEOGRAFICA
(
  id_zona_geografica BIGINT
,cve_ent BIGINT
,entidad VARCHAR(200)
,cve_mun BIGINT
,municipio VARCHAR(200)
,cve_loc BIGINT
,localidad VARCHAR(200)
,latitud NUMERIC(20, 8)
,longitud NUMERIC(20, 8)
)
;

drop table TMP_ESTABLECIMIENTO;
CREATE TABLE TMP_ESTABLECIMIENTO
(
  id_est BIGINT
, nom_estab VARCHAR(250)
, raz_social VARCHAR(250)
, codigo_act BIGINT
, nombre_act VARCHAR(250)
, tipounieco VARCHAR(8)
,fecha_alta VARCHAR(20)
)
;

CREATE TABLE tmp_estaditica
(
  id_est BIGINT
, id_zona BIGINT
, id_anio INT
, per_ocu VARCHAR(20)
)
; 

delete from public.tmp_establecimiento;
delete from public.tmp_estaditica;
delete from public.tmp_zona_geografica;

select count(*)  from  "DWH"."DM_ESTABLECIMIENTO" where raz_social like 'INDEFINIDO';

select fecha_alta, count(*)  from  "DWH"."DM_ESTABLECIMIENTO" group by fecha_alta order by 1;


select sum(conteo) from(
WITH series AS (
                SELECT generate_series(1, 10000000, 1000000) AS r_from -- 1950 = min, 2010 = max, 10 = 10 year interval
), range AS (
                SELECT r_from, (r_from + 999999) AS r_to FROM series -- 9 = interval (10 years) minus 1
)
SELECT r_from, r_to,
       (SELECT count(*) FROM "SA".tmp_establecimiento WHERE id_est BETWEEN r_from AND r_to) as conteo
FROM range) as suma;

WITH series AS (
                SELECT generate_series(1, 10000000, 500000) AS r_from -- 1950 = min, 2010 = max, 10 = 10 year interval
), range AS (
                SELECT r_from, (r_from + 499999) AS r_to FROM series -- 9 = interval (10 years) minus 1
)
SELECT r_from, r_to,
       (SELECT count(*) FROM "SA".tmp_establecimiento WHERE id_est BETWEEN r_from AND r_to) as conteo
FROM range;
------------------------------------------------------------------------------------

delete from "SA".tmp_establecimiento;
delete from "SA".tmp_estaditica o;
delete from "SA".tmp_zona_geografica ;

drop table "SA".tmp_establecimiento;
drop table "SA".tmp_estaditica;
drop table "SA".tmp_zona_geografica ;

CREATE TABLE "DWH"."DM_LOCALIDAD"
(
    ID_LOCALIDAD INT NOT NULL GENERATED BY DEFAULT AS IDENTITY
    ,CODE_LOCALIDAD VARCHAR(100) NOT NULL
    ,DESC_LOCALIDAD VARCHAR(100)
    ,ID_MUNICIPIO INT NOT NULL
    ,CONSTRAINT PK_DM_LOCALIDAD PRIMARY KEY (ID_LOCALIDAD)
    ,CONSTRAINT FK_DM_LOCALIDAD_DM_MUNICIPIO FOREIGN KEY (ID_MUNICIPIO)
  REFERENCES "DWH"."DM_MUNICIPIO" (ID_MUNICIPIO)
);

insert into "DWH"."DM_LOCALIDAD" (CODE_LOCALIDAD, DESC_LOCALIDAD, ID_MUNICIPIO) values ('INDEFINIDO', 'INDEFINIDO', 1);

delete from "DWH"."FACT_ESTADISTICA" 


drop table "DWH"."DM_LOCALIDAD"
drop table "PART"."LOCALIDAD_01" cascade;
drop table "PART"."LOCALIDAD_02";
drop table "PART"."LOCALIDAD_03";
drop table "PART"."LOCALIDAD_04";
drop table "PART"."LOCALIDAD_05";

CREATE TABLE "PART"."LOCALIDAD_01" PARTITION OF "DWH"."DM_LOCALIDAD" 
    FOR VALUES FROM (0) TO (60000); -- se delimita el rango de las particiones
CREATE TABLE "PART"."LOCALIDAD_02" PARTITION OF "DWH"."DM_LOCALIDAD" 
    FOR VALUES FROM (60000) TO (120000);
 
insert into "DWH"."DM_LOCALIDAD" (CODE_LOCALIDAD, DESC_LOCALIDAD, ID_MUNICIPIO) values ('INDEFINIDO', 'INDEFINIDO', 1);
insert into "DWH"."DM_ZONA_GEOGRAFICA" (CODE_ZONA_GEOGRAFICA, LATITUD, LONGITUD, ID_LOCALIDAD) values ('INDEFINIDO', null, 
null, 1);

select * from "DWH"."DM_LOCALIDAD";
select * from "DWH"."DM_ZONA_GEOGRAFICA" dzg ;

delete from "DWH"."DM_LOCALIDAD" 
delete from "DWH"."DM_ZONA_GEOGRAFICA" where id_zona_geografica = 2;

drop table "DWH"."FACT_ESTADISTICA";
drop table "DWH"."DM_ZONA_GEOGRAFICA";
drop table "DWH"."DM_LOCALIDAD";
drop table "DWH"."DM_MUNICIPIO";
drop table "DWH"."DM_ENTIDAD";
drop table "DWH"."DM_ESTABLECIMIENTO";
drop table "DWH"."DM_ACTIVIDAD";
insert into "DWH"."DM_ANIO" values (0, 'INDEFINIDO');
insert into "DWH"."DM_MES" values (0, 0, 'INDEFINIDO');
---------------------------------------------------------------------------

select  COUNT(*) from (
    select  cve_mun --,COUNT(*)
        FROM "SA".tmp_zona_geografica tzg 
                JOIN "DWH"."DM_ENTIDAD" de
                    ON de.code_entidad  = CAST(tzg.cve_ent  AS VARCHAR) group by cve_mun) as vvv


 select  COUNT(*) from (                   
      select distinct CAST(tzg.cve_loc as VARCHAR) CODE_LOCALIDAD
        ,UPPER(localidad)
        ,ID_MUNICIPIO 
        FROM "SA".tmp_zona_geografica tzg 
          JOIN "DWH"."DM_MUNICIPIO" dm 
            ON dm.code_municipio  = CAST(tzg.cve_mun AS VARCHAR)
             --   JOIN "DWH"."DM_ENTIDAD" de
               --     ON dm.id_entidad  = de.id_entidad      
                    ) as vvv            
                    
                    
                    
SELECT CAST(tzg.cve_loc as VARCHAR) CODE_LOCALIDAD
        ,localidad, municipio
        
        FROM "SA".tmp_zona_geografica tzg where localidad = 'Salto de Agua';
        
        
        select desc_municipio, count(*)  from "DWH"."DM_MUNICIPIO" group by desc_municipio order by 1 desc ;
        
    
CREATE OR REPLACE FUNCTION "SA".sp_zona()
 RETURNS character
 LANGUAGE plpgsql
AS $function$   
  BEGIN

---------------------------------------------------------------------------------------------
-----------------------------Se crea tabla temporal zona geografica--------------------------
---------------------------------------------------------------------------------------------
CREATE TEMPORARY table TMP_ZONA AS 
(

  select cast(tzg.id_zona_geografica as varchar) id_zona_geografica, 
  			latitud, 
  			longitud, 
  			dl.id_localidad id_localidad 
  			from "SA".tmp_zona_geografica tzg 
  				join "DWH"."DM_LOCALIDAD" dl 	
  					on (cast(tzg.cve_loc as varchar) = dl.code_localidad and dl.desc_localidad = upper(tzg.localidad))
					    join "DWH"."DM_MUNICIPIO" dm 
						    on dm.id_municipio = dl.id_municipio and dm.code_municipio = cast(tzg.cve_mun as varchar)
						      join "DWH"."DM_ENTIDAD" de 
						      	on dm.id_entidad = de.id_entidad and de.code_entidad  = cast(tzg.cve_ent as varchar)
						      		order by 4
);  
     
------------------------------------------------------
----------------dwh.fact_ventas------------------
------------------------------------------------------
INSERT INTO "DWH"."DM_ZONA_GEOGRAFICA"
  (CODE_ZONA_GEOGRAFICA, 
  LATITUD,
   LONGITUD,
   ID_LOCALIDAD
   )
------TMP_FACT_VENT 
select id_zona_geografica,
       latitud,
     longitud,
     id_localidad
from TMP_ZONA;
      
    drop table TMP_ZONA;--elimina la temporal TMP_ZONA
return 'ok';   
END;
$function$
;


  select count(*)  from (
  select distinct cast(tzg.id_zona_geografica as varchar) id_zona_geografica, 
  			latitud, 
  			longitud,
  			dl.id_localidad id_localidad 
  			from "SA".tmp_zona_geografica tzg 
  				join "DWH"."DM_LOCALIDAD" dl 	
  					on (dl.desc_localidad = upper(tzg.localidad) and cast(tzg.cve_loc as varchar) = dl.code_localidad) -- ) as dddd
					    join "DWH"."DM_MUNICIPIO" dm 
						    on dm.code_municipio = cast(tzg.cve_mun as varchar) --and dm.id_municipio  = dl.id_municipio
						      join "DWH"."DM_ENTIDAD" de  
						      	on dm.id_entidad = de.id_entidad --and de.code_entidad  = cast(tzg.cve_ent as varchar) --where dl.id_localidad=1
						      		--group by id_localidad 
									--order by 4
									) as dddd
						      		
  select tzg.cve_mun 
  			from "SA".tmp_zona_geografica tzg 		
  			 group by tzg.cve_mun 
				
    select count(*)  from (			 
  		select  cast(tzg.id_zona_geografica as varchar) id_zona_geografica, 
  			latitud, 
  			longitud, 
  			dl.id_localidad,
  			tzg.cve_loc, tzg.cve_mun, tzg.cve_ent
  			from "SA".tmp_zona_geografica tzg 
  				join "DWH"."DM_LOCALIDAD" dl 	
  					on (cast(tzg.cve_loc as varchar) = dl.code_localidad and dl.desc_localidad = upper(tzg.localidad))
					    join "DWH"."DM_MUNICIPIO" dm 
						    on (dm.code_municipio = cast(tzg.cve_mun as varchar) and dm.id_municipio  = dl.id_municipio)
						      join "DWH"."DM_ENTIDAD" de 
						      	on de.code_entidad  = cast(tzg.cve_ent as varchar) and dm.id_entidad = de.id_entidad 
						      	order by 4, 1
						      	) as dddd
						      	
select * from 	 "SA".tmp_zona_geografica	where cve_loc	= null  
select * from 	 "SA".tmp_zona_geografica	where localidad = 'Villa Juárez' and cve_mun = 2 and cve_ent = 8 
select  cve_loc ,localidad, cve_mun  from  "SA".tmp_zona_geografica	where localidad	= 'Villa Juárez'
select count(*)  from  "SA".tmp_zona_geografica	where localidad	= 'Villa Juárez'
select cve_loc ,localidad from  "SA".tmp_zona_geografica	where id_zona_geografica = 34842
select * from  "SA".tmp_zona_geografica	where id_zona_geografica = 34842
select count(*)  from 	 "DWH"."DM_LOCALIDAD" order by 4
select * from 	 "DWH"."DM_LOCALIDAD" dl join "DWH"."DM_MUNICIPIO" dm on dm.id_municipio  = dl.id_municipio join "DWH"."DM_ENTIDAD" de on dm.id_entidad = de.id_entidad where desc_localidad	= 'VILLA JUÁREZ' and dm.code_municipio  = '2'
select count(*)  from 	 "DWH"."DM_ZONA_GEOGRAFICA" dzg 					      	
select * from 	 "DWH"."DM_ZONA_GEOGRAFICA" dzg order by 5,2;


select count(*)  from (	
SELECT distinct  CAST(tzg.cve_loc as VARCHAR) CODE_LOCALIDAD
        ,UPPER(localidad) localidad
        ,ID_MUNICIPIO , tzg.cve_mun 
        FROM "SA".tmp_zona_geografica tzg 
          JOIN "DWH"."DM_MUNICIPIO" dm 
            ON dm.code_municipio  = CAST(tzg.cve_mun AS VARCHAR) 
            	join "DWH"."DM_ENTIDAD" de 
					on de.code_entidad  = cast(tzg.cve_ent as varchar) and dm.id_entidad = de.id_entidad 
            	--where tzg.localidad = 'Villa Juárez'
                ORDER BY 3,2 ) as dddd
                
                SELECT distinct  *
        FROM "SA".tmp_zona_geografica tzg 
          JOIN "DWH"."DM_MUNICIPIO" dm 
            ON dm.code_municipio  = CAST(tzg.cve_mun AS VARCHAR) 
            	join "DWH"."DM_ENTIDAD" de 
					on de.code_entidad  = cast(tzg.cve_ent as varchar) and dm.id_entidad = de.id_entidad 
            	where tzg.localidad = 'Villa Juárez'
                ORDER BY 3,2
                
select * from 	"DWH"."DM_ANIO" da ;         "SA".pro_dim_tiempo     


select code_entidad ,desc_entidad  from "DWH"."DM_ENTIDAD" de 
union all
select cast(cve_ent as varchar) cve_ent, entidad from "SA".tmp_zona_geografica tzg group by cve_ent, entidad;   

select code_entidad ,desc_entidad  from "DWH"."DM_ENTIDAD" de 
intersect
select cast(cve_ent as varchar) cve_ent, entidad from "SA".tmp_zona_geografica tzg group by cve_ent, entidad;   

Select cast(cve_ent as varchar) cve_ent, entidad from "SA".tmp_zona_geografica where not exists (select code_entidad ,desc_entidad  from "DWH"."DM_ENTIDAD" de 
union
select cast(cve_ent as varchar) cve_ent, entidad from "SA".tmp_zona_geografica tzg group by cve_ent, entidad)

Select code_entidad ,desc_entidad  from "DWH"."DM_ENTIDAD" where not exists (select code_entidad ,desc_entidad  from "DWH"."DM_ENTIDAD" de 
intersect
select cast(cve_ent as varchar) cve_ent, entidad from "SA".tmp_zona_geografica tzg group by cve_ent, entidad) order by 1

Select * from "DWH"."DM_ENTIDAD" e left join "SA".tmp_zona_geografica tzg on e.code_entidad=cast(tzg.cve_ent as varchar) where t2.id is null;

select distinct  code_entidad  ,desc_entidad from "DWH"."DM_ENTIDAD" e left join "SA".tmp_zona_geografica tzg on e.code_entidad=cast(tzg.cve_ent as varchar) where tzg.cve_ent is null;