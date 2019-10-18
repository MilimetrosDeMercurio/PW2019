--CREANDO TABLAS-----

create table alumno(
	nie varchar(20) not null,
	nombre varchar(100),
	edad integer,
	anio_ingreso smallint,

    constraint pk_nie primary key(nie)
);

create table susbvencion(
	codigo_susb varchar(50) not null,
	porcentaje_descuento numeric,
	descripcion varchar(100),
    
    constraint pk_codigo_susb primary key(codigo_susb)
);

create table anio(
	id_num_anio varchar(30) not null,
    
    constraint pk_id_num_anio primary key (id_num_anio)
);

------TABLA TERNARIA------ALUMNO--SUSBVENCION--ANIO--

create table otorga(
    id_alumno varchar(20),
    id_susbvencion varchar(50),
    num_anio varchar(30),

    constraint pk_otorga primary key(id_alumno,id_susbvencion,num_anio),

    constraint fk_otorga_alumno foreign key (id_alumno) references alumno(nie) on 
    delete cascade on update cascade,

    constraint fk_otorga_susbvencion foreign key (id_susbvencion) references 
    susbvencion(codigo_susb) on delete cascade on update cascade,
    
    constraint fk_otorga_num_anio foreign key (num_anio) references
    anio(id_num_anio) on delete cascade on update cascade

);

-----------TABLA N:M ----DOCENTE----ASIGNATURA----

create table imparte(
    denominacion_docente varchar(30),
    id_asignatura varchar(30),

    constraint pk_imparte primary key (denominacion_docente, id_asignatura),

    constraint fk_imparte_docente foreign key (denominacion_docente) references 
    docente (id_docente) on delete cascade on update cascade,
    
    constraint fk_imparte_asignatura foreign key (id_asignatura) references 
    asignatura (codigo_asignatura) on delete cascade on update cascade

);

create table docente(
	id_docente varchar(30) not null,
	nombre varchar(100),
	imparte_materia varchar(30),
	id_profesor_docente smallint,
	id_num_anio varchar(30),

    constraint pk_id_docente primary key(id_docente),

    constraint fk_docente_profesor foreign key (id_profesor_docente) references 
    profesor (id_profesor_docente) on delete cascade on update cascade,

    constraint fk_docente_anio foreign key (id_num_anio) references anio (id_num_anio)
    on delete cascade on update cascade

);

create table profesor(
	id_profesor_docente smallint not null,
	anio_graduacion smallint,

    constraint pk_profesor primary key(id_profesor_docente)

    
);

-------------TABLA N:M ----ESTUDIANTE---CARRERA---

create table estudia(
    id_estudiante_docente varchar(30),
    codigo_carrera varchar(30),
    num_anio varchar(30),

    constraint pk_estudia primary key (id_estudiante_docente,codigo_carrera,num_anio),

    constraint fk_estudia_estudiante foreign key (id_estudiante_docente) references
    estudiante_docente (id_docente) on delete cascade on update cascade,

    constraint fk_estudia_carrera foreign key (codigo_carrera) references 
    carrera (id_carrera) on delete cascade on update cascade,

    constraint fk_estudia_anio foreign key (num_anio) references anio (id_num_anio)
    on delete cascade on update cascade

);

drop table estudiante_docente;

create table estudiante_docente(
	id_docente varchar(30),

	constraint pk_estudiante_docente primary key (id_docente),

	constraint fk_estudiante_docente foreign key (id_docente) references docente (id_docente)
	on delete cascade on update cascade
);


create table carrera(
    id_carrera varchar(30) not null,
    nombre varchar(50),

    constraint pk_carrera primary key (id_carrera)
);

------TABLA TERNARIA-----ALUMNO--ANIO--SECCION--------------------

create table matricula(
    id_alumno varchar(20),
    id_anio varchar(30), -------------PENDIENTE-----------------

    constraint pk_matricula primary key(id_alumno,id_anio),
    
    constraint fk_matricula_alumno foreign key (id_alumno) references alumno (nie)
    on delete cascade on update cascade,

    constraint fk_matricula_num_anio foreign key (id_anio) references anio
    (id_num_anio) on delete cascade on update cascade
    
);

