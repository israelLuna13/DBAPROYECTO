--tabla del plan de estudios
CREATE TABLE planE
(   cve_pe VARCHAR(25),
    nombre_pe VARCHAR(50) NOT NULL,
    cvees_pe VARCHAR(25),
    nombreespecialidad_pe VARCHAR(50) NOT NULL,
    PRIMARY KEY(cve_pe,cvees_pe)
);

--tabla de alumnos
CREATE TABLE alumnos
(
    control_a VARCHAR(50) PRIMARY KEY,
    apellidop_a VARCHAR(50) NOT NULL,
    apellidop_m VARCHAR(50) NOT NULL,
    nombre_a VARCHAR(50) NOT NULL,
    discapacidad_a INT NOT NULL,
    carrera_a VARCHAR(50) NOT NULL,
    ingreso_a INT NOT NULL,
    periodo_a VARCHAR(50) NOT NULL,
    password_a TEXT NOT NULL,
    telefono_a TEXT NOT NULL,
    email_a VARCHAR(100),
    fkplanE_a VARCHAR(50) ,
    fkEspecialidad_a VARCHAR(50),
    FOREIGN KEY (fkplanE_a,fkEspecialidad_a) REFERENCES planE(cve_pe,cvees_pe)
);

--tabla de personal
CREATE TABLE personal
(
    cve_per VARCHAR(50) PRIMARY KEY,
    apellidop_per VARCHAR(50) NOT NULL,
    apellidom_per VARCHAR(50) ,
    nombre_per VARCHAR(50) NOT NULL,
    password_per TEXT NOT NULL,
    email_per TEXT NOT NULL
);

--tabla kardex 
CREATE TABLE kardex
(

    fkAlumno_k VARCHAR(13),
    calificacionR_k FLOAT NOT NULL,
    calificacionP_k FLOAT NOT NULL,       
    promedio_k FLOAT NOT NULL,                                                                              
    fkGrupo_k VARCHAR(5), 
    fkPersonal_k VARCHAR(10),      
    fkMateria_k VARCHAR(10), 
    fkPlanE_k VARCHAR(15),      
    fkEspecialidad_k VARCHAR(20),      
    fkSemestre_k VARCHAR(15),
    PRIMARY KEY(fkAlumno_k,fkPersonal_k,fkMateria_k,fkGrupo_k,fkPlanE_k,fkEspecialidad_k,fkSemestre_k)       ,
    FOREIGN KEY (fkAlumno_k) REFERENCES alumnos(control_a),   
    FOREIGN KEY(fkPersonal_k,fkMateria_k,fkGrupo_k,fkPlanE_k,fkEspecialidad_k,fkSemestre_k) REFERENCES grupo(fkPersonal_g,fkMateria_g,cve_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g));


--tabla materia plan de estudio
CREATE TABLE materiaPlanE
(
    semestre_mpe VARCHAR(20),
    fkMateria_mpe VARCHAR(10),
    fkPlanE_mpe VARCHAR(50),
    fkEspecialidad_mpe VARCHAR(50),
    PRIMARY KEY (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe),
    FOREIGN KEY (fkPlanE_mpe, fkEspecialidad_mpe) REFERENCES planE(cve_pe, cvees_pe),
    FOREIGN KEY (fkMateria_mpe) REFERENCES materia(cve_m)
);
-- tabla materia 
CREATE TABLE materia
(
    cve_m VARCHAR(10) PRIMARY KEY,
    nombre_m VARCHAR(50),
    creditosP_m SMALLINT NOT NULL,
    creditosT_m SMALLINT NOT NULL
);

-- --tabla grupo

