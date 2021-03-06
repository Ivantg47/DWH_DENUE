CREATE SCHEMA "DWH";
CREATE SCHEMA "SA";
CREATE SCHEMA "PART";

-------------------------------------------------
-------------------DM_ANIO----------------------
-------------------------------------------------

CREATE TABLE "DWH"."DM_ANIO"
(
  ANIO_ID INT NOT NULL,
  ANIO_DESC VARCHAR(30),
  CONSTRAINT PK_DM_ANIO PRIMARY KEY (ANIO_ID) 
);
insert into "DWH"."DM_ANIO" values (0, 'INDEFINIDO');
--------------------------------------------------
-----------------DM_MES--------------------------
--------------------------------------------------

CREATE TABLE "DWH"."DM_MES"
(
  MES_ID INT NOT NULL,
  ANIO_ID INT NOT NULL,
  MES_DESC VARCHAR(30),
  CONSTRAINT PK_DM_MES PRIMARY KEY (MES_ID), 
  CONSTRAINT FK_DM_MES_DM_ANIO FOREIGN KEY (ANIO_ID)
  REFERENCES "DWH"."DM_ANIO" (ANIO_ID) 
  ON UPDATE CASCADE
  ON DELETE CASCADE  
);
insert into "DWH"."DM_MES" values (0, 0, 'INDEFINIDO');
--------------------------------------------------
----------------DM_ACTIVIDAD----------------------
--------------------------------------------------
CREATE TABLE "DWH"."DM_ACTIVIDAD"
(
    ID_ACT INT NOT NULL GENERATED BY DEFAULT AS IDENTITY
    ,CODE_ACT VARCHAR(6)
    ,NOMBRE_ACT VARCHAR(250)
    ,CONSTRAINT PK_DM_ACTIVIDAD PRIMARY KEY (ID_ACT)
);
insert into "DWH"."DM_ACTIVIDAD" (CODE_ACT,NOMBRE_ACT ) values ('INDEF', 'INDEFINIDO');
--------------------------------------------------
-------------DM_ESTABLECIMIENTO-------------------
--------------------------------------------------
CREATE TABLE "DWH"."DM_ESTABLECIMIENTO"
(
    ID_ESTAB INT NOT NULL GENERATED BY DEFAULT AS IDENTITY
    ,CODE_ESTAB VARCHAR(10) NOT NULL
    ,NOM_ESTAB VARCHAR(250)
    ,RAZ_SOCIAL VARCHAR(250)
    ,FECHA_ALTA INT
    ,TIPOUNIECO VARCHAR(10)
    ,ID_ACT INT NOT NULL
    ,CONSTRAINT PK_DM_ESTABLECIMIENTO PRIMARY KEY (ID_ESTAB)  
)PARTITION BY RANGE (ID_ESTAB);

-------------------------------------------------
--------------------SE CREAN TABLAS HIJAS--------
-------------------------------------------------

CREATE TABLE "PART"."ESTABLECIMIENTO_01" PARTITION OF "DWH"."DM_ESTABLECIMIENTO" 
    FOR VALUES FROM (0) TO (50000); -- se delimita el rango de las particiones
CREATE TABLE "PART"."ESTABLECIMIENTO_02" PARTITION OF "DWH"."DM_ESTABLECIMIENTO" 
    FOR VALUES FROM (50000) TO (100000);
CREATE TABLE "PART"."ESTABLECIMIENTO_03" PARTITION OF "DWH"."DM_ESTABLECIMIENTO" 
    FOR VALUES FROM (100000) TO (150000); 
CREATE TABLE "PART"."ESTABLECIMIENTO_04" PARTITION OF "DWH"."DM_ESTABLECIMIENTO" 
    FOR VALUES FROM (150000) TO (200000);
CREATE TABLE "PART"."ESTABLECIMIENTO_05" PARTITION OF "DWH"."DM_ESTABLECIMIENTO" 
    FOR VALUES FROM (200000) TO (250000);
CREATE TABLE "PART"."ESTABLECIMIENTO_06" PARTITION OF "DWH"."DM_ESTABLECIMIENTO" 
    FOR VALUES FROM (250000) TO (300000);
CREATE TABLE "PART"."ESTABLECIMIENTO_07" PARTITION OF "DWH"."DM_ESTABLECIMIENTO" 
    FOR VALUES FROM (300000) TO (350000); 
CREATE TABLE "PART"."ESTABLECIMIENTO_08" PARTITION OF "DWH"."DM_ESTABLECIMIENTO" 
    FOR VALUES FROM (350000) TO (400000);
CREATE TABLE "PART"."ESTABLECIMIENTO_09" PARTITION OF "DWH"."DM_ESTABLECIMIENTO" 
    FOR VALUES FROM (400000) TO (450000); 
CREATE TABLE "PART"."ESTABLECIMIENTO_10" PARTITION OF "DWH"."DM_ESTABLECIMIENTO" 
    FOR VALUES FROM (450000) TO (500000);
CREATE TABLE "PART"."ESTABLECIMIENTO_11" PARTITION OF "DWH"."DM_ESTABLECIMIENTO" 
    FOR VALUES FROM (500000) TO (550000); 
CREATE TABLE "PART"."ESTABLECIMIENTO_12" PARTITION OF "DWH"."DM_ESTABLECIMIENTO" 
    FOR VALUES FROM (550000) TO (600000);
CREATE TABLE "PART"."ESTABLECIMIENTO_13" PARTITION OF "DWH"."DM_ESTABLECIMIENTO" 
    FOR VALUES FROM (600000) TO (650000);
CREATE TABLE "PART"."ESTABLECIMIENTO_14" PARTITION OF "DWH"."DM_ESTABLECIMIENTO" 
    FOR VALUES FROM (650000) TO (700000);
CREATE TABLE "PART"."ESTABLECIMIENTO_15" PARTITION OF "DWH"."DM_ESTABLECIMIENTO" 
    FOR VALUES FROM (700000) TO (750000);

insert into "DWH"."DM_ESTABLECIMIENTO" (CODE_ESTAB, NOM_ESTAB, RAZ_SOCIAL,FECHA_ALTA,TIPOUNIECO,ID_ACT) values ('INDEFINIDO', 'INDEFINIDO', 'INDEFINIDO', 0, 'INDEFINIDO', 1);

