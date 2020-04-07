-- Generado por Oracle SQL Developer Data Modeler 18.2.0.179.0806
--   en:        2018-10-19 21:53:22 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g

DROP TABLE album CASCADE CONSTRAINTS;

DROP TABLE cancion CASCADE CONSTRAINTS;

DROP TABLE cancionxlistasr CASCADE CONSTRAINTS;

DROP TABLE cxi CASCADE CONSTRAINTS;

DROP TABLE empresa CASCADE CONSTRAINTS;

DROP TABLE familiar CASCADE CONSTRAINTS;

DROP TABLE genero CASCADE CONSTRAINTS;

DROP TABLE generoxidioma CASCADE CONSTRAINTS;

DROP TABLE idioma CASCADE CONSTRAINTS;

DROP TABLE individual CASCADE CONSTRAINTS;

DROP TABLE interprete CASCADE CONSTRAINTS;

DROP TABLE lista_r CASCADE CONSTRAINTS;

DROP TABLE pais CASCADE CONSTRAINTS;

DROP TABLE registro CASCADE CONSTRAINTS;

DROP TABLE sigue CASCADE CONSTRAINTS;

DROP TABLE suscripcion CASCADE CONSTRAINTS;

DROP TABLE usuario CASCADE CONSTRAINTS;

DROP TABLE AUDITORIA;

create table AUDITORIA
(
    Entidad_modificada varchar(20) NOT NULL,
    identificador varchar(80),
    OPERACION varchar2(15) NOT NULL,
    FECHA_HORA date NOT NULL,
    primary key (identificador)
);



CREATE TABLE album (
    id_album                 NUMBER(10) NOT NULL,
    titulo_album             VARCHAR2(40) NOT NULL,
    fecha_lanzamiento        DATE,
    tipo                     VARCHAR2(40) NOT NULL,
    empresa_nombre_empresa   VARCHAR2(40) NOT NULL
);

ALTER TABLE album ADD CONSTRAINT album_pk PRIMARY KEY ( id_album );

CREATE TABLE cancion (
    titulo_c               VARCHAR2(40) NOT NULL,
    duracion               DATE NOT NULL,
    album_id_album         NUMBER(10) NOT NULL,
    interprete_id_in       NUMBER(10) NOT NULL,
    genero_codigo_genero   NUMBER(10) NOT NULL
);

ALTER TABLE cancion ADD CONSTRAINT cancion_pk PRIMARY KEY ( titulo_c,
                                                            interprete_id_in );

CREATE TABLE cancionxlistasr (
    cancion_titulo_c    VARCHAR2(40) NOT NULL,
    cancion_id_in       NUMBER(10) NOT NULL,
    lista_r_id_listar   NUMBER(10) NOT NULL,
    lista_r_nickname    VARCHAR2(40) NOT NULL,
    orden               NUMBER NOT NULL
);

ALTER TABLE cancionxlistasr
    ADD CONSTRAINT cancionxlistasr_pk PRIMARY KEY ( cancion_titulo_c,
                                                    cancion_id_in,
                                                    lista_r_id_listar,
                                                    lista_r_nickname );

CREATE TABLE cxi (
    cancion_titulo_c   VARCHAR2(40) NOT NULL,
    cancion_id_in      NUMBER(10) NOT NULL,
    interprete_id_in   NUMBER(10) NOT NULL,
    roll               Varchar(20) not null
);

ALTER TABLE cxi
    ADD CONSTRAINT cxi_pk PRIMARY KEY ( cancion_titulo_c,
                                        cancion_id_in,
                                        interprete_id_in );

CREATE TABLE empresa (
    nombre_empresa   VARCHAR2(40) NOT NULL
);

ALTER TABLE empresa ADD CONSTRAINT empresa_pk PRIMARY KEY ( nombre_empresa );

CREATE TABLE familiar (
    sus_id_suscripcion   NUMBER(10) NOT NULL,
    usuario_nickname     VARCHAR2(40) NOT NULL,
    usuario_nickname3    VARCHAR2(40) NOT NULL,
    usuario_nickname1    VARCHAR2(40) NOT NULL,
    usuario_nickname2    VARCHAR2(40) NOT NULL
);

CREATE UNIQUE INDEX familiar__idx ON
    familiar (
        usuario_nickname
    ASC );

CREATE UNIQUE INDEX familiar__idxv1 ON
    familiar (
        usuario_nickname1
    ASC );

CREATE UNIQUE INDEX familiar__idxv2 ON
    familiar (
        usuario_nickname2
    ASC );

CREATE UNIQUE INDEX familiar__idxv3 ON
    familiar (
        usuario_nickname3
    ASC );

ALTER TABLE familiar ADD CONSTRAINT familiar_pk PRIMARY KEY ( sus_id_suscripcion );

CREATE TABLE genero (
    codigo_genero   NUMBER(10) NOT NULL
);

ALTER TABLE genero ADD CONSTRAINT genero_pk PRIMARY KEY ( codigo_genero );

CREATE TABLE generoxidioma (
    genero_codigo_genero   NUMBER(10) NOT NULL,
    idioma_nombre_idioma   VARCHAR2(40) NOT NULL,
    alias                  VARCHAR2(40) NOT NULL
);

ALTER TABLE generoxidioma ADD CONSTRAINT generoxidioma_pk PRIMARY KEY ( genero_codigo_genero,
                                                                        idioma_nombre_idioma );

CREATE TABLE idioma (
    nombre_idioma   VARCHAR2(40) NOT NULL
);

ALTER TABLE idioma ADD CONSTRAINT idioma_pk PRIMARY KEY ( nombre_idioma );

CREATE TABLE individual (
    sus_id_suscripcion   NUMBER(10) NOT NULL
);

ALTER TABLE individual ADD CONSTRAINT individual_pk PRIMARY KEY ( sus_id_suscripcion );

CREATE TABLE interprete (
    interprete_id_in              NUMBER(10) NOT NULL,
    nombre_real        VARCHAR2(40) NOT NULL,
    nombre_artistico   VARCHAR2(40),
    pais_nombre_pais   VARCHAR2(40) NOT NULL
);

ALTER TABLE interprete ADD CONSTRAINT interprete_pk PRIMARY KEY ( interprete_id_in );

CREATE TABLE lista_r (
    id_listar          NUMBER(10) NOT NULL,
    nombre_ldr         VARCHAR2(40) NOT NULL,
    tipo               VARCHAR2(40) NOT NULL,
    usuario_nickname   VARCHAR2(40) NOT NULL
);

ALTER TABLE lista_r ADD CONSTRAINT lista_r_pk PRIMARY KEY ( id_listar,
                                                            usuario_nickname );

CREATE TABLE pais (
    nombre_pais   VARCHAR2(40) NOT NULL
);

ALTER TABLE pais ADD CONSTRAINT pais_pk PRIMARY KEY ( nombre_pais );

CREATE TABLE registro (
    cancion_titulo_c           VARCHAR2(40) NOT NULL,
    cancion_interprete_id_in   NUMBER(10) NOT NULL,
    usuario_nickname           VARCHAR2(40) NOT NULL,
    tipo                       VARCHAR2(40) NOT NULL,
    fechahora                  DATE NOT NULL
);

ALTER TABLE registro
    ADD CONSTRAINT registro_pk PRIMARY KEY ( cancion_titulo_c,
                                             cancion_interprete_id_in,
                                             usuario_nickname,tipo );

CREATE TABLE sigue (
    usuario_nickname    VARCHAR2(40) NOT NULL,
    usuario_nickname1   VARCHAR2(40) NOT NULL
);

ALTER TABLE sigue ADD CONSTRAINT sigue_pk PRIMARY KEY ( usuario_nickname,
                                                        usuario_nickname1 );

CREATE TABLE suscripcion (
    sus_id_suscripcion            NUMBER(10) NOT NULL,
    sus_fecha_inicio              DATE NOT NULL,
    sus_fecha_ultima_renovacion   DATE NOT NULL,
    sus_tipo_sus                  VARCHAR2(3) NOT NULL,
    usuario_nickname              VARCHAR2(40) NOT NULL
);