CREATE TABLE grupo
(
    cve_g VARCHAR(5),
    semestre_g VARCHAR(20),
    fkPersonal_g VARCHAR(50),
    fkMateria_g VARCHAR(10),
    fkPlanE_g VARCHAR(50),
    fkEspecialidad_g VARCHAR(50),
    fksemestre_g VARCHAR(50),
    PRIMARY KEY(cve_g, fkPersonal_g, fkMateria_g, fkPlanE_g, fkEspecialidad_g, fksemestre_g),
    FOREIGN KEY(fkPersonal_g) REFERENCES personal(cve_per),
    FOREIGN KEY(fksemestre_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g) REFERENCES materiaPlanE(semestre_mpe,fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
);

--tabla edificio 
CREATE TABLE edificio
(
    cve_e VARCHAR(10),
    planta_e VARCHAR(10),
    cveAula_e VARCHAR(10),
    numBancas_e SMALLINT NOT NULL,
    numPc_e SMALLINT NULL,
    PRIMARY KEY(cve_e,cveAula_e)
);


-- Horas
CREATE TABLE horas
(
    fkEdificio_h VARCHAR(10),
    fkAula_h VARCHAR(10),
    fkGrupo_h VARCHAR(5),
    fkEspecialidad_h VARCHAR(50),
    fkPlanE_h VARCHAR(50),
    fkMateria_h VARCHAR(10),
    fkSemestre_h VARCHAR(20),
    fkPersonal_h VARCHAR(50),
    hora_h VARCHAR(10) NOT NULL,
    PRIMARY KEY(fkEdificio_h, fkAula_h, fkGrupo_h, fkEspecialidad_h, fkPlanE_h, fkMateria_h, fkSemestre_h,fkPersonal_h),
    FOREIGN KEY(fkEdificio_h,fkAula_h) REFERENCES edificio(cve_e,cveAula_e),
    FOREIGN KEY(fkGrupo_h,fkPlanE_h,fkEspecialidad_h,fkMateria_h,fkSemestre_h,fkPersonal_h) REFERENCES grupo(cve_g,fkPlanE_g,fkEspecialidad_g,fkMateria_g,fksemestre_g,fkPersonal_g)
);

-- Prerrequisitos
CREATE TABLE Prerrequisitos
(
    cveMateria_pre VARCHAR(10),
    fkMateria_pre VARCHAR(10),
    fkPlanE_pre VARCHAR(50),
    fkEspecialidad_pre VARCHAR(50),
    fkSemestre_pre VARCHAR(20),
     --Primary Key
    PRIMARY KEY(cveMateria_pre,fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre),
    -- Foreign keys
    FOREIGN KEY(fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre) 
    REFERENCES materiaPlanE(fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe,semestre_mpe),
    FOREIGN KEY(cveMateria_pre)
    REFERENCES materia(cve_m)
);

--valores para prerequisitos
--primer semestre 
-- calculo integral (2 semestre) depende de calculo dieferencia (1 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('ACF-0902', 'ACC-0907','ISIC-2010-224','ISIE-TWM-2020-01','1');

-- progra orientada a objetos (2 semestre) depende de fundamentos de progra (1 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('IQC-1024', 'SCD-1008','ISIC-2010-224','ISIE-TWM-2020-01','1');

--segundo semestre 
-- calculo vectorial (3 semestre) depende calculo integral (2 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('ACF-0904', 'ACF-0902','ISIC-2010-224','ISIE-TWM-2020-01','2');

-- estructura de datos (3 semestre) depende progra orientada a obj (2 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('AED-1026', 'IQC-1024','ISIC-2010-224','ISIE-TWM-2020-01','2');

-- fundamentos de bd (3 semestre) depende progra orientada a obj (2 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('AEF-1031', 'IQC-1024','ISIC-2010-224','ISIE-TWM-2020-01','2');


-- investigacion de operaciones (3 semestre) depende algebra lineal (2 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('SCC-1013', 'ACF-0903','ISIC-2010-224','ISIE-TWM-2020-01','2');

-- investigacion de operaciones (3 semestre) depende prob y estadistica (2 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('SCC-1013', 'AEC-1053','ISIC-2010-224','ISIE-TWM-2020-01','2');


--tercer semestre

-- ecuaciones diferenciales (4 semestre) depende calculo vectorial (3 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('ACF-0905', 'ACF-0904','ISIC-2010-224','ISIE-TWM-2020-01','3');

-- topicos (4 semestre) depende estructura de datos (3 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('SCD-1007', 'AED-1026','ISIC-2010-224','ISIE-TWM-2020-01','3');

-- automatas 1 (6 semestre) depende estructura de datos (3 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('SCD-1015', 'AED-1026','ISIC-2010-224','ISIE-TWM-2020-01','3');

-- graficacion (5 semestre) depende estructura de datos (3 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('SCC-1010', 'AED-1026','ISIC-2010-224','ISIE-TWM-2020-01','3');

-- so (5 semestre) depende estructura de datos (3 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('AEC-1061', 'AED-1026','ISIC-2010-224','ISIE-TWM-2020-01','3');

-- taller de db (4 semestre) depende fundamentos bd (3 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('SCA-1025', 'AEF-1031','ISIC-2010-224','ISIE-TWM-2020-01','3');

-- simulacion (4 semestre) depende investigacion de oper (3 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('SCD-1022', 'SCC-1013','ISIC-2010-224','ISIE-TWM-2020-01','3');

--PRINCIPIOPS ELECT. Y APLICACIONES DIGITALES (4 semestre) depende de fisica general 
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('SCD-1018', 'SCF-1016','ISIC-2010-224','ISIE-TWM-2020-01','3');

-- cuarto semestre

-- ingenieria de software (5 semestre) depende FUNDAMENTOS DE INGENIERÍA DE SOFTWARE (4 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('SCD-1011', 'SCC-1007','ISIC-2010-224','ISIE-TWM-2020-01','4');

-- progra web (5 semestre) depende taller db (4 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('AEB-1055', 'SCA-1025','ISIC-2010-224','ISIE-TWM-2020-01','4');

-- fundamentos tele (5 semestre) PRINCIPIOPS ELECT. Y APLICACIONES DIGITALES  (4 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('AEC-1034', 'SCD-1018','ISIC-2010-224','ISIE-TWM-2020-01','4');

-- arquitectura (5 semestre) PRINCIPIOPS ELECT. Y APLICACIONES DIGITALES  (4 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('SCD-1003', 'SCD-1018','ISIC-2010-224','ISIE-TWM-2020-01','4');


-- quinto semestre 
-- taller so (6 semestre)depende   depende so  (5 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('SCA-1026', 'AEC-1061','ISIC-2010-224','ISIE-TWM-2020-01','5');

-- pila 1 (7 semestre)depende  progra web  (5 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('SCC-1019', 'AEB-1055','ISIC-2010-224','ISIE-TWM-2020-01','5');

-- redes (6 semestre) depende  fundamentos tele  (5 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('SCD-1021', 'AEC-1034','ISIC-2010-224','ISIE-TWM-2020-01','5');

-- ensamblador (6 semestre) depende  arquitectura   (5 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('SCC-1014', 'SCD-1003','ISIC-2010-224','ISIE-TWM-2020-01','5');


-- taller 2 (6 semestre)  depende taller 1   (5 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('ACA-0910', 'ACA-0909','ISIC-2010-224','ISIE-TWM-2020-01','5');

--sexto semestre
-- automatas 2 (7 semestre)  depende automatas   (1 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('SCD-1016', 'SCD-1015','ISIC-2010-224','ISIE-TWM-2020-01','6');

-- gestion de proy (7 semestre)  ingenieria software  (6 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('SCG-1009', 'SCD-1011','ISIC-2010-224','ISIE-TWM-2020-01','6');

-- conmuta (7 semestre)  redes  (6 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('SCD-1004', 'SCD-1021','ISIC-2010-224','ISIE-TWM-2020-01','6');

--septimo 
-- IA (8 semestre)  progra logica y funcional  (7 semestre)
INSERT INTO prerrequisitos (cveMateria_pre, fkMateria_pre,fkPlanE_pre,fkEspecialidad_pre,fkSemestre_pre)
VALUES ('SCC-1022', 'SCC-1019','ISIC-2010-224','ISIE-TWM-2020-01','7');

-- valores para la tabla materiaPlanE


--------------------------------------------------------------------------
-- INGENIRIA EN SISTEMAS
    --DBA ing sistemas web movil 
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('8', 'SCB-1001','ISIC-2010-224','ISIE-TWM-2020-01');

--     --DBA ing sistemas tics
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('8', 'SCB-1001','ISIC-2010-224','ISIE-TIC-2020-02');

-- --desarrollo en ios , Ing sistemas , web movil 
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('8', 'TWD-2002','ISIC-2010-224','ISIE-TWM-2020-01');

--  -- algebra lineal ing sistemas web movil
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('2', 'ACF-0903','ISIC-2010-224','ISIE-TWM-2020-01');

--  -- algebra lineal ing sistemas tics
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('2', 'ACF-0903','ISIC-2010-224','ISIE-TIC-2020-02');

--  --admin redes ing sistemas web movil
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
-- VALUES ('8', 'SCA-1002','ISIC-2010-224','ISIE-TWM-2020-01');

--  --admin redes ing sistemas tics
-- -- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- -- VALUES ('AGO-DIC', 'SCA-1002','ISIC-2010-224','ISIE-TIC-2020-02');

-- -- algoritmos y programacion ing sistemas web movil
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('1', 'MAE-1001','ISIC-2010-224','ISIE-TWM-2020-01');

-- -- algoritmos y programacion ing sistemas web movil
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('1', 'MAE-1001','ISIC-2010-224','ISIE-TIC-2020-02');

--  -- big data ing sistemas tics
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('7', 'TIC-2002','ISIC-2010-224','ISIE-TIC-2020-02');

--  --calculo diferencial ing sistemas web movil
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('1', 'ACC-0907','ISIC-2010-224','ISIE-TWM-2020-01');



--  --desarrollo en android ing sistemas web movil
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('7', 'TWD-2001','ISIC-2010-224','ISIE-TWM-2020-01');

--  --pila 1 ing sistemas web movil
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('7', 'TWM-2003','ISIC-2010-224','ISIE-TWM-2020-01');

--  --pila 2 ing sistemas web movil
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('8', 'TWD-2004','ISIC-2010-224','ISIE-TWM-2020-01');


--primer semestre 

 --calculo diferencial ing sistemas web movil
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
VALUES ('1', 'ACC-0907','ISIC-2010-224','ISIE-TWM-2020-01');

--fundamentos de programacion 
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
VALUES ('1', 'SCD-1008','ISIC-2010-224','ISIE-TWM-2020-01');

--taller de etica 
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
VALUES ('1', 'ACA-0907','ISIC-2010-224','ISIE-TWM-2020-01');

--matematicas discretas 
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
VALUES ('1', 'AEF-1041','ISIC-2010-224','ISIE-TWM-2020-01');

-- algoritmos y programacion ing sistemas web movil
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
VALUES ('1', 'MAE-1001','ISIC-2010-224','ISIE-TWM-2020-01');

--fundamentos de investigacion 
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
VALUES ('1', 'ACC-0906','ISIC-2010-224','ISIE-TWM-2020-01');


-- segundo semestre 

 --calculo integral ing sistemas web movil
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
VALUES ('2', 'ACF-0902','ISIC-2010-224','ISIE-TWM-2020-01');

--Desarrollo sustentable
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
VALUES ('2', 'ACD-0908','ISIC-2010-224','ISIE-TWM-2020-01');

-- probabilidad y estadistica
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
VALUES ('2', 'AEC-1053','ISIC-2010-224','ISIE-TWM-2020-01');

--programacion 
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
VALUES ('2', 'IQC-1024','ISIC-2010-224','ISIE-TWM-2020-01');

-- algebra lineal
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
VALUES ('2', 'ACF-0903','ISIC-2010-224','ISIE-TWM-2020-01');

--quimica
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
VALUES ('2', 'MTC-1003','ISIC-2010-224','ISIE-TWM-2020-01');
-----------------------------------------------------------------------------------------

--                                                   --INGENIERIA QUIMICA

--  --CALCULO INTEGRAL ING QUIMICA  MATALURGIA                                                  
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('3', 'ACF-0902','IQUI-2010-232','IQUE-MET-2020-01');

-- --CALCULO INTEGRAL ING QUIMICA AMBIENTAL
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('3', 'ACF-0902','IQUI-2010-232','IQUE-AMB-2020-02');

-- --tall investigacion 1 ING QUIMICA  MATALURGIA                                                  
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('6', 'ACA-0909','IQUI-2010-232','IQUE-MET-2020-01');

-- --tall investigacion 1 ING QUIMICA AMBIENTAL
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('6', 'ACA-0909','IQUI-2010-232','IQUE-AMB-2020-02');

-- --Algebra lineal 1 ING QUIMICA  MATALURGIA                                                  
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('2', 'ACF-0903','IQUI-2010-232','IQUE-MET-2020-01');

-- --algebra lineal 1 ING QUIMICA AMBIENTAL
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('2', 'ACF-0903','IQUI-2010-232','IQUE-AMB-2020-02');

-- --calculo diferencial 1 ING QUIMICA  MATALURGIA                                                  
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('1', 'ACC-0907','IQUI-2010-232','IQUE-MET-2020-01');

-- --calculo diferencial 1 ING QUIMICA AMBIENTAL
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('1', 'ACC-0907','IQUI-2010-232','IQUE-AMB-2020-02');

-- --calculo vectorial 1 ING QUIMICA  MATALURGIA                                                  
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('4', 'ACF-0904','IQUI-2010-232','IQUE-MET-2020-01');

-- --calculo vectorila 1 ING QUIMICA AMBIENTAL
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('AGO-DIC', 'ACF-0904','IQUI-2010-232','IQUE-AMB-2020-02');

-- --metodos numericos 1 ING QUIMICA  MATALURGIA                                                  
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('5', 'SCC-1017','IQUI-2010-232','IQUE-MET-2020-01');

-- --metodos numericos 1 ING QUIMICA AMBIENTAL
-- INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe,fkPlanE_mpe,fkEspecialidad_mpe)
-- VALUES ('5', 'SCC-1017','IQUI-2010-232','IQUE-AMB-2020-02');


------------------------------------------------------------------------------------------------------------------------------------



-- planE_mpe ( de 3ro a 6to )

-- 3er semestre sistemas

--fundamentos de bd
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('3', 'AEF-1031','ISIC-2010-224','ISIE-TWM-2020-01');

--calculo vectorial
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('3', 'ACF-0904','ISIC-2010-224','ISIE-TWM-2020-01');

--estructura de datos
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('3', 'AED-1026','ISIC-2010-224','ISIE-TWM-2020-01');

-- control
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('3', 'MTJ-1006','ISIC-2010-224','ISIE-TWM-2020-01');

--fisica general
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('3', 'SCF-1016','ISIC-2010-224','ISIE-TWM-2020-01');

--invest de operaciones
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('3', 'SCC-1013','ISIC-2010-224','ISIE-TWM-2020-01');


-- 4to semestre sistemas
--ecuaciones diferenciales 
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('4', 'ACF-0905','ISIC-2010-224','ISIE-TWM-2020-01');
--fundamentos de ing software 

INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('4', 'SCC-1007','ISIC-2010-224','ISIE-TWM-2020-01');
--simulacion
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('4', 'SCD-1022','ISIC-2010-224','ISIE-TWM-2020-01');
--topicos progr
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('4', 'SCD-1007','ISIC-2010-224','ISIE-TWM-2020-01');
--Taller bd
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('4', 'SCA-1025','ISIC-2010-224','ISIE-TWM-2020-01');
--principios electricos
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('4', 'SCD-1018','ISIC-2010-224','ISIE-TWM-2020-01');


-- 5to semestre sistemas
--metodos numericos
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('5', 'SCC-1017','ISIC-2010-224','ISIE-TWM-2020-01');
--graficacion
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('5', 'SCC-1010','ISIC-2010-224','ISIE-TWM-2020-01');
--progra web
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('5', 'AEB-1055','ISIC-2010-224','ISIE-TWM-2020-01');
--SO
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('5', 'AEC-1061','ISIC-2010-224','ISIE-TWM-2020-01');
--fundamentos tele
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('5', 'AEC-1034','ISIC-2010-224','ISIE-TWM-2020-01');
--taller de investigacion 1
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('5', 'ACA-0909','ISIC-2010-224','ISIE-TWM-2020-01');
--arquitectura

INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('5', 'SCD-1003','ISIC-2010-224','ISIE-TWM-2020-01');


-- 6to semestre sistemas
-- automatas 1
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('6', 'SCD-1015','ISIC-2010-224','ISIE-TWM-2020-01');
--ingenieria software
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('6', 'SCD-1011','ISIC-2010-224','ISIE-TWM-2020-01');
--cultura
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('6', 'SCC-1005','ISIC-2010-224','ISIE-TWM-2020-01');
-- taller so
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('6', 'SCA-1026','ISIC-2010-224','ISIE-TWM-2020-01');
--redes
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('6', 'SCD-1021','ISIC-2010-224','ISIE-TWM-2020-01');
--taller investi 2
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('6', 'ACA-0910','ISIC-2010-224','ISIE-TWM-2020-01');
-- lenhiajes de interfaz
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('6', 'SCC-1014','ISIC-2010-224','ISIE-TWM-2020-01');

--septimo semestre
--automatas 2
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('7', 'SCD-1016','ISIC-2010-224','ISIE-TWM-2020-01');
--gestion 
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('7', 'SCG-1009','ISIC-2010-224','ISIE-TWM-2020-01');
--programacion logica y funcional
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('7', 'SCC-1019','ISIC-2010-224','ISIE-TWM-2020-01');
-- pila 1
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('7', 'TWM-2003','ISIC-2010-224','ISIE-TWM-2020-01');
--conmuta
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('7', 'SCD-1004','ISIC-2010-224','ISIE-TWM-2020-01');
--android
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('7', 'TWD-2001','ISIC-2010-224','ISIE-TWM-2020-01');

--octavo semestre 
--IOS
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('8', 'TWD-2002','ISIC-2010-224','ISIE-TWM-2020-01');
--IA
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('8', 'SCC-1022','ISIC-2010-224','ISIE-TWM-2020-01');
--admin redes
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('8', 'SCA-1002','ISIC-2010-224','ISIE-TWM-2020-01');
-- pila 2
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('8', 'TWD-2004','ISIC-2010-224','ISIE-TWM-2020-01');
--admin db
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('8', 'SCB-1001','ISIC-2010-224','ISIE-TWM-2020-01');
--sistemas programables
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('8', 'SCC-1023','ISIC-2010-224','ISIE-TWM-2020-01');
--desarrollo habili
INSERT INTO materiaPlanE (semestre_mpe, fkMateria_mpe, fkPlanE_mpe, fkEspecialidad_mpe)
VALUES ('8', 'TWD-2005','ISIC-2010-224','ISIE-TWM-2020-01');



----------------------------------------------------------------------------------------
                                                -- VALORES PARA LA TABLA GRUPO

 -- grupo de sistemas 
-------------------------------------------------------------------------
 --grupos de primer semestre sistemas , habra dos grupos por materia

--grupo a calculo diferencial  	ALBA	GARCIA	JOSE DE JESUS
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T137201','ACC-0907','ISIC-2010-224','ISIE-TWM-2020-01','1');

--grupo b calculo diferencial  	ALBA	GARCIA	JOSE DE JESUS
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T137201','ACC-0907','ISIC-2010-224','ISIE-TWM-2020-01','1');

--Grupo A taller de etica  	RAMOS	ROSALES	JOSEFINA
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T139314','ACA-0907','ISIC-2010-224','ISIE-TWM-2020-01','1');

--Grupo B taller de etica  	RAMOS	ROSALES	JOSEFINA
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T139314','ACA-0907','ISIC-2010-224','ISIE-TWM-2020-01','1');

--grupo a mate discretas  	RIOS	QUINTANA	SAMUEL DIAMANTE
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T130019','AEF-1041','ISIC-2010-224','ISIE-TWM-2020-01','1');

--grupo b mate discretas  	RIOS	QUINTANA	SAMUEL DIAMANTE
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T130019','AEF-1041','ISIC-2010-224','ISIE-TWM-2020-01','1');

--grupo a alogirtomos LOPEZ	CISEÑA	ARMANDO
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T139311','MAE-1001','ISIC-2010-224','ISIE-TWM-2020-01','1');

--grupo b alogirtomos LOPEZ	CISEÑA	ARMANDO
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T139311','MAE-1001','ISIC-2010-224','ISIE-TWM-2020-01','1');

 -- grupo A Fundamentos de programacion 	LOPEZ	CISEÑA	ARMANDO
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T139311','SCD-1008','ISIC-2010-224','ISIE-TWM-2020-01','1');

 -- grupo B Fundamentos de programacion	LOPEZ	CISEÑA	ARMANDO
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T139311','SCD-1008','ISIC-2010-224','ISIE-TWM-2020-01','1');

--grupo a fundamentos de investigacion  	DE SANTIAGO	BARRAGAN	MAYELA ESTHER
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T138406','ACC-0906','ISIC-2010-224','ISIE-TWM-2020-01','1');

--grupo b fundamentos de investigacion  	DE SANTIAGO	BARRAGAN	MAYELA ESTHER
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T138406','ACC-0906','ISIC-2010-224','ISIE-TWM-2020-01','1');
----------------------------------------------------------
-------------------------------

--grupos segundo semestre 
--grupo a calculo integral  	ALBA	GARCIA	JOSE DE JESUS
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T130205','ACF-0902','ISIC-2010-224','ISIE-TWM-2020-01','2');

--grupo b   integral	ALBA	GARCIA	JOSE DE JESUS
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T130205','ACF-0902','ISIC-2010-224','ISIE-TWM-2020-01','2');

--Grupo A desa sus  	RAMOS	ROSALES	JOSEFINA
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T138102','ACD-0908','ISIC-2010-224','ISIE-TWM-2020-01','2');

--Grupo B desa sus  	RAMOS	ROSALES	JOSEFINA
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T138102','ACD-0908','ISIC-2010-224','ISIE-TWM-2020-01','2');

--grupo a prob y estad  	RIOS	QUINTANA	SAMUEL DIAMANTE
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T139503','AEC-1053','ISIC-2010-224','ISIE-TWM-2020-01','2');

--grupo b proba y estad 	RIOS	QUINTANA	SAMUEL DIAMANTE
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T139503','AEC-1053','ISIC-2010-224','ISIE-TWM-2020-01','2');

--grupo a progra LOPEZ	CISEÑA	ARMANDO
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T137904','IQC-1024','ISIC-2010-224','ISIE-TWM-2020-01','2');

--grupo b progra LOPEZ	CISEÑA	ARMANDO
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T137904','IQC-1024','ISIC-2010-224','ISIE-TWM-2020-01','2');

 -- grupo A analisis flui 	LOPEZ	CISEÑA	ARMANDO
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T139311','MTC-1003','ISIC-2010-224','ISIE-TWM-2020-01','2');

 -- grupo B analisi flui	LOPEZ	CISEÑA	ARMANDO
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T139311','MTC-1003','ISIC-2010-224','ISIE-TWM-2020-01','2');

--grupo a dinamica(quimica) 	DE SANTIAGO	BARRAGAN	MAYELA ESTHER
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T138406','ACF-0903','ISIC-2010-224','ISIE-TWM-2020-01','2');

--grupo b fdinamica (quimica)	DE SANTIAGO	BARRAGAN	MAYELA ESTHER
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T138406','ACF-0903','ISIC-2010-224','ISIE-TWM-2020-01','2');



-- NUEVOS INSERTS...
-- GRUPOS ( de 3er a 6to )

-- grupo 3er semestre A y B

-- ACF-0904 ( para 3er semestre en grupo, hay un error de llave, ya que es maestro por asignar, y no se tiene clave para ello... no tratar de insertar )
-- se insertará después.
--estructura de datos A ZAPATA	DAVILA	JOSE LUIS
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T138408','AED-1026','ISIC-2010-224','ISIE-TWM-2020-01','3');
--estructura de datos B ZAPATA	DAVILA	JOSE LUIS
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T138408','AED-1026','ISIC-2010-224','ISIE-TWM-2020-01','3');

--calculo vectorial A  OCON	DIAZ	CESAR ADRIAN
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T131009','ACF-0904','ISIC-2010-224','ISIE-TWM-2020-01','3');
--calculo vectorial B  OCON	DIAZ	CESAR ADRIAN
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T131009','ACF-0904','ISIC-2010-224','ISIE-TWM-2020-01','3');

--fundamentos bd A PACHECO	CASAS	JOSE CANDELARIO
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T137407','AEF-1031','ISIC-2010-224','ISIE-TWM-2020-01','3');
--fundamentos bd B PACHECO	CASAS	JOSE CANDELARIO
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T137407','AEF-1031','ISIC-2010-224','ISIE-TWM-2020-01','3');

--control A  	RIOS	VELEZ	GERARDO
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T139317','MTJ-1006','ISIC-2010-224','ISIE-TWM-2020-01','3');
--control B  RIOS	VELEZ	GERARDO
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T139317','MTJ-1006','ISIC-2010-224','ISIE-TWM-2020-01','3');

--fisica A  	RIOS	VELEZ	GERARDO
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T130614','SCF-1016','ISIC-2010-224','ISIE-TWM-2020-01','3');
--fisica B  RIOS	VELEZ	GERARDO
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T130614','SCF-1016','ISIC-2010-224','ISIE-TWM-2020-01','3');


--operaciones A  	TORRES	MARTINEZ	LAURA CRISTINA
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T131505','SCC-1013','ISIC-2010-224','ISIE-TWM-2020-01','3');
--operaciones B TORRES	MARTINEZ	LAURA CRISTINA
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T131505','SCC-1013','ISIC-2010-224','ISIE-TWM-2020-01','3');



-- =============================================================================================================

-- grupo 4to semestre A y B
--ecuaciones diferenciales A  QUIROZ	BARRAGAN	GUSTAVO SABINO
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T138104','ACF-0905','ISIC-2010-224','ISIE-TWM-2020-01','4');
--ecuaciones diferenciales B UIROZ	BARRAGAN	GUSTAVO SABINO
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T138104','ACF-0905','ISIC-2010-224','ISIE-TWM-2020-01','4');

--simulacion A CUAN	DURON	ERNESTO
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T139202','SCD-1022','ISIC-2010-224','ISIE-TWM-2020-01','4');
--simulacion B CUAN	DURON	ERNESTO
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T139202','SCD-1022','ISIC-2010-224','ISIE-TWM-2020-01','4');

-- fundamentos ing soft A PALACIOS	DURAN	CARLA ROCIO
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T130211','SCC-1007','ISIC-2010-224','ISIE-TWM-2020-01','4');
-- fundamentos ing soft B PADILLA	TORRES	MICHELLE
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T130016','SCC-1007','ISIC-2010-224','ISIE-TWM-2020-01','4');

-- principios elec A 	CARRILLO	REYES	CLAUDIA ELENA
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T139003','SCD-1018','ISIC-2010-224','ISIE-TWM-2020-01','4');
-- principios elec B 
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T139003','SCD-1018','ISIC-2010-224','ISIE-TWM-2020-01','4');


-- TALLER BD A 		CAMPA	NUÑEZ	PANTALEONA
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T130402','SCA-1025','ISIC-2010-224','ISIE-TWM-2020-01','4');
-- taller bd B 
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T130402','SCA-1025','ISIC-2010-224','ISIE-TWM-2020-01','4');

-- topicos A 	RUIZ	ARROYO	ARMANDO
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T139911','SCD-1007','ISIC-2010-224','ISIE-TWM-2020-01','4');
-- topicos bd B 
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T139911','SCD-1007','ISIC-2010-224','ISIE-TWM-2020-01','4');


-- =============================================================================================================


-- grupo 5to semestre A y B
-- metodos numericos A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T130211','SCC-1017','ISIC-2010-224','ISIE-TWM-2020-01','5');
-- metodos numericos B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T138104','SCC-1017','ISIC-2010-224','ISIE-TWM-2020-01','5');

--graficacion A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T139807','SCC-1010','ISIC-2010-224','ISIE-TWM-2020-01','5');
--Graficacion B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T139701','SCC-1010','ISIC-2010-224','ISIE-TWM-2020-01','5');

--programacion web A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T131304','AEB-1055','ISIC-2010-224','ISIE-TWM-2020-01','5');
--pprogramacion web B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T130027','AEB-1055','ISIC-2010-224','ISIE-TWM-2020-01','5');

--SO A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T139510','AEC-1061','ISIC-2010-224','ISIE-TWM-2020-01','5');
--SO B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T139510','AEC-1061','ISIC-2010-224','ISIE-TWM-2020-01','5');

--funda tele A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T138508','AEC-1034','ISIC-2010-224','ISIE-TWM-2020-01','5');
--funda tele B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T138508','AEC-1034','ISIC-2010-224','ISIE-TWM-2020-01','5');


--taller inv 1 A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T131506','ACA-0909','ISIC-2010-224','ISIE-TWM-2020-01','5');
--taller 1 B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T131506','ACA-0909','ISIC-2010-224','ISIE-TWM-2020-01','5');

--arquitectuta A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T131506','SCD-1003','ISIC-2010-224','ISIE-TWM-2020-01','5');
--arquitectura B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T131506','SCD-1003','ISIC-2010-224','ISIE-TWM-2020-01','5');



-- =============================================================================================================

-- grupo 6to semestre
--cultura A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T130114','SCC-1005','ISIC-2010-224','ISIE-TWM-2020-01','6');
--cultura B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T130017','SCC-1005','ISIC-2010-224','ISIE-TWM-2020-01','6'); --Ruth

--ingeniria software A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T130016','SCD-1011','ISIC-2010-224','ISIE-TWM-2020-01','6');
-- ingenieria software B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T139307','SCD-1011','ISIC-2010-224','ISIE-TWM-2020-01','6');

-- automaytas 1
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T130818','SCD-1015','ISIC-2010-224','ISIE-TWM-2020-01','6');
--automatas 1
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T139807','SCD-1015','ISIC-2010-224','ISIE-TWM-2020-01','6');

-- taller so
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T130026','SCA-1026','ISIC-2010-224','ISIE-TWM-2020-01','6');
--taller so
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T130026','SCA-1026','ISIC-2010-224','ISIE-TWM-2020-01','6');

-- redes A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T138508','SCD-1021','ISIC-2010-224','ISIE-TWM-2020-01','6');
--redes B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T138508','SCD-1021','ISIC-2010-224','ISIE-TWM-2020-01','6');

-- taller inv 2 A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T139214','ACA-0910','ISIC-2010-224','ISIE-TWM-2020-01','6');
--taller inv 2 B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T139214','ACA-0910','ISIC-2010-224','ISIE-TWM-2020-01','6');

-- interfaz A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T139415','SCC-1014','ISIC-2010-224','ISIE-TWM-2020-01','6');
-- interfaz 2 B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T139415','SCC-1014','ISIC-2010-224','ISIE-TWM-2020-01','6');


--grupos septimo

--automatas 2 A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T131119','SCD-1016','ISIC-2010-224','ISIE-TWM-2020-01','7');
--automatas 2 B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T131119','SCD-1016','ISIC-2010-224','ISIE-TWM-2020-01','7'); --Ruth

-- gestion A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T130504','SCG-1009','ISIC-2010-224','ISIE-TWM-2020-01','7');
-- gestion  B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T130504','SCG-1009','ISIC-2010-224','ISIE-TWM-2020-01','7');

-- Progre logica func A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T139912','SCC-1019','ISIC-2010-224','ISIE-TWM-2020-01','7');
--Progre logica func B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T139912','SCC-1019','ISIC-2010-224','ISIE-TWM-2020-01','7');

-- Pila 1 A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T138408','TWM-2003','ISIC-2010-224','ISIE-TWM-2020-01','7');
--Pila 1 B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T138408','TWM-2003','ISIC-2010-224','ISIE-TWM-2020-01','7');

-- conmuta A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T137104','SCD-1004','ISIC-2010-224','ISIE-TWM-2020-01','7');
-- conmuta B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T137104','SCD-1004','ISIC-2010-224','ISIE-TWM-2020-01','7');

-- androd A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T139416','TWD-2001','ISIC-2010-224','ISIE-TWM-2020-01','7');
-- android B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T139416','TWD-2001','ISIC-2010-224','ISIE-TWM-2020-01','7');


--grupos octavo

--IA A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T137103','SCC-1022','ISIC-2010-224','ISIE-TWM-2020-01','8');
-- IA B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T137103','SCC-1022','ISIC-2010-224','ISIE-TWM-2020-01','8'); --Ruth

-- IOS A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T131507','TWD-2002','ISIC-2010-224','ISIE-TWM-2020-01','8');
-- IOS B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T131507','TWD-2002','ISIC-2010-224','ISIE-TWM-2020-01','8');

-- admin redes A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T139106','SCA-1002','ISIC-2010-224','ISIE-TWM-2020-01','8');
-- admin redes B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T139106','SCA-1002','ISIC-2010-224','ISIE-TWM-2020-01','8');

-- Pila 2 A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T138213','TWD-2004','ISIC-2010-224','ISIE-TWM-2020-01','8');
--Pila 2 B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T138213','TWD-2004','ISIC-2010-224','ISIE-TWM-2020-01','8');

-- admin dba A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T130614','SCB-1001','ISIC-2010-224','ISIE-TWM-2020-01','8');
-- admin dba B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T130614','SCB-1001','ISIC-2010-224','ISIE-TWM-2020-01','8');

-- sistemas progra A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T139416','SCC-1023','ISIC-2010-224','ISIE-TWM-2020-01','8');
-- sistemas progra B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T139416','SCC-1023','ISIC-2010-224','ISIE-TWM-2020-01','8');

-- desarrollo habi A
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('A', 'AGO-DIC','T131013','TWD-2005','ISIC-2010-224','ISIE-TWM-2020-01','8');
-- desarrollo hab B
INSERT INTO grupo (cve_g, semestre_g,fkPersonal_g,fkMateria_g,fkPlanE_g,fkEspecialidad_g,fksemestre_g)
VALUES ('B', 'AGO-DIC','T131013','TWD-2005','ISIC-2010-224','ISIE-TWM-2020-01','8');


-----------------------------------------

-- kardex
--insertar la calificacion de las materias de los 8 semestres 

--alumno 20130026
--semestre 1
INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.9,80.0,'A','T137201','ACC-0907',
'ISIC-2010-224','ISIE-TWM-2020-01','1');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.9,80.0,'A','T139314','ACA-0907',
'ISIC-2010-224','ISIE-TWM-2020-01','1');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.0,80.0,'A','T130019','AEF-1041',
'ISIC-2010-224','ISIE-TWM-2020-01','1');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.0,80.0,'A','T139311','MAE-1001',
'ISIC-2010-224','ISIE-TWM-2020-01','1');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,8.6,80.0,'A','T139311','SCD-1008',
'ISIC-2010-224','ISIE-TWM-2020-01','1');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.6,80.0,'A','T138406','ACC-0906',
'ISIC-2010-224','ISIE-TWM-2020-01','1');

--segundo semestre 
INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.9,80.0,'A','T130205','ACF-0902',
'ISIC-2010-224','ISIE-TWM-2020-01','2');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.9,80.0,'A','T138102','ACD-0908',
'ISIC-2010-224','ISIE-TWM-2020-01','2');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.0,80.0,'A','T139503','AEC-1053',
'ISIC-2010-224','ISIE-TWM-2020-01','2');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.0,80.0,'A','T137904','IQC-1024',
'ISIC-2010-224','ISIE-TWM-2020-01','2');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,8.6,80.0,'A','T139311','MTC-1003',
'ISIC-2010-224','ISIE-TWM-2020-01','2');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.6,80.0,'A','T138406','ACF-0903',
'ISIC-2010-224','ISIE-TWM-2020-01','2');

--tercer semestre 

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,7.0,80.0,'A','T138408','AED-1026',
'ISIC-2010-224','ISIE-TWM-2020-01','3');

--estructura de datos 
INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 8.0 ,3.0,80.0,'A','T131009','ACF-0904',
'ISIC-2010-224','ISIE-TWM-2020-01','3');

--vectorial 
INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.0,80.0,'A','T137407','AEF-1031',
'ISIC-2010-224','ISIE-TWM-2020-01','3');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.0,80.0,'A','T139317','MTJ-1006',
'ISIC-2010-224','ISIE-TWM-2020-01','3');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,8.6,80.0,'A','T131505','SCC-1013',
'ISIC-2010-224','ISIE-TWM-2020-01','3');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.6,80.0,'A','T130614','SCF-1016',
'ISIC-2010-224','ISIE-TWM-2020-01','3');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.6,80.0,'A','T131505','SCC-1013',
'ISIC-2010-224','ISIE-TWM-2020-01','3');

-- cuarto semestre
INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,7.0,80.0,'A','T138104','ACF-0905',
'ISIC-2010-224','ISIE-TWM-2020-01','4');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.9,80.0,'A','T139202','SCD-1022',
'ISIC-2010-224','ISIE-TWM-2020-01','4');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.0,80.0,'A','T130211','SCC-1007',
'ISIC-2010-224','ISIE-TWM-2020-01','4');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.0,80.0,'A','T139003','SCD-1018',
'ISIC-2010-224','ISIE-TWM-2020-01','4');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,8.6,80.0,'A','T130402','SCA-1025',
'ISIC-2010-224','ISIE-TWM-2020-01','4');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.6,80.0,'A','T139911','SCD-1007',
'ISIC-2010-224','ISIE-TWM-2020-01','4');

--quinto semestre
INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,7.0,80.0,'A','T130211','SCC-1017',
'ISIC-2010-224','ISIE-TWM-2020-01','5');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.9,80.0,'A','T139807','SCC-1010',
'ISIC-2010-224','ISIE-TWM-2020-01','5');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.0,80.0,'A','T139510','AEB-1055',
'ISIC-2010-224','ISIE-TWM-2020-01','5');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,8.6,80.0,'A','T139510','AEC-1061',
'ISIC-2010-224','ISIE-TWM-2020-01','5');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.6,80.0,'A','T138508','AEC-1034',
'ISIC-2010-224','ISIE-TWM-2020-01','5');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.6,80.0,'A','T131506','ACA-0909',
'ISIC-2010-224','ISIE-TWM-2020-01','5');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.6,80.0,'A','T131506','SCD-1003',
'ISIC-2010-224','ISIE-TWM-2020-01','5');