--------------------------------------------------
-------------DM_ENTIDAD-------------------
--------------------------------------------------
CREATE TABLE "DWH"."DM_ENTIDAD"
(
    ID_ENTIDAD INT NOT NULL GENERATED BY DEFAULT AS IDENTITY
    ,CODE_ENTIDAD VARCHAR(100) NOT NULL
    ,DESC_ENTIDAD VARCHAR(100)
    ,CONSTRAINT PK_DM_ENTIDAD PRIMARY KEY (ID_ENTIDAD)
);

insert into "DWH"."DM_ENTIDAD" (CODE_ENTIDAD,DESC_ENTIDAD) values ('INDEFINIDO', 'INDEFINIDO');

--------------------------------------------------
-------------DM_MUNICIPIO-------------------
--------------------------------------------------
CREATE TABLE "DWH"."DM_MUNICIPIO"
(
    ID_MUNICIPIO INT NOT NULL GENERATED BY DEFAULT AS IDENTITY
    ,CODE_MUNICIPIO VARCHAR(100) NOT NULL
    ,DESC_MUNICIPIO VARCHAR(100)
    ,ID_ENTIDAD INT NOT NULL
    ,CONSTRAINT PK_DM_MUNICIPIO PRIMARY KEY (ID_MUNICIPIO)
);

insert into "DWH"."DM_MUNICIPIO" (CODE_MUNICIPIO, DESC_MUNICIPIO, ID_ENTIDAD) values ('INDEFINIDO', 'INDEFINIDO', 1);

--------------------------------------------------
-------------DM_LOCALIDAD-------------------
--------------------------------------------------
CREATE TABLE "DWH"."DM_LOCALIDAD"
(
    ID_LOCALIDAD INT NOT NULL GENERATED BY DEFAULT AS IDENTITY
    ,CODE_LOCALIDAD VARCHAR(100) NOT NULL
    ,DESC_LOCALIDAD VARCHAR(100)
    ,ID_MUNICIPIO INT NOT NULL
    ,CONSTRAINT PK_DM_LOCALIDAD PRIMARY KEY (ID_LOCALIDAD)
);
   
insert into "DWH"."DM_LOCALIDAD" (CODE_LOCALIDAD, DESC_LOCALIDAD, ID_MUNICIPIO) values ('INDEFINIDO', 'INDEFINIDO', 1);

--------------------------------------------------
-------------DM_ZONA_GEOGRAFICA-------------------
--------------------------------------------------
CREATE TABLE "DWH"."DM_ZONA_GEOGRAFICA"
(
    ID_ZONA_GEOGRAFICA INT NOT NULL GENERATED BY DEFAULT AS identity
    ,CODE_ZONA_GEOGRAFICA VARCHAR(10)
    ,LATITUD NUMERIC(21, 8)
    ,LONGITUD NUMERIC(21, 8)
    ,ID_LOCALIDAD INT NOT NULL
    ,CONSTRAINT PK_DM_ZONA_GEOGRAFICA PRIMARY KEY (ID_ZONA_GEOGRAFICA)
)PARTITION BY RANGE (ID_ZONA_GEOGRAFICA);

-------------------------------------------------
--------------------SE CREAN TABLAS HIJAS--------
-------------------------------------------------

CREATE TABLE "PART"."ZONA_GEOGRAFICA_01" PARTITION OF "DWH"."DM_ZONA_GEOGRAFICA" 
    FOR VALUES FROM (0) TO (50000); -- se delimita el rango de las particiones
CREATE TABLE "PART"."ZONA_GEOGRAFICA_02" PARTITION OF "DWH"."DM_ZONA_GEOGRAFICA" 
    FOR VALUES FROM (50000) TO (100000);
CREATE TABLE "PART"."ZONA_GEOGRAFICA_03" PARTITION OF "DWH"."DM_ZONA_GEOGRAFICA" 
    FOR VALUES FROM (100000) TO (150000); 
CREATE TABLE "PART"."ZONA_GEOGRAFICA_04" PARTITION OF "DWH"."DM_ZONA_GEOGRAFICA" 
    FOR VALUES FROM (150000) TO (200000);
CREATE TABLE "PART"."ZONA_GEOGRAFICA_05" PARTITION OF "DWH"."DM_ZONA_GEOGRAFICA" 
    FOR VALUES FROM (200000) TO (250000);
CREATE TABLE "PART"."ZONA_GEOGRAFICA_06" PARTITION OF "DWH"."DM_ZONA_GEOGRAFICA" 
    FOR VALUES FROM (250000) TO (300000);
CREATE TABLE "PART"."ZONA_GEOGRAFICA_07" PARTITION OF "DWH"."DM_ZONA_GEOGRAFICA" 
    FOR VALUES FROM (300000) TO (350000); 
CREATE TABLE "PART"."ZONA_GEOGRAFICA_08" PARTITION OF "DWH"."DM_ZONA_GEOGRAFICA" 
    FOR VALUES FROM (350000) TO (400000);
CREATE TABLE "PART"."ZONA_GEOGRAFICA_09" PARTITION OF "DWH"."DM_ZONA_GEOGRAFICA" 
    FOR VALUES FROM (400000) TO (450000); 
CREATE TABLE "PART"."ZONA_GEOGRAFICA_10" PARTITION OF "DWH"."DM_ZONA_GEOGRAFICA" 
    FOR VALUES FROM (450000) TO (500000);
CREATE TABLE "PART"."ZONA_GEOGRAFICA_11" PARTITION OF "DWH"."DM_ZONA_GEOGRAFICA" 
    FOR VALUES FROM (500000) TO (550000); 
CREATE TABLE "PART"."ZONA_GEOGRAFICA_12" PARTITION OF "DWH"."DM_ZONA_GEOGRAFICA" 
    FOR VALUES FROM (550000) TO (600000);
CREATE TABLE "PART"."ZONA_GEOGRAFICA_13" PARTITION OF "DWH"."DM_ZONA_GEOGRAFICA" 
    FOR VALUES FROM (600000) TO (650000);