create table asignatura(
    codigo_asignatura varchar(30) not null,
    nombre varchar(50),
    id_nivel_grado varchar(30),
    num_grado varchar(10),

    constraint pk_asignatura primary key(codigo_asignatura),

    constraint fk_asignatura_grado foreign key (id_nivel_grado,num_grado) references grado 
    (id_nivel,num) on delete cascade on update cascade
);

drop table grado;

create table grado(
    id_nivel varchar(30) not null,
    num varchar(10),

    constraint pk_grado primary key(id_nivel,num),

    constraint fk_grado_nivel foreign key (id_nivel) references nivel (id) on delete cascade
    on update cascade
);

create table nivel(
    id varchar(10) not null,

    constraint pk_nivel primary key(id)
);

------------------TABLA N:M-------ASIGNATURA--ALUMNO 

create table inscribe(
    id_asignatura varchar(30),
    id_alumno varchar(30),

    constraint pk_inscribe primary key (id_asignatura,id_Alumno),

    constraint fk_inscribe_asignatura foreign key (id_asignatura) references 
    asignatura (codigo_asignatura) on delete cascade on update cascade,

    constraint fk_inscribe_alumno foreign key (id_alumno) references alumno 
    (nie) on delete cascade on update cascade
);

--------tabla nota con # y equivalencia , denominacion podria ser un array

create table seccion(
    letra varchar(10), 
    num_grado varchar(10),
    id_nivel_grado varchar(10),
    id_aulaxseccion varchar(30),
    id_aulaxasignatura varchar(30),

    constraint pk_id_seccion primary key(num_grado,id_nivel_grado,letra),

    constraint fk_seccion_grado foreign key (id_nivel_grado,num_grado) references 
    grado (id_nivel,num) on delete cascade on update cascade

);

drop table responsable;

create table responsable(
    id varchar(30) not null,
    nombre varchar(30),
    cargo varchar(50),
    responsable_empleado varchar(30),
    estudiante_responsable varchar(30),

    constraint pk_responsable primary key (id)

);

----RELACION N:M-----ALUMNO--PAGO------

create table talonario(
    id_alumno varchar(20) not null,
    id_pago smallint,
    monto numeric,
    estado varchar(50),
    fecha_pago date,
    fecha_omision date,
    fecha_vencimiento date,

    constraint fk_talonario_alumno foreign key (id_alumno) references 
    alumno (nie) on delete cascade on update cascade,

    constraint fk_talonario_pago foreign key (id_pago) references 
    pago (denominacion_pago) on delete cascade on update cascade

);

create table pago(
    denominacion_pago numeric not null,
    tipo varchar(30),
    numero integer,

    constraint pk_denominacion_pago primary key(denominacion_pago)

);

-------------TABLA N:M------BITACORA--RESPONSABLE-------

create table acuerda(
    nie_alumno_bitacora varchar(30),
    id_correlativo_bitacora varchar(50),
    id_responsable varchar(30),
 
    constraint pk_acuerda primary key (nie_alumno_bitacora,id_correlativo_bitacora,id_responsable),

    constraint fk_acuerda_alumno foreign key (nie_alumno_bitacora,id_correlativo_bitacora) references
    bitacora (nie_alumno,id_correlativo) on delete cascade on update cascade,

    constraint fk_acuerda_responsable foreign key (id_responsable) references
    responsable (id) on delete cascade on update cascade

);

create table empleado(
    id_responsable_empleado varchar(30) not null,
    oficio varchar(50),
    telefono_uca varchar(100),

    constraint pk_id_empleado primary key (id_responsable_empleado)

);

create table estudiante(
    id_estudiante_responsable varchar(30) not null,
    denominacion_carrera varchar(30),

    constraint pk_estudiante primary key (id_estudiante_responsable)

);

------------TABLA ----ESTUDIANTE---CARRERA----

create table inscribe(
    estudiante_responsable varchar(30),
    denominacion_carrera varchar(30),

    constraint pk_inscribe primary key (estudiante_responsable,denominacion_carrera),

    constraint fk_inscribe_estudiante foreign key (estudiante_responsable) 
    references estudiante (id_estudiante_responsable) on delete cascade
    on update cascade,

    constraint fk_inscribe_carrera foreign key (denominacion_carrera) references
    carrera (id_carrera) on delete cascade on update cascade
);