ALTER TABLE suscripcion
    ADD CONSTRAINT ch_inh_sus CHECK ( sus_tipo_sus IN (
        'FAM',
        'IND',
        'SUS'
    ) );

CREATE UNIQUE INDEX suscripcion__idx ON
    suscripcion (
        usuario_nickname
    ASC );

ALTER TABLE suscripcion ADD CONSTRAINT suscripcion_pk PRIMARY KEY ( sus_id_suscripcion );

CREATE TABLE usuario (
    nickname           VARCHAR2(40) NOT NULL,
    nombre_u           VARCHAR2(40) NOT NULL,
    apellido_u         VARCHAR2(40) NOT NULL,
    pais_nombre_pais   VARCHAR2(40) NOT NULL
);

ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( nickname );

ALTER TABLE album
    ADD CONSTRAINT album_empresa_fk FOREIGN KEY ( empresa_nombre_empresa )
        REFERENCES empresa ( nombre_empresa );

ALTER TABLE cancion
    ADD CONSTRAINT cancion_album_fk FOREIGN KEY ( album_id_album )
        REFERENCES album ( id_album );

ALTER TABLE cancion
    ADD CONSTRAINT cancion_genero_fk FOREIGN KEY ( genero_codigo_genero )
        REFERENCES genero ( codigo_genero );

ALTER TABLE cancion
    ADD CONSTRAINT cancion_interprete_fk FOREIGN KEY ( interprete_id_in )
        REFERENCES interprete ( interprete_id_in );

ALTER TABLE cancionxlistasr
    ADD CONSTRAINT cancionxlistasr_cancion_fk FOREIGN KEY ( cancion_titulo_c,
                                                            cancion_id_in )
        REFERENCES cancion ( titulo_c,
                             interprete_id_in );

ALTER TABLE cancionxlistasr
    ADD CONSTRAINT cancionxlistasr_lista_r_fk FOREIGN KEY ( lista_r_id_listar,
                                                            lista_r_nickname )
        REFERENCES lista_r ( id_listar,
                             usuario_nickname );

ALTER TABLE cxi
    ADD CONSTRAINT cxi_cancion_fk FOREIGN KEY ( cancion_titulo_c,
                                                cancion_id_in )
        REFERENCES cancion ( titulo_c,
                             interprete_id_in );

ALTER TABLE cxi
    ADD CONSTRAINT cxi_interprete_fk FOREIGN KEY ( interprete_id_in )
        REFERENCES interprete ( interprete_id_in );

ALTER TABLE familiar
    ADD CONSTRAINT familiar_suscripcion_fk FOREIGN KEY ( sus_id_suscripcion )
        REFERENCES suscripcion ( sus_id_suscripcion );

ALTER TABLE familiar
    ADD CONSTRAINT familiar_usuario_fk FOREIGN KEY ( usuario_nickname )
        REFERENCES usuario ( nickname );

ALTER TABLE familiar
    ADD CONSTRAINT familiar_usuario_fkv2 FOREIGN KEY ( usuario_nickname1 )
        REFERENCES usuario ( nickname );

ALTER TABLE familiar
    ADD CONSTRAINT familiar_usuario_fkv3 FOREIGN KEY ( usuario_nickname2 )
        REFERENCES usuario ( nickname );

ALTER TABLE familiar
    ADD CONSTRAINT familiar_usuario_fkv4 FOREIGN KEY ( usuario_nickname3 )
        REFERENCES usuario ( nickname );

ALTER TABLE generoxidioma
    ADD CONSTRAINT generoxidioma_genero_fk FOREIGN KEY ( genero_codigo_genero )
        REFERENCES genero ( codigo_genero );

ALTER TABLE generoxidioma
    ADD CONSTRAINT generoxidioma_idioma_fk FOREIGN KEY ( idioma_nombre_idioma )
        REFERENCES idioma ( nombre_idioma );

ALTER TABLE individual
    ADD CONSTRAINT individual_suscripcion_fk FOREIGN KEY ( sus_id_suscripcion )
        REFERENCES suscripcion ( sus_id_suscripcion );

ALTER TABLE interprete
    ADD CONSTRAINT interprete_pais_fk FOREIGN KEY ( pais_nombre_pais )
        REFERENCES pais ( nombre_pais );

ALTER TABLE lista_r
    ADD CONSTRAINT lista_r_usuario_fk FOREIGN KEY ( usuario_nickname )
        REFERENCES usuario ( nickname );

ALTER TABLE registro
    ADD CONSTRAINT registro_cancion_fk FOREIGN KEY ( cancion_titulo_c,
                                                     cancion_interprete_id_in )
        REFERENCES cancion ( titulo_c,
                             interprete_id_in );

ALTER TABLE registro
    ADD CONSTRAINT registro_usuario_fk FOREIGN KEY ( usuario_nickname )
        REFERENCES usuario ( nickname );

ALTER TABLE sigue
    ADD CONSTRAINT sigue_usuario_fk FOREIGN KEY ( usuario_nickname )
        REFERENCES usuario ( nickname );

ALTER TABLE sigue
    ADD CONSTRAINT sigue_usuario_fkv1 FOREIGN KEY ( usuario_nickname1 )
        REFERENCES usuario ( nickname );

ALTER TABLE suscripcion
    ADD CONSTRAINT suscripcion_usuario_fk FOREIGN KEY ( usuario_nickname )
        REFERENCES usuario ( nickname );

ALTER TABLE usuario
    ADD CONSTRAINT usuario_pais_fk FOREIGN KEY ( pais_nombre_pais )
        REFERENCES pais ( nombre_pais );

CREATE OR REPLACE TRIGGER arc_fkarc_1_familiar BEFORE
    INSERT OR UPDATE OF sus_id_suscripcion ON familiar
    FOR EACH ROW
DECLARE
    d   VARCHAR2(3);