CREATE TABLE "PART"."ZONA_GEOGRAFICA_14" PARTITION OF "DWH"."DM_ZONA_GEOGRAFICA" 
    FOR VALUES FROM (650000) TO (700000);
CREATE TABLE "PART"."ZONA_GEOGRAFICA_15" PARTITION OF "DWH"."DM_ZONA_GEOGRAFICA" 
    FOR VALUES FROM (700000) TO (750000);

insert into "DWH"."DM_ZONA_GEOGRAFICA" (CODE_ZONA_GEOGRAFICA, LATITUD, LONGITUD, ID_LOCALIDAD) values ('INDEFINIDO', null, 
null, 1);
--------------------------------------------------
-------------FACT_ESTADISTICA-------------------
--------------------------------------------------

-----------------------------------------------------------------
-------------------------SE CREA LA TABLA PADRE------------------
-----------------------------------------------------------------
CREATE TABLE "DWH"."FACT_ESTADISTICA"
(
    ID_ANIO INT NOT NULL
    ,ID_ZONA_GEOGRAFICA INT NOT NULL
    ,ID_EST INT NOT NULL
    ,MIN_PERSONA INT 
    ,MAX_PERSONA INT
    --,CONSTRAINT PK_FACT_ESTADISTICA PRIMARY KEY (ID_ANIO, ID_ZONA_GEOGRAFICA, ID_EST)
)PARTITION BY RANGE (ID_EST);

-------------------------------------------------
--------------------SE CREAN TABLAS HIJAS--------
-------------------------------------------------
CREATE TABLE "PART"."ESTADISTICA_01" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (0) TO (50000); -- se delimita el rango de las particiones
CREATE TABLE "PART"."ESTADISTICA_02" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (50000) TO (100000);
CREATE TABLE "PART"."ESTADISTICA_03" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (100000) TO (150000); 
CREATE TABLE "PART"."ESTADISTICA_04" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (150000) TO (200000);
CREATE TABLE "PART"."ESTADISTICA_05" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (200000) TO (250000);
CREATE TABLE "PART"."ESTADISTICA_06" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (250000) TO (300000);
CREATE TABLE "PART"."ESTADISTICA_07" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (300000) TO (350000); 
CREATE TABLE "PART"."ESTADISTICA_08" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (350000) TO (400000);
CREATE TABLE "PART"."ESTADISTICA_09" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (400000) TO (450000); 
CREATE TABLE "PART"."ESTADISTICA_10" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (450000) TO (500000);
CREATE TABLE "PART"."ESTADISTICA_11" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (500000) TO (550000); 
CREATE TABLE "PART"."ESTADISTICA_12" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (550000) TO (600000);
CREATE TABLE "PART"."ESTADISTICA_13" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (600000) TO (650000);
CREATE TABLE "PART"."ESTADISTICA_14" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (650000) TO (700000);
CREATE TABLE "PART"."ESTADISTICA_15" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (700000) TO (750000);
CREATE TABLE "PART"."ESTADISTICA_16" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (750000) TO (800000);
CREATE TABLE "PART"."ESTADISTICA_17" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (800000) TO (850000); 
CREATE TABLE "PART"."ESTADISTICA_18" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (850000) TO (900000);
CREATE TABLE "PART"."ESTADISTICA_19" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (900000) TO (950000); 
CREATE TABLE "PART"."ESTADISTICA_20" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (950000) TO (1000000);
CREATE TABLE "PART"."ESTADISTICA_21" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (1000000) TO (1050000);
CREATE TABLE "PART"."ESTADISTICA_22" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (1050000) TO (1100000);
CREATE TABLE "PART"."ESTADISTICA_23" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (1100000) TO (1150000); 
CREATE TABLE "PART"."ESTADISTICA_24" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (1150000) TO (1200000);
CREATE TABLE "PART"."ESTADISTICA_25" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (1200000) TO (1250000);
CREATE TABLE "PART"."ESTADISTICA_26" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (1250000) TO (1300000);
CREATE TABLE "PART"."ESTADISTICA_27" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (1300000) TO (1350000); 
CREATE TABLE "PART"."ESTADISTICA_28" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (1350000) TO (1400000);
CREATE TABLE "PART"."ESTADISTICA_29" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (1400000) TO (1450000); 
CREATE TABLE "PART"."ESTADISTICA_30" PARTITION OF "DWH"."FACT_ESTADISTICA" 
    FOR VALUES FROM (1450000) TO (1500000);



-----------------------------------------------------------------
-------------------------SE CREA TABLA TMP tiempo----------------
-----------------------------------------------------------------
CREATE TABLE "SA".TMP_TIEMPO
(
	DIA_ID INT NOT NULL,
	DIA_DESC date,
	ANIO_ID INT NOT NULL,
  	ANIO_DESC VARCHAR(30),
	MES_ID INT NOT NULL,
	MES_DESC VARCHAR(30),
	DIA_DESC2 VARCHAR(30),
	DIA_SEMANA VARCHAR(30), 
	TRIMESTRE_ID int,
	TRIMESTRE_DESC VARCHAR(30),
	SEMESTRE_ID INT,
	SEMESTRE_DESC VARCHAR(30)
  
);


--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--
--<<<<<<<<<<<<<<<<<<<Procedimiento llenado tiempo>>>>>>>>>>>>>>>>>>>>>>>--
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--
CREATE OR REPLACE FUNCTION "SA".pro_dim_tiempo(anio integer)
 RETURNS date
 LANGUAGE plpgsql
AS $function$
     DECLARE 
	    Fecha_ini  varchar;
        Fecha_fin varchar;
		
	 BEGIN
	 
	 anio:=cast (anio as varchar);
     Fecha_ini:=anio||'0101' ;
     Fecha_fin:=anio||'1231';
	 Fecha_ini:=cast(Fecha_ini as date);
     Fecha_fin:=cast(Fecha_fin as date);


CREATE TEMPORARY TABLE fecha(fecha date) ON COMMIT DELETE ROWS;

while Fecha_ini <= Fecha_fin
  Loop    
     insert into fecha(fecha) values(cast(Fecha_ini as date));
     Fecha_ini:=cast(Fecha_ini as date)+1;

   End Loop;