----------------------TABLA N:M---------ALUMNO----RESPONSABLE
drop table encarga;

create table encarga(
    id_alumno varchar(30),
    ident_responsable varchar(30),

    constraint fk_encarga_alumno foreign key (id_alumno) references alumno (nie)
    on delete cascade on update cascade,

    constraint fk_encarga_responsable foreign key (ident_responsable) references
    responsable (id) on delete cascade on update cascade

);

drop table bitacora;

create table bitacora(
    nie_alumno varchar(30),
    id_correlativo varchar(50),
    fecha_hora date, 
    tipo varchar(50),
    comentario varchar(200),
 
    constraint pk_bitacora_correlativo primary key (nie_alumno,id_correlativo),

    constraint fk_bitacora_alumno foreign key (nie_alumno) references
    alumno (nie) on delete cascade on update cascade

);

create table bitacora_relaciona(
    nie_alumno_referencia varchar(30),
    id_correlativo_referencia varchar(50),
    nie_alumno_referenciada varchar(30),
    id_correlativo_referenciada varchar(50),

    constraint pk_bitacora_relacion primary key (nie_alumno_referencia,
    id_correlativo_referencia, nie_alumno_referenciada, id_correlativo_referenciada),
    
    constraint fk_bitacora_relaciona foreign key (nie_alumno_referencia,
    id_correlativo_referencia) references bitacora (nie_alumno, id_correlativo),

    constraint fk_bitacora_referenciada foreign key 
    (nie_alumno_referenciada, id_correlativo_referenciada) references bitacora
    (nie_alumno, id_correlativo)
);

------------TABLA N:M ------BITACORA--DOCENTE----

create table anota(
    ident_nie_alumno varchar(30),
    ident_correlativo varchar(50),
    ident_docente varchar(30),
    
    constraint fk_anota_correlativo foreign key (ident_nie_alumno,ident_correlativo) references
    bitacora (nie_alumno,id_correlativo) on delete cascade on update cascade,

    constraint fk_anota_docente foreign key (ident_docente) references docente
    (id_docente) on delete cascade on update cascade

);

create table edificio(
    denominacion_edificio varchar(30) not null,
    nombre varchar(50),
    
    constraint pk_edificio primary key (denominacion_edificio)

);

--------------------TABLA RELACION N:M---------ALUMNO--EDIFICIO--------

create table acceso(
    id_alumno varchar(20),
    id_edificio varchar(30),
    fecha date,
    fecha_entrada date,
    fecha_salida date,


    constraint fk_acceso_alumno foreign key (id_alumno) references alumno (nie)
    on delete cascade on update cascade,
    
    constraint fk_acceso_edificio foreign key (id_edificio) references edificio 
    (denominacion_edificio) on delete cascade on update cascade

);

create table semestre(
    denominacion varchar(30) not null,
    id_num_anio varchar(30),
    anio smallint,

    constraint pk_denominacion primary key(denominacion),

    constraint fk_semestre_anio foreign key (id_num_anio) 
    references anio (id_num_anio)
    on delete cascade on update cascade
);

create table aula(
    denominacion_edificio varchar(30) not null,
    espacios integer,
    id_edificio varchar(30),
    id_lab varchar(30),
    id_clase varchar(30),

    constraint pk_denominacion_edificio primary key(denominacion_edificio),
    
    constraint fk_aula_edificio foreign key (id_edificio) references edificio
    (denominacion_edificio) on delete cascade on update cascade,

    constraint fk_aula_lab foreign key (id_lab) references lab__cc (denominacion_edificio) on delete cascade on update cascade,

    constraint fk_aula_clase foreign key (id_clase) references clase 
    (denominacion_edificio) on delete cascade on update cascade
);

-----TABLA N:M----- LAB--DOCENTE--
create table reserva(
    id_edificio varchar(30) not null,
    denominacion_docente varchar(30),
    fecha date,
    hora_inicio integer,
    hora_fin integer,

    constraint pk_reserva primary key (id_edificio, denominacion_docente),

    constraint fk_reserva_edificio foreign key (id_edificio) references 
    Lab__cc (denominacion_edificio) on delete cascade on update cascade,

    constraint fk_reserva_docente foreign key (denominacion_docente) references
    docente (id_docente) on delete cascade on update cascade

);