BEGIN
    SELECT
        a.sus_tipo_sus
    INTO d
    FROM
        suscripcion a
    WHERE
        a.sus_id_suscripcion =:new.sus_id_suscripcion;

    IF ( d IS NULL OR d <> 'FAM' ) THEN
        raise_application_error(-20223,'FK Familiar_Suscripcion_FK in Table Familiar violates Arc constraint on Table Suscripcion - discriminator column SUS_Tipo_SUS doesn''t have value ''FAM'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_1_individual BEFORE
    INSERT OR UPDATE OF sus_id_suscripcion ON individual
    FOR EACH ROW
DECLARE
    d   VARCHAR2(3);
BEGIN
    SELECT
        a.sus_tipo_sus
    INTO d
    FROM
        suscripcion a
    WHERE
        a.sus_id_suscripcion =:new.sus_id_suscripcion;

    IF ( d IS NULL OR d <> 'IND' ) THEN
        raise_application_error(-20223,'FK Individual_Suscripcion_FK in Table Individual violates Arc constraint on Table Suscripcion - discriminator column SUS_Tipo_SUS doesn''t have value ''IND'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

create or replace TRIGGER SISTEMA_TREE
    AFTER INSERT or DELETE or UPDATE ON interprete
    FOR EACH ROW
    begin
    
    IF DELETING THEN
        insert into AUDITORIA (Entidad_modificada, identificador, OPERACION, FECHA_HORA) values ('Interprete',:new.Interprete_Id_In,'D', (SELECT SYSDATE FROM DUAL));
    END IF;
    
    IF INSERTING THEN
        insert into AUDITORIA (Entidad_modificada, identificador, OPERACION, FECHA_HORA) values ('Interprete',:new.Interprete_Id_In,'I', (SELECT SYSDATE FROM DUAL));
    END IF;
    
    IF UPDATING THEN
        insert into AUDITORIA (Entidad_modificada, identificador,OPERACION, FECHA_HORA) values ('Interprete',:new.Interprete_Id_In,'U', (SELECT SYSDATE FROM DUAL));
    END IF;
         
    end;
    /

create or replace TRIGGER SISTEMA_TREE2
    AFTER INSERT or DELETE or UPDATE ON album
    FOR EACH ROW
    when (new.tipo='Album')
    begin
    
    IF DELETING THEN
        insert into AUDITORIA (Entidad_modificada, identificador, OPERACION, FECHA_HORA) values ('Album',:new.Id_album,'D', (SELECT SYSDATE FROM DUAL));
    END IF;
    
    IF INSERTING  THEN
        insert into AUDITORIA (Entidad_modificada, identificador, OPERACION, FECHA_HORA) values ('Album',:new.Id_album,'I', (SELECT SYSDATE FROM DUAL));
    END IF;
    
    IF UPDATING  THEN
        insert into AUDITORIA (Entidad_modificada, identificador,OPERACION, FECHA_HORA) values ('Album',:new.Id_album,'U', (SELECT SYSDATE FROM DUAL));
    END IF;
         
    end;
    /
    
create or replace TRIGGER SISTEMA_TREE3
    AFTER INSERT or DELETE or UPDATE ON album
    FOR EACH ROW
    when (new.tipo='EP')
    begin
    
    IF DELETING  THEN
        insert into AUDITORIA (Entidad_modificada, identificador, OPERACION, FECHA_HORA) values ('EP',:new.Id_album,'D', (SELECT SYSDATE FROM DUAL));
    END IF;
    
    IF INSERTING  THEN
        insert into AUDITORIA (Entidad_modificada, identificador, OPERACION, FECHA_HORA) values ('EP',:new.Id_album,'I', (SELECT SYSDATE FROM DUAL));
    END IF;
    
    IF UPDATING  THEN
        insert into AUDITORIA (Entidad_modificada, identificador,OPERACION, FECHA_HORA) values ('EP',:new.Id_album,'U', (SELECT SYSDATE FROM DUAL));
    END IF;
         
    end;
    /
    
    create or replace TRIGGER SISTEMA_TREE4
    AFTER INSERT or DELETE or UPDATE ON Cancion
    FOR EACH ROW
    begin
    
    IF DELETING THEN
        insert into AUDITORIA (Entidad_modificada, identificador, OPERACION, FECHA_HORA) values ('Cancion',:new.Titulo_c ||'-'||:new.interprete_id_in,'D', (SELECT SYSDATE FROM DUAL));
    END IF;
    
    IF INSERTING THEN
        insert into AUDITORIA (Entidad_modificada, identificador, OPERACION, FECHA_HORA) values ('Cancion',:new.Titulo_c ||'-'||:new.interprete_id_in,'I', (SELECT SYSDATE FROM DUAL));
    END IF;
    
    IF UPDATING THEN
        insert into AUDITORIA (Entidad_modificada, identificador,OPERACION, FECHA_HORA) values ('Cancion',:new.Titulo_c ||'-'||:new.interprete_id_in,'U', (SELECT SYSDATE FROM DUAL));
    END IF;
         
    end;
    /
-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            17
-- CREATE INDEX                             5
-- ALTER TABLE                             42
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           2
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0

INSERT INTO empresa VALUES ('Monstercat');
INSERT INTO empresa VALUES ('Astralwerks');
INSERT INTO empresa VALUES ('Columbia Records');
INSERT INTO empresa VALUES ('Domino Records');
INSERT INTO empresa VALUES ('Universal Music');

INSERT INTO album VALUES (1001,'vertigo',TO_DATE('02/02/2018', 'DD/MM/YYYY'),'Album','Astralwerks');
INSERT INTO album VALUES (1002,'AM',TO_DATE('17/12/2016', 'DD/MM/YYYY'),'Album','Domino Records');
INSERT INTO album VALUES (1003,'End Credits',TO_DATE('10/08/2015', 'DD/MM/YYYY'),'Album','Astralwerks');
INSERT INTO album VALUES (1004,'Hard',TO_DATE('11/07/2018', 'DD/MM/YYYY'),'EP','Columbia Records');
INSERT INTO album VALUES (1005,'To Imagine',TO_DATE('28/10/2018', 'DD/MM/YYYY'),'EP','Columbia Records');
INSERT INTO album VALUES (1006,'Mil Ciudades',TO_DATE('06/12/2015', 'DD/MM/YYYY'),'Album','Universal Music');
INSERT INTO album VALUES (1007,'Dr Charas',TO_DATE('24/12/2017', 'DD/MM/YYYY'),'Album','Universal Music');
INSERT INTO album VALUES (1008,'The Wall',TO_DATE('03/05/2016', 'DD/MM/YYYY'),'EP','Domino Records');
INSERT INTO album VALUES (1009,'Lagrimas Desordenadas',TO_DATE('05/10/2008', 'DD/MM/YYYY'),'EP','Universal Music');

INSERT INTO pais VALUES ('Colombia');
INSERT INTO pais VALUES ('Inglaterra');
INSERT INTO pais VALUES ('Noruega');
INSERT INTO pais VALUES ('Italia');
INSERT INTO pais VALUES ('España');

INSERT INTO usuario VALUES('JuCarr1','Juan','Carrillo','Noruega');
INSERT INTO usuario VALUES('JoLoai2','Jose','Loaiza','Italia');
INSERT INTO usuario VALUES('PeMest3','Pedro','Mestra','España');
INSERT INTO usuario VALUES('MaGarc4','Maria','Garcia','Colombia');
INSERT INTO usuario VALUES('AnTova5','Ana','Tovar','Inglaterra');
INSERT INTO usuario VALUES('MoPere6','Monica','Perez','Noruega');
INSERT INTO usuario VALUES('SaTruj7','Santiago','Trujillo','Italia');
INSERT INTO usuario VALUES('LuRami8','Luis','Ramirez','España');
INSERT INTO usuario VALUES('SeAlva9','Sergio','Alvarez','Colombia');
INSERT INTO usuario VALUES('SeBala10','Sebastian','Balaguera','Inglaterra');
INSERT INTO usuario VALUES('DaLope11','Daniela','Lopez','Noruega');
INSERT INTO usuario VALUES('LaSmit12','Laura','Smith','Italia');
INSERT INTO usuario VALUES('TaCarr13','Tatiana','Carrillo','España');
INSERT INTO usuario VALUES('JuLoai14','Julian','Loaiza','Colombia');
INSERT INTO usuario VALUES('AnMest16','Andres','Mestra','Inglaterra');
INSERT INTO usuario VALUES('SaGarc17','Sara','Garcia','Noruega');
INSERT INTO usuario VALUES('AnTova18','Andrea','Tovar','Italia');
INSERT INTO usuario VALUES('JuPere19','Juan','Perez','España');
INSERT INTO usuario VALUES('JoTruj20','Jose','Trujillo','Colombia');
INSERT INTO usuario VALUES('PeRami21','Pedro','Ramirez','Inglaterra');
INSERT INTO usuario VALUES('MaAlva22','Maria','Alvarez','Noruega');
INSERT INTO usuario VALUES('AnBala23','Ana','Balaguera','Italia');
INSERT INTO usuario VALUES('MoLope25','Monica','Lopez','España');
INSERT INTO usuario VALUES('SaSmit26','Santiago','Smith','Colombia');
INSERT INTO usuario VALUES('LuCarr27','Luis','Carrillo','Inglaterra');
INSERT INTO usuario VALUES('SeLoai28','Sergio','Loaiza','Noruega');
INSERT INTO usuario VALUES('SeMest29','Sebastian','Mestra','Italia');
INSERT INTO usuario VALUES('DaGarc30','Daniela','Garcia','España');
INSERT INTO usuario VALUES('LaTova31','Laura','Tovar','Colombia');
INSERT INTO usuario VALUES('TaPere32','Tatiana','Perez','Inglaterra');
INSERT INTO usuario VALUES('JuTruj33','Julian','Trujillo','Noruega');
INSERT INTO usuario VALUES('AnRami34','Andres','Ramirez','Italia');
INSERT INTO usuario VALUES('SaAlva35','Sara','Alvarez','España');
INSERT INTO usuario VALUES('AnBala36','Andrea','Balaguera','Colombia');
INSERT INTO usuario VALUES('JuLope37','Juan','Lopez','Inglaterra');
INSERT INTO usuario VALUES('juliancd38','Julian','Parada','España');
INSERT INTO usuario VALUES('LuValle12','Lucia','Vallejo','Inglaterra');
INSERT INTO usuario VALUES('JulRodri34','Julia','Rodriguez','España');
INSERT INTO usuario VALUES('NicoOrte45','Nicolas','Ortegon','Noruega');
INSERT INTO usuario VALUES('PaDel9','Pablo','Delgado','Colombia');
INSERT INTO usuario VALUES('Mapis123','Maria','Cespedes','Italia');
INSERT INTO usuario VALUES('CataM7','Catalina','Mendonza','Noruega');
INSERT INTO usuario VALUES('LinaAl5','Lina','Alvarez','Italia');

INSERT INTO sigue VALUES('JuCarr1','JoLoai2');
INSERT INTO sigue VALUES('JuCarr1','MaGarc4');
INSERT INTO sigue VALUES('JuCarr1','MoPere6');
INSERT INTO sigue VALUES('JuCarr1','LuRami8');
INSERT INTO sigue VALUES('JuCarr1','DaLope11');


INSERT INTO sigue VALUES('JoLoai2','PeMest3');
INSERT INTO sigue VALUES('PeMest3','MaGarc4');
INSERT INTO sigue VALUES('MaGarc4','AnTova5');
INSERT INTO sigue VALUES('AnTova5','MoPere6');
INSERT INTO sigue VALUES('MoPere6','SaTruj7');
INSERT INTO sigue VALUES('SaTruj7','LuRami8');
INSERT INTO sigue VALUES('LuRami8','SeAlva9');
INSERT INTO sigue VALUES('SeAlva9','SeBala10');
INSERT INTO sigue VALUES('SeBala10','DaLope11');
INSERT INTO sigue VALUES('DaLope11','LaSmit12');
INSERT INTO sigue VALUES('LaSmit12','TaCarr13');
INSERT INTO sigue VALUES('TaCarr13','JuLoai14');
INSERT INTO sigue VALUES('JuLoai14','AnMest16');
INSERT INTO sigue VALUES('AnMest16','SaGarc17');
INSERT INTO sigue VALUES('SaGarc17','AnTova18');
INSERT INTO sigue VALUES('AnTova18','JuPere19');
INSERT INTO sigue VALUES('JuPere19','JoTruj20');
INSERT INTO sigue VALUES('JoTruj20','PeRami21');
INSERT INTO sigue VALUES('PeRami21','MaAlva22');
INSERT INTO sigue VALUES('MaAlva22','AnBala23');
INSERT INTO sigue VALUES('AnBala23','MoLope25');
INSERT INTO sigue VALUES('MoLope25','SaSmit26');
INSERT INTO sigue VALUES('SaSmit26','LuCarr27');
INSERT INTO sigue VALUES('LuCarr27','SeLoai28');
INSERT INTO sigue VALUES('SeLoai28','SeMest29');
INSERT INTO sigue VALUES('SeMest29','DaGarc30');
INSERT INTO sigue VALUES('DaGarc30','LaTova31');
INSERT INTO sigue VALUES('LaTova31','TaPere32');
INSERT INTO sigue VALUES('TaPere32','JuTruj33');
INSERT INTO sigue VALUES('JuTruj33','AnRami34');
INSERT INTO sigue VALUES('AnRami34','SaAlva35');
INSERT INTO sigue VALUES('SaAlva35','AnBala36');
INSERT INTO sigue VALUES('AnBala36','JuCarr1');
INSERT INTO sigue VALUES('JuLope37','JoLoai2');


INSERT INTO interprete VALUES(100,'JuanCarrillo','Juan Carrillo','Noruega');
INSERT INTO interprete VALUES(101,'JoseLoaiza','Jose Loaiza','Italia');
INSERT INTO interprete VALUES(102,'PedroMestra','Pedro Mestra','España');
INSERT INTO interprete VALUES(103,'MariaGarcia','Maria Garcia','Colombia');
INSERT INTO interprete VALUES(104,'AnaTovar','Ana Tovar','Inglaterra');
INSERT INTO interprete VALUES(105,'MonicaPerez','Monica Perez','Noruega');
INSERT INTO interprete VALUES(106,'SantiagoTrujillo','Santiago Trujillo','Italia');
INSERT INTO interprete VALUES(107,'LuisRamirez','Luis Ramirez','España');
INSERT INTO interprete VALUES(108,'SergioAlvarez','Sergio Alvarez','Colombia');
INSERT INTO interprete VALUES(109,'SebastianBalaguera','Sebastian Balaguera','Inglaterra');


INSERT INTO idioma  VALUES ('Español');
INSERT INTO idioma  VALUES ('Frances');
INSERT INTO idioma  VALUES ('Italiano');
INSERT INTO idioma  VALUES ('Aleman');
INSERT INTO idioma  VALUES ('Japones');
INSERT INTO idioma  VALUES ('Ingles');

INSERT INTO genero VALUES (0);
INSERT INTO genero VALUES (1);
INSERT INTO genero VALUES (2);
INSERT INTO genero VALUES (3);
INSERT INTO genero VALUES (4);
INSERT INTO genero VALUES (5);
INSERT INTO genero VALUES (6);

INSERT INTO generoxidioma VALUES (0, 'Español', 'Balada');
INSERT INTO generoxidioma VALUES (0, 'Frances', 'Balada');
INSERT INTO generoxidioma VALUES (0, 'Italiano', 'Balada');
INSERT INTO generoxidioma VALUES (1, 'Frances', 'Jazz');
INSERT INTO generoxidioma VALUES (1, 'Italiano', 'Jazz');
INSERT INTO generoxidioma VALUES (1, 'Aleman', 'Jazz');
INSERT INTO generoxidioma VALUES (1, 'Ingles', 'Jazz');
INSERT INTO generoxidioma VALUES (2, 'Italiano', 'Pop');
INSERT INTO generoxidioma VALUES (2, 'Aleman', 'Pop');
INSERT INTO generoxidioma VALUES (2, 'Ingles', 'Pop');
INSERT INTO generoxidioma VALUES (2, 'Español', 'Pop');
INSERT INTO generoxidioma VALUES (3, 'Aleman', 'Rap');
INSERT INTO generoxidioma VALUES (3, 'Ingles', 'Rap');
INSERT INTO generoxidioma VALUES (3, 'Español', 'Rap');
INSERT INTO generoxidioma VALUES (5, 'Ingles', 'Rock');
INSERT INTO generoxidioma VALUES (5, 'Español', 'Rock');
INSERT INTO generoxidioma VALUES (5, 'Frances', 'Rock');
INSERT INTO generoxidioma VALUES (5, 'Italiano', 'Rock');
INSERT INTO generoxidioma VALUES (5, 'Aleman', 'Rock');

INSERT INTO cancion  VALUES('XO',TO_DATE('02:20', 'mi:ss'),1001,103,5);--
INSERT INTO cancion  VALUES('R U MINE',TO_DATE('03:02', 'mi:ss'),1001,104,0);
INSERT INTO cancion  VALUES('Do I wanna know',TO_DATE('04:04', 'mi:ss'),1002,105,1);
INSERT INTO cancion  VALUES('Wake Up',TO_DATE('04:03', 'mi:ss'),1003,106,2);
INSERT INTO cancion  VALUES('Amiga mia',TO_DATE('05:04', 'mi:ss'),1004,107,3);--
INSERT INTO cancion  VALUES('Sadderdaze',TO_DATE('01:10', 'mi:ss'),1005,108,4);
INSERT INTO cancion  VALUES('Imagine',TO_DATE('02:12', 'mi:ss'),1006,109,5);
INSERT INTO cancion  VALUES('Show must go',TO_DATE('03:14', 'mi:ss'),1007,100,0);--
INSERT INTO cancion  VALUES('Thunder',TO_DATE('04:16', 'mi:ss'),1008,101,1);
INSERT INTO cancion  VALUES('Desde Cuando',TO_DATE('04:09', 'mi:ss'),1009,101,2);--
INSERT INTO cancion  VALUES('Creo en ti',TO_DATE('05:10', 'mi:ss'),1003,102,3);
INSERT INTO cancion  VALUES('Runaway',TO_DATE('01:22', 'mi:ss'),1001,103,4);--
INSERT INTO cancion  VALUES('Gold',TO_DATE('02:24', 'mi:ss'),1002,104,5);
INSERT INTO cancion  VALUES('Float',TO_DATE('03:26', 'mi:ss'),1003,105,0);
INSERT INTO cancion  VALUES('Wings',TO_DATE('04:28', 'mi:ss'),1004,106,1);--
INSERT INTO cancion  VALUES('Icarus',TO_DATE('04:15', 'mi:ss'),1005,107,2);--
INSERT INTO cancion  VALUES('Wrong',TO_DATE('05:16', 'mi:ss'),1006,108,3);
INSERT INTO cancion  VALUES('Fireside',TO_DATE('01:34', 'mi:ss'),1007,109,4);
INSERT INTO cancion  VALUES('Desesperado',TO_DATE('02:36', 'mi:ss'),1008,100,5);--
INSERT INTO cancion  VALUES('One and Only',TO_DATE('03:38', 'mi:ss'),1009,101,0);
INSERT INTO cancion  VALUES('Another Love',TO_DATE('04:40', 'mi:ss'),1001,102,1);
INSERT INTO cancion  VALUES('Be the one',TO_DATE('04:21', 'mi:ss'),1007,103,2);
INSERT INTO cancion  VALUES('Hotel California',TO_DATE('05:22', 'mi:ss'),1002,104,3);--
INSERT INTO cancion  VALUES('Stairway to heaven',TO_DATE('01:46', 'mi:ss'),1003,105,4);
INSERT INTO cancion  VALUES('Rumour',TO_DATE('02:48', 'mi:ss'),1004,106,5);
INSERT INTO cancion  VALUES('Afuera',TO_DATE('03:50', 'mi:ss'),1005,107,0);
INSERT INTO cancion  VALUES('Run boy',TO_DATE('04:52', 'mi:ss'),1006,108,1);
INSERT INTO cancion  VALUES('Honest',TO_DATE('04:27', 'mi:ss'),1007,108,2);
INSERT INTO cancion  VALUES('Sex',TO_DATE('05:28', 'mi:ss'),1008,108,3);

INSERT INTO cancion  VALUES('Cuando te vi',TO_DATE('02:13', 'mi:ss'),1001,103,3);
INSERT INTO cancion  VALUES('Loazita',TO_DATE('04:18', 'mi:ss'),1001,104,5);
INSERT INTO cancion  VALUES('GeiGei',TO_DATE('02:26', 'mi:ss'),1002,105,2);
INSERT INTO cancion  VALUES('Amor a Alejandro',TO_DATE('01:14', 'mi:ss'),1003,106,4);
INSERT INTO cancion  VALUES('Amor mai',TO_DATE('02:54', 'mi:ss'),1003,102,1);

INSERT INTO suscripcion VALUES(0,TO_DATE('11/12/2017','DD/MM/YYYY'),TO_DATE('14/09/2018','DD/MM/YYYY'),'FAM','JuCarr1');
--INSERT INTO suscripcion VALUES(1,TO_DATE('14/09/2017','DD/MM/YYYY'),TO_DATE('16/11/2018','DD/MM/YYYY'),'IND','JoLoai2');
INSERT INTO suscripcion VALUES(2,TO_DATE('16/05/2016','DD/MM/YYYY'),TO_DATE('01/12/2018','DD/MM/YYYY'),'IND','PeMest3');
INSERT INTO suscripcion VALUES(3,TO_DATE('01/04/2017','DD/MM/YYYY'),TO_DATE('07/08/2018','DD/MM/YYYY'),'FAM','MaGarc4');
INSERT INTO suscripcion VALUES(4,TO_DATE('08/04/2015','DD/MM/YYYY'),TO_DATE('22/10/2018','DD/MM/YYYY'),'IND','AnTova5');
INSERT INTO suscripcion VALUES(5,TO_DATE('06/12/2016','DD/MM/YYYY'),TO_DATE('05/09/2018','DD/MM/YYYY'),'IND','MoPere6');
INSERT INTO suscripcion VALUES(6,TO_DATE('17/10/2015','DD/MM/YYYY'),TO_DATE('18/02/2018','DD/MM/YYYY'),'FAM','SaTruj7');
INSERT INTO suscripcion VALUES(7,TO_DATE('15/08/2017','DD/MM/YYYY'),TO_DATE('09/02/2018','DD/MM/YYYY'),'IND','LuRami8');
INSERT INTO suscripcion VALUES(8,TO_DATE('07/07/2015','DD/MM/YYYY'),TO_DATE('13/08/2018','DD/MM/YYYY'),'IND','SeAlva9');
INSERT INTO suscripcion VALUES(9,TO_DATE('09/12/2014','DD/MM/YYYY'),TO_DATE('25/05/2018','DD/MM/YYYY'),'FAM','SeBala10');
INSERT INTO suscripcion VALUES(10,TO_DATE('09/12/2016','DD/MM/YYYY'),TO_DATE('26/10/2018','DD/MM/YYYY'),'FAM','JuLope37');
INSERT INTO suscripcion VALUES(11,TO_DATE('03/08/2013','DD/MM/YYYY'),TO_DATE('23/10/2018','DD/MM/YYYY'),'FAM','juliancd38');



INSERT INTO lista_r VALUES(10,'Para Viajar','Publica','JuCarr1');
INSERT INTO lista_r VALUES(20,'Concentracion','Privada','JoLoai2');
INSERT INTO lista_r VALUES(21,'Democracia','Privada','JoLoai2');
INSERT INTO lista_r VALUES(30,'Para Bailar','Publica','PeMest3');
INSERT INTO lista_r VALUES(40,'Favoritas','Privada','MaGarc4');
INSERT INTO lista_r VALUES(50,'Para Dormir','Publica','AnTova5');
INSERT INTO lista_r VALUES(60,'Romanticas','Privada','MoPere6');
INSERT INTO lista_r VALUES(70,'Infantil','Publica','SaTruj7');
INSERT INTO lista_r VALUES(80,'Pride ','Privada','LuRami8');
INSERT INTO lista_r VALUES(90,' Peliculas','Publica','SeAlva9');
INSERT INTO lista_r VALUES(100,'Pistas de Shazam','Privada','SeBala10');
INSERT INTO lista_r VALUES(110,'Para Viajar','Publica','DaLope11');
INSERT INTO lista_r VALUES(120,'Concentracion','Privada','LaSmit12');
INSERT INTO lista_r VALUES(130,'Para Bailar','Publica','TaCarr13');
INSERT INTO lista_r VALUES(140,'Favoritas','Privada','JuLoai14');
INSERT INTO lista_r VALUES(150,'Para Dormir','Publica','AnMest16');
INSERT INTO lista_r VALUES(160,'Romanticas','Privada','SaGarc17');
INSERT INTO lista_r VALUES(170,'Infantil','Publica','AnTova18');
INSERT INTO lista_r VALUES(180,'Pride ','Privada','JuPere19');
INSERT INTO lista_r VALUES(190,' Peliculas','Publica','JoTruj20');
INSERT INTO lista_r VALUES(200,'Pistas de Shazam','Privada','PeRami21');
INSERT INTO lista_r VALUES(210,'Para Viajar','Publica','MaAlva22');
INSERT INTO lista_r VALUES(220,'Concentracion','Privada','AnBala23');
INSERT INTO lista_r VALUES(230,'Para Bailar','Publica','MoLope25');
INSERT INTO lista_r VALUES(240,'Favoritas','Privada','SaSmit26');
INSERT INTO lista_r VALUES(250,'Para Dormir','Publica','LuCarr27');
INSERT INTO lista_r VALUES(260,'Romanticas','Privada','SeLoai28');
INSERT INTO lista_r VALUES(270,'Infantil','Publica','SeMest29');
INSERT INTO lista_r VALUES(280,'Pride ','Privada','DaGarc30');
INSERT INTO lista_r VALUES(290,' Peliculas','Publica','LaTova31');

INSERT INTO registro VALUES('XO',103,'JuCarr1','Like',TO_DATE('01/05/2018 00:01','DD/MM/YYYY hh24:mi'));
--INSERT INTO registro VALUES('R U MINE',104,'JoLoai2','Skip',TO_DATE('02/06/2018 01:02','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Do I wanna know',105,'MaGarc4','Play',TO_DATE('03/07/2018 02:03','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Wake Up',106,'MaGarc4','Like',TO_DATE('04/08/2018 03:04','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Amiga mia',107,'AnTova5','Skip',TO_DATE('05/09/2018 04:05','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Sadderdaze',108,'MaGarc4','Play',TO_DATE('06/10/2018 05:06','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Imagine',109,'SaTruj7','Like',TO_DATE('07/11/2018 06:07','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Show must go',100,'LuRami8','Skip',TO_DATE('08/01/2018 07:08','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Thunder',101,'MaGarc4','Play',TO_DATE('09/02/2018 08:09','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Thunder',101,'SeBala10','Like',TO_DATE('10/03/2018 09:10','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Thunder',101,'DaLope11','Skip',TO_DATE('11/04/2018 10:11','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Desde Cuando',101,'SeAlva9','Play',TO_DATE('12/05/2018 11:12','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Creo en ti',102,'TaCarr13','Like',TO_DATE('13/06/2018 12:13','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Runaway',103,'JuLoai14','Skip',TO_DATE('14/07/2018 13:14','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Gold',104,'SeAlva9','Play',TO_DATE('15/08/2018 14:15','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Gold',104,'SaGarc17','Like',TO_DATE('16/09/2018 15:16','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Gold',104,'AnTova18','Skip',TO_DATE('17/10/2018 16:17','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Float',105,'SeAlva9','Play',TO_DATE('18/11/2018 17:18','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Wings',106,'JoTruj20','Like',TO_DATE('19/01/2018 18:19','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Icarus',107,'PeRami21','Skip',TO_DATE('20/02/2018 19:20','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Wrong',108,'SeAlva9','Play',TO_DATE('21/03/2018 20:21','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Wrong',108,'AnBala23','Like',TO_DATE('22/04/2018 21:22','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Wrong',108,'MoLope25','Skip',TO_DATE('23/05/2018 22:23','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Fireside',109,'SeAlva9','Play',TO_DATE('24/06/2018 23:24','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Desesperado',100,'LuCarr27','Like',TO_DATE('25/07/2018 00:25','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('One and Only',101,'JuCarr1','Skip',TO_DATE('26/08/2018 01:26','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Another Love',102,'SeAlva9','Play',TO_DATE('27/09/2018 02:27','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Another Love',102,'PeMest3','Like',TO_DATE('28/10/2018 03:28','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Be the one',103,'MaGarc4','Skip',TO_DATE('01/11/2018 04:01','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Hotel California',104,'AnTova5','Play',TO_DATE('02/01/2018 05:02','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Stairway to heaven',105,'MoPere6','Like',TO_DATE('03/02/2018 06:03','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Rumour',106,'SaTruj7','Skip',TO_DATE('04/03/2018 07:04','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Afuera',107,'SeAlva9','Play',TO_DATE('05/04/2018 08:05','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Run boy',108,'SeAlva9','Like',TO_DATE('06/05/2018 09:06','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Run boy',108,'SeBala10','Skip',TO_DATE('07/06/2018 10:07','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Honest',108,'SeAlva9','Play',TO_DATE('08/07/2018 11:08','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Sex',108,'LaSmit12','Like',TO_DATE('09/08/2018 12:09','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('XO',103,'TaCarr13','Skip',TO_DATE('10/09/2018 13:10','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('R U MINE',104,'JuLoai14','Play',TO_DATE('11/10/2018 14:11','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('R U MINE',104,'AnMest16','Like',TO_DATE('12/11/2018 15:12','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('R U MINE',104,'SaGarc17','Skip',TO_DATE('13/01/2018 16:13','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Do I wanna know',105,'JuLoai14','Play',TO_DATE('14/02/2018 17:14','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Wake Up',106,'JuPere19','Like',TO_DATE('15/03/2018 18:15','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Amiga mia',107,'JoTruj20','Skip',TO_DATE('16/04/2018 19:16','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Sadderdaze',108,'JoTruj20','Play',TO_DATE('17/05/2018 20:17','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Sadderdaze',108,'MaAlva22','Like',TO_DATE('18/06/2018 21:18','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Sadderdaze',108,'AnBala23','Skip',TO_DATE('19/07/2018 22:19','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Imagine',109,'JoTruj20','Play',TO_DATE('20/08/2018 23:20','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Show must go',100,'SaSmit26','Like',TO_DATE('21/09/2018 00:21','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Thunder',101,'LuCarr27','Skip',TO_DATE('22/10/2018 01:22','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Desde Cuando',101,'SaSmit26','Play',TO_DATE('23/11/2018 02:23','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Desde Cuando',101,'JoLoai2','Like',TO_DATE('24/01/2018 03:24','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Desde Cuando',101,'PeMest3','Skip',TO_DATE('25/02/2018 04:25','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Creo en ti',102,'SaSmit26','Play',TO_DATE('26/03/2018 05:26','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Runaway',103,'AnTova5','Like',TO_DATE('27/04/2018 06:27','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Gold',104,'MoPere6','Skip',TO_DATE('28/05/2018 07:28','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Float',105,'SaSmit26','Play',TO_DATE('01/06/2018 08:01','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Wings',106,'LuRami8','Like',TO_DATE('02/07/2018 09:02','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Icarus',107,'SeAlva9','Skip',TO_DATE('03/08/2018 10:03','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Wrong',108,'SaSmit26','Play',TO_DATE('04/09/2018 11:04','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Fireside',109,'DaLope11','Like',TO_DATE('05/10/2018 12:05','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Desesperado',100,'LaSmit12','Skip',TO_DATE('06/11/2018 13:06','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('One and Only',101,'SaSmit26','Play',TO_DATE('07/01/2018 14:07','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('One and Only',101,'JuLoai14','Like',TO_DATE('08/02/2018 15:08','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('One and Only',101,'AnMest16','Skip',TO_DATE('09/03/2018 16:09','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Another Love',102,'SaSmit26','Play',TO_DATE('10/04/2018 17:10','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Be the one',103,'AnTova18','Like',TO_DATE('11/05/2018 18:11','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Hotel California',104,'JuPere19','Skip',TO_DATE('12/06/2018 19:12','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Stairway to heaven',105,'LaTova31','Play',TO_DATE('13/07/2018 20:13','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Stairway to heaven',105,'PeRami21','Like',TO_DATE('14/08/2018 21:14','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Stairway to heaven',105,'MaAlva22','Skip',TO_DATE('15/09/2018 22:15','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Rumour',106,'LaTova31','Play',TO_DATE('16/10/2018 23:16','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Afuera',107,'MoLope25','Like',TO_DATE('17/11/2018 00:17','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Run boy',108,'SaSmit26','Skip',TO_DATE('18/01/2018 01:18','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Honest',108,'LaTova31','Play',TO_DATE('19/02/2018 02:19','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Honest',108,'JuCarr1','Like',TO_DATE('20/03/2018 03:20','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Honest',108,'JoLoai2','Skip',TO_DATE('21/04/2018 04:21','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Sex',108,'LaTova31','Play',TO_DATE('22/05/2018 05:22','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('XO',103,'MaGarc4','Like',TO_DATE('23/06/2018 06:23','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('R U MINE',104,'AnTova5','Skip',TO_DATE('24/07/2018 07:24','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Do I wanna know',105,'LaTova31','Play',TO_DATE('25/08/2018 08:25','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Do I wanna know',105,'SaTruj7','Like',TO_DATE('26/09/2018 09:26','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Do I wanna know',105,'LuRami8','Skip',TO_DATE('27/10/2018 10:27','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Wake Up',106,'AnBala36','Play',TO_DATE('28/11/2018 11:28','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Amiga mia',107,'SeBala10','Like',TO_DATE('01/01/2018 12:01','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Sadderdaze',108,'DaLope11','Skip',TO_DATE('02/02/2018 13:02','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Imagine',109,'AnBala36','Play',TO_DATE('03/03/2018 14:03','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Show must go',100,'TaCarr13','Like',TO_DATE('04/04/2018 15:04','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Thunder',101,'JuLoai14','Skip',TO_DATE('05/05/2018 16:05','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Desde Cuando',101,'AnBala36','Play',TO_DATE('06/06/2018 17:06','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Creo en ti',102,'SaGarc17','Like',TO_DATE('07/07/2018 18:07','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Runaway',103,'AnTova18','Skip',TO_DATE('08/08/2018 19:08','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Gold',104,'AnBala36','Play',TO_DATE('09/09/2018 20:09','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Gold',104,'JoTruj20','Like',TO_DATE('10/10/2018 21:10','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Gold',104,'PeRami21','Skip',TO_DATE('11/11/2018 22:11','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Float',105,'PaDel9','Play',TO_DATE('12/01/2018 23:12','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Wings',106,'AnBala23','Like',TO_DATE('13/02/2018 00:13','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Icarus',107,'MoLope25','Skip',TO_DATE('14/03/2018 01:14','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Wrong',108,'PaDel9','Play',TO_DATE('15/04/2018 02:15','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Wrong',108,'LuCarr27','Like',TO_DATE('16/05/2018 03:16','DD/MM/YYYY hh24:mi'));

INSERT INTO registro VALUES('R U MINE',104,'JoLoai2','Skip',TO_DATE('20/10/2018 22:40','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Wake Up',106,'JoLoai2','Skip',TO_DATE('20/10/2018 22:41','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Imagine',109,'JoLoai2','Skip',TO_DATE('20/10/2018 22:43','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Amiga mia',107,'JoLoai2','Skip',TO_DATE('20/10/2018 22:28','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Desde Cuando',101,'JoLoai2','Skip',TO_DATE('20/10/2018 22:37','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Creo en ti',102,'JoLoai2','Skip',TO_DATE('20/10/2018 22:55','DD/MM/YYYY hh24:mi'));

INSERT INTO registro VALUES('Cuando te vi',103,'MaGarc4','Play',TO_DATE('16/05/2018 03:16','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Cuando te vi',103,'SeAlva9','Play',TO_DATE('17/06/2018 03:16','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Loazita',104,'JuLoai14','Play',TO_DATE('06/07/2018 03:16','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Loazita',104,'JoTruj20','Play',TO_DATE('18/08/2018 03:16','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('GeiGei',105,'SaSmit26','Play',TO_DATE('19/09/2018 03:16','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('GeiGei',105,'LaTova31','Play',TO_DATE('29/10/2018 03:16','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Amor a Alejandro',106,'AnBala36','Play',TO_DATE('22/11/2018 03:16','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Amor mai',102,'PaDel9','Play',TO_DATE('21/12/2018 03:16','DD/MM/YYYY hh24:mi'));

INSERT INTO registro VALUES('XO',103,'PaDel9','Play',TO_DATE('21/12/2018 03:16','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Amiga mia',107,'PaDel9','Play',TO_DATE('21/12/2018 03:16','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Show must go',100,'PaDel9','Play',TO_DATE('21/12/2018 03:16','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Desde Cuando',101,'PaDel9','Play',TO_DATE('21/12/2018 03:16','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Runaway',103,'PaDel9','Play',TO_DATE('21/12/2018 03:16','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Wings',106,'PaDel9','Play',TO_DATE('21/12/2018 03:16','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Icarus',107,'PaDel9','Play',TO_DATE('21/12/2018 03:16','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Desesperado',100,'PaDel9','Play',TO_DATE('21/12/2018 03:16','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Hotel California',104,'PaDel9','Play',TO_DATE('21/12/2018 03:16','DD/MM/YYYY hh24:mi'));

INSERT INTO registro VALUES('Runaway',103,'LuRami8','Like',TO_DATE('21/01/2018 03:16','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Hotel California',104,'MaGarc4','Like',TO_DATE('21/12/2018 03:16','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Icarus',107,'LuRami8','Like',TO_DATE('24/10/2018 02:16','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Wings',106,'MaGarc4','Like',TO_DATE('10/12/2018 03:16','DD/MM/YYYY hh24:mi'));
INSERT INTO registro VALUES('Desde Cuando',101,'MaGarc4','Like',TO_DATE('03/12/2018 03:16','DD/MM/YYYY hh24:mi'));

INSERT INTO familiar VALUES(0, 'DaLope11','LaSmit12', 'TaCarr13', 'JuLoai14');
INSERT INTO familiar VALUES(3,'AnMest16', 'SaGarc17', 'AnTova18', 'JuPere19');
INSERT INTO familiar VALUES(6, 'JoTruj20', 'PeRami21', 'MaAlva22', 'AnBala23');
INSERT INTO familiar VALUES(9,'MoLope25', 'SaSmit26', 'LuCarr27', 'SeLoai28');
INSERT INTO familiar VALUES(10,'SeMest29', 'DaGarc30', 'LaTova31', 'TaPere32');
INSERT INTO familiar VALUES(11,'JuTruj33', 'AnRami34', 'SaAlva35', 'AnBala36');


INSERT INTO cancionxlistasr VALUES('XO',103,10,'JuCarr1',1);
INSERT INTO cancionxlistasr VALUES('R U MINE',104,10,'JuCarr1',2);
INSERT INTO cancionxlistasr VALUES('Do I wanna know',105,10,'JuCarr1',3);

INSERT INTO cancionxlistasr VALUES('R U MINE',104,20,'JoLoai2',1);
INSERT INTO cancionxlistasr VALUES('XO',103,20,'JoLoai2',2);
INSERT INTO cancionxlistasr VALUES('Do I wanna know',105,20,'JoLoai2',5);
INSERT INTO cancionxlistasr VALUES('Imagine',109,20,'JoLoai2',3);
INSERT INTO cancionxlistasr VALUES('Show must go',100,20,'JoLoai2',6);
INSERT INTO cancionxlistasr VALUES('Thunder',101,20,'JoLoai2',4);

INSERT INTO cancionxlistasr VALUES('Do I wanna know',105,21,'JoLoai2',1);
INSERT INTO cancionxlistasr VALUES('Wake Up',106,21,'JoLoai2',2);
INSERT INTO cancionxlistasr VALUES('Amiga mia',107,21,'JoLoai2',3);



INSERT INTO cancionxlistasr VALUES('Sadderdaze',108,60,'MoPere6',1);
INSERT INTO cancionxlistasr VALUES('Imagine',109,70,'SaTruj7',1);
INSERT INTO cancionxlistasr VALUES('Show must go',100,80,'LuRami8',1);
INSERT INTO cancionxlistasr VALUES('Thunder',101,90,'SeAlva9',1);
INSERT INTO cancionxlistasr VALUES('Desde Cuando',101,100,'SeBala10',1);
INSERT INTO cancionxlistasr VALUES('Creo en ti',102,110,'DaLope11',1);
INSERT INTO cancionxlistasr VALUES('Runaway',103,120,'LaSmit12',1);
INSERT INTO cancionxlistasr VALUES('Gold',104,130,'TaCarr13',1);
INSERT INTO cancionxlistasr VALUES('Float',105,140,'JuLoai14',1);
INSERT INTO cancionxlistasr VALUES('Wings',106,150,'AnMest16',1);
INSERT INTO cancionxlistasr VALUES('Icarus',107,160,'SaGarc17',1);
INSERT INTO cancionxlistasr VALUES('Wrong',108,170,'AnTova18',1);
INSERT INTO cancionxlistasr VALUES('Fireside',109,180,'JuPere19',1);
INSERT INTO cancionxlistasr VALUES('Desesperado',100,190,'JoTruj20',1);
INSERT INTO cancionxlistasr VALUES('One and Only',101,200,'PeRami21',1);
INSERT INTO cancionxlistasr VALUES('Another Love',102,210,'MaAlva22',1);
INSERT INTO cancionxlistasr VALUES('Be the one',103,220,'AnBala23',1);
INSERT INTO cancionxlistasr VALUES('Hotel California',104,230,'MoLope25',1);
INSERT INTO cancionxlistasr VALUES('Stairway to heaven',105,240,'SaSmit26',1);
INSERT INTO cancionxlistasr VALUES('Rumour',106,250,'LuCarr27',1);
INSERT INTO cancionxlistasr VALUES('Afuera',107,260,'SeLoai28',1);
INSERT INTO cancionxlistasr VALUES('Run boy',108,270,'SeMest29',1);
INSERT INTO cancionxlistasr VALUES('Honest',108,280,'DaGarc30',1);
INSERT INTO cancionxlistasr VALUES('Sex',108,290,'LaTova31',1);

INSERT INTO CXI (cancion_titulo_c, cancion_id_in, interprete_id_in, ROLL) (SELECT TITULO_C, interprete_id_in, interprete_id_in, 'Secundario' from cancion natural join interprete);

INSERT INTO individual (sus_id_suscripcion) (select sus_id_suscripcion from suscripcion where sus_tipo_sus = 'IND');

commit;


--CONSULTAS

--Primera Consulta
select *
from(
select id_album, titulo_album, fecha_lanzamiento, tipo, empresa_nombre_empresa as Empresa
from album
order by fecha_lanzamiento desc)
where rownum <=5;

--Segunda Consulta

with paisXusuario as (
    select Nickname, Nombre_Pais
    from Pais inner join usuario on (Nombre_Pais = Pais_Nombre_Pais)
    where Nombre_Pais = 'Colombia'),
    
    registroXpu as (
    select Cancion_Titulo_C, Nombre_Pais
    from Registro inner join paisXusuario on (Nickname = Usuario_Nickname)
    where tipo = 'Play'),
    
    numReproducciones as (
    select Cancion_Titulo_C, Nombre_Pais, count(Cancion_Titulo_C) as cant
    from registroXpu
    group by Cancion_Titulo_C, Nombre_Pais),
    
    CancionXinterprete as (
    select Titulo_C, Nombre_Artistico, Duracion
    from Cancion natural join Interprete),
    
    cXn as (
    select Nombre_Artistico, Titulo_C as Cancion, to_number(TO_CHAR(to_date(duracion,'DD/MM/YYYY hh24:mi:ss'),'mi'))||':'||to_number(TO_CHAR(to_date(duracion,'DD/MM/YYYY hh24:mi:ss'),'ss')) as Duracion, Nombre_Pais as Pais
    from CancionXinterprete inner join numReproducciones on (Titulo_C = Cancion_Titulo_C)
    order by cant desc)

select *
from cXn
where rownum <=30;

--Tercera Consulta

with cancionfull (name,tipo,fecha,duracion)As
(
SELECT cancion.titulo_c, album.tipo, album.fecha_lanzamiento, cancion.duracion
FROM Cancion inner join Album on(cancion.album_id_album=album.id_album)
),

registrosfull(idin,namer,tipo) as
(
   SELECT registro.Cancion_interprete_id_in,registro.cancion_titulo_c,registro.tipo
   from Registro
   where (registro.Cancion_interprete_id_in=108) and (registro.tipo ='Play') --ACA LO HACEMOS PARA EL DETERMINADO ARTISTA CON ID 108
),

 unioncr(name, idi, dura,fecha,tipo)as
(
   select cancionfull.name, registrosfull.idin, cancionfull.duracion, cancionfull.fecha, cancionfull.tipo
   from registrosfull inner join cancionfull on(cancionfull.name=registrosfull.namer)
),

 final (Nombre,id,duracion,fecha_lanzamiento, tipo, cantidad)as(
select unioncr.name,idi,dura,fecha,tipo, count(unioncr.name) canti
from unioncr
group by(unioncr.name,idi,dura,fecha,tipo)
order by canti desc)

SELECT * FROM final where rownum <= 10;

--Cuarta Consulta
with revisarSus (nickname) as(
select u.nickname
from usuario u 
where not exists (
                select u.nickname
                from suscripcion s
                where s.usuario_nickname =u.nickname
                union
                select u.nickname
                from familiar f
                where f.usuario_nickname =u.nickname or f.usuario_nickname1 =u.nickname or f.usuario_nickname2 =u.nickname or f.usuario_nickname3 =u.nickname
                )
                ),
skips (nickname,fecha) as(
select u.nickname, to_char(r.fechahora,'DD/MM/YY hh24:mi:SS')
from registro r, revisarSus u
where u.nickname= r.usuario_nickname and r.tipo= 'Skip'
),
revFecha(nickname) as(
select s.nickname
from skips s
where TO_CHAR(to_date(s.fecha,'DD/MM/YYYY hh24:mi:SS'),'DD/MM/YY')=TO_CHAR(to_date(sysdate,'DD/MM/YYYY hh24:mi:SS'),'DD/MM/YY')  and  
((to_number(TO_CHAR(to_date(s.fecha,'DD/MM/YYYY hh24:mi:SS'),'mi'))> to_number(TO_CHAR(to_date(sysdate,'DD/MM/YYYY hh24:mi:SS'),'mi')) and to_number(TO_CHAR(to_date(s.fecha,'DD/MM/YYYY hh24:mi:SS'),'hh24'))= to_number(TO_CHAR(to_date(sysdate,'DD/MM/YYYY hh24:mi:SS'),'hh24'))-1) 
or to_number(TO_CHAR(to_date(s.fecha,'DD/MM/YYYY hh24:mi:SS'),'hh24'))= to_number(TO_CHAR(to_date(sysdate,'DD/MM/YYYY hh24:mi:SS'),'hh24')))
),
contarFech (canti,nickname) as(
select count(nickname),nickname
from revFecha
group by nickname
having count(nickname) >5
)

select nickname
from contarFech;

--Quinta Consulta
with userxamig as
(
 select nickname, usuario_nickname1
 from usuario inner join sigue on (nickname=usuario_nickname)
 where nickname ='JuCarr1'
),
 CancionXinterprete as (
    select Titulo_C, Nombre_Artistico, Duracion
    from Cancion natural join Interprete),
registrofull as
(
    select Titulo_C, Nombre_Artistico, Duracion, tipo, usuario_nickname, fechahora
    from CancionXinterprete inner join registro on (Titulo_C=Cancion_Titulo_C)
    where tipo ='Like'
),
finalikes as
(
select Nombre_Artistico,Titulo_C,  Duracion, usuario_nickname1, fechahora
from registrofull inner join userxamig on (usuario_nickname=usuario_nickname1)
)

select  Nombre_Artistico,Titulo_C,  to_number(TO_CHAR(to_date(duracion,'DD/MM/YYYY hh24:mi:ss'),'mi'))||':'||to_number(TO_CHAR(to_date(duracion,'DD/MM/YYYY hh24:mi:ss'),'ss')) as Duracion, usuario_nickname1, fechahora
from finalikes
where rownum <= 10
order by fechahora asc;

--Sexta Consulta
select sus_id_suscripcion as Suscripcion, usuario_nickname as NicknameDeUsuario, sus_fecha_ultima_renovacion as Fecha_Renovacion
from suscripcion 
where( (select sus_fecha_ultima_renovacion - (SELECT SYSDATE FROM DUAL) from dual ))between 0 and 5; --SOLO MUESTRA LOS QUE ESTA PRONTO A VEMCER EN 5 DIAS Y NO LAS VENCIDAS

--Septima Consulta
with listaxuser As 
(
select id_listar, nombre_ldr
from lista_r
where Usuario_nickname='JoLoai2'
),
listaUSxcancion AS
(
select nombre_ldr, cancion_titulo_c, orden
from listaxuser inner join cancionxlistasr on (id_listar=lista_r_id_listar)
order by orden
),
CancionXINpp as 
(
select titulo_c, duracion, nombre_artistico
from cancion natural join interprete
),

todo as (
select nombre_ldr, nombre_artistico, cancion_titulo_c, duracion, orden
from listaUSxcancion inner join CancionXINpp on (cancion_titulo_c=titulo_c))


select nombre_ldr as ListaReproduccion, nombre_artistico, cancion_titulo_c as Cancion, to_number(TO_CHAR(to_date(duracion,'DD/MM/YYYY hh24:mi:ss'),'mi'))||':'||to_number(TO_CHAR(to_date(duracion,'DD/MM/YYYY hh24:mi:ss'),'ss')) as Duracion, ordenU as Orden from(
select nombre_ldr, nombre_artistico, cancion_titulo_c, duracion, orden, row_number() over (partition by nombre_ldr order by orden asc) ordenU
from todo)
 
commit;