DELETE FROM "SA".TMP_TIEMPO
   WHERE ANIO_ID=anio;

insert into "SA".TMP_TIEMPO 
select 
       cast(to_char( fecha,'yyyymmdd') as int) DIA_ID,
       fecha DIA_DESC,
       cast(to_char( fecha,'yyyy') as int) ANIO_ID,
       'A??O '||to_char( fecha,'yyyy') ANIO_DESC,
      cast( to_char( fecha,'YYYYMM') as int) MES_ID,
       to_char( fecha,'TMMonth')||' '||to_char(fecha,'YYYY') MES_DESC, -- el prefijo TM muestra los datos en el lenguage configurado en lc_time de lo contrario muestra el Default
       to_char( fecha,'dd')||' de '||to_char( fecha,'TMMonth')||' '||to_char( fecha,'yyyy') DIA_DESC2,
       to_char( fecha,'TMDay') DIA_SEMANA,
      cast( to_char( fecha,'yyyy')||'0'||to_char( fecha,'q') as int) TRIMESTRE_ID,
       '0'||to_char( fecha,'q')||' TRIMESTRE '||to_char( fecha,'yyyy') TRIMESTRE_DESC,
      cast( to_char( fecha,'yyyy')||case when cast(to_char( fecha,'q')as INT)<=2 then '01' else '02' end as int) SEMESTRE_ID,
       (case when cast(to_char( fecha,'q')as INT)<=2 then '01' else '02' end)||' SEMESTRE '||to_char( fecha,'yyyy') SEMESTRE_DESC
       
from FECHA ;


------------------------------------------
---------Inserts DM_ANIO-----------------
------------------------------------------

DELETE FROM "DWH"."DM_ANIO" 
    WHERE ANIO_ID=ANIO;

INSERT INTO "DWH"."DM_ANIO" (ANIO_ID
                              ,ANIO_DESC)
	   SELECT DISTINCT A.ANIO_ID, A.ANIO_DESC
	    FROM  "SA".TMP_TIEMPO A
	WHERE A.ANIO_ID=anio;


------------------------------------------
---------Inserts DM_MES-------------
------------------------------------------

DELETE FROM "DWH"."DM_MES" 
    WHERE ANIO_ID=anio;

INSERT INTO "DWH"."DM_MES" (MES_ID
                               ,ANIO_ID
                              ,MES_DESC)
	   SELECT DISTINCT A.MES_ID,A.ANIO_ID,A.MES_DESC
	    FROM  "SA".TMP_TIEMPO A
	WHERE A.ANIO_ID=anio;

drop table fecha;

 return Fecha_ini; 	 
END;
$function$
;


--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--
--<<<<<<<<<<<<<<<<<Procedimiento llenado zona geografica>>>>>>>>>>>>>>>>--
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--

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
    SELECT tmp.id_zona, 
        tmp.latitud, 
        tmp.longitud, 
        tmp.id_localidad  
    FROM "DWH"."DM_ZONA_GEOGRAFICA" g 
            RIGHT JOIN (select cast(tzg.id_zona_geografica as varchar) id_zona
            ,tzg.latitud 
            ,tzg.longitud 
            ,dl.id_localidad
            from "SA".tmp_establecimiento te 
            inner join "SA".tmp_zona_geografica tzg  
            on tzg.id_zona_geografica = te.id_est
                right  join "DWH"."DM_LOCALIDAD" dl 
                    on dl.desc_localidad = upper(tzg.localidad) and cast(tzg.cve_loc as varchar) = dl.code_localidad
                    join "DWH"."DM_MUNICIPIO" dm 
                        on dm.code_municipio  = cast(tzg.cve_mun as varchar) and dl.id_municipio = dm.id_municipio
                            order by dm.id_municipio) 
                            AS tmp 
                            ON tmp.id_zona = g.code_zona_geografica
                            WHERE g.id_zona_geografica IS NULL 
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


--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--
--<<<<<<<<<<<<<<<<<Procedimiento llenado fact estadistica>>>>>>>>>>>>>>>>--
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--
CREATE OR REPLACE FUNCTION "SA".sp_fact_estadistica(fecha integer)
 RETURNS character
 LANGUAGE plpgsql
AS $function$   
  BEGIN

DELETE FROM "DWH"."FACT_ESTADISTICA"
    WHERE ID_ANIO = fecha;
---------------------------------------------------------------------------------------------
-----------------------------Se crea tabla temporal TMP_FACT_ESTADISTICA---------------------
---------------------------------------------------------------------------------------------
CREATE TEMPORARY table TMP_FACT_ESTADISTICA AS 
(

  SELECT de.id_estab , ID_EST,
     dzg.id_zona_geografica, ID_ZONA,
     CAST(NULL AS INT) ID_FECHA,
     CAST(SUBSTRING(per_ocu, '[0-9]{1,3}') AS INT) MIN_PERSONA,
     CAST(SUBSTRING( SUBSTRING(per_ocu, 5, 5), '[0-9]{1,3}')AS INT) MAX_PERSONA
    FROM "SA".tmp_estaditica e
      JOIN "DWH"."DM_ZONA_GEOGRAFICA" dzg 
        ON dzg.code_zona_geografica = CAST(e.id_zona AS VARCHAR)
      JOIN "DWH"."DM_ESTABLECIMIENTO" de 
        ON de.code_estab = CAST(e.id_est  AS VARCHAR) ORDER BY 1
);  

----------------------------------------------------------------------------------
--------------------------SE ACTUALIZA ID_FECHA-----------------------------------
----------------------------------------------------------------------------------
UPDATE TMP_FACT_ESTADISTICA
     SET id_fecha=fecha;
  
     
------------------------------------------------------
----------------DWH.FACT_ESTADISTICA------------------
------------------------------------------------------
INSERT INTO "DWH"."FACT_ESTADISTICA"
  (ID_EST, 
   ID_ZONA_GEOGRAFICA,
   ID_ANIO,
   MIN_PERSONA,
   MAX_PERSONA
   )