create table lab__cc(
    denominacion_edificio varchar(30) not null,
    num_aula integer,

    constraint pk_lab__cc primary key (denominacion_edificio)
);

create table asigna(
    id_clase varchar(30),
    id_aulaxseccion varchar(30),
    
    constraint pk_asigna primary key (id_clase, id_aulaxseccion),

    constraint fk_asigna_edificio foreign key (id_clase) references clase 
    (denominacion_edificio) on delete cascade on update cascade,

    constraint fk_asigna_aulaxseccion foreign key (id_aulaxseccion) references 
    aulaxseccion (num_grado,id_nivel_grado,letra) on delete cascade on update cascade

);

create table clase(
    denominacion_edificio varchar(30) not null,
    num_Aula integer,
    
    constraint pk_clase primary key (denominacion_edificio)
);

----BITACORA REFERENCIA Y BITACORA REFERENCIADA una sola tabla 

-------------TABLE TERNARIA---SECCION---DOCENTE---SEMESTRE--------

create table responsable_SD(
    id_docente varchar(30),
    id_nivel_seccion varchar(30),
    id_semestre varchar(30),

    constraint pk_responsable_SD primary key (id_docente, id_nivel_seccion,id_semestre),

    constraint fk_respnsable_SD_docente foreign key (id_docente) references 
    docente (id_docente) on delete cascade on update cascade,

    constraint fk_responsable_SD_nivel foreign key (id_nivel_seccion) references
    seccion (id_nivel_grado) on delete cascade on update cascade,

    constraint fk_responsable_SD_semestre foreign key (id_semestre)
    references semestre (denominacion) on delete cascade on update cascade
);

drop table aulaxseccion;

create table aulaxseccion(
    num_grado varchar(30),
    id_nivel_grado varchar(30),
    id_anio_num varchar(30),
    letra varchar(10), 
    
    constraint pk_aulaxseccion primary key (num_grado,id_nivel_grado,id_anio_num,letra)

);

------TABLA ----AULAXSECCIO---ANIO----CLASE

drop table asigna_AAC;

create table asigna_AAC(
    id_anio_num varchar(30),
    letra varchar(10), 
    id_nivel_grado varchar(30),
    num_grado varchar(30),
    denominacion_edificio varchar(30),
    
    
    constraint pk_aulaxseccion primary key (id_anio_num,letra,id_nivel_grado,
    num_grado,denominacion_edificio),

    constraint fk_asigna_AAC_anio foreign key (id_anio_num) references
    anio (id) on delete cascade on update cascade,
    
    constraint fk_asigna_AAC_letra foreign key (letra) references seccion (letra,
    num_grado,id_nivel_grado) on delete cascade on update cascade,

    constraint fk_asigna_AAC_grado foreign key (id_nivel_grado) references 
    grado (id_nivel,num_grado) on delete cascade on update cascade,

    constraint fk_asigna_AAC_grado foreign key (num_grado) references 
    grado (id_nivel,num_grado) on delete cascade on update cascade,

    constraint fk_asigna_AAC_edificio foreign key (denominacion_edificio) references
    edificio (denominacion_edificio) on delete cascade on update cascade

);


create table aulaxasignatura(
    denominacion_aulaxasignatura varchar(30) not null,

    constraint pk_aulaxdenominacion primary key (denominacion_aulaxasignatura)

);

create table asigna_asignatura(
    id_asignatura varchar(30),
    id_aulaxasignatura varchar(30),

    constraint pk_asigna_asignatura primary key (id_asignatura, id_aulaxasignatura),

    constraint fk_asigna_asignatura foreign key (id_asignatura) references 
    asignatura (codigo_asignatura) on delete cascade on update cascade,

    constraint fk_asigna_aulaxasignatura foreign key (id_aulaxasignatura) 
    references aulaxasignatura (denominacion_aulaxasignatura) on delete    
    cascade on update cascade

);