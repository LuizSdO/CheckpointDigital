------------------------TABELA ENDERCO--------------------------------------
DROP TABLE endereco CASCADE CONSTRAINTS;
CREATE TABLE endereco (
    id_endereco    NUMBER (4) PRIMARY KEY,
    ds_logradouro  VARCHAR2(50) NOT NULL,
    ds_complemento VARCHAR2(45) NOT NULL,
    nm_cidade      VARCHAR2(55) NOT NULL,
    nm_estado      VARCHAR2(55) NOT NULL,
    ds_cep         VARCHAR2(9) NOT NULL
);


-------------------TABELA CONSULTORIO------------------------------
DROP TABLE CONSULTORIO CASCADE CONSTRAINTS;
CREATE TABLE CONSULTORIO  (
    id_consultorio NUMBER (4) PRIMARY KEY,
    id_endereco    NUMBER (3) NOT NULL,
    nm_empresa     VARCHAR2(55) NOT NULL,
    nr_cnpj        VARCHAR2(14) NOT NULL
);

--FOREIGN KEY
ALTER TABLE CONSULTORIO 
    ADD CONSTRAINT fk_consultorio_endereco FOREIGN KEY ( id_endereco )
        REFERENCES endereco ( id_endereco );

----------------------TABELA USUARIO-----------------------
DROP TABLE usuario CASCADE CONSTRAINTS;
CREATE TABLE usuario (
    id_usuario NUMBER (4) PRIMARY KEY,
    nm_usuario VARCHAR2(55) NOT NULL,
    nr_cpf     VARCHAR2(11) NOT NULL,
    ds_email   VARCHAR2(75) NOT NULL,
    ds_senha   VARCHAR2(25) NOT NULL,
    ds_genero CHAR(2) NOT NULL
);

--------------CHECK----------------
ALTER TABLE usuario
ADD CONSTRAINT ck_usuario_ds_genero
CHECK (upper(ds_genero) = 'M' OR upper(ds_genero) = 'F' OR upper(ds_genero) = 'NB');


-------------------TABELA IMAGEM-----------------------------
DROP TABLE imagem CASCADE CONSTRAINTS;
CREATE TABLE imagem (
    id_imagem    NUMBER (4) PRIMARY KEY,
    id_usuario   NUMBER(2) NOT NULL,
    dt_data_hora TIMESTAMP NOT NULL,
    ds_resultado VARCHAR2(55) NOT NULL
);

--FOREIGN KEY 
ALTER TABLE imagem
    ADD CONSTRAINT fk_imagem_usuario FOREIGN KEY ( id_usuario )
        REFERENCES usuario ( id_usuario );



---------------------TABELA MEDICO----------------------
DROP TABLE medico CASCADE CONSTRAINTS;
CREATE TABLE medico (
    id_medico NUMBER (4) PRIMARY KEY,
    nm_medico VARCHAR2(55) NOT NULL,
    ds_crm    VARCHAR2(55) NOT NULL,
    ds_email  VARCHAR2(65) NOT NULL
);
---------------------------------------------------------
DROP TABLE pertencer CASCADE CONSTRAINTS;
CREATE TABLE pertencer (
    id_medico      NUMBER(2) NOT NULL,
    id_consultorio NUMBER(2) NOT NULL
);

ALTER TABLE pertencer ADD CONSTRAINT pertencer_pk PRIMARY KEY ( id_medico,
                                                                id_consultorio );
--FOREIGN KEY 
ALTER TABLE pertencer
    ADD CONSTRAINT fk_pertencer_consultorio FOREIGN KEY ( id_consultorio )
        REFERENCES CONSULTORIO  ( id_consultorio );

ALTER TABLE pertencer
    ADD CONSTRAINT fk_pertencer_medico FOREIGN KEY ( id_medico )
        REFERENCES medico ( id_medico );

----------------TABELA CONSULTA-------------------------------
DROP TABLE consulta CASCADE CONSTRAINTS;
CREATE TABLE consulta (
    id_consulta  NUMBER (4) PRIMARY KEY,
    id_consultorio NUMBER(2) NOT NULL,
    id_medico      NUMBER(2) NOT NULL,
    id_usuario     NUMBER(2) NOT NULL,
    dt_data_hora   TIMESTAMP NOT NULL
);

--FOREIGN KEY 
ALTER TABLE consulta
    ADD CONSTRAINT fk_consulta_consultorio FOREIGN KEY ( id_consultorio )
        REFERENCES CONSULTORIO  ( id_consultorio );
        
ALTER TABLE consulta
    ADD CONSTRAINT fk_consulta_medico FOREIGN KEY ( id_medico )
        REFERENCES medico ( id_medico );
        
ALTER TABLE consulta
    ADD CONSTRAINT fk_consulta_usuario FOREIGN KEY ( id_usuario )
        REFERENCES usuario ( id_usuario );

-----------------TABELA REGISTRO ERRO--------------
drop table t_erro cascade constraints;
Create table t_erro(
    cd_erro NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nm_erro varchar(255),
    dt_ocorrencia date,
    nm_usuario varchar(50)
);
commit;