------TMP_FACT_VENT 
SELECT ID_ESTAB, 
   ID_ZONA_GEOGRAFICA,
   ID_FECHA,
   MIN_PERSONA,
   MAX_PERSONA
FROM TMP_FACT_ESTADISTICA ON CONFLICT DO NOTHING;
      
    DROP TABLE TMP_FACT_ESTADISTICA;--elimina la temporal TMP_FACT_ESTADISTICA
RETURN 'ok';   
END;
$function$
;

--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--
--<<<<<<<<<<<<<<<<Procedimiento llenado dm establecimiento>>>>>>>>>>>>>>>--
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--
CREATE OR REPLACE FUNCTION "SA".sp_dm_establecimiento()
 RETURNS character
 LANGUAGE plpgsql
AS $function$   
  BEGIN

---------------------------------------------------------------------------------------------
-----------------------------Se crea tabla temporal TMP_ESTABLECIMIENTO----------------------
---------------------------------------------------------------------------------------------
CREATE TEMPORARY table TMP_ESTABLECIMIENTO AS 
(
  SELECT CAST(id_est as VARCHAR) CODE_ESTAB
    ,UPPER(NOM_ESTAB)
    ,UPPER(RAZ_SOCIAL)
    ,CAST(SUBSTRING(fecha_alta, '[0-9]{1,4}') || SUBSTRING(SUBSTRING(fecha_alta, 5, 5), '[0-9]{1,3}')AS INT) FECHA_ALTA
    ,UPPER(TIPOUNIECO)
    ,ID_ACT
    FROM "SA".tmp_establecimiento e
      JOIN "DWH"."DM_ACTIVIDAD" a
        ON a.CODE_ACT = CAST(e.codigo_act AS VARCHAR)
            ORDER BY 2,3
);  

----------------------------------------------------------------------------------
---------------------SE ACTUALIZA RAZ_SOCIAL ID_ACT-------------------------------
----------------------------------------------------------------------------------
UPDATE TMP_ESTABLECIMIENTO
     SET RAZ_SOCIAL='INDEFINIDO' WHERE RAZ_SOCIAL IS NULL;
UPDATE TMP_ESTABLECIMIENTO
     SET ID_ACT=0 WHERE ID_ACT IS NULL;
  
     
------------------------------------------------------
----------------DWH.ESTABLECIMIENTO------------------
------------------------------------------------------
INSERT INTO "DWH"."DM_ESTABLECIMIENTO"
  (CODE_ESTAB
    ,NOM_ESTAB
    ,RAZ_SOCIAL
    ,FECHA_ALTA
    ,TIPOUNIECO
    ,ID_ACT
   )
------TMP_ESTABLECIMIENTO 
SELECT CODE_ESTAB
    ,NOM_ESTAB
    ,RAZ_SOCIAL
    ,FECHA_ALTA
    ,TIPOUNIECO
    ,ID_ACT
FROM TMP_ESTABLECIMIENTO;
      
    DROP TABLE TMP_ESTABLECIMIENTO;--elimina la temporal TMP_ESTABLECIMIENTO
RETURN 'ok';   
END;
$function$
;

--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--
--<<<<<<<<<<<<<<<<<<<Procedimiento llenado dm localidad>>>>>>>>>>>>>>>>>>--
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--
CREATE OR REPLACE FUNCTION "SA".sp_dm_localidad()
 RETURNS character
 LANGUAGE plpgsql
AS $function$   
  BEGIN

---------------------------------------------------------------------------------------------
-----------------------------Se crea tabla temporal TMP_LOCALIDAD----------------------------
---------------------------------------------------------------------------------------------
CREATE TEMPORARY table TMP_LOCALIDAD AS 
(
    SELECT  tmp.CODE_LOCALIDAD 
            ,tmp.localidad
            ,tmp.ID_MUNICIPIO
    FROM "DWH"."DM_LOCALIDAD" dl
        RIGHT JOIN (SELECT DISTINCT CAST(tzg.cve_loc AS VARCHAR) CODE_LOCALIDAD
                        ,UPPER(localidad) localidad
                        ,ID_MUNICIPIO 
                        FROM "SA".tmp_zona_geografica tzg 
                          JOIN "DWH"."DM_MUNICIPIO" dm 
                            ON dm.code_municipio  = CAST(tzg.cve_mun AS VARCHAR)
                                JOIN "DWH"."DM_ENTIDAD" de 
                                    ON de.code_entidad  = cast(tzg.cve_ent AS VARCHAR) AND dm.id_entidad = de.id_entidad
                                ORDER BY 3,2
                    ) AS tmp ON dl.CODE_LOCALIDAD = tmp.CODE_LOCALIDAD and  dl.desc_localidad = tmp.localidad
                        WHERE dl.id_localidad IS NULL 
                        ORDER BY 3 desc
              
);  

----------------------------------------------------------------------------------
--------------------------SE ACTUALIZA ID_MUNICIPIO-------------------------------
----------------------------------------------------------------------------------
UPDATE TMP_LOCALIDAD
     SET ID_MUNICIPIO=1 WHERE ID_MUNICIPIO IS NULL;
  
   
------------------------------------------------------
----------------DWH.ESTABLECIMIENTO------------------
------------------------------------------------------
INSERT INTO "DWH"."DM_LOCALIDAD"
  (CODE_LOCALIDAD
    ,DESC_LOCALIDAD
    ,ID_MUNICIPIO
   )
------TMP_ESTABLECIMIENTO 
SELECT CODE_LOCALIDAD
    ,localidad
    ,ID_MUNICIPIO
FROM TMP_LOCALIDAD;
      
    DROP TABLE TMP_LOCALIDAD;--elimina la temporal TMP_LOCALIDAD
RETURN 'ok';   
END;
$function$
;

------------------------------------------
----------------tablas SA-----------------
------------------------------------------
CREATE TABLE "SA".TMP_ZONA_GEOGRAFICA
(
  id_zona_geografica BIGINT
, cve_ent BIGINT
, entidad VARCHAR(200)
, cve_mun BIGINT
, municipio VARCHAR(200)
, cve_loc BIGINT
, localidad VARCHAR(200)
, latitud NUMERIC(21, 8)
, longitud NUMERIC(21, 8)
)PARTITION BY RANGE (id_zona_geografica);