--sexto semestre 

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,7.0,80.0,'A','T130114','SCC-1005',
'ISIC-2010-224','ISIE-TWM-2020-01','6');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.9,80.0,'A','T130016','SCD-1011',
'ISIC-2010-224','ISIE-TWM-2020-01','6');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.0,80.0,'A','T130818','SCD-1015',
'ISIC-2010-224','ISIE-TWM-2020-01','6');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.0,80.0,'A','T130026','SCA-1026',
'ISIC-2010-224','ISIE-TWM-2020-01','6');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,8.6,80.0,'A','T138508','SCD-1021',
'ISIC-2010-224','ISIE-TWM-2020-01','6');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.6,80.0,'A','T139214','ACA-0910',
'ISIC-2010-224','ISIE-TWM-2020-01','6');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.6,80.0,'A','T139415','SCC-1014',
'ISIC-2010-224','ISIE-TWM-2020-01','6');

--septimo semestre
INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,7.0,80.0,'A','T131119','SCD-1016',
'ISIC-2010-224','ISIE-TWM-2020-01','7');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.9,80.0,'A','T130504','SCG-1009',
'ISIC-2010-224','ISIE-TWM-2020-01','7');

--progra logi - ligada(IA) - rerpobada
INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 5.0 ,4.0,80.0,'A','T139912','SCC-1019',
'ISIC-2010-224','ISIE-TWM-2020-01','7');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.0,80.0,'A','T138408','TWM-2003',
'ISIC-2010-224','ISIE-TWM-2020-01','7');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,8.6,80.0,'A','T137104','SCD-1004',
'ISIC-2010-224','ISIE-TWM-2020-01','7');

INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_k)
VALUES ('20130026', 0.0 ,9.6,80.0,'A','T139416','TWD-2001',
'ISIC-2010-224','ISIE-TWM-2020-01','7');

--octavo
-- INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
-- fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_)
-- VALUES ('20130026', 0.0 ,7.0,80.0,'A','T137103','SCC-1022',
-- 'ISIC-2010-224','ISIE-TWM-2020-01','8');

-- INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
-- fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_)
-- VALUES ('20130026', 0.0 ,9.9,80.0,'A','T131507','TWD-2002',
-- 'ISIC-2010-224','ISIE-TWM-2020-01','8');

-- INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
-- fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_)
-- VALUES ('20130026', 0.0 ,9.0,80.0,'A','T139106','SCA-1002',
-- 'ISIC-2010-224','ISIE-TWM-2020-01','8');

-- INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
-- fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_)
-- VALUES ('20130026', 0.0 ,9.0,80.0,'A','T138213','TWD-2004',
-- 'ISIC-2010-224','ISIE-TWM-2020-01','8');

-- INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
-- fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_)
-- VALUES ('20130026', 0.0 ,8.6,80.0,'A','T130614','SCB-1001',
-- 'ISIC-2010-224','ISIE-TWM-2020-01','8');

-- INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
-- fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_)
-- VALUES ('20130026', 0.0 ,9.6,80.0,'A','T139416','SCC-1023',
-- 'ISIC-2010-224','ISIE-TWM-2020-01','8');

-- INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,
-- fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_)
-- VALUES ('20130026', 0.0 ,9.6,80.0,'A','T131013','TWD-2005',
-- 'ISIC-2010-224','ISIE-TWM-2020-01','8');
--------------------------------------------------------------------------------------------
--valores para la tabla de kardex
-------------
 -- alumnos de sistemas 

-- INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_)
-- VALUES ('20130026', 8.8,9.9,80.0,'B','T130701','SCB-1001','ISIC-2010-224','ISIE-TWM-2020-01','8');

-- INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_)
-- VALUES ('20130026', 7.7,8.9,90.0,'A','T130712','TWD-2002','ISIC-2010-224','ISIE-TWM-2020-01','8');

-- INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_)
-- VALUES ('20130026', 9.9,7.9,90.0,'B','T130712','TWD-2004','ISIC-2010-224','ISIE-TWM-2020-01','8');
----------------------
 -- alumnos de quimica
-- INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_)
-- VALUES ('20130085',9.9,7.0,90.0,'A','T131013','ACF-0903','IQUI-2010-232','IQUE-MET-2020-01','2');
 
-- INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_)
-- VALUES ('20130085',9.9,7.0,90.0,'A','T130504','SCC-1017','IQUI-2010-232','IQUE-MET-2020-01','5');

