-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://github.com/pgadmin-org/pgadmin4/issues/new/choose if you find any bugs, including reproduction steps.
BEGIN;


CREATE SEQUENCE IF NOT EXISTS public.alumno_id_alumno_seq;
CREATE SEQUENCE IF NOT EXISTS public.rama_id_rama_seq;

CREATE TABLE IF NOT EXISTS public.rol (
    id_rol serial NOT NULL,
    nombre text NOT NULL,
    descripcion text,
    hora_entrada time,
    hora_salida time,
    CONSTRAINT rol_pkey PRIMARY KEY (id_rol)
);

CREATE TABLE IF NOT EXISTS public.modalidad (
    id_modalidad serial NOT NULL,
    nombre text NOT NULL,
    hora_entrada time,
    hora_salida time,
    CONSTRAINT modalidad_pkey PRIMARY KEY (id_modalidad)
);

CREATE TABLE IF NOT EXISTS public.profesor (
    id_profesor serial NOT NULL,
    nombre text NOT NULL,
    email text,
    fecha_inicio_trabajo date,
    fecha_fin date,
    id_rol integer,
    CONSTRAINT profesor_pkey PRIMARY KEY (id_profesor)
);

CREATE TABLE IF NOT EXISTS public.rama (
    id_rama integer NOT NULL DEFAULT nextval('public.rama_id_rama_seq'::regclass),
    nombre character varying NOT NULL,
    id_profesor integer,
    id_modalidad integer,
    CONSTRAINT rama_pkey PRIMARY KEY (id_rama)
);

CREATE TABLE IF NOT EXISTS public.promocion (
    id_promocion serial NOT NULL,
    fecha_inicio date,
    fecha_fin date,
    npromocion integer,
    CONSTRAINT promocion_pkey PRIMARY KEY (id_promocion)
);

CREATE TABLE IF NOT EXISTS public.campus (
    id_campus serial NOT NULL,
    nombre character varying NOT NULL,
    id_promocion integer,
    CONSTRAINT campus_pkey PRIMARY KEY (id_campus)
);

CREATE TABLE IF NOT EXISTS public.proyecto (
    id_proyecto serial NOT NULL,
    nombre text NOT NULL,
    descripcion text,
    id_rama integer,
    CONSTRAINT proyecto_pkey PRIMARY KEY (id_proyecto)
);

CREATE TABLE IF NOT EXISTS public.alumno (
    id_alumno integer NOT NULL DEFAULT nextval('public.alumno_id_alumno_seq'::regclass),
    nombre text NOT NULL,
    email text,
    id_rama integer,
    id_promocion integer,
    CONSTRAINT alumno_pkey PRIMARY KEY (id_alumno)
);

CREATE TABLE IF NOT EXISTS public.aprobado (
    id_nota serial NOT NULL,
    id_proyecto integer NOT NULL,
    apto boolean,
    id_alumno integer,
    CONSTRAINT aprobado_pkey PRIMARY KEY (id_nota)
);

ALTER TABLE IF EXISTS public.profesor
    ADD CONSTRAINT fk_profesor_rol FOREIGN KEY (id_rol)
    REFERENCES public.rol (id_rol) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.rama
    ADD CONSTRAINT fk_rama_profesor FOREIGN KEY (id_profesor)
    REFERENCES public.profesor (id_profesor) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.rama
    ADD CONSTRAINT fk_rama_modalidad FOREIGN KEY (id_modalidad)
    REFERENCES public.modalidad (id_modalidad) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.proyecto
    ADD CONSTRAINT fk_proyecto_rama FOREIGN KEY (id_rama)
    REFERENCES public.rama (id_rama) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.alumno
    ADD CONSTRAINT fk_alumno_rama FOREIGN KEY (id_rama)
    REFERENCES public.rama (id_rama) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.alumno
    ADD CONSTRAINT fk_alumno_promocion FOREIGN KEY (id_promocion)
    REFERENCES public.promocion (id_promocion) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.campus
    ADD CONSTRAINT fk_campus_promocion FOREIGN KEY (id_promocion)
    REFERENCES public.promocion (id_promocion) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.aprobado
    ADD CONSTRAINT fk_aprobado_alumno FOREIGN KEY (id_alumno)
    REFERENCES public.alumno (id_alumno) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.aprobado
    ADD CONSTRAINT fk_aprobado_proyecto FOREIGN KEY (id_proyecto)
    REFERENCES public.proyecto (id_proyecto) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

CREATE INDEX IF NOT EXISTS idx_profesor_rol ON public.profesor(id_rol);
CREATE INDEX IF NOT EXISTS idx_rama_profesor ON public.rama(id_profesor);
CREATE INDEX IF NOT EXISTS idx_rama_modalidad ON public.rama(id_modalidad);
CREATE INDEX IF NOT EXISTS idx_proyecto_rama ON public.proyecto(id_rama);
CREATE INDEX IF NOT EXISTS idx_alumno_rama ON public.alumno(id_rama);
CREATE INDEX IF NOT EXISTS idx_alumno_promocion ON public.alumno(id_promocion);
CREATE INDEX IF NOT EXISTS idx_campus_promocion ON public.campus(id_promocion);
CREATE INDEX IF NOT EXISTS idx_aprobado_alumno ON public.aprobado(id_alumno);
CREATE INDEX IF NOT EXISTS idx_aprobado_proyecto ON public.aprobado(id_proyecto);

END;