CREATE TABLE "PART"."ZONA_GEO01" PARTITION OF "SA".TMP_ZONA_GEOGRAFICA
    FOR VALUES FROM (1) TO (500000); -- se delimita el rango de las particiones
CREATE TABLE "PART"."ZONA_GEO02" PARTITION OF "SA".TMP_ZONA_GEOGRAFICA
    FOR VALUES FROM (500000) TO (1000000);
CREATE TABLE "PART"."ZONA_GEO03" PARTITION OF "SA".TMP_ZONA_GEOGRAFICA
    FOR VALUES FROM (1000000) TO (1500000); 
CREATE TABLE "PART"."ZONA_GEO04" PARTITION OF "SA".TMP_ZONA_GEOGRAFICA
    FOR VALUES FROM (1500000) TO (2000000);
CREATE TABLE "PART"."ZONA_GEO05" PARTITION OF "SA".TMP_ZONA_GEOGRAFICA
    FOR VALUES FROM (2000000) TO (2500000);
CREATE TABLE "PART"."ZONA_GEO06" PARTITION OF "SA".TMP_ZONA_GEOGRAFICA
    FOR VALUES FROM (2500000) TO (3000000);
CREATE TABLE "PART"."ZONA_GEO07" PARTITION OF "SA".TMP_ZONA_GEOGRAFICA
    FOR VALUES FROM (3000000) TO (3500000); 
CREATE TABLE "PART"."ZONA_GEO08" PARTITION OF "SA".TMP_ZONA_GEOGRAFICA
    FOR VALUES FROM (3500000) TO (4000000);
CREATE TABLE "PART"."ZONA_GEO09" PARTITION OF "SA".TMP_ZONA_GEOGRAFICA
    FOR VALUES FROM (4000000) TO (4500000); 
CREATE TABLE "PART"."ZONA_GEO10" PARTITION OF "SA".TMP_ZONA_GEOGRAFICA
    FOR VALUES FROM (4500000) TO (5000000);
CREATE TABLE "PART"."ZONA_GEO11" PARTITION OF "SA".TMP_ZONA_GEOGRAFICA
    FOR VALUES FROM (5000000) TO (5500000); 
CREATE TABLE "PART"."ZONA_GEO12" PARTITION OF "SA".TMP_ZONA_GEOGRAFICA
    FOR VALUES FROM (5500000) TO (6000000);
CREATE TABLE "PART"."ZONA_GEO13" PARTITION OF "SA".TMP_ZONA_GEOGRAFICA
    FOR VALUES FROM (6000000) TO (6500000);
CREATE TABLE "PART"."ZONA_GEO14" PARTITION OF "SA".TMP_ZONA_GEOGRAFICA
    FOR VALUES FROM (6500000) TO (7000000);
CREATE TABLE "PART"."ZONA_GEO15" PARTITION OF "SA".TMP_ZONA_GEOGRAFICA
    FOR VALUES FROM (7000000) TO (7500000);
CREATE TABLE "PART"."ZONA_GEO16" PARTITION OF "SA".TMP_ZONA_GEOGRAFICA
    FOR VALUES FROM (7500000) TO (8000000);
CREATE TABLE "PART"."ZONA_GEO17" PARTITION OF "SA".TMP_ZONA_GEOGRAFICA
    FOR VALUES FROM (8000000) TO (8500000); 
CREATE TABLE "PART"."ZONA_GEO18" PARTITION OF "SA".TMP_ZONA_GEOGRAFICA
    FOR VALUES FROM (8500000) TO (9000000);
CREATE TABLE "PART"."ZONA_GEO19" PARTITION OF "SA".TMP_ZONA_GEOGRAFICA
    FOR VALUES FROM (9000000) TO (9500000); 
CREATE TABLE "PART"."ZONA_GEO20" PARTITION OF "SA".TMP_ZONA_GEOGRAFICA
    FOR VALUES FROM (9500000) TO (10000000);

 -------------------------------------------------------------------------------------------   
CREATE TABLE "SA".tmp_estaditica
(
  id_est BIGINT
, id_zona BIGINT
, id_anio INT
, per_ocu VARCHAR(20)
)PARTITION BY RANGE (id_est);

CREATE TABLE "PART"."tmp_estaditica_01" PARTITION OF "SA".tmp_estaditica
    FOR VALUES FROM (1) TO (500000); -- se delimita el rango de las particiones
CREATE TABLE "PART"."tmp_estaditica_02" PARTITION OF "SA".tmp_estaditica
    FOR VALUES FROM (500000) TO (1000000);
CREATE TABLE "PART"."tmp_estaditica_03" PARTITION OF "SA".tmp_estaditica
    FOR VALUES FROM (1000000) TO (1500000); 
CREATE TABLE "PART"."tmp_estaditica_04" PARTITION OF "SA".tmp_estaditica
    FOR VALUES FROM (1500000) TO (2000000);
CREATE TABLE "PART"."tmp_estaditica_05" PARTITION OF "SA".tmp_estaditica
    FOR VALUES FROM (2000000) TO (2500000);
CREATE TABLE "PART"."tmp_estaditica_06" PARTITION OF "SA".tmp_estaditica
    FOR VALUES FROM (2500000) TO (3000000);
CREATE TABLE "PART"."tmp_estaditica_07" PARTITION OF "SA".tmp_estaditica
    FOR VALUES FROM (3000000) TO (3500000); 
CREATE TABLE "PART"."tmp_estaditica_08" PARTITION OF "SA".tmp_estaditica
    FOR VALUES FROM (3500000) TO (4000000);
CREATE TABLE "PART"."tmp_estaditica_09" PARTITION OF "SA".tmp_estaditica
    FOR VALUES FROM (4000000) TO (4500000); 
CREATE TABLE "PART"."tmp_estaditica_10" PARTITION OF "SA".tmp_estaditica
    FOR VALUES FROM (4500000) TO (5000000);
CREATE TABLE "PART"."tmp_estaditica_11" PARTITION OF "SA".tmp_estaditica
    FOR VALUES FROM (5000000) TO (5500000); 