-- INSERT INTO kardex (fkAlumno_k,calificacionR_k, calificacionP_k,promedio_k,fkGrupo_k,fkPersonal_k,fkMateria_k,fkPlanE_k,fkEspecialidad_k,fksemestre_)
-- VALUES ('20130085',9.9,7.0,90.0,'A','T130504','ACF-0902','IQUI-2010-232','IQUE-MET-2020-01','3');


-- consultas 
-- obtenemos una tabla con los nombre de los alumnos que estan en el kardex 
select control_a,nombre_a,fkalumno_k from kardex inner join alumnos 
on kardex.fkalumno_k = alumnos.control_a;

-- buscamos en la tabla de kardex al  alumno que se quiere inscribir
SELECT *
FROM kardex
WHERE fkAlumno_k = 'cve del alumno a inscribir';


--ingreso periodo de un alumno
select ingreso_a, periodo_a from alumnos where control_a = '20130026';

-- filtrado de los grupos por semestre
 select * from grupo where fksemestre_g = '1';

--para verificar si un alumno se va a incribir por primera vez, tenemos que consultar su fecha de ingreso y periodo, si 
-- la fecha de ingreso coincide con el año actual y el periodo coinicide con el periodo de los grupos , entonces sera inscripcion por primerz vez
--const año = fechaActual.getFullYear(); 
select * from grupo where semestre_g = (select periodo_a from alumnos where control_a = 'D1813008');