CREATE TABLE "PART"."tmp_estaditica_12" PARTITION OF "SA".tmp_estaditica
    FOR VALUES FROM (5500000) TO (6000000);
CREATE TABLE "PART"."tmp_estaditica_13" PARTITION OF "SA".tmp_estaditica
    FOR VALUES FROM (6000000) TO (6500000);
CREATE TABLE "PART"."tmp_estaditica_14" PARTITION OF "SA".tmp_estaditica
    FOR VALUES FROM (6500000) TO (7000000);
CREATE TABLE "PART"."tmp_estaditica_15" PARTITION OF "SA".tmp_estaditica
    FOR VALUES FROM (7000000) TO (7500000);
CREATE TABLE "PART"."tmp_estaditica_16" PARTITION OF "SA".tmp_estaditica
    FOR VALUES FROM (7500000) TO (8000000);
CREATE TABLE "PART"."tmp_estaditica_17" PARTITION OF "SA".tmp_estaditica
    FOR VALUES FROM (8000000) TO (8500000); 
CREATE TABLE "PART"."tmp_estaditica_18" PARTITION OF "SA".tmp_estaditica
    FOR VALUES FROM (8500000) TO (9000000);
CREATE TABLE "PART"."tmp_estaditica_19" PARTITION OF "SA".tmp_estaditica
    FOR VALUES FROM (9000000) TO (9500000); 
CREATE TABLE "PART"."tmp_estaditica_20" PARTITION OF "SA".tmp_estaditica
    FOR VALUES FROM (9500000) TO (10000000);

 -------------------------------------------------------------------------------------------   
CREATE TABLE "SA".TMP_ESTABLECIMIENTO
(
  id_est BIGINT
, nom_estab VARCHAR(300)
, raz_social VARCHAR(300)
, codigo_act BIGINT
, nombre_act VARCHAR(300)
, tipounieco VARCHAR(8)
, fecha_alta VARCHAR(7)
)PARTITION BY RANGE (id_est);

CREATE TABLE "PART"."tmp_ESTABLECIMIENTO_01" PARTITION OF "SA".TMP_ESTABLECIMIENTO
    FOR VALUES FROM (1) TO (500000); -- se delimita el rango de las particiones
CREATE TABLE "PART"."tmp_ESTABLECIMIENTO_02" PARTITION OF "SA".TMP_ESTABLECIMIENTO
    FOR VALUES FROM (500000) TO (1000000);
CREATE TABLE "PART"."tmp_ESTABLECIMIENTO_03" PARTITION OF "SA".TMP_ESTABLECIMIENTO
    FOR VALUES FROM (1000000) TO (1500000); 
CREATE TABLE "PART"."tmp_ESTABLECIMIENTO_04" PARTITION OF "SA".TMP_ESTABLECIMIENTO
    FOR VALUES FROM (1500000) TO (2000000);
CREATE TABLE "PART"."tmp_ESTABLECIMIENTO_05" PARTITION OF "SA".TMP_ESTABLECIMIENTO
    FOR VALUES FROM (2000000) TO (2500000);
CREATE TABLE "PART"."tmp_ESTABLECIMIENTO_06" PARTITION OF "SA".TMP_ESTABLECIMIENTO
    FOR VALUES FROM (2500000) TO (3000000);
CREATE TABLE "PART"."tmp_ESTABLECIMIENTO_07" PARTITION OF "SA".TMP_ESTABLECIMIENTO
    FOR VALUES FROM (3000000) TO (3500000); 
CREATE TABLE "PART"."tmp_ESTABLECIMIENTO_08" PARTITION OF "SA".TMP_ESTABLECIMIENTO
    FOR VALUES FROM (3500000) TO (4000000);
CREATE TABLE "PART"."tmp_ESTABLECIMIENTO_09" PARTITION OF "SA".TMP_ESTABLECIMIENTO
    FOR VALUES FROM (4000000) TO (4500000); 
CREATE TABLE "PART"."tmp_ESTABLECIMIENTO_10" PARTITION OF "SA".TMP_ESTABLECIMIENTO
    FOR VALUES FROM (4500000) TO (5000000);
CREATE TABLE "PART"."tmp_ESTABLECIMIENTO_11" PARTITION OF "SA".TMP_ESTABLECIMIENTO
    FOR VALUES FROM (5000000) TO (5500000); 
CREATE TABLE "PART"."tmp_ESTABLECIMIENTO_12" PARTITION OF "SA".TMP_ESTABLECIMIENTO
    FOR VALUES FROM (5500000) TO (6000000);
CREATE TABLE "PART"."tmp_ESTABLECIMIENTO_13" PARTITION OF "SA".TMP_ESTABLECIMIENTO
    FOR VALUES FROM (6000000) TO (6500000);
CREATE TABLE "PART"."tmp_ESTABLECIMIENTO_14" PARTITION OF "SA".TMP_ESTABLECIMIENTO
    FOR VALUES FROM (6500000) TO (7000000);
CREATE TABLE "PART"."tmp_ESTABLECIMIENTO_15" PARTITION OF "SA".TMP_ESTABLECIMIENTO
    FOR VALUES FROM (7000000) TO (7500000);
CREATE TABLE "PART"."tmp_ESTABLECIMIENTO_16" PARTITION OF "SA".TMP_ESTABLECIMIENTO
    FOR VALUES FROM (7500000) TO (8000000);
CREATE TABLE "PART"."tmp_ESTABLECIMIENTO_17" PARTITION OF "SA".TMP_ESTABLECIMIENTO
    FOR VALUES FROM (8000000) TO (8500000); 
CREATE TABLE "PART"."tmp_ESTABLECIMIENTO_18" PARTITION OF "SA".TMP_ESTABLECIMIENTO
    FOR VALUES FROM (8500000) TO (9000000);
CREATE TABLE "PART"."tmp_ESTABLECIMIENTO_19" PARTITION OF "SA".TMP_ESTABLECIMIENTO
    FOR VALUES FROM (9000000) TO (9500000); 
CREATE TABLE "PART"."tmp_ESTABLECIMIENTO_20" PARTITION OF "SA".TMP_ESTABLECIMIENTO
    FOR VALUES FROM (9500000) TO (10000000);