--obtener los alumnos que ingresaron en 2023
select control_a,nombre_a, ingreso_a from alumnos where ingreso_a = '2023' limit 20;

--nombre y calificacion de la materia reprobada
select calificacionr_k,calificacionp_k,nombre_m from kardex
 inner join materia on kardex.fkmateria_k = materia.cve_m                                                                                     
where calificacionp_k < 7 and calificacionr_k < 7;

--calificacion de regulas y parcial 
select calificacionr_k,calificacionp_k,nombre_m from kardex
 inner join materia on kardex.fkmateria_k = materia.cve_m;

--calificacion diferente de 0 pero mayor que 6 , verificamos si paso en regulas 
select calificacionr_k,calificacionp_k,nombre_m from kardex
inner join materia on kardex.fkmateria_k = materia.cve_m where calificacionr_k != 0
and calificacionr_k > 6;

--calificacion diferente de 0 pero mayor que 6 , verificamos si reprobo en regulas 
select calificacionr_k,calificacionp_k,nombre_m from kardex
inner join materia on kardex.fkmateria_k = materia.cve_m where calificacionr_k != 0
and calificacionr_k < 6;

--materias que paso en primeras
select fkmateria_k,cve_m,nombre_m from kardex inner join materia on kardex.fkmateria_k = cve_m where calificacionp_k > 6;  

-- materias paso en regulas
select fkmateria_k,cve_m,nombre_m from kardex inner join materia on kardex.fkmateria_k = cve_m where calificacionr_k > 6;  

-- materia ligada a la reprobada
select nombre_m  from prerrequisitos INNER JOIN materia  on materia.cve_m = prerrequisitos.cvemateria_pre where fkmateria_pre = 'SCC-1019';


SELECT nombre_m
FROM prerrequisitos
INNER JOIN materia ON materia.cve_m = prerrequisitos.cvemateria_pre
WHERE fkmateria_pre IN (
    SELECT fkmateria_k
    FROM kardex
    INNER JOIN materia ON kardex.fkmateria_k = materia.cve_m
    WHERE calificacionp_k < 7 AND calificacionr_k < 7
);


--materias que le faltan 
SELECT mpe.fkmateria_mpe, m.nombre_m                                                                                         
FROM materiaplane mpe
LEFT JOIN kardex k ON mpe.fkmateria_mpe = k.fkmateria_k
LEFT JOIN materia m ON mpe.fkmateria_mpe = m.cve_m
WHERE k.fkmateria_k IS NULL;


--inscription
-- obtener numero control 
-- obtener fecha de ingreso y periodo del alumno
-- el alumno tiene que tener el mismo año que el año actual , si no es igual aqui termina todo
-- calcular el semestre del alumno
-- filtrar los grupos de primer semestre 
-- comparar el periodo del alumno con los periodos de los grupos
-- validar si el periodo del alumno coincide con el de los grupos , si coincide quiere decir que es nuevo ingreso , si no aqui acaba 

--reincripcion
-- obtener las calificaciones regulas y parcial 
-- validar si se paso en regulas o parcial o si reprobo
-- si en la calificacion parcial es > 6 entonces paso y ya no hay que validar la calif regulas 
-- mostrar las materias que ya aprobo de cada semestre por separado 
-- mostrar las materias que le faltan pasar , incluyendo la reprobada 
-- si reprueba una materia, cuando le toque seleccionar materias del siguiente semestre , tendra que elegir la materia reprobada si o si 
-- solo podra elegir materias del siguiente semestre 