--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--
--<<<<<<<<<<<<<<<<<<<Procedimiento limpieza de tablas>>>>>>>>>>>>>>>>>>>>--
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>--
CREATE OR REPLACE FUNCTION "SA".sp_limpiar()
 RETURNS character
 LANGUAGE plpgsql
AS $function$   
  BEGIN

---------------------------------------------------------------------------------------------
-------------------------------------Vacian las tablas tmp-----------------------------------
---------------------------------------------------------------------------------------------
delete from "SA".tmp_establecimiento;
delete from "SA".tmp_estaditica;
delete from "SA".tmp_zona_geografica ;

return 'ok';   
END;
$function$
;
 ------------------------------------------------------------------------------------------- 
--kitchen.bat /rep:DENUE /dir:/JOBS/ /job:CargaDatos2021 /level:basic

alter table "DWH"."FACT_ESTADISTICA" add column unidad_economica int;
select * from "DWH"."FACT_ESTADISTICA";
update "DWH"."FACT_ESTADISTICA" fe set unidad_economica = ddd.unidad_economica FROM
(select id_anio, id_zona_geografica, id_est , min_persona , max_persona , count(*) unidad_economica  
from "DWH"."FACT_ESTADISTICA" group by id_anio, id_zona_geografica, id_est , min_persona , max_persona)
as ddd where ddd.id_anio = fe.id_anio and ddd.id_zona_geografica = fe.id_zona_geografica and ddd.id_est = fe.id_est;


CREATE OR REPLACE VIEW "DWH".vista_bar_motel
AS SELECT x.desc_municipio,
    COALESCE(x.bares, 0::bigint) AS bares,
    COALESCE(y.moteles, 0::bigint) AS moteles
   FROM ( SELECT f.desc_municipio,
            f.id_municipio,
                CASE
                    WHEN c.id_act = 7 THEN sum(a.unidad_economica)
                    ELSE NULL::bigint
                END AS bares
           FROM "DWH"."FACT_ESTADISTICA" a
             JOIN "DWH"."DM_ESTABLECIMIENTO" b ON a.id_est = b.id_estab
             JOIN "DWH"."DM_ACTIVIDAD" c ON b.id_act = c.id_act
             JOIN "DWH"."DM_ZONA_GEOGRAFICA" d ON a.id_zona_geografica = d.id_zona_geografica
             JOIN "DWH"."DM_LOCALIDAD" e ON d.id_localidad = e.id_localidad
             JOIN "DWH"."DM_MUNICIPIO" f ON e.id_municipio = f.id_municipio
          WHERE c.id_act = 7
          GROUP BY f.desc_municipio, c.id_act, f.id_municipio) x
     JOIN ( SELECT f.desc_municipio,
            f.id_municipio,
                CASE
                    WHEN c.id_act = 18 THEN sum(a.unidad_economica)
                    ELSE NULL::bigint
                END AS moteles
           FROM "DWH"."FACT_ESTADISTICA" a
             JOIN "DWH"."DM_ESTABLECIMIENTO" b ON a.id_est = b.id_estab
             JOIN "DWH"."DM_ACTIVIDAD" c ON b.id_act = c.id_act
             JOIN "DWH"."DM_ZONA_GEOGRAFICA" d ON a.id_zona_geografica = d.id_zona_geografica
             JOIN "DWH"."DM_LOCALIDAD" e ON d.id_localidad = e.id_localidad
             JOIN "DWH"."DM_MUNICIPIO" f ON e.id_municipio = f.id_municipio
          WHERE c.id_act = 18
          GROUP BY f.desc_municipio, c.id_act, f.id_municipio) y ON x.id_municipio = y.id_municipio;



CREATE OR REPLACE VIEW "DWH".vista_bar_motel_estado
AS SELECT x.desc_entidad,
    COALESCE(x.bares, 0::bigint) AS bares,
    COALESCE(y.moteles, 0::bigint) AS moteles
   FROM ( SELECT g.desc_entidad,
            g.id_entidad,
                CASE
                    WHEN c.id_act = 7 THEN sum(a.unidad_economica)
                    ELSE NULL::integer::bigint
                END AS bares
           FROM "DWH"."FACT_ESTADISTICA" a
             JOIN "DWH"."DM_ESTABLECIMIENTO" b ON a.id_est = b.id_estab
             JOIN "DWH"."DM_ACTIVIDAD" c ON b.id_act = c.id_act
             JOIN "DWH"."DM_ZONA_GEOGRAFICA" d ON a.id_zona_geografica = d.id_zona_geografica
             JOIN "DWH"."DM_LOCALIDAD" e ON d.id_localidad = e.id_localidad
             JOIN "DWH"."DM_MUNICIPIO" f ON e.id_municipio = f.id_municipio
             JOIN "DWH"."DM_ENTIDAD" g ON g.id_entidad = f.id_entidad
          WHERE c.id_act = 7
          GROUP BY g.desc_entidad, c.id_act, g.id_entidad) x
     JOIN ( SELECT g.desc_entidad,
            g.id_entidad,
                CASE
                    WHEN c.id_act = 18 THEN sum(a.unidad_economica)
                    ELSE NULL::integer::bigint
                END AS moteles
           FROM "DWH"."FACT_ESTADISTICA" a
             JOIN "DWH"."DM_ESTABLECIMIENTO" b ON a.id_est = b.id_estab
             JOIN "DWH"."DM_ACTIVIDAD" c ON b.id_act = c.id_act
             JOIN "DWH"."DM_ZONA_GEOGRAFICA" d ON a.id_zona_geografica = d.id_zona_geografica
             JOIN "DWH"."DM_LOCALIDAD" e ON d.id_localidad = e.id_localidad
             JOIN "DWH"."DM_MUNICIPIO" f ON e.id_municipio = f.id_municipio
             JOIN "DWH"."DM_ENTIDAD" g ON g.id_entidad = f.id_entidad
          WHERE c.id_act = 18
          GROUP BY g.desc_entidad, c.id_act, g.id_entidad) y ON x.id_entidad = y.id_entidad;

