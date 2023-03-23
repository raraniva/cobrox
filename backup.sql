--
-- PostgreSQL database dump
--

-- Dumped from database version 13.7
-- Dumped by pg_dump version 14.2

-- Started on 2023-03-22 17:57:51

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2 (class 3079 OID 20678)
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA pg_catalog;


--
-- TOC entry 3596 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 208 (class 1259 OID 20439)
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 20437)
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- TOC entry 3597 (class 0 OID 0)
-- Dependencies: 207
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- TOC entry 210 (class 1259 OID 20449)
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 20447)
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- TOC entry 3598 (class 0 OID 0)
-- Dependencies: 209
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- TOC entry 206 (class 1259 OID 20431)
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 20429)
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- TOC entry 3599 (class 0 OID 0)
-- Dependencies: 205
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- TOC entry 212 (class 1259 OID 20457)
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 20467)
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 20465)
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO postgres;

--
-- TOC entry 3600 (class 0 OID 0)
-- Dependencies: 213
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- TOC entry 211 (class 1259 OID 20455)
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO postgres;

--
-- TOC entry 3601 (class 0 OID 0)
-- Dependencies: 211
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- TOC entry 216 (class 1259 OID 20475)
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 20473)
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO postgres;

--
-- TOC entry 3602 (class 0 OID 0)
-- Dependencies: 215
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- TOC entry 233 (class 1259 OID 20657)
-- Name: cobrox_cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cobrox_cliente (
    id bigint NOT NULL,
    codigo character varying(10),
    nombre character varying(200) NOT NULL,
    dui character varying(15) NOT NULL,
    nit character varying(25) NOT NULL,
    direccion text NOT NULL,
    telefono character varying(25) NOT NULL,
    observacion text,
    tipo_cliente_id bigint,
    zona_id bigint NOT NULL,
    celular character varying(25),
    date_creation timestamp with time zone NOT NULL,
    user_creation_id integer,
    user_last_update_id integer
);


ALTER TABLE public.cobrox_cliente OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 20745)
-- Name: cobrox_cliente_archivo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cobrox_cliente_archivo (
    id bigint NOT NULL,
    archivo character varying(100) NOT NULL,
    nombre character varying(400) NOT NULL,
    fecha timestamp with time zone NOT NULL,
    cliente_id bigint NOT NULL,
    date_creation timestamp with time zone NOT NULL,
    user_creation_id integer,
    user_last_update_id integer
);


ALTER TABLE public.cobrox_cliente_archivo OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 20756)
-- Name: cobrox_credito_archivo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cobrox_credito_archivo (
    id bigint NOT NULL,
    archivo character varying(500) NOT NULL,
    nombre character varying(400) NOT NULL,
    fecha timestamp with time zone NOT NULL,
    credito_id bigint NOT NULL,
    date_creation timestamp with time zone NOT NULL,
    user_creation_id integer,
    user_last_update_id integer
);


ALTER TABLE public.cobrox_credito_archivo OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 20754)
-- Name: cobrox_cliente_archivos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cobrox_cliente_archivos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cobrox_cliente_archivos_id_seq OWNER TO postgres;

--
-- TOC entry 3603 (class 0 OID 0)
-- Dependencies: 242
-- Name: cobrox_cliente_archivos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cobrox_cliente_archivos_id_seq OWNED BY public.cobrox_credito_archivo.id;


--
-- TOC entry 232 (class 1259 OID 20655)
-- Name: cobrox_cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cobrox_cliente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cobrox_cliente_id_seq OWNER TO postgres;

--
-- TOC entry 3604 (class 0 OID 0)
-- Dependencies: 232
-- Name: cobrox_cliente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cobrox_cliente_id_seq OWNED BY public.cobrox_cliente.id;


--
-- TOC entry 235 (class 1259 OID 20687)
-- Name: cobrox_credito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cobrox_credito (
    id bigint NOT NULL,
    codigo character varying(10),
    montootorgado numeric(10,2) NOT NULL,
    fechaini date NOT NULL,
    fechaven date NOT NULL,
    interespct numeric(6,3) NOT NULL,
    qtydiascuota numeric(10,2) NOT NULL,
    capitalcuota numeric(10,2) NOT NULL,
    interescuota numeric(10,2) NOT NULL,
    totalcuota numeric(10,2) NOT NULL,
    cuotaspagadas numeric(10,2) NOT NULL,
    cuotaspendientes numeric(10,2) NOT NULL,
    saldopendiente numeric(10,2) NOT NULL,
    tipocredito integer NOT NULL,
    estadocredito integer NOT NULL,
    cliente_id bigint NOT NULL,
    interestotal numeric(10,2) NOT NULL,
    montoyinterestotal numeric(10,2) NOT NULL,
    estadoregistro integer NOT NULL,
    nm_estado integer NOT NULL,
    date_creation timestamp with time zone NOT NULL,
    user_creation_id integer,
    user_last_update_id integer,
    CONSTRAINT cobrox_credito_estadocredito_check CHECK ((estadocredito >= 0)),
    CONSTRAINT cobrox_credito_estadoregistro_check CHECK ((estadoregistro >= 0)),
    CONSTRAINT cobrox_credito_tipocredito_check CHECK ((tipocredito >= 0))
);


ALTER TABLE public.cobrox_credito OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 20743)
-- Name: cobrox_credito_archivos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cobrox_credito_archivos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cobrox_credito_archivos_id_seq OWNER TO postgres;

--
-- TOC entry 3605 (class 0 OID 0)
-- Dependencies: 240
-- Name: cobrox_credito_archivos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cobrox_credito_archivos_id_seq OWNED BY public.cobrox_cliente_archivo.id;


--
-- TOC entry 234 (class 1259 OID 20685)
-- Name: cobrox_credito_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cobrox_credito_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cobrox_credito_id_seq OWNER TO postgres;

--
-- TOC entry 3606 (class 0 OID 0)
-- Dependencies: 234
-- Name: cobrox_credito_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cobrox_credito_id_seq OWNED BY public.cobrox_credito.id;


--
-- TOC entry 239 (class 1259 OID 20725)
-- Name: cobrox_creditofinanc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cobrox_creditofinanc (
    id bigint NOT NULL,
    credito_financia_id bigint NOT NULL,
    credito_nvo_id bigint NOT NULL,
    date_creation timestamp with time zone NOT NULL,
    user_creation_id integer,
    user_last_update_id integer
);


ALTER TABLE public.cobrox_creditofinanc OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 20723)
-- Name: cobrox_creditofinanc_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cobrox_creditofinanc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cobrox_creditofinanc_id_seq OWNER TO postgres;

--
-- TOC entry 3607 (class 0 OID 0)
-- Dependencies: 238
-- Name: cobrox_creditofinanc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cobrox_creditofinanc_id_seq OWNED BY public.cobrox_creditofinanc.id;


--
-- TOC entry 221 (class 1259 OID 20578)
-- Name: cobrox_filial; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cobrox_filial (
    id bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    date_creation timestamp with time zone NOT NULL,
    user_creation_id integer,
    user_last_update_id integer
);


ALTER TABLE public.cobrox_filial OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 20576)
-- Name: cobrox_filial_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cobrox_filial_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cobrox_filial_id_seq OWNER TO postgres;

--
-- TOC entry 3608 (class 0 OID 0)
-- Dependencies: 220
-- Name: cobrox_filial_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cobrox_filial_id_seq OWNED BY public.cobrox_filial.id;


--
-- TOC entry 261 (class 1259 OID 20995)
-- Name: cobrox_historicalcliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cobrox_historicalcliente (
    id bigint NOT NULL,
    codigo character varying(10),
    nombre character varying(200) NOT NULL,
    dui character varying(15) NOT NULL,
    nit character varying(25) NOT NULL,
    direccion text NOT NULL,
    telefono character varying(25) NOT NULL,
    celular character varying(25),
    observacion text,
    date_creation timestamp with time zone NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    history_user_id integer,
    tipo_cliente_id bigint,
    user_creation_id integer,
    user_last_update_id integer,
    zona_id bigint
);


ALTER TABLE public.cobrox_historicalcliente OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 20984)
-- Name: cobrox_historicalcliente_archivo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cobrox_historicalcliente_archivo (
    id bigint NOT NULL,
    archivo text NOT NULL,
    nombre character varying(400) NOT NULL,
    fecha timestamp with time zone NOT NULL,
    date_creation timestamp with time zone NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    cliente_id bigint,
    history_user_id integer,
    user_creation_id integer,
    user_last_update_id integer
);


ALTER TABLE public.cobrox_historicalcliente_archivo OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 20982)
-- Name: cobrox_historicalcliente_archivo_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cobrox_historicalcliente_archivo_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cobrox_historicalcliente_archivo_history_id_seq OWNER TO postgres;

--
-- TOC entry 3609 (class 0 OID 0)
-- Dependencies: 258
-- Name: cobrox_historicalcliente_archivo_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cobrox_historicalcliente_archivo_history_id_seq OWNED BY public.cobrox_historicalcliente_archivo.history_id;


--
-- TOC entry 260 (class 1259 OID 20993)
-- Name: cobrox_historicalcliente_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cobrox_historicalcliente_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cobrox_historicalcliente_history_id_seq OWNER TO postgres;

--
-- TOC entry 3610 (class 0 OID 0)
-- Dependencies: 260
-- Name: cobrox_historicalcliente_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cobrox_historicalcliente_history_id_seq OWNED BY public.cobrox_historicalcliente.history_id;


--
-- TOC entry 257 (class 1259 OID 20973)
-- Name: cobrox_historicalcredito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cobrox_historicalcredito (
    id bigint NOT NULL,
    codigo character varying(10),
    montootorgado numeric(10,2) NOT NULL,
    fechaini date NOT NULL,
    fechaven date NOT NULL,
    interespct numeric(6,3) NOT NULL,
    qtydiascuota numeric(10,2) NOT NULL,
    capitalcuota numeric(10,2) NOT NULL,
    interescuota numeric(10,2) NOT NULL,
    totalcuota numeric(10,2) NOT NULL,
    interestotal numeric(10,2) NOT NULL,
    montoyinterestotal numeric(10,2) NOT NULL,
    cuotaspagadas numeric(10,2) NOT NULL,
    cuotaspendientes numeric(10,2) NOT NULL,
    saldopendiente numeric(10,2) NOT NULL,
    tipocredito integer NOT NULL,
    estadocredito integer NOT NULL,
    estadoregistro integer NOT NULL,
    nm_estado integer NOT NULL,
    date_creation timestamp with time zone NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    cliente_id bigint,
    history_user_id integer,
    user_creation_id integer,
    user_last_update_id integer,
    CONSTRAINT cobrox_historicalcredito_estadocredito_check CHECK ((estadocredito >= 0)),
    CONSTRAINT cobrox_historicalcredito_estadoregistro_check CHECK ((estadoregistro >= 0)),
    CONSTRAINT cobrox_historicalcredito_tipocredito_check CHECK ((tipocredito >= 0))
);


ALTER TABLE public.cobrox_historicalcredito OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 20962)
-- Name: cobrox_historicalcredito_archivo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cobrox_historicalcredito_archivo (
    id bigint NOT NULL,
    archivo text NOT NULL,
    nombre character varying(400) NOT NULL,
    fecha timestamp with time zone NOT NULL,
    date_creation timestamp with time zone NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    credito_id bigint,
    history_user_id integer,
    user_creation_id integer,
    user_last_update_id integer
);


ALTER TABLE public.cobrox_historicalcredito_archivo OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 20960)
-- Name: cobrox_historicalcredito_archivo_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cobrox_historicalcredito_archivo_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cobrox_historicalcredito_archivo_history_id_seq OWNER TO postgres;

--
-- TOC entry 3611 (class 0 OID 0)
-- Dependencies: 254
-- Name: cobrox_historicalcredito_archivo_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cobrox_historicalcredito_archivo_history_id_seq OWNED BY public.cobrox_historicalcredito_archivo.history_id;


--
-- TOC entry 256 (class 1259 OID 20971)
-- Name: cobrox_historicalcredito_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cobrox_historicalcredito_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cobrox_historicalcredito_history_id_seq OWNER TO postgres;

--
-- TOC entry 3612 (class 0 OID 0)
-- Dependencies: 256
-- Name: cobrox_historicalcredito_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cobrox_historicalcredito_history_id_seq OWNED BY public.cobrox_historicalcredito.history_id;


--
-- TOC entry 253 (class 1259 OID 20954)
-- Name: cobrox_historicalcreditofinanc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cobrox_historicalcreditofinanc (
    id bigint NOT NULL,
    date_creation timestamp with time zone NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    credito_financia_id bigint,
    credito_nvo_id bigint,
    history_user_id integer,
    user_creation_id integer,
    user_last_update_id integer
);


ALTER TABLE public.cobrox_historicalcreditofinanc OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 20952)
-- Name: cobrox_historicalcreditofinanc_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cobrox_historicalcreditofinanc_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cobrox_historicalcreditofinanc_history_id_seq OWNER TO postgres;

--
-- TOC entry 3613 (class 0 OID 0)
-- Dependencies: 252
-- Name: cobrox_historicalcreditofinanc_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cobrox_historicalcreditofinanc_history_id_seq OWNED BY public.cobrox_historicalcreditofinanc.history_id;


--
-- TOC entry 245 (class 1259 OID 20799)
-- Name: cobrox_historicalfilial; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cobrox_historicalfilial (
    id bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    date_creation timestamp with time zone NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    history_user_id integer,
    user_creation_id integer,
    user_last_update_id integer
);


ALTER TABLE public.cobrox_historicalfilial OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 20797)
-- Name: cobrox_historicalfilial_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cobrox_historicalfilial_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cobrox_historicalfilial_history_id_seq OWNER TO postgres;

--
-- TOC entry 3614 (class 0 OID 0)
-- Dependencies: 244
-- Name: cobrox_historicalfilial_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cobrox_historicalfilial_history_id_seq OWNED BY public.cobrox_historicalfilial.history_id;


--
-- TOC entry 251 (class 1259 OID 20944)
-- Name: cobrox_historicalpago; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cobrox_historicalpago (
    id bigint NOT NULL,
    monto numeric(10,2) NOT NULL,
    capital numeric(10,2) NOT NULL,
    interes numeric(10,2) NOT NULL,
    cuota numeric(10,2) NOT NULL,
    recibo character varying(10) NOT NULL,
    fecha date NOT NULL,
    tipoingreso integer NOT NULL,
    estadoregistro integer NOT NULL,
    date_creation timestamp with time zone NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    credito_id bigint,
    history_user_id integer,
    user_creation_id integer,
    user_last_update_id integer,
    CONSTRAINT cobrox_historicalpago_estadoregistro_check CHECK ((estadoregistro >= 0)),
    CONSTRAINT cobrox_historicalpago_tipoingreso_check CHECK ((tipoingreso >= 0))
);


ALTER TABLE public.cobrox_historicalpago OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 20942)
-- Name: cobrox_historicalpago_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cobrox_historicalpago_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cobrox_historicalpago_history_id_seq OWNER TO postgres;

--
-- TOC entry 3615 (class 0 OID 0)
-- Dependencies: 250
-- Name: cobrox_historicalpago_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cobrox_historicalpago_history_id_seq OWNED BY public.cobrox_historicalpago.history_id;


--
-- TOC entry 249 (class 1259 OID 20936)
-- Name: cobrox_historicaltipo_cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cobrox_historicaltipo_cliente (
    id bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    date_creation timestamp with time zone NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    history_user_id integer,
    user_creation_id integer,
    user_last_update_id integer
);


ALTER TABLE public.cobrox_historicaltipo_cliente OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 20934)
-- Name: cobrox_historicaltipo_cliente_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cobrox_historicaltipo_cliente_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cobrox_historicaltipo_cliente_history_id_seq OWNER TO postgres;

--
-- TOC entry 3616 (class 0 OID 0)
-- Dependencies: 248
-- Name: cobrox_historicaltipo_cliente_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cobrox_historicaltipo_cliente_history_id_seq OWNED BY public.cobrox_historicaltipo_cliente.history_id;


--
-- TOC entry 247 (class 1259 OID 20839)
-- Name: cobrox_historicalzona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cobrox_historicalzona (
    id bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    date_creation timestamp with time zone NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    filial_id bigint,
    history_user_id integer,
    user_creation_id integer,
    user_last_update_id integer
);


ALTER TABLE public.cobrox_historicalzona OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 20837)
-- Name: cobrox_historicalzona_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cobrox_historicalzona_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cobrox_historicalzona_history_id_seq OWNER TO postgres;

--
-- TOC entry 3617 (class 0 OID 0)
-- Dependencies: 246
-- Name: cobrox_historicalzona_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cobrox_historicalzona_history_id_seq OWNED BY public.cobrox_historicalzona.history_id;


--
-- TOC entry 237 (class 1259 OID 20705)
-- Name: cobrox_pago; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cobrox_pago (
    id bigint NOT NULL,
    monto numeric(10,2) NOT NULL,
    capital numeric(10,2) NOT NULL,
    interes numeric(10,2) NOT NULL,
    cuota numeric(10,2) NOT NULL,
    recibo character varying(10) NOT NULL,
    fecha date NOT NULL,
    tipoingreso integer NOT NULL,
    credito_id bigint NOT NULL,
    estadoregistro integer NOT NULL,
    date_creation timestamp with time zone NOT NULL,
    user_creation_id integer,
    user_last_update_id integer,
    CONSTRAINT cobrox_pago_estadoregistro_check CHECK ((estadoregistro >= 0)),
    CONSTRAINT cobrox_pagos_tipoingreso_check CHECK ((tipoingreso >= 0))
);


ALTER TABLE public.cobrox_pago OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 20703)
-- Name: cobrox_pagos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cobrox_pagos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cobrox_pagos_id_seq OWNER TO postgres;

--
-- TOC entry 3618 (class 0 OID 0)
-- Dependencies: 236
-- Name: cobrox_pagos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cobrox_pagos_id_seq OWNED BY public.cobrox_pago.id;


--
-- TOC entry 231 (class 1259 OID 20649)
-- Name: cobrox_tipo_cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cobrox_tipo_cliente (
    id bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    date_creation timestamp with time zone NOT NULL,
    user_creation_id integer,
    user_last_update_id integer
);


ALTER TABLE public.cobrox_tipo_cliente OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 20647)
-- Name: cobrox_tipo_cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cobrox_tipo_cliente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cobrox_tipo_cliente_id_seq OWNER TO postgres;

--
-- TOC entry 3619 (class 0 OID 0)
-- Dependencies: 230
-- Name: cobrox_tipo_cliente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cobrox_tipo_cliente_id_seq OWNED BY public.cobrox_tipo_cliente.id;


--
-- TOC entry 223 (class 1259 OID 20586)
-- Name: cobrox_zona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cobrox_zona (
    id bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    filial_id bigint NOT NULL,
    date_creation timestamp with time zone NOT NULL,
    user_creation_id integer,
    user_last_update_id integer
);


ALTER TABLE public.cobrox_zona OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 20584)
-- Name: cobrox_zona_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cobrox_zona_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cobrox_zona_id_seq OWNER TO postgres;

--
-- TOC entry 3620 (class 0 OID 0)
-- Dependencies: 222
-- Name: cobrox_zona_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cobrox_zona_id_seq OWNED BY public.cobrox_zona.id;


--
-- TOC entry 218 (class 1259 OID 20535)
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 20533)
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- TOC entry 3621 (class 0 OID 0)
-- Dependencies: 217
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- TOC entry 204 (class 1259 OID 20421)
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 20419)
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- TOC entry 3622 (class 0 OID 0)
-- Dependencies: 203
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- TOC entry 202 (class 1259 OID 20410)
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 20408)
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- TOC entry 3623 (class 0 OID 0)
-- Dependencies: 201
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- TOC entry 219 (class 1259 OID 20566)
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 20600)
-- Name: user_login_cv; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_login_cv (
    id bigint NOT NULL,
    fecha timestamp with time zone NOT NULL,
    usuario_id integer
);


ALTER TABLE public.user_login_cv OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 20598)
-- Name: user_login_cv_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_login_cv_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_login_cv_id_seq OWNER TO postgres;

--
-- TOC entry 3624 (class 0 OID 0)
-- Dependencies: 224
-- Name: user_login_cv_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_login_cv_id_seq OWNED BY public.user_login_cv.id;


--
-- TOC entry 227 (class 1259 OID 20615)
-- Name: user_rol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_rol (
    id bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    codigo character varying(3) NOT NULL
);


ALTER TABLE public.user_rol OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 20613)
-- Name: user_rol_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_rol_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_rol_id_seq OWNER TO postgres;

--
-- TOC entry 3625 (class 0 OID 0)
-- Dependencies: 226
-- Name: user_rol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_rol_id_seq OWNED BY public.user_rol.id;


--
-- TOC entry 229 (class 1259 OID 20623)
-- Name: user_user_rol_filial; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_user_rol_filial (
    id bigint NOT NULL,
    filial_id bigint NOT NULL,
    rol_id bigint NOT NULL,
    usuario_id integer NOT NULL
);


ALTER TABLE public.user_user_rol_filial OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 20621)
-- Name: user_user_rol_filial_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_user_rol_filial_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_user_rol_filial_id_seq OWNER TO postgres;

--
-- TOC entry 3626 (class 0 OID 0)
-- Dependencies: 228
-- Name: user_user_rol_filial_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_user_rol_filial_id_seq OWNED BY public.user_user_rol_filial.id;


--
-- TOC entry 269 (class 1259 OID 21129)
-- Name: wsfacturae_historicalwsentorno; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wsfacturae_historicalwsentorno (
    id bigint NOT NULL,
    codigo character varying(10) NOT NULL,
    nombre character varying(200) NOT NULL,
    url character varying(1000) NOT NULL,
    date_creation timestamp with time zone NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    history_user_id integer,
    user_creation_id integer,
    user_last_update_id integer
);


ALTER TABLE public.wsfacturae_historicalwsentorno OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 21127)
-- Name: wsfacturae_historicalwsentorno_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wsfacturae_historicalwsentorno_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wsfacturae_historicalwsentorno_history_id_seq OWNER TO postgres;

--
-- TOC entry 3627 (class 0 OID 0)
-- Dependencies: 268
-- Name: wsfacturae_historicalwsentorno_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wsfacturae_historicalwsentorno_history_id_seq OWNED BY public.wsfacturae_historicalwsentorno.history_id;


--
-- TOC entry 267 (class 1259 OID 21118)
-- Name: wsfacturae_historicalwsurl; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wsfacturae_historicalwsurl (
    id bigint NOT NULL,
    codigo character varying(10) NOT NULL,
    url character varying(1000) NOT NULL,
    nombre character varying(100) NOT NULL,
    date_creation timestamp with time zone NOT NULL,
    history_id integer NOT NULL,
    history_date timestamp with time zone NOT NULL,
    history_change_reason character varying(100),
    history_type character varying(1) NOT NULL,
    history_user_id integer,
    user_creation_id integer,
    user_last_update_id integer,
    wsentorno_id bigint
);


ALTER TABLE public.wsfacturae_historicalwsurl OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 21116)
-- Name: wsfacturae_historicalwsurl_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wsfacturae_historicalwsurl_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wsfacturae_historicalwsurl_history_id_seq OWNER TO postgres;

--
-- TOC entry 3628 (class 0 OID 0)
-- Dependencies: 266
-- Name: wsfacturae_historicalwsurl_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wsfacturae_historicalwsurl_history_id_seq OWNED BY public.wsfacturae_historicalwsurl.history_id;


--
-- TOC entry 273 (class 1259 OID 21206)
-- Name: wsfacturae_param_version_dte; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wsfacturae_param_version_dte (
    id bigint NOT NULL,
    codigo_documento integer NOT NULL,
    version integer NOT NULL,
    "tipoDte" character varying(2) NOT NULL,
    CONSTRAINT wsfacturae_param_version_dte_codigo_documento_check CHECK ((codigo_documento >= 0)),
    CONSTRAINT wsfacturae_param_version_dte_version_check CHECK ((version >= 0))
);


ALTER TABLE public.wsfacturae_param_version_dte OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 21204)
-- Name: wsfacturae_param_version_dte_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wsfacturae_param_version_dte_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wsfacturae_param_version_dte_id_seq OWNER TO postgres;

--
-- TOC entry 3629 (class 0 OID 0)
-- Dependencies: 272
-- Name: wsfacturae_param_version_dte_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wsfacturae_param_version_dte_id_seq OWNED BY public.wsfacturae_param_version_dte.id;


--
-- TOC entry 271 (class 1259 OID 21195)
-- Name: wsfacturae_ws_autenticacion_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wsfacturae_ws_autenticacion_log (
    id bigint NOT NULL,
    user_enviado text NOT NULL,
    jenviado jsonb,
    jrespuesta jsonb,
    token text,
    tiporespuesta integer NOT NULL,
    mensajeerror text,
    date_creation timestamp with time zone NOT NULL
);


ALTER TABLE public.wsfacturae_ws_autenticacion_log OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 21193)
-- Name: wsfacturae_ws_autenticacion_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wsfacturae_ws_autenticacion_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wsfacturae_ws_autenticacion_log_id_seq OWNER TO postgres;

--
-- TOC entry 3630 (class 0 OID 0)
-- Dependencies: 270
-- Name: wsfacturae_ws_autenticacion_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wsfacturae_ws_autenticacion_log_id_seq OWNED BY public.wsfacturae_ws_autenticacion_log.id;


--
-- TOC entry 263 (class 1259 OID 21092)
-- Name: wsfacturae_wsentorno; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wsfacturae_wsentorno (
    id bigint NOT NULL,
    codigo character varying(10) NOT NULL,
    nombre character varying(200) NOT NULL,
    url character varying(1000) NOT NULL,
    date_creation timestamp with time zone NOT NULL,
    user_creation_id integer,
    user_last_update_id integer
);


ALTER TABLE public.wsfacturae_wsentorno OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 21090)
-- Name: wsfacturae_wsentorno_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wsfacturae_wsentorno_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wsfacturae_wsentorno_id_seq OWNER TO postgres;

--
-- TOC entry 3631 (class 0 OID 0)
-- Dependencies: 262
-- Name: wsfacturae_wsentorno_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wsfacturae_wsentorno_id_seq OWNED BY public.wsfacturae_wsentorno.id;


--
-- TOC entry 265 (class 1259 OID 21105)
-- Name: wsfacturae_wsurl; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wsfacturae_wsurl (
    id bigint NOT NULL,
    codigo character varying(10) NOT NULL,
    url character varying(1000) NOT NULL,
    nombre character varying(100) NOT NULL,
    date_creation timestamp with time zone NOT NULL,
    user_creation_id integer,
    user_last_update_id integer,
    wsentorno_id bigint NOT NULL
);


ALTER TABLE public.wsfacturae_wsurl OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 21103)
-- Name: wsfacturae_wsurl_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wsfacturae_wsurl_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wsfacturae_wsurl_id_seq OWNER TO postgres;

--
-- TOC entry 3632 (class 0 OID 0)
-- Dependencies: 264
-- Name: wsfacturae_wsurl_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wsfacturae_wsurl_id_seq OWNED BY public.wsfacturae_wsurl.id;


--
-- TOC entry 3085 (class 2604 OID 20442)
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- TOC entry 3086 (class 2604 OID 20452)
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- TOC entry 3084 (class 2604 OID 20434)
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- TOC entry 3087 (class 2604 OID 20460)
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- TOC entry 3088 (class 2604 OID 20470)
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- TOC entry 3089 (class 2604 OID 20478)
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- TOC entry 3098 (class 2604 OID 20660)
-- Name: cobrox_cliente id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_cliente ALTER COLUMN id SET DEFAULT nextval('public.cobrox_cliente_id_seq'::regclass);


--
-- TOC entry 3107 (class 2604 OID 20748)
-- Name: cobrox_cliente_archivo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_cliente_archivo ALTER COLUMN id SET DEFAULT nextval('public.cobrox_credito_archivos_id_seq'::regclass);


--
-- TOC entry 3099 (class 2604 OID 20690)
-- Name: cobrox_credito id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_credito ALTER COLUMN id SET DEFAULT nextval('public.cobrox_credito_id_seq'::regclass);


--
-- TOC entry 3108 (class 2604 OID 20759)
-- Name: cobrox_credito_archivo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_credito_archivo ALTER COLUMN id SET DEFAULT nextval('public.cobrox_cliente_archivos_id_seq'::regclass);


--
-- TOC entry 3106 (class 2604 OID 20728)
-- Name: cobrox_creditofinanc id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_creditofinanc ALTER COLUMN id SET DEFAULT nextval('public.cobrox_creditofinanc_id_seq'::regclass);


--
-- TOC entry 3092 (class 2604 OID 20581)
-- Name: cobrox_filial id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_filial ALTER COLUMN id SET DEFAULT nextval('public.cobrox_filial_id_seq'::regclass);


--
-- TOC entry 3122 (class 2604 OID 20998)
-- Name: cobrox_historicalcliente history_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalcliente ALTER COLUMN history_id SET DEFAULT nextval('public.cobrox_historicalcliente_history_id_seq'::regclass);


--
-- TOC entry 3121 (class 2604 OID 20987)
-- Name: cobrox_historicalcliente_archivo history_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalcliente_archivo ALTER COLUMN history_id SET DEFAULT nextval('public.cobrox_historicalcliente_archivo_history_id_seq'::regclass);


--
-- TOC entry 3117 (class 2604 OID 20976)
-- Name: cobrox_historicalcredito history_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalcredito ALTER COLUMN history_id SET DEFAULT nextval('public.cobrox_historicalcredito_history_id_seq'::regclass);


--
-- TOC entry 3116 (class 2604 OID 20965)
-- Name: cobrox_historicalcredito_archivo history_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalcredito_archivo ALTER COLUMN history_id SET DEFAULT nextval('public.cobrox_historicalcredito_archivo_history_id_seq'::regclass);


--
-- TOC entry 3115 (class 2604 OID 20957)
-- Name: cobrox_historicalcreditofinanc history_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalcreditofinanc ALTER COLUMN history_id SET DEFAULT nextval('public.cobrox_historicalcreditofinanc_history_id_seq'::regclass);


--
-- TOC entry 3109 (class 2604 OID 20802)
-- Name: cobrox_historicalfilial history_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalfilial ALTER COLUMN history_id SET DEFAULT nextval('public.cobrox_historicalfilial_history_id_seq'::regclass);


--
-- TOC entry 3112 (class 2604 OID 20947)
-- Name: cobrox_historicalpago history_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalpago ALTER COLUMN history_id SET DEFAULT nextval('public.cobrox_historicalpago_history_id_seq'::regclass);


--
-- TOC entry 3111 (class 2604 OID 20939)
-- Name: cobrox_historicaltipo_cliente history_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicaltipo_cliente ALTER COLUMN history_id SET DEFAULT nextval('public.cobrox_historicaltipo_cliente_history_id_seq'::regclass);


--
-- TOC entry 3110 (class 2604 OID 20842)
-- Name: cobrox_historicalzona history_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalzona ALTER COLUMN history_id SET DEFAULT nextval('public.cobrox_historicalzona_history_id_seq'::regclass);


--
-- TOC entry 3103 (class 2604 OID 20708)
-- Name: cobrox_pago id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_pago ALTER COLUMN id SET DEFAULT nextval('public.cobrox_pagos_id_seq'::regclass);


--
-- TOC entry 3097 (class 2604 OID 20652)
-- Name: cobrox_tipo_cliente id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_tipo_cliente ALTER COLUMN id SET DEFAULT nextval('public.cobrox_tipo_cliente_id_seq'::regclass);


--
-- TOC entry 3093 (class 2604 OID 20589)
-- Name: cobrox_zona id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_zona ALTER COLUMN id SET DEFAULT nextval('public.cobrox_zona_id_seq'::regclass);


--
-- TOC entry 3090 (class 2604 OID 20538)
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- TOC entry 3083 (class 2604 OID 20424)
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- TOC entry 3082 (class 2604 OID 20413)
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- TOC entry 3094 (class 2604 OID 20603)
-- Name: user_login_cv id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_login_cv ALTER COLUMN id SET DEFAULT nextval('public.user_login_cv_id_seq'::regclass);


--
-- TOC entry 3095 (class 2604 OID 20618)
-- Name: user_rol id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_rol ALTER COLUMN id SET DEFAULT nextval('public.user_rol_id_seq'::regclass);


--
-- TOC entry 3096 (class 2604 OID 20626)
-- Name: user_user_rol_filial id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_user_rol_filial ALTER COLUMN id SET DEFAULT nextval('public.user_user_rol_filial_id_seq'::regclass);


--
-- TOC entry 3126 (class 2604 OID 21132)
-- Name: wsfacturae_historicalwsentorno history_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wsfacturae_historicalwsentorno ALTER COLUMN history_id SET DEFAULT nextval('public.wsfacturae_historicalwsentorno_history_id_seq'::regclass);


--
-- TOC entry 3125 (class 2604 OID 21121)
-- Name: wsfacturae_historicalwsurl history_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wsfacturae_historicalwsurl ALTER COLUMN history_id SET DEFAULT nextval('public.wsfacturae_historicalwsurl_history_id_seq'::regclass);


--
-- TOC entry 3128 (class 2604 OID 21209)
-- Name: wsfacturae_param_version_dte id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wsfacturae_param_version_dte ALTER COLUMN id SET DEFAULT nextval('public.wsfacturae_param_version_dte_id_seq'::regclass);


--
-- TOC entry 3127 (class 2604 OID 21198)
-- Name: wsfacturae_ws_autenticacion_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wsfacturae_ws_autenticacion_log ALTER COLUMN id SET DEFAULT nextval('public.wsfacturae_ws_autenticacion_log_id_seq'::regclass);


--
-- TOC entry 3123 (class 2604 OID 21095)
-- Name: wsfacturae_wsentorno id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wsfacturae_wsentorno ALTER COLUMN id SET DEFAULT nextval('public.wsfacturae_wsentorno_id_seq'::regclass);


--
-- TOC entry 3124 (class 2604 OID 21108)
-- Name: wsfacturae_wsurl id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wsfacturae_wsurl ALTER COLUMN id SET DEFAULT nextval('public.wsfacturae_wsurl_id_seq'::regclass);


--
-- TOC entry 3525 (class 0 OID 20439)
-- Dependencies: 208
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- TOC entry 3527 (class 0 OID 20449)
-- Dependencies: 210
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- TOC entry 3523 (class 0 OID 20431)
-- Dependencies: 206
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add zona	7	add_zona
26	Can change zona	7	change_zona
27	Can delete zona	7	delete_zona
28	Can view zona	7	view_zona
29	Can add filial	8	add_filial
30	Can change filial	8	change_filial
31	Can delete filial	8	delete_filial
32	Can view filial	8	view_filial
33	Can add login_cv	9	add_login_cv
34	Can change login_cv	9	change_login_cv
35	Can delete login_cv	9	delete_login_cv
36	Can view login_cv	9	view_login_cv
37	Can add rol	10	add_rol
38	Can change rol	10	change_rol
39	Can delete rol	10	delete_rol
40	Can view rol	10	view_rol
41	Can add user_rol_filial	11	add_user_rol_filial
42	Can change user_rol_filial	11	change_user_rol_filial
43	Can delete user_rol_filial	11	delete_user_rol_filial
44	Can view user_rol_filial	11	view_user_rol_filial
45	Can add cliente	12	add_cliente
46	Can change cliente	12	change_cliente
47	Can delete cliente	12	delete_cliente
48	Can view cliente	12	view_cliente
49	Can add tipo_cliente	13	add_tipo_cliente
50	Can change tipo_cliente	13	change_tipo_cliente
51	Can delete tipo_cliente	13	delete_tipo_cliente
52	Can view tipo_cliente	13	view_tipo_cliente
53	Can add credito	14	add_credito
54	Can change credito	14	change_credito
55	Can delete credito	14	delete_credito
56	Can view credito	14	view_credito
57	Can add pagos	15	add_pagos
58	Can change pagos	15	change_pagos
59	Can delete pagos	15	delete_pagos
60	Can view pagos	15	view_pagos
61	Can add pago	15	add_pago
62	Can change pago	15	change_pago
63	Can delete pago	15	delete_pago
64	Can view pago	15	view_pago
65	Can add creditofinanc	16	add_creditofinanc
66	Can change creditofinanc	16	change_creditofinanc
67	Can delete creditofinanc	16	delete_creditofinanc
68	Can view creditofinanc	16	view_creditofinanc
69	Can add credito_archivos	17	add_credito_archivos
70	Can change credito_archivos	17	change_credito_archivos
71	Can delete credito_archivos	17	delete_credito_archivos
72	Can view credito_archivos	17	view_credito_archivos
73	Can add cliente_archivos	18	add_cliente_archivos
74	Can change cliente_archivos	18	change_cliente_archivos
75	Can delete cliente_archivos	18	delete_cliente_archivos
76	Can view cliente_archivos	18	view_cliente_archivos
77	Can add cliente_archivo	17	add_cliente_archivo
78	Can change cliente_archivo	17	change_cliente_archivo
79	Can delete cliente_archivo	17	delete_cliente_archivo
80	Can view cliente_archivo	17	view_cliente_archivo
81	Can add credito_archivo	18	add_credito_archivo
82	Can change credito_archivo	18	change_credito_archivo
83	Can delete credito_archivo	18	delete_credito_archivo
84	Can view credito_archivo	18	view_credito_archivo
85	Can add historical filial	19	add_historicalfilial
86	Can change historical filial	19	change_historicalfilial
87	Can delete historical filial	19	delete_historicalfilial
88	Can view historical filial	19	view_historicalfilial
89	Can add historical zona	20	add_historicalzona
90	Can change historical zona	20	change_historicalzona
91	Can delete historical zona	20	delete_historicalzona
92	Can view historical zona	20	view_historicalzona
93	Can add historical tipo_cliente	21	add_historicaltipo_cliente
94	Can change historical tipo_cliente	21	change_historicaltipo_cliente
95	Can delete historical tipo_cliente	21	delete_historicaltipo_cliente
96	Can view historical tipo_cliente	21	view_historicaltipo_cliente
97	Can add historical pago	22	add_historicalpago
98	Can change historical pago	22	change_historicalpago
99	Can delete historical pago	22	delete_historicalpago
100	Can view historical pago	22	view_historicalpago
101	Can add historical creditofinanc	23	add_historicalcreditofinanc
102	Can change historical creditofinanc	23	change_historicalcreditofinanc
103	Can delete historical creditofinanc	23	delete_historicalcreditofinanc
104	Can view historical creditofinanc	23	view_historicalcreditofinanc
105	Can add historical credito_archivo	24	add_historicalcredito_archivo
106	Can change historical credito_archivo	24	change_historicalcredito_archivo
107	Can delete historical credito_archivo	24	delete_historicalcredito_archivo
108	Can view historical credito_archivo	24	view_historicalcredito_archivo
109	Can add historical credito	25	add_historicalcredito
110	Can change historical credito	25	change_historicalcredito
111	Can delete historical credito	25	delete_historicalcredito
112	Can view historical credito	25	view_historicalcredito
113	Can add historical cliente_archivo	26	add_historicalcliente_archivo
114	Can change historical cliente_archivo	26	change_historicalcliente_archivo
115	Can delete historical cliente_archivo	26	delete_historicalcliente_archivo
116	Can view historical cliente_archivo	26	view_historicalcliente_archivo
117	Can add historical cliente	27	add_historicalcliente
118	Can change historical cliente	27	change_historicalcliente
119	Can delete historical cliente	27	delete_historicalcliente
120	Can view historical cliente	27	view_historicalcliente
121	Can add historical wsurl	28	add_historicalwsurl
122	Can change historical wsurl	28	change_historicalwsurl
123	Can delete historical wsurl	28	delete_historicalwsurl
124	Can view historical wsurl	28	view_historicalwsurl
125	Can add wsurl	29	add_wsurl
126	Can change wsurl	29	change_wsurl
127	Can delete wsurl	29	delete_wsurl
128	Can view wsurl	29	view_wsurl
129	Can add historical wsentorno	30	add_historicalwsentorno
130	Can change historical wsentorno	30	change_historicalwsentorno
131	Can delete historical wsentorno	30	delete_historicalwsentorno
132	Can view historical wsentorno	30	view_historicalwsentorno
133	Can add wsentorno	31	add_wsentorno
134	Can change wsentorno	31	change_wsentorno
135	Can delete wsentorno	31	delete_wsentorno
136	Can view wsentorno	31	view_wsentorno
137	Can add ws_autenticacion_log	32	add_ws_autenticacion_log
138	Can change ws_autenticacion_log	32	change_ws_autenticacion_log
139	Can delete ws_autenticacion_log	32	delete_ws_autenticacion_log
140	Can view ws_autenticacion_log	32	view_ws_autenticacion_log
141	Can add param_version_dte	33	add_param_version_dte
142	Can change param_version_dte	33	change_param_version_dte
143	Can delete param_version_dte	33	delete_param_version_dte
144	Can view param_version_dte	33	view_param_version_dte
\.


--
-- TOC entry 3529 (class 0 OID 20457)
-- Dependencies: 212
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
3	pbkdf2_sha256$260000$2I8jYFJRwK23yt0HYWVPj6$PJlHYOFdR5nSSxT5Noa6Pvz2RMmezz1fwv0h2k/ECKw=	2023-03-16 11:38:01.855725-06	f	Raul	M			t	t	2023-02-24 16:24:16.37006-06
6	pbkdf2_sha256$260000$UuxmMjKoNHNeXkLTKm0PXz$DUU4I1/rjaI6JI26nyDGWpqj56A6JLAE3j8v8/5e1Jg=	2023-03-17 10:04:43.225512-06	t	raraniva2				t	t	2023-02-28 14:44:29.507599-06
11	pbkdf2_sha256$260000$zNGRCHeYzndVmeU7EKXNpZ$jSOoFuGZWX+56J4OOV1T9t5qwCrGDs8k+9iNFMO+7TU=	2023-03-01 10:45:55.393107-06	f	Administrador	Admin	istrato		f	t	2023-03-01 10:45:19.781744-06
12	pbkdf2_sha256$260000$5etqQcWTAGqumtofq7zL1B$ZthxTsID4WsNfr28LFjDYQU3AB7nDjG+n+I+vlM520g=	\N	f	weqw	wwe			f	f	2023-03-03 15:42:50.379042-06
\.


--
-- TOC entry 3531 (class 0 OID 20467)
-- Dependencies: 214
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- TOC entry 3533 (class 0 OID 20475)
-- Dependencies: 216
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- TOC entry 3550 (class 0 OID 20657)
-- Dependencies: 233
-- Data for Name: cobrox_cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cobrox_cliente (id, codigo, nombre, dui, nit, direccion, telefono, observacion, tipo_cliente_id, zona_id, celular, date_creation, user_creation_id, user_last_update_id) FROM stdin;
2	\N	Roberto Araniva	12312323-2	1231-313232-323-2	dsadasl	9182-9829		2	1	\N	2023-03-16 11:49:27.541315-06	\N	\N
5	\N	qwe	13132312-3	1231-231232-312-3	eqwq	2323-2323		\N	1	\N	2023-03-16 11:49:27.541315-06	\N	\N
4	\N	usuario santa ana	12313123-1	1231-232323-232-3	asdasd	1231-2322		2	2	\N	2023-03-16 11:49:27.541315-06	\N	\N
3	\N	omaosda	12312323-2	3123-131232-312-1	sdsdasdasdsa	1313-2323	hrht	2	1	\N	2023-03-16 11:49:27.541315-06	\N	\N
6	\N	12321	12313123-2	1231-231232-131-2	123	1231-2323		2	1	7919-1177	2023-03-16 11:49:27.541315-06	\N	\N
7	\N	Ernesto Barrera	12121232-1	1213-211212-122-1	VAmos	2243-1154	Ning	2	1	7914-5511	2023-03-16 11:49:27.541315-06	\N	\N
8	\N	Napoleón Bonaparte	32323232-3	1231-323132-232-3	CAlle la Cima #123\r\nEl Arco	2232-3222	Posee una moto	2	1	7878-7878	2023-03-16 11:49:27.541315-06	\N	\N
9	\N	Xiomara Chavez	23424224-2	1231-323233-232-3	Paseo Escalon\r\nNo 12	2332-3232	Posee moto	2	1	7878-7878	2023-03-16 11:49:27.541315-06	\N	\N
10	\N	Maria Montero	12312321-3	1233-131231-231-3	adsds\r\nasda	1232-3232	qwqw	2	2	1231-3123	2023-03-16 11:49:27.541315-06	\N	\N
11	\N	Lucrecia Santamaria	13212321-3	1321-313213-131-2	adsada	1231-2312		\N	3	1231-2312	2023-03-16 11:49:27.541315-06	\N	\N
12	\N	1313213	12313123-1	1231-321313-132-1	1231	3123-1312		6	1	1231-3121	2023-03-16 11:49:27.541315-06	\N	\N
13	\N	nuevo de Raul	12313123-1	1232-131312-132-3	asdas	1231-2321	asd	6	3	1231-3213	2023-03-16 12:00:50.74269-06	3	3
\.


--
-- TOC entry 3558 (class 0 OID 20745)
-- Dependencies: 241
-- Data for Name: cobrox_cliente_archivo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cobrox_cliente_archivo (id, archivo, nombre, fecha, cliente_id, date_creation, user_creation_id, user_last_update_id) FROM stdin;
9	mysite/static/images/arc_clientes/9/8f7250_3OFGwHo.png	Capture1.PNG	2023-03-12 18:34:35.265515-06	9	2023-03-16 11:49:27.578313-06	\N	\N
10	mysite/static/images/arc_clientes/9/d6bb6a_xMQFayI.png	Licencia Conducir Roberto Araniva.PNG	2023-03-12 18:35:20.639379-06	9	2023-03-16 11:49:27.578313-06	\N	\N
11	mysite/static/images/arc_clientes/7/8efaa2_ToQWwt2.png	Licencia Conducir Roberto Araniva.PNG	2023-03-12 18:39:47.15632-06	7	2023-03-16 11:49:27.578313-06	\N	\N
12	mysite/static/images/arc_clientes/7/da9537_jbYG73O.png	Capture1.PNG	2023-03-12 18:40:07.692674-06	7	2023-03-16 11:49:27.578313-06	\N	\N
13	mysite/static/images/arc_clientes/10/697c1_fu3j6O7.png	Capturessssds.PNG	2023-03-12 18:42:49.935344-06	10	2023-03-16 11:49:27.578313-06	\N	\N
14	mysite/static/images/arc_clientes/10/20510_aZuDt9y.png	Capture2.PNG	2023-03-12 18:46:59.714982-06	10	2023-03-16 11:49:27.578313-06	\N	\N
15	mysite/static/images/arc_clientes/10/c309a_DbA1LJT.png	Capture1.PNG	2023-03-12 18:47:43.704679-06	10	2023-03-16 11:49:27.578313-06	\N	\N
17	mysite/static/images/arc_clientes/11/c7557_gZqvryu.png	Captureff.PNG	2023-03-12 18:48:41.134553-06	11	2023-03-16 11:49:27.578313-06	\N	\N
19	mysite/static/images/arc_clientes/12/eea85_JgCGDZV.png	Licencia Conducir Roberto Araniva.PNG	2023-03-12 18:54:32.272831-06	12	2023-03-16 11:49:27.578313-06	\N	\N
22	mysite/static/images/arc_clientes/6/937761_DVq1B7u.png	Licencia Conducir Roberto Araniva.PNG	2023-03-12 19:49:42.516897-06	6	2023-03-16 11:49:27.578313-06	\N	\N
23	mysite/static/images/arc_clientes/13/4b689_9UdZRCI.png	Capture1.PNG	2023-03-16 12:01:00.844499-06	13	2023-03-16 12:01:00.839694-06	3	3
\.


--
-- TOC entry 3552 (class 0 OID 20687)
-- Dependencies: 235
-- Data for Name: cobrox_credito; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cobrox_credito (id, codigo, montootorgado, fechaini, fechaven, interespct, qtydiascuota, capitalcuota, interescuota, totalcuota, cuotaspagadas, cuotaspendientes, saldopendiente, tipocredito, estadocredito, cliente_id, interestotal, montoyinterestotal, estadoregistro, nm_estado, date_creation, user_creation_id, user_last_update_id) FROM stdin;
63	\N	5000.00	2023-03-01	2023-03-24	12.000	23.00	217.39	26.09	243.48	2.32	20.68	5035.07	0	0	13	600.07	5600.07	1	1	2023-03-16 12:01:38.998575-06	3	6
1	\N	2000.00	2023-03-01	2023-03-27	20.000	26.00	76.92	15.38	92.30	0.00	0.00	2399.88	0	0	2	399.88	2399.88	1	-1	2023-03-16 11:49:27.610093-06	\N	\N
47	\N	2320.10	2023-03-01	2023-03-09	20.000	8.00	290.01	58.00	348.01	0.00	8.00	2784.10	1	0	2	464.00	2784.10	1	1	2023-03-16 11:49:27.610093-06	\N	\N
48	\N	12.00	2023-03-01	2023-03-09	12.000	8.00	1.50	0.18	1.68	0.00	8.00	13.44	0	0	2	1.44	13.44	1	1	2023-03-16 11:49:27.610093-06	\N	\N
8	\N	2000.00	2023-03-01	2023-03-17	20.000	16.00	125.00	25.00	150.00	0.00	0.00	2400.00	0	0	2	400.00	2400.00	1	1	2023-03-16 11:49:27.610093-06	\N	\N
34	\N	2000.00	2023-03-01	2023-04-30	20.000	60.00	33.33	6.67	40.00	5.00	55.00	2200.20	0	0	6	400.20	2400.20	1	1	2023-03-16 11:49:27.610093-06	\N	\N
35	\N	3000.00	2023-03-01	2023-03-31	20.000	30.00	100.00	20.00	120.00	0.00	30.00	3600.00	0	0	6	600.00	3600.00	1	1	2023-03-16 11:49:27.610093-06	\N	\N
30	\N	2000.00	2023-02-01	2023-02-28	20.000	27.00	74.07	14.81	88.88	0.00	27.00	2399.87	0	0	7	399.87	2399.87	1	1	2023-03-16 11:49:27.610093-06	\N	\N
52	\N	19.00	2023-03-01	2023-03-10	12.000	9.00	2.11	0.25	2.36	50.85	-41.85	-98.75	1	2	4	2.25	21.25	0	1	2023-03-16 11:49:27.610093-06	\N	\N
49	\N	1200.00	2023-03-02	2023-03-24	12.000	22.00	54.55	6.55	61.10	0.00	22.00	1344.10	0	0	6	144.10	1344.10	1	1	2023-03-16 11:49:27.610093-06	\N	\N
24	\N	200.00	2023-03-01	2023-03-10	20.000	9.00	22.22	4.44	26.66	0.00	9.00	239.96	0	0	2	39.96	239.96	1	1	2023-03-16 11:49:27.610093-06	\N	\N
27	\N	2000.00	2023-03-01	2023-03-31	20.000	30.00	66.67	13.33	80.00	0.00	30.00	2399.90	0	0	3	399.90	2399.90	1	1	2023-03-16 11:49:27.610093-06	\N	\N
6	\N	2000.00	2023-03-01	2023-03-23	16.000	22.00	90.91	14.55	105.46	22.00	-22.00	0.00	0	2	2	320.10	2320.10	1	1	2023-03-16 11:49:27.610093-06	\N	\N
23	\N	200.00	2023-03-01	2023-03-31	20.000	30.00	6.67	1.33	8.00	150.00	-120.00	-960.10	0	2	2	39.90	239.90	1	1	2023-03-16 11:49:27.610093-06	\N	\N
50	\N	12231.00	2023-03-07	2023-03-23	123.000	16.00	764.44	940.26	1704.70	0.00	16.00	27275.16	0	0	2	15044.16	27275.16	1	1	2023-03-16 11:49:27.610093-06	\N	\N
54	\N	2965.00	2023-04-01	2023-04-30	20.000	29.00	102.24	20.45	122.69	29.00	0.00	0.00	1	2	8	593.05	3558.05	1	1	2023-03-16 11:49:27.610093-06	\N	\N
56	\N	3558.05	2023-05-01	2023-05-30	15.000	29.00	122.69	18.40	141.09	2.13	26.87	3791.65	1	0	8	533.60	4091.65	1	1	2023-03-16 11:49:27.610093-06	\N	\N
36	\N	2000.00	2023-03-01	2023-03-31	20.000	30.00	66.67	13.33	80.00	0.00	30.00	2399.90	0	0	6	399.90	2399.90	1	1	2023-03-16 11:49:27.610093-06	\N	\N
2	\N	2000.00	2023-03-21	2023-03-11	20.000	-10.00	-200.00	-40.00	-240.00	0.00	0.00	0.00	0	2	2	400.00	2400.00	1	1	2023-03-16 11:49:27.610093-06	\N	\N
7	\N	2000.00	2023-03-13	2023-03-14	20.000	1.00	2000.00	400.00	2400.00	1.00	-1.00	0.00	0	2	2	400.00	2400.00	1	1	2023-03-16 11:49:27.610093-06	\N	\N
57	\N	12.00	2023-03-01	2023-03-15	12.000	14.00	0.86	0.10	0.96	0.00	14.00	13.40	0	0	6	1.40	13.40	1	1	2023-03-16 11:49:27.610093-06	\N	\N
31	\N	200.00	2023-03-01	2023-03-15	20.000	14.00	14.29	2.86	17.15	1.11	12.89	221.04	0	0	4	40.04	240.04	0	1	2023-03-16 11:49:27.610093-06	\N	\N
37	\N	2000.00	2023-03-01	2023-03-22	12.000	21.00	95.24	11.43	106.67	0.00	21.00	2240.03	0	0	6	240.03	2240.03	1	1	2023-03-16 11:49:27.610093-06	\N	\N
38	\N	5000.00	2023-03-01	2023-03-30	20.000	29.00	172.41	34.48	206.89	0.00	29.00	5999.92	0	0	7	999.92	5999.92	1	1	2023-03-16 11:49:27.610093-06	\N	\N
51	\N	2280.00	2023-03-01	2023-03-23	12.000	22.00	103.64	12.44	116.08	0.00	22.00	2553.68	1	0	2	273.68	2553.68	1	1	2023-03-16 11:49:27.610093-06	\N	\N
53	\N	3000.00	2023-03-01	2023-03-31	12.000	30.00	100.00	12.00	112.00	30.00	0.00	0.00	0	2	8	360.00	3360.00	1	1	2023-03-16 11:49:27.610093-06	\N	\N
60	\N	4649.80	2023-03-01	2023-03-30	20.000	29.00	160.34	32.07	192.41	0.00	29.00	5579.83	1	0	9	930.03	5579.83	1	1	2023-03-16 11:49:27.610093-06	\N	\N
25	\N	200.00	2023-03-01	2023-03-23	20.000	22.00	9.09	1.82	10.91	27.50	-5.50	-59.96	0	2	2	40.04	240.04	1	1	2023-03-16 11:49:27.610093-06	\N	\N
28	\N	2000.00	2023-03-01	2023-03-24	15.000	23.00	86.96	13.04	100.00	21.50	1.50	149.92	0	0	7	299.92	2299.92	1	1	2023-03-16 11:49:27.610093-06	\N	\N
39	\N	2400.00	2023-03-01	2023-03-30	12.000	29.00	82.76	9.93	92.69	29.00	0.00	0.00	1	2	2	287.97	2687.97	1	1	2023-03-16 11:49:27.610093-06	\N	\N
61	\N	121.00	2023-03-01	2023-03-23	12.000	22.00	5.50	0.66	6.16	0.00	22.00	135.52	0	0	12	14.52	135.52	1	1	2023-03-16 11:49:27.610093-06	\N	\N
59	\N	500.00	2023-03-01	2023-03-30	20.000	29.00	17.24	3.45	20.69	0.00	29.00	600.05	0	0	9	100.05	600.05	1	1	2023-03-16 11:49:27.610093-06	\N	\N
55	\N	2487.97	2023-04-01	2023-04-30	30.000	29.00	85.79	25.74	111.53	0.00	29.00	3234.43	1	0	2	746.46	3234.43	1	1	2023-03-16 11:49:27.610093-06	\N	\N
58	\N	4000.00	2023-03-01	2023-04-30	20.000	60.00	66.67	13.33	80.00	60.00	0.00	0.00	0	2	9	799.80	4799.80	1	1	2023-03-16 11:49:27.610093-06	\N	\N
62	\N	12313.00	2023-03-01	2023-03-10	12.000	9.00	1368.11	164.17	1532.28	0.00	9.00	13790.53	0	0	6	1477.53	13790.53	1	1	2023-03-16 11:49:27.610093-06	\N	\N
\.


--
-- TOC entry 3560 (class 0 OID 20756)
-- Dependencies: 243
-- Data for Name: cobrox_credito_archivo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cobrox_credito_archivo (id, archivo, nombre, fecha, credito_id, date_creation, user_creation_id, user_last_update_id) FROM stdin;
2	mysite/static/images/arc_clientes/12/credito/61/e476484d-f1b7-4987-bbd3-6208879eaf12.png	Capturess.PNG	2023-03-12 19:24:10.243927-06	61	2023-03-16 11:49:27.668246-06	\N	\N
3	mysite/static/images/arc_clientes/12/credito/61/065f3bf0-747a-4d60-8874-1dbccfce96bb.png	Capture2.PNG	2023-03-12 19:27:16.65016-06	61	2023-03-16 11:49:27.668246-06	\N	\N
4	mysite/static/images/arc_clientes/6/credito/62/62a64f2d-f714-406a-8794-63acbe4636d9.png	Capture1.PNG	2023-03-12 19:48:13.579061-06	62	2023-03-16 11:49:27.668246-06	\N	\N
\.


--
-- TOC entry 3556 (class 0 OID 20725)
-- Dependencies: 239
-- Data for Name: cobrox_creditofinanc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cobrox_creditofinanc (id, credito_financia_id, credito_nvo_id, date_creation, user_creation_id, user_last_update_id) FROM stdin;
1	2	39	2023-03-16 11:49:27.695537-06	\N	\N
9	6	47	2023-03-16 11:49:27.695537-06	\N	\N
10	7	51	2023-03-16 11:49:27.695537-06	\N	\N
11	31	52	2023-03-16 11:49:27.695537-06	\N	\N
12	53	54	2023-03-16 11:49:27.695537-06	\N	\N
13	39	55	2023-03-16 11:49:27.695537-06	\N	\N
14	54	56	2023-03-16 11:49:27.695537-06	\N	\N
15	58	60	2023-03-16 11:49:27.695537-06	\N	\N
\.


--
-- TOC entry 3538 (class 0 OID 20578)
-- Dependencies: 221
-- Data for Name: cobrox_filial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cobrox_filial (id, nombre, date_creation, user_creation_id, user_last_update_id) FROM stdin;
2	asdadsada	2023-03-16 10:48:09.427297-06	\N	\N
3	Filial 2	2023-03-16 10:48:09.427297-06	\N	\N
4	das	2023-03-16 10:48:09.427297-06	\N	\N
8	nueva filial	2023-03-16 11:43:11.438004-06	3	3
\.


--
-- TOC entry 3578 (class 0 OID 20995)
-- Dependencies: 261
-- Data for Name: cobrox_historicalcliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cobrox_historicalcliente (id, codigo, nombre, dui, nit, direccion, telefono, celular, observacion, date_creation, history_id, history_date, history_change_reason, history_type, history_user_id, tipo_cliente_id, user_creation_id, user_last_update_id, zona_id) FROM stdin;
13	\N	nuevo de	12313123-1	1232-131312-132-3	asdas	1231-2321	1231-3213	asd	2023-03-16 12:00:50.74269-06	1	2023-03-16 12:00:50.749539-06	\N	+	3	6	3	3	3
13	\N	nuevo de Raul	12313123-1	1232-131312-132-3	asdas	1231-2321	1231-3213	asd	2023-03-16 12:00:50.74269-06	2	2023-03-16 12:01:20.06705-06	\N	~	3	6	3	3	3
\.


--
-- TOC entry 3576 (class 0 OID 20984)
-- Dependencies: 259
-- Data for Name: cobrox_historicalcliente_archivo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cobrox_historicalcliente_archivo (id, archivo, nombre, fecha, date_creation, history_id, history_date, history_change_reason, history_type, cliente_id, history_user_id, user_creation_id, user_last_update_id) FROM stdin;
23	mysite/static/images/arc_clientes/13/4b689_9UdZRCI.png	Capture1.PNG	2023-03-16 12:01:00.844499-06	2023-03-16 12:01:00.839694-06	1	2023-03-16 12:01:00.850982-06	\N	+	13	3	3	3
23	mysite/static/images/arc_clientes/13/4b689_9UdZRCI.png	Capture1.PNG	2023-03-16 12:01:00.844499-06	2023-03-16 12:01:00.839694-06	2	2023-03-16 12:01:00.855607-06	\N	~	13	3	3	3
24	mysite/static/images/arc_clientes/6/73e921_D9Xt4s8.png	Capturessssds.PNG	2023-03-19 07:44:49.656406-06	2023-03-19 07:44:49.650205-06	3	2023-03-19 07:44:49.658715-06	\N	+	6	6	6	6
24	mysite/static/images/arc_clientes/6/73e921_D9Xt4s8.png	Capturessssds.PNG	2023-03-19 07:44:49.656406-06	2023-03-19 07:44:49.650205-06	4	2023-03-19 07:44:49.666725-06	\N	~	6	6	6	6
24		Capturessssds.PNG	2023-03-19 07:44:49.656406-06	2023-03-19 07:44:49.650205-06	5	2023-03-19 07:45:04.975104-06	\N	~	6	6	6	6
24		Capturessssds.PNG	2023-03-19 07:44:49.656406-06	2023-03-19 07:44:49.650205-06	6	2023-03-19 07:45:04.983435-06	\N	-	6	6	6	6
\.


--
-- TOC entry 3574 (class 0 OID 20973)
-- Dependencies: 257
-- Data for Name: cobrox_historicalcredito; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cobrox_historicalcredito (id, codigo, montootorgado, fechaini, fechaven, interespct, qtydiascuota, capitalcuota, interescuota, totalcuota, interestotal, montoyinterestotal, cuotaspagadas, cuotaspendientes, saldopendiente, tipocredito, estadocredito, estadoregistro, nm_estado, date_creation, history_id, history_date, history_change_reason, history_type, cliente_id, history_user_id, user_creation_id, user_last_update_id) FROM stdin;
63	\N	5000.00	2023-03-01	2023-03-24	12.000	23.00	217.39	26.09	243.48	600.07	5600.07	0.00	23.00	5600.07	0	0	0	1	2023-03-16 12:01:38.998575-06	1	2023-03-16 12:01:39.007477-06	\N	+	13	3	3	3
63	\N	5000.00	2023-03-01	2023-03-24	12.000	23.00	217.39	26.09	243.48	600.07	5600.07	0.00	23.00	5600.07	0	0	0	1	2023-03-16 12:01:38.998575-06	2	2023-03-16 12:01:39.01568-06	\N	~	13	3	3	3
63	\N	5000.00	2023-03-01	2023-03-24	12.000	23.00	217.39	26.09	243.48	600.07	5600.07	2.32	20.68	5035.07	0	0	0	1	2023-03-16 12:01:38.998575-06	3	2023-03-16 12:02:14.803324-06	\N	~	13	3	3	3
63	\N	5000.00	2023-03-01	2023-03-24	12.000	23.00	217.39	26.09	243.48	600.07	5600.07	2.32	20.68	5035.07	0	0	1	-1	2023-03-16 12:01:38.998575-06	5	2023-03-16 12:07:11.833981-06	\N	~	13	6	3	6
63	\N	5000.00	2023-03-01	2023-03-24	12.000	23.00	217.39	26.09	243.48	600.07	5600.07	2.32	20.68	5035.07	0	0	1	1	2023-03-16 12:01:38.998575-06	6	2023-03-16 12:07:40.188834-06	\N	~	13	6	3	6
\.


--
-- TOC entry 3572 (class 0 OID 20962)
-- Dependencies: 255
-- Data for Name: cobrox_historicalcredito_archivo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cobrox_historicalcredito_archivo (id, archivo, nombre, fecha, date_creation, history_id, history_date, history_change_reason, history_type, credito_id, history_user_id, user_creation_id, user_last_update_id) FROM stdin;
6	mysite/static/images/arc_clientes/13/credito/63/b21a88fd-373d-40b5-b596-e48f6d41cc2d.png	Untitled.png	2023-03-19 07:40:37.918758-06	2023-03-19 07:40:37.899165-06	1	2023-03-19 07:40:37.932373-06	\N	+	63	6	6	6
6	mysite/static/images/arc_clientes/13/credito/63/b21a88fd-373d-40b5-b596-e48f6d41cc2d.png	Untitled.png	2023-03-19 07:40:37.918758-06	2023-03-19 07:40:37.899165-06	2	2023-03-19 07:40:37.957057-06	\N	~	63	6	6	6
6		Untitled.png	2023-03-19 07:40:37.918758-06	2023-03-19 07:40:37.899165-06	3	2023-03-19 07:41:24.700643-06	\N	~	63	6	6	6
6		Untitled.png	2023-03-19 07:40:37.918758-06	2023-03-19 07:40:37.899165-06	4	2023-03-19 07:41:24.701263-06	\N	-	63	6	6	6
7	mysite/static/images/arc_clientes/13/credito/63/b86a178d-6f73-4db6-8d6d-09d6f710928c.png	Capturessssds.PNG	2023-03-19 07:44:14.384411-06	2023-03-19 07:44:14.35991-06	5	2023-03-19 07:44:14.384411-06	\N	+	63	6	6	6
7	mysite/static/images/arc_clientes/13/credito/63/b86a178d-6f73-4db6-8d6d-09d6f710928c.png	Capturessssds.PNG	2023-03-19 07:44:14.384411-06	2023-03-19 07:44:14.35991-06	6	2023-03-19 07:44:14.403296-06	\N	~	63	6	6	6
7		Capturessssds.PNG	2023-03-19 07:44:14.384411-06	2023-03-19 07:44:14.35991-06	7	2023-03-19 07:44:24.507403-06	\N	~	63	6	6	6
7		Capturessssds.PNG	2023-03-19 07:44:14.384411-06	2023-03-19 07:44:14.35991-06	8	2023-03-19 07:44:24.51364-06	\N	-	63	6	6	6
\.


--
-- TOC entry 3570 (class 0 OID 20954)
-- Dependencies: 253
-- Data for Name: cobrox_historicalcreditofinanc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cobrox_historicalcreditofinanc (id, date_creation, history_id, history_date, history_change_reason, history_type, credito_financia_id, credito_nvo_id, history_user_id, user_creation_id, user_last_update_id) FROM stdin;
\.


--
-- TOC entry 3562 (class 0 OID 20799)
-- Dependencies: 245
-- Data for Name: cobrox_historicalfilial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cobrox_historicalfilial (id, nombre, date_creation, history_id, history_date, history_change_reason, history_type, history_user_id, user_creation_id, user_last_update_id) FROM stdin;
5	REnacuajo	2023-03-16 10:48:42.404715-06	1	2023-03-16 10:48:42.408703-06	\N	+	6	\N	\N
6	Raymond	2023-03-16 11:08:53.105289-06	2	2023-03-16 11:08:53.107948-06	\N	+	6	6	6
6	Raymond2	2023-03-16 11:08:53.105289-06	3	2023-03-16 11:09:48.77089-06	\N	~	6	6	6
5	REnacuajo	2023-03-16 10:48:42.404715-06	4	2023-03-16 11:10:08.890658-06	\N	-	6	\N	6
6	Raymond2	2023-03-16 11:08:53.105289-06	5	2023-03-16 11:10:33.059617-06	\N	-	6	6	6
7	Probemos	2023-03-16 11:16:11.172176-06	6	2023-03-16 11:16:11.175157-06	\N	+	6	6	6
7	Probemos 23232	2023-03-16 11:16:11.172176-06	7	2023-03-16 11:40:11.227914-06	\N	~	3	6	3
7	Probemos 23232	2023-03-16 11:16:11.172176-06	8	2023-03-16 11:41:27.951957-06	\N	-	3	6	3
8	nueva filial	2023-03-16 11:43:11.438004-06	10	2023-03-16 11:43:11.440012-06	\N	+	3	3	3
\.


--
-- TOC entry 3568 (class 0 OID 20944)
-- Dependencies: 251
-- Data for Name: cobrox_historicalpago; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cobrox_historicalpago (id, monto, capital, interes, cuota, recibo, fecha, tipoingreso, estadoregistro, date_creation, history_id, history_date, history_change_reason, history_type, credito_id, history_user_id, user_creation_id, user_last_update_id) FROM stdin;
43	565.00	504.34	60.53	2.32	2343	2023-03-02	0	0	2023-03-16 12:02:14.799201-06	1	2023-03-16 12:02:14.809798-06	\N	+	63	3	3	3
43	565.00	504.34	60.53	2.32	2343	2023-03-02	0	0	2023-03-16 12:02:14.799201-06	2	2023-03-16 12:02:14.816748-06	\N	~	63	3	3	3
\.


--
-- TOC entry 3566 (class 0 OID 20936)
-- Dependencies: 249
-- Data for Name: cobrox_historicaltipo_cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cobrox_historicaltipo_cliente (id, nombre, date_creation, history_id, history_date, history_change_reason, history_type, history_user_id, user_creation_id, user_last_update_id) FROM stdin;
7	adasd	2023-03-16 11:53:54.293856-06	1	2023-03-16 11:53:54.297967-06	\N	+	3	3	3
7	adasdqwewq	2023-03-16 11:53:54.293856-06	2	2023-03-16 11:54:01.514255-06	\N	~	3	3	3
7	adasdqwewq	2023-03-16 11:53:54.293856-06	3	2023-03-16 11:54:03.966939-06	\N	-	3	3	3
\.


--
-- TOC entry 3564 (class 0 OID 20839)
-- Dependencies: 247
-- Data for Name: cobrox_historicalzona; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cobrox_historicalzona (id, nombre, date_creation, history_id, history_date, history_change_reason, history_type, filial_id, history_user_id, user_creation_id, user_last_update_id) FROM stdin;
\.


--
-- TOC entry 3554 (class 0 OID 20705)
-- Dependencies: 237
-- Data for Name: cobrox_pago; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cobrox_pago (id, monto, capital, interes, cuota, recibo, fecha, tipoingreso, credito_id, estadoregistro, date_creation, user_creation_id, user_last_update_id) FROM stdin;
18	200.00	33.35	166.65	5.00	qweqw	2023-03-14	0	34	1	2023-03-16 11:49:27.725941-06	\N	\N
8	2000.00	0.00	0.00	0.00	123131	2023-03-01	0	28	1	2023-03-16 11:49:27.725941-06	\N	\N
30	19.00	15.86	3.17	1.11	REFINAN	2023-03-01	1	31	0	2023-03-16 11:49:27.725941-06	\N	\N
25	2320.10	2000.02	320.10	22.00	REFINAN	2023-03-01	1	6	1	2023-03-16 11:49:27.725941-06	\N	\N
26	1200.00	1000.50	199.50	150.00	1231231	2023-03-01	0	23	1	2023-03-16 11:49:27.725941-06	\N	\N
27	100.00	89.38	10.72	1.08	12313	2023-03-01	0	39	1	2023-03-16 11:49:27.725941-06	\N	\N
28	120.00	100.00	20.00	0.05	223132	2023-03-16	0	7	1	2023-03-16 11:49:27.725941-06	\N	\N
29	2280.00	1900.00	380.00	0.95	REFINAN	2023-03-01	1	7	1	2023-03-16 11:49:27.725941-06	\N	\N
31	245.00	219.00	26.28	2.19	657	2023-03-02	0	53	1	2023-03-16 11:49:27.725941-06	\N	\N
32	150.00	134.00	16.08	1.34	67	2023-03-10	0	53	1	2023-03-16 11:49:27.725941-06	\N	\N
40	120.00	107.29	12.71	50.85	43	2023-03-02	0	52	0	2023-03-16 11:49:27.725941-06	\N	\N
33	2965.00	2647.00	317.64	26.47	REFINAN	2023-04-01	1	53	1	2023-03-16 11:49:27.725941-06	\N	\N
34	300.00	249.98	50.05	27.50	REE33	2023-03-01	0	25	1	2023-03-16 11:49:27.725941-06	\N	\N
35	150.00	130.44	19.56	1.50	REEE	2023-03-16	0	28	1	2023-03-16 11:49:27.725941-06	\N	\N
36	100.00	89.38	10.72	1.08	RECF	2023-03-10	0	39	1	2023-03-16 11:49:27.725941-06	\N	\N
37	2487.97	2221.28	266.52	26.84	REFINAN	2023-04-01	1	39	1	2023-03-16 11:49:27.725941-06	\N	\N
38	3558.05	2964.96	593.05	29.00	REFINAN	2023-05-01	1	54	1	2023-03-16 11:49:27.725941-06	\N	\N
39	300.00	261.33	39.19	2.13	rre	2023-05-12	0	56	1	2023-03-16 11:49:27.725941-06	\N	\N
41	150.00	125.34	25.06	1.88	3242	2023-03-02	0	58	1	2023-03-16 11:49:27.725941-06	\N	\N
42	4649.80	3874.86	774.74	58.12	REFINAN	2023-03-01	1	58	1	2023-03-16 11:49:27.725941-06	\N	\N
43	565.00	504.34	60.53	2.32	2343	2023-03-02	0	63	1	2023-03-16 12:02:14.799201-06	3	3
\.


--
-- TOC entry 3548 (class 0 OID 20649)
-- Dependencies: 231
-- Data for Name: cobrox_tipo_cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cobrox_tipo_cliente (id, nombre, date_creation, user_creation_id, user_last_update_id) FROM stdin;
2	Comedor	2023-03-16 11:49:27.756411-06	\N	\N
3	Tienda	2023-03-16 11:49:27.756411-06	\N	\N
4	Tienda y Comedor.	2023-03-16 11:49:27.756411-06	\N	\N
5	qewq	2023-03-16 11:49:27.756411-06	\N	\N
6	chgf	2023-03-16 11:49:27.756411-06	\N	\N
\.


--
-- TOC entry 3540 (class 0 OID 20586)
-- Dependencies: 223
-- Data for Name: cobrox_zona; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cobrox_zona (id, nombre, filial_id, date_creation, user_creation_id, user_last_update_id) FROM stdin;
1	CUSCATANCINGO	2	2023-03-16 11:47:34.700609-06	\N	\N
2	Santa Ana	3	2023-03-16 11:47:34.700609-06	\N	\N
3	asda2342342	2	2023-03-16 11:47:34.700609-06	\N	\N
\.


--
-- TOC entry 3535 (class 0 OID 20535)
-- Dependencies: 218
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- TOC entry 3521 (class 0 OID 20421)
-- Dependencies: 204
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	cobrox	zona
8	cobrox	filial
9	user	login_cv
10	user	rol
11	user	user_rol_filial
12	cobrox	cliente
13	cobrox	tipo_cliente
14	cobrox	credito
15	cobrox	pago
16	cobrox	creditofinanc
17	cobrox	cliente_archivo
18	cobrox	credito_archivo
19	cobrox	historicalfilial
20	cobrox	historicalzona
21	cobrox	historicaltipo_cliente
22	cobrox	historicalpago
23	cobrox	historicalcreditofinanc
24	cobrox	historicalcredito_archivo
25	cobrox	historicalcredito
26	cobrox	historicalcliente_archivo
27	cobrox	historicalcliente
28	wsfacturae	historicalwsurl
29	wsfacturae	wsurl
30	wsfacturae	historicalwsentorno
31	wsfacturae	wsentorno
32	wsfacturae	ws_autenticacion_log
33	wsfacturae	param_version_dte
\.


--
-- TOC entry 3519 (class 0 OID 20410)
-- Dependencies: 202
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2023-02-22 10:15:42.127449-06
2	auth	0001_initial	2023-02-22 10:15:42.273874-06
3	admin	0001_initial	2023-02-22 10:15:42.319627-06
4	admin	0002_logentry_remove_auto_add	2023-02-22 10:15:42.342211-06
5	admin	0003_logentry_add_action_flag_choices	2023-02-22 10:15:42.364337-06
6	contenttypes	0002_remove_content_type_name	2023-02-22 10:15:42.405646-06
7	auth	0002_alter_permission_name_max_length	2023-02-22 10:15:42.424738-06
8	auth	0003_alter_user_email_max_length	2023-02-22 10:15:42.444107-06
9	auth	0004_alter_user_username_opts	2023-02-22 10:15:42.457929-06
10	auth	0005_alter_user_last_login_null	2023-02-22 10:15:42.473919-06
11	auth	0006_require_contenttypes_0002	2023-02-22 10:15:42.4799-06
12	auth	0007_alter_validators_add_error_messages	2023-02-22 10:15:42.494045-06
13	auth	0008_alter_user_username_max_length	2023-02-22 10:15:42.519008-06
14	auth	0009_alter_user_last_name_max_length	2023-02-22 10:15:42.535068-06
15	auth	0010_alter_group_name_max_length	2023-02-22 10:15:42.552976-06
16	auth	0011_update_proxy_permissions	2023-02-22 10:15:42.568139-06
17	auth	0012_alter_user_first_name_max_length	2023-02-22 10:15:42.584204-06
18	sessions	0001_initial	2023-02-22 10:15:42.607498-06
19	cobrox	0001_initial	2023-02-23 13:49:26.082074-06
20	user	0001_initial	2023-02-23 13:49:26.095559-06
21	user	0002_rol_user_rol_filial	2023-02-23 14:43:03.8246-06
22	cobrox	0002_cliente_tipo_cliente	2023-02-28 16:27:02.303416-06
23	cobrox	0003_auto_20230301_0952	2023-03-01 09:52:57.385283-06
24	cobrox	0004_credito	2023-03-01 17:40:05.372377-06
25	cobrox	0005_auto_20230302_1657	2023-03-02 16:57:41.720502-06
26	cobrox	0006_auto_20230303_1507	2023-03-03 15:07:55.971567-06
27	cobrox	0007_pagos	2023-03-03 16:38:12.737957-06
28	cobrox	0008_rename_pagos_pago	2023-03-03 16:43:56.097533-06
29	cobrox	0009_auto_20230304_1528	2023-03-04 15:28:20.761795-06
30	cobrox	0010_credito_nm_estado	2023-03-08 18:44:54.518858-06
31	cobrox	0011_creditofinanc	2023-03-09 18:04:17.102686-06
32	cobrox	0012_auto_20230312_1005	2023-03-12 10:05:28.724693-06
33	cobrox	0013_auto_20230312_1025	2023-03-12 10:35:47.95394-06
34	cobrox	0014_alter_credito_archivo_archivo	2023-03-12 19:23:19.932629-06
35	cobrox	0015_auto_20230316_1047	2023-03-16 10:48:09.530782-06
36	cobrox	0016_auto_20230316_1103	2023-03-16 11:03:46.813266-06
37	cobrox	0017_auto_20230316_1147	2023-03-16 11:47:34.77749-06
38	cobrox	0018_auto_20230316_1149	2023-03-16 11:49:28.005446-06
39	wsfacturae	0001_initial	2023-03-18 06:36:03.997346-06
40	wsfacturae	0002_ws_autenticacion_log	2023-03-19 12:49:03.009314-06
41	wsfacturae	0003_param_version_dte	2023-03-21 18:11:17.827761-06
\.


--
-- TOC entry 3536 (class 0 OID 20566)
-- Dependencies: 219
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
9309ms956rz3mq2qbpijmfc8brvybyua	eyJ0ZXN0Y29va2llIjoid29ya2VkIn0:1pVi5F:qKy2t4kYI6svWmB2Ked5BFjyK7EwlP5qa63aw1ZFwDM	2023-03-10 18:06:37.561219-06
gwwsvtmg0o8hfx9cdrggtic5hm46udlh	.eJxVjEEOwiAQRe_C2hCGykBduu8ZyAxMbdVAUtqV8e7apAvd_vfef6lI2zrFrckS56wuCkCdfkem9JCyk3yncqs61bIuM-td0QdteqhZntfD_TuYqE3fmoKAdWiZbQbGDOR7Ix5BsDOSUJwN0mPCZHh0AoE7kRHPPlHfgXHq_QELazgv:1pXPaV:qUEIikE7cRO4DS7j3dR_XsABXLNlvTcTswfRsW82lOA	2023-03-15 10:45:55.401563-06
ga00sbfsjmxmof8mwnmrsismg66gfrki	.eJxVjLsOgkAUBf9la7MRWC5gae83kPsUxLAJu8TC-O9CQkN7ZuZ8XdaUOcZpVHdzn7hMKu7ielzz0K9Jl36UDcB5I-RJ5x3IC-dn9BznvIzkd8UfNPlHFH3fD_d0MGAatrqoCgQLCm0Iyl1VqQYW09YYUAwhNNaZXesyIFlHjVBJLUABrDUZuN8fk1FA8w:1pcrz5:ME6_MwklUolmoCu4onqyPiZzHCVKvf1gMegNwEFQOag	2023-03-30 12:05:51.202744-06
i9dpatljh8ojqfe0wm0vsziw6tg7jhcv	.eJxVjLsOgkAUBf9la7MRWC5gae83kPsUxLAJu8TC-O9CQkN7ZuZ8XdaUOcZpVHdzn7hMKu7ielzz0K9Jl36UDcB5I-RJ5x3IC-dn9BznvIzkd8UfNPlHFH3fD_d0MGAatrqoCgQLCm0Iyl1VqQYW09YYUAwhNNaZXesyIFlHjVBJLUABrDUZuN8fk1FA8w:1pdCZP:qTH3C1va0JIdFVCwD63Pl5j5YFLEa7uPXM0QCEBZVcg	2023-03-31 10:04:43.237929-06
\.


--
-- TOC entry 3542 (class 0 OID 20600)
-- Dependencies: 225
-- Data for Name: user_login_cv; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_login_cv (id, fecha, usuario_id) FROM stdin;
1	2023-02-28 16:02:42.896076-06	6
2	2023-03-01 10:08:06.648404-06	6
3	2023-03-01 10:45:55.397109-06	11
4	2023-03-01 11:49:36.112132-06	6
5	2023-03-01 13:35:07.692676-06	6
6	2023-03-01 13:36:18.490648-06	6
7	2023-03-04 05:43:56.646725-06	6
8	2023-03-09 14:47:28.069743-06	6
9	2023-03-11 11:02:28.881074-06	6
10	2023-03-11 11:03:16.639951-06	6
11	2023-03-11 11:09:02.469142-06	6
12	2023-03-16 11:16:31.20346-06	3
13	2023-03-16 11:16:43.499678-06	6
14	2023-03-16 11:18:15.289922-06	3
15	2023-03-16 11:18:58.429505-06	6
16	2023-03-16 11:19:41.966109-06	3
17	2023-03-16 11:21:34.676086-06	3
18	2023-03-16 11:24:54.589145-06	3
19	2023-03-16 11:29:39.536277-06	3
20	2023-03-16 11:30:10.611283-06	3
21	2023-03-16 11:30:34.202471-06	6
22	2023-03-16 11:38:01.858735-06	3
23	2023-03-16 12:05:51.200207-06	6
24	2023-03-17 10:04:43.237929-06	6
\.


--
-- TOC entry 3544 (class 0 OID 20615)
-- Dependencies: 227
-- Data for Name: user_rol; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_rol (id, nombre, codigo) FROM stdin;
2	Administrador	ADM
3	Operador	OPE
5	qweq	232
\.


--
-- TOC entry 3546 (class 0 OID 20623)
-- Dependencies: 229
-- Data for Name: user_user_rol_filial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_user_rol_filial (id, filial_id, rol_id, usuario_id) FROM stdin;
4	2	2	11
2	2	2	6
5	2	3	12
1	4	2	3
\.


--
-- TOC entry 3586 (class 0 OID 21129)
-- Dependencies: 269
-- Data for Name: wsfacturae_historicalwsentorno; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wsfacturae_historicalwsentorno (id, codigo, nombre, url, date_creation, history_id, history_date, history_change_reason, history_type, history_user_id, user_creation_id, user_last_update_id) FROM stdin;
1	001	Entorno	https://apitest.dtes.mh.gob.sv	2023-03-18 06:38:54.813363-06	1	2023-03-18 06:38:54.818128-06	\N	+	6	6	6
1	001	Entorno	https://apitest.dtes.mh.gob.sv	2023-03-18 06:38:54.813363-06	2	2023-03-18 06:40:29.613465-06	\N	-	6	6	6
2	001	Entorno Web Services	https://apitest.dtes.mh.gob.sv	2023-03-18 06:40:59.785641-06	3	2023-03-18 06:40:59.788017-06	\N	+	6	6	6
2	001	Entorno Web Services	https://apitest.dtes.mh.gob.sv	2023-03-18 06:40:59.785641-06	4	2023-03-19 10:52:09.022488-06	\N	~	6	6	6
3	1001	Entorno Firma Electrónica	http://localhost:8113	2023-03-19 15:20:15.740208-06	5	2023-03-19 15:20:15.742246-06	\N	+	6	6	6
3	002	Entorno Firma Electrónica	http://localhost:8113	2023-03-19 15:20:15.740208-06	6	2023-03-19 15:20:46.872223-06	\N	~	6	6	6
\.


--
-- TOC entry 3584 (class 0 OID 21118)
-- Dependencies: 267
-- Data for Name: wsfacturae_historicalwsurl; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wsfacturae_historicalwsurl (id, codigo, url, nombre, date_creation, history_id, history_date, history_change_reason, history_type, history_user_id, user_creation_id, user_last_update_id, wsentorno_id) FROM stdin;
1	001	/seguridad/auth	Servicio de Authenticación	2023-03-19 11:10:26.899661-06	1	2023-03-19 11:10:26.915157-06	\N	+	6	6	6	2
1	001	/seguridad/auths	Servicio de Authenticación de WS	2023-03-19 11:10:26.899661-06	2	2023-03-19 11:10:43.025669-06	\N	~	6	6	6	2
1	001	/seguridad/auth	Servicio de Authenticación	2023-03-19 11:10:26.899661-06	3	2023-03-19 11:10:53.234317-06	\N	~	6	6	6	2
2	1001	/firmardocumento/	Firmaro Documento	2023-03-19 15:21:22.934674-06	4	2023-03-19 15:21:22.940654-06	\N	+	6	6	6	3
3	002	/fesv/recepciondte	Servicio de Recepción	2023-03-19 15:37:58.119253-06	5	2023-03-19 15:37:58.121991-06	\N	+	6	6	6	2
\.


--
-- TOC entry 3590 (class 0 OID 21206)
-- Dependencies: 273
-- Data for Name: wsfacturae_param_version_dte; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wsfacturae_param_version_dte (id, codigo_documento, version, "tipoDte") FROM stdin;
\.


--
-- TOC entry 3588 (class 0 OID 21195)
-- Dependencies: 271
-- Data for Name: wsfacturae_ws_autenticacion_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wsfacturae_ws_autenticacion_log (id, user_enviado, jenviado, jrespuesta, token, tiporespuesta, mensajeerror, date_creation) FROM stdin;
\.


--
-- TOC entry 3580 (class 0 OID 21092)
-- Dependencies: 263
-- Data for Name: wsfacturae_wsentorno; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wsfacturae_wsentorno (id, codigo, nombre, url, date_creation, user_creation_id, user_last_update_id) FROM stdin;
2	001	Entorno Web Services	https://apitest.dtes.mh.gob.sv	2023-03-18 06:40:59.785641-06	6	6
3	002	Entorno Firma Electrónica	http://localhost:8113	2023-03-19 15:20:15.740208-06	6	6
\.


--
-- TOC entry 3582 (class 0 OID 21105)
-- Dependencies: 265
-- Data for Name: wsfacturae_wsurl; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wsfacturae_wsurl (id, codigo, url, nombre, date_creation, user_creation_id, user_last_update_id, wsentorno_id) FROM stdin;
1	001	/seguridad/auth	Servicio de Authenticación	2023-03-19 11:10:26.899661-06	6	6	2
2	1001	/firmardocumento/	Firmaro Documento	2023-03-19 15:21:22.934674-06	6	6	3
3	002	/fesv/recepciondte	Servicio de Recepción	2023-03-19 15:37:58.119253-06	6	6	2
\.


--
-- TOC entry 3633 (class 0 OID 0)
-- Dependencies: 207
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- TOC entry 3634 (class 0 OID 0)
-- Dependencies: 209
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- TOC entry 3635 (class 0 OID 0)
-- Dependencies: 205
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 144, true);


--
-- TOC entry 3636 (class 0 OID 0)
-- Dependencies: 213
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- TOC entry 3637 (class 0 OID 0)
-- Dependencies: 211
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 12, true);


--
-- TOC entry 3638 (class 0 OID 0)
-- Dependencies: 215
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- TOC entry 3639 (class 0 OID 0)
-- Dependencies: 242
-- Name: cobrox_cliente_archivos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cobrox_cliente_archivos_id_seq', 7, true);


--
-- TOC entry 3640 (class 0 OID 0)
-- Dependencies: 232
-- Name: cobrox_cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cobrox_cliente_id_seq', 13, true);


--
-- TOC entry 3641 (class 0 OID 0)
-- Dependencies: 240
-- Name: cobrox_credito_archivos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cobrox_credito_archivos_id_seq', 24, true);


--
-- TOC entry 3642 (class 0 OID 0)
-- Dependencies: 234
-- Name: cobrox_credito_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cobrox_credito_id_seq', 63, true);


--
-- TOC entry 3643 (class 0 OID 0)
-- Dependencies: 238
-- Name: cobrox_creditofinanc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cobrox_creditofinanc_id_seq', 15, true);


--
-- TOC entry 3644 (class 0 OID 0)
-- Dependencies: 220
-- Name: cobrox_filial_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cobrox_filial_id_seq', 8, true);


--
-- TOC entry 3645 (class 0 OID 0)
-- Dependencies: 258
-- Name: cobrox_historicalcliente_archivo_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cobrox_historicalcliente_archivo_history_id_seq', 6, true);


--
-- TOC entry 3646 (class 0 OID 0)
-- Dependencies: 260
-- Name: cobrox_historicalcliente_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cobrox_historicalcliente_history_id_seq', 2, true);


--
-- TOC entry 3647 (class 0 OID 0)
-- Dependencies: 254
-- Name: cobrox_historicalcredito_archivo_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cobrox_historicalcredito_archivo_history_id_seq', 8, true);


--
-- TOC entry 3648 (class 0 OID 0)
-- Dependencies: 256
-- Name: cobrox_historicalcredito_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cobrox_historicalcredito_history_id_seq', 6, true);


--
-- TOC entry 3649 (class 0 OID 0)
-- Dependencies: 252
-- Name: cobrox_historicalcreditofinanc_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cobrox_historicalcreditofinanc_history_id_seq', 1, false);


--
-- TOC entry 3650 (class 0 OID 0)
-- Dependencies: 244
-- Name: cobrox_historicalfilial_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cobrox_historicalfilial_history_id_seq', 10, true);


--
-- TOC entry 3651 (class 0 OID 0)
-- Dependencies: 250
-- Name: cobrox_historicalpago_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cobrox_historicalpago_history_id_seq', 2, true);


--
-- TOC entry 3652 (class 0 OID 0)
-- Dependencies: 248
-- Name: cobrox_historicaltipo_cliente_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cobrox_historicaltipo_cliente_history_id_seq', 3, true);


--
-- TOC entry 3653 (class 0 OID 0)
-- Dependencies: 246
-- Name: cobrox_historicalzona_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cobrox_historicalzona_history_id_seq', 1, false);


--
-- TOC entry 3654 (class 0 OID 0)
-- Dependencies: 236
-- Name: cobrox_pagos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cobrox_pagos_id_seq', 43, true);


--
-- TOC entry 3655 (class 0 OID 0)
-- Dependencies: 230
-- Name: cobrox_tipo_cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cobrox_tipo_cliente_id_seq', 7, true);


--
-- TOC entry 3656 (class 0 OID 0)
-- Dependencies: 222
-- Name: cobrox_zona_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cobrox_zona_id_seq', 4, true);


--
-- TOC entry 3657 (class 0 OID 0)
-- Dependencies: 217
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- TOC entry 3658 (class 0 OID 0)
-- Dependencies: 203
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 33, true);


--
-- TOC entry 3659 (class 0 OID 0)
-- Dependencies: 201
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 41, true);


--
-- TOC entry 3660 (class 0 OID 0)
-- Dependencies: 224
-- Name: user_login_cv_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_login_cv_id_seq', 24, true);


--
-- TOC entry 3661 (class 0 OID 0)
-- Dependencies: 226
-- Name: user_rol_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_rol_id_seq', 5, true);


--
-- TOC entry 3662 (class 0 OID 0)
-- Dependencies: 228
-- Name: user_user_rol_filial_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_user_rol_filial_id_seq', 5, true);


--
-- TOC entry 3663 (class 0 OID 0)
-- Dependencies: 268
-- Name: wsfacturae_historicalwsentorno_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wsfacturae_historicalwsentorno_history_id_seq', 6, true);


--
-- TOC entry 3664 (class 0 OID 0)
-- Dependencies: 266
-- Name: wsfacturae_historicalwsurl_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wsfacturae_historicalwsurl_history_id_seq', 5, true);


--
-- TOC entry 3665 (class 0 OID 0)
-- Dependencies: 272
-- Name: wsfacturae_param_version_dte_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wsfacturae_param_version_dte_id_seq', 1, false);


--
-- TOC entry 3666 (class 0 OID 0)
-- Dependencies: 270
-- Name: wsfacturae_ws_autenticacion_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wsfacturae_ws_autenticacion_log_id_seq', 1, false);


--
-- TOC entry 3667 (class 0 OID 0)
-- Dependencies: 262
-- Name: wsfacturae_wsentorno_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wsfacturae_wsentorno_id_seq', 3, true);


--
-- TOC entry 3668 (class 0 OID 0)
-- Dependencies: 264
-- Name: wsfacturae_wsurl_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wsfacturae_wsurl_id_seq', 3, true);


--
-- TOC entry 3144 (class 2606 OID 20564)
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- TOC entry 3149 (class 2606 OID 20491)
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- TOC entry 3152 (class 2606 OID 20454)
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 3146 (class 2606 OID 20444)
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- TOC entry 3139 (class 2606 OID 20482)
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- TOC entry 3141 (class 2606 OID 20436)
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 3160 (class 2606 OID 20472)
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 3163 (class 2606 OID 20506)
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- TOC entry 3154 (class 2606 OID 20462)
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- TOC entry 3166 (class 2606 OID 20480)
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 3169 (class 2606 OID 20520)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- TOC entry 3157 (class 2606 OID 20558)
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- TOC entry 3229 (class 2606 OID 20764)
-- Name: cobrox_credito_archivo cobrox_cliente_archivos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_credito_archivo
    ADD CONSTRAINT cobrox_cliente_archivos_pkey PRIMARY KEY (id);


--
-- TOC entry 3202 (class 2606 OID 20665)
-- Name: cobrox_cliente cobrox_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_cliente
    ADD CONSTRAINT cobrox_cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 3227 (class 2606 OID 20753)
-- Name: cobrox_cliente_archivo cobrox_credito_archivos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_cliente_archivo
    ADD CONSTRAINT cobrox_credito_archivos_pkey PRIMARY KEY (id);


--
-- TOC entry 3209 (class 2606 OID 20694)
-- Name: cobrox_credito cobrox_credito_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_credito
    ADD CONSTRAINT cobrox_credito_pkey PRIMARY KEY (id);


--
-- TOC entry 3220 (class 2606 OID 20730)
-- Name: cobrox_creditofinanc cobrox_creditofinanc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_creditofinanc
    ADD CONSTRAINT cobrox_creditofinanc_pkey PRIMARY KEY (id);


--
-- TOC entry 3179 (class 2606 OID 20583)
-- Name: cobrox_filial cobrox_filial_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_filial
    ADD CONSTRAINT cobrox_filial_pkey PRIMARY KEY (id);


--
-- TOC entry 3285 (class 2606 OID 20992)
-- Name: cobrox_historicalcliente_archivo cobrox_historicalcliente_archivo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalcliente_archivo
    ADD CONSTRAINT cobrox_historicalcliente_archivo_pkey PRIMARY KEY (history_id);


--
-- TOC entry 3291 (class 2606 OID 21003)
-- Name: cobrox_historicalcliente cobrox_historicalcliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalcliente
    ADD CONSTRAINT cobrox_historicalcliente_pkey PRIMARY KEY (history_id);


--
-- TOC entry 3271 (class 2606 OID 20970)
-- Name: cobrox_historicalcredito_archivo cobrox_historicalcredito_archivo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalcredito_archivo
    ADD CONSTRAINT cobrox_historicalcredito_archivo_pkey PRIMARY KEY (history_id);


--
-- TOC entry 3278 (class 2606 OID 20981)
-- Name: cobrox_historicalcredito cobrox_historicalcredito_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalcredito
    ADD CONSTRAINT cobrox_historicalcredito_pkey PRIMARY KEY (history_id);


--
-- TOC entry 3264 (class 2606 OID 20959)
-- Name: cobrox_historicalcreditofinanc cobrox_historicalcreditofinanc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalcreditofinanc
    ADD CONSTRAINT cobrox_historicalcreditofinanc_pkey PRIMARY KEY (history_id);


--
-- TOC entry 3236 (class 2606 OID 20804)
-- Name: cobrox_historicalfilial cobrox_historicalfilial_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalfilial
    ADD CONSTRAINT cobrox_historicalfilial_pkey PRIMARY KEY (history_id);


--
-- TOC entry 3256 (class 2606 OID 20951)
-- Name: cobrox_historicalpago cobrox_historicalpago_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalpago
    ADD CONSTRAINT cobrox_historicalpago_pkey PRIMARY KEY (history_id);


--
-- TOC entry 3249 (class 2606 OID 20941)
-- Name: cobrox_historicaltipo_cliente cobrox_historicaltipo_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicaltipo_cliente
    ADD CONSTRAINT cobrox_historicaltipo_cliente_pkey PRIMARY KEY (history_id);


--
-- TOC entry 3243 (class 2606 OID 20844)
-- Name: cobrox_historicalzona cobrox_historicalzona_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalzona
    ADD CONSTRAINT cobrox_historicalzona_pkey PRIMARY KEY (history_id);


--
-- TOC entry 3216 (class 2606 OID 20711)
-- Name: cobrox_pago cobrox_pagos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_pago
    ADD CONSTRAINT cobrox_pagos_pkey PRIMARY KEY (id);


--
-- TOC entry 3198 (class 2606 OID 20654)
-- Name: cobrox_tipo_cliente cobrox_tipo_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_tipo_cliente
    ADD CONSTRAINT cobrox_tipo_cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 3184 (class 2606 OID 20591)
-- Name: cobrox_zona cobrox_zona_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_zona
    ADD CONSTRAINT cobrox_zona_pkey PRIMARY KEY (id);


--
-- TOC entry 3172 (class 2606 OID 20544)
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3134 (class 2606 OID 20428)
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- TOC entry 3136 (class 2606 OID 20426)
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3132 (class 2606 OID 20418)
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3176 (class 2606 OID 20573)
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- TOC entry 3188 (class 2606 OID 20605)
-- Name: user_login_cv user_login_cv_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_login_cv
    ADD CONSTRAINT user_login_cv_pkey PRIMARY KEY (id);


--
-- TOC entry 3191 (class 2606 OID 20620)
-- Name: user_rol user_rol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_rol
    ADD CONSTRAINT user_rol_pkey PRIMARY KEY (id);


--
-- TOC entry 3194 (class 2606 OID 20628)
-- Name: user_user_rol_filial user_user_rol_filial_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_user_rol_filial
    ADD CONSTRAINT user_user_rol_filial_pkey PRIMARY KEY (id);


--
-- TOC entry 3325 (class 2606 OID 21137)
-- Name: wsfacturae_historicalwsentorno wsfacturae_historicalwsentorno_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wsfacturae_historicalwsentorno
    ADD CONSTRAINT wsfacturae_historicalwsentorno_pkey PRIMARY KEY (history_id);


--
-- TOC entry 3316 (class 2606 OID 21126)
-- Name: wsfacturae_historicalwsurl wsfacturae_historicalwsurl_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wsfacturae_historicalwsurl
    ADD CONSTRAINT wsfacturae_historicalwsurl_pkey PRIMARY KEY (history_id);


--
-- TOC entry 3331 (class 2606 OID 21213)
-- Name: wsfacturae_param_version_dte wsfacturae_param_version_dte_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wsfacturae_param_version_dte
    ADD CONSTRAINT wsfacturae_param_version_dte_pkey PRIMARY KEY (id);


--
-- TOC entry 3329 (class 2606 OID 21203)
-- Name: wsfacturae_ws_autenticacion_log wsfacturae_ws_autenticacion_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wsfacturae_ws_autenticacion_log
    ADD CONSTRAINT wsfacturae_ws_autenticacion_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3298 (class 2606 OID 21102)
-- Name: wsfacturae_wsentorno wsfacturae_wsentorno_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wsfacturae_wsentorno
    ADD CONSTRAINT wsfacturae_wsentorno_codigo_key UNIQUE (codigo);


--
-- TOC entry 3300 (class 2606 OID 21100)
-- Name: wsfacturae_wsentorno wsfacturae_wsentorno_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wsfacturae_wsentorno
    ADD CONSTRAINT wsfacturae_wsentorno_pkey PRIMARY KEY (id);


--
-- TOC entry 3305 (class 2606 OID 21115)
-- Name: wsfacturae_wsurl wsfacturae_wsurl_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wsfacturae_wsurl
    ADD CONSTRAINT wsfacturae_wsurl_codigo_key UNIQUE (codigo);


--
-- TOC entry 3307 (class 2606 OID 21113)
-- Name: wsfacturae_wsurl wsfacturae_wsurl_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wsfacturae_wsurl
    ADD CONSTRAINT wsfacturae_wsurl_pkey PRIMARY KEY (id);


--
-- TOC entry 3142 (class 1259 OID 20565)
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- TOC entry 3147 (class 1259 OID 20502)
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- TOC entry 3150 (class 1259 OID 20503)
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- TOC entry 3137 (class 1259 OID 20488)
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- TOC entry 3158 (class 1259 OID 20518)
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- TOC entry 3161 (class 1259 OID 20517)
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- TOC entry 3164 (class 1259 OID 20532)
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- TOC entry 3167 (class 1259 OID 20531)
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- TOC entry 3155 (class 1259 OID 20559)
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- TOC entry 3223 (class 1259 OID 20789)
-- Name: cobrox_cliente_archivo_cliente_id_dee14b40; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_cliente_archivo_cliente_id_dee14b40 ON public.cobrox_cliente_archivo USING btree (cliente_id);


--
-- TOC entry 3224 (class 1259 OID 21006)
-- Name: cobrox_cliente_archivo_user_creation_id_2d19f43f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_cliente_archivo_user_creation_id_2d19f43f ON public.cobrox_cliente_archivo USING btree (user_creation_id);


--
-- TOC entry 3225 (class 1259 OID 21007)
-- Name: cobrox_cliente_archivo_user_last_update_id_1b76b8f8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_cliente_archivo_user_last_update_id_1b76b8f8 ON public.cobrox_cliente_archivo USING btree (user_last_update_id);


--
-- TOC entry 3203 (class 1259 OID 20676)
-- Name: cobrox_cliente_tipo_cliente_id_a6ad7b8f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_cliente_tipo_cliente_id_a6ad7b8f ON public.cobrox_cliente USING btree (tipo_cliente_id);


--
-- TOC entry 3204 (class 1259 OID 21004)
-- Name: cobrox_cliente_user_creation_id_3bfc775e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_cliente_user_creation_id_3bfc775e ON public.cobrox_cliente USING btree (user_creation_id);


--
-- TOC entry 3205 (class 1259 OID 21005)
-- Name: cobrox_cliente_user_last_update_id_2ff89019; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_cliente_user_last_update_id_2ff89019 ON public.cobrox_cliente USING btree (user_last_update_id);


--
-- TOC entry 3206 (class 1259 OID 20677)
-- Name: cobrox_cliente_zona_id_91d81355; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_cliente_zona_id_91d81355 ON public.cobrox_cliente USING btree (zona_id);


--
-- TOC entry 3230 (class 1259 OID 20790)
-- Name: cobrox_credito_archivo_credito_id_9084eacc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_credito_archivo_credito_id_9084eacc ON public.cobrox_credito_archivo USING btree (credito_id);


--
-- TOC entry 3231 (class 1259 OID 21010)
-- Name: cobrox_credito_archivo_user_creation_id_c877ca6e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_credito_archivo_user_creation_id_c877ca6e ON public.cobrox_credito_archivo USING btree (user_creation_id);


--
-- TOC entry 3232 (class 1259 OID 21011)
-- Name: cobrox_credito_archivo_user_last_update_id_fa8a1fe6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_credito_archivo_user_last_update_id_fa8a1fe6 ON public.cobrox_credito_archivo USING btree (user_last_update_id);


--
-- TOC entry 3207 (class 1259 OID 20700)
-- Name: cobrox_credito_cliente_id_f063243a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_credito_cliente_id_f063243a ON public.cobrox_credito USING btree (cliente_id);


--
-- TOC entry 3210 (class 1259 OID 21008)
-- Name: cobrox_credito_user_creation_id_a89dea97; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_credito_user_creation_id_a89dea97 ON public.cobrox_credito USING btree (user_creation_id);


--
-- TOC entry 3211 (class 1259 OID 21009)
-- Name: cobrox_credito_user_last_update_id_1bdd946f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_credito_user_last_update_id_1bdd946f ON public.cobrox_credito USING btree (user_last_update_id);


--
-- TOC entry 3217 (class 1259 OID 20741)
-- Name: cobrox_creditofinanc_credito_financia_id_f92d6b99; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_creditofinanc_credito_financia_id_f92d6b99 ON public.cobrox_creditofinanc USING btree (credito_financia_id);


--
-- TOC entry 3218 (class 1259 OID 20742)
-- Name: cobrox_creditofinanc_credito_nvo_id_188e887d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_creditofinanc_credito_nvo_id_188e887d ON public.cobrox_creditofinanc USING btree (credito_nvo_id);


--
-- TOC entry 3221 (class 1259 OID 21012)
-- Name: cobrox_creditofinanc_user_creation_id_ce1492e1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_creditofinanc_user_creation_id_ce1492e1 ON public.cobrox_creditofinanc USING btree (user_creation_id);


--
-- TOC entry 3222 (class 1259 OID 21013)
-- Name: cobrox_creditofinanc_user_last_update_id_2c8b8ae4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_creditofinanc_user_last_update_id_2c8b8ae4 ON public.cobrox_creditofinanc USING btree (user_last_update_id);


--
-- TOC entry 3180 (class 1259 OID 20805)
-- Name: cobrox_filial_user_creation_76186b68; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_filial_user_creation_76186b68 ON public.cobrox_filial USING btree (user_creation_id);


--
-- TOC entry 3181 (class 1259 OID 20824)
-- Name: cobrox_filial_user_last_update_id_cf53df2d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_filial_user_last_update_id_cf53df2d ON public.cobrox_filial USING btree (user_last_update_id);


--
-- TOC entry 3281 (class 1259 OID 21074)
-- Name: cobrox_historicalcliente_archivo_cliente_id_cb5caf0c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcliente_archivo_cliente_id_cb5caf0c ON public.cobrox_historicalcliente_archivo USING btree (cliente_id);


--
-- TOC entry 3282 (class 1259 OID 21075)
-- Name: cobrox_historicalcliente_archivo_history_user_id_1b657f24; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcliente_archivo_history_user_id_1b657f24 ON public.cobrox_historicalcliente_archivo USING btree (history_user_id);


--
-- TOC entry 3283 (class 1259 OID 21073)
-- Name: cobrox_historicalcliente_archivo_id_826a8edf; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcliente_archivo_id_826a8edf ON public.cobrox_historicalcliente_archivo USING btree (id);


--
-- TOC entry 3286 (class 1259 OID 21076)
-- Name: cobrox_historicalcliente_archivo_user_creation_id_2ef33782; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcliente_archivo_user_creation_id_2ef33782 ON public.cobrox_historicalcliente_archivo USING btree (user_creation_id);


--
-- TOC entry 3287 (class 1259 OID 21077)
-- Name: cobrox_historicalcliente_archivo_user_last_update_id_314b85e0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcliente_archivo_user_last_update_id_314b85e0 ON public.cobrox_historicalcliente_archivo USING btree (user_last_update_id);


--
-- TOC entry 3288 (class 1259 OID 21084)
-- Name: cobrox_historicalcliente_history_user_id_49823d25; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcliente_history_user_id_49823d25 ON public.cobrox_historicalcliente USING btree (history_user_id);


--
-- TOC entry 3289 (class 1259 OID 21083)
-- Name: cobrox_historicalcliente_id_fca1f598; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcliente_id_fca1f598 ON public.cobrox_historicalcliente USING btree (id);


--
-- TOC entry 3292 (class 1259 OID 21085)
-- Name: cobrox_historicalcliente_tipo_cliente_id_2d5567dc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcliente_tipo_cliente_id_2d5567dc ON public.cobrox_historicalcliente USING btree (tipo_cliente_id);


--
-- TOC entry 3293 (class 1259 OID 21086)
-- Name: cobrox_historicalcliente_user_creation_id_175eb236; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcliente_user_creation_id_175eb236 ON public.cobrox_historicalcliente USING btree (user_creation_id);


--
-- TOC entry 3294 (class 1259 OID 21087)
-- Name: cobrox_historicalcliente_user_last_update_id_98d3b98e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcliente_user_last_update_id_98d3b98e ON public.cobrox_historicalcliente USING btree (user_last_update_id);


--
-- TOC entry 3295 (class 1259 OID 21088)
-- Name: cobrox_historicalcliente_zona_id_dfea335d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcliente_zona_id_dfea335d ON public.cobrox_historicalcliente USING btree (zona_id);


--
-- TOC entry 3267 (class 1259 OID 21054)
-- Name: cobrox_historicalcredito_archivo_credito_id_7046e71a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcredito_archivo_credito_id_7046e71a ON public.cobrox_historicalcredito_archivo USING btree (credito_id);


--
-- TOC entry 3268 (class 1259 OID 21055)
-- Name: cobrox_historicalcredito_archivo_history_user_id_cb933a72; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcredito_archivo_history_user_id_cb933a72 ON public.cobrox_historicalcredito_archivo USING btree (history_user_id);


--
-- TOC entry 3269 (class 1259 OID 21053)
-- Name: cobrox_historicalcredito_archivo_id_4773eeb3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcredito_archivo_id_4773eeb3 ON public.cobrox_historicalcredito_archivo USING btree (id);


--
-- TOC entry 3272 (class 1259 OID 21056)
-- Name: cobrox_historicalcredito_archivo_user_creation_id_49ba8f67; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcredito_archivo_user_creation_id_49ba8f67 ON public.cobrox_historicalcredito_archivo USING btree (user_creation_id);


--
-- TOC entry 3273 (class 1259 OID 21057)
-- Name: cobrox_historicalcredito_archivo_user_last_update_id_8d0fc9f5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcredito_archivo_user_last_update_id_8d0fc9f5 ON public.cobrox_historicalcredito_archivo USING btree (user_last_update_id);


--
-- TOC entry 3274 (class 1259 OID 21064)
-- Name: cobrox_historicalcredito_cliente_id_9e43535d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcredito_cliente_id_9e43535d ON public.cobrox_historicalcredito USING btree (cliente_id);


--
-- TOC entry 3275 (class 1259 OID 21065)
-- Name: cobrox_historicalcredito_history_user_id_117fcd6b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcredito_history_user_id_117fcd6b ON public.cobrox_historicalcredito USING btree (history_user_id);


--
-- TOC entry 3276 (class 1259 OID 21063)
-- Name: cobrox_historicalcredito_id_e1488903; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcredito_id_e1488903 ON public.cobrox_historicalcredito USING btree (id);


--
-- TOC entry 3279 (class 1259 OID 21066)
-- Name: cobrox_historicalcredito_user_creation_id_86dc5723; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcredito_user_creation_id_86dc5723 ON public.cobrox_historicalcredito USING btree (user_creation_id);


--
-- TOC entry 3280 (class 1259 OID 21067)
-- Name: cobrox_historicalcredito_user_last_update_id_6b9a932e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcredito_user_last_update_id_6b9a932e ON public.cobrox_historicalcredito USING btree (user_last_update_id);


--
-- TOC entry 3259 (class 1259 OID 21043)
-- Name: cobrox_historicalcreditofinanc_credito_financia_id_65ab3f5c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcreditofinanc_credito_financia_id_65ab3f5c ON public.cobrox_historicalcreditofinanc USING btree (credito_financia_id);


--
-- TOC entry 3260 (class 1259 OID 21044)
-- Name: cobrox_historicalcreditofinanc_credito_nvo_id_dafae2fc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcreditofinanc_credito_nvo_id_dafae2fc ON public.cobrox_historicalcreditofinanc USING btree (credito_nvo_id);


--
-- TOC entry 3261 (class 1259 OID 21045)
-- Name: cobrox_historicalcreditofinanc_history_user_id_1a22e061; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcreditofinanc_history_user_id_1a22e061 ON public.cobrox_historicalcreditofinanc USING btree (history_user_id);


--
-- TOC entry 3262 (class 1259 OID 21042)
-- Name: cobrox_historicalcreditofinanc_id_3e1931da; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcreditofinanc_id_3e1931da ON public.cobrox_historicalcreditofinanc USING btree (id);


--
-- TOC entry 3265 (class 1259 OID 21046)
-- Name: cobrox_historicalcreditofinanc_user_creation_id_ce4c7e51; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcreditofinanc_user_creation_id_ce4c7e51 ON public.cobrox_historicalcreditofinanc USING btree (user_creation_id);


--
-- TOC entry 3266 (class 1259 OID 21047)
-- Name: cobrox_historicalcreditofinanc_user_last_update_id_eeb052e6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalcreditofinanc_user_last_update_id_eeb052e6 ON public.cobrox_historicalcreditofinanc USING btree (user_last_update_id);


--
-- TOC entry 3233 (class 1259 OID 20812)
-- Name: cobrox_historicalfilial_history_user_id_7eb03007; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalfilial_history_user_id_7eb03007 ON public.cobrox_historicalfilial USING btree (history_user_id);


--
-- TOC entry 3234 (class 1259 OID 20811)
-- Name: cobrox_historicalfilial_id_bdec0501; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalfilial_id_bdec0501 ON public.cobrox_historicalfilial USING btree (id);


--
-- TOC entry 3237 (class 1259 OID 20813)
-- Name: cobrox_historicalfilial_user_creation_b162e594; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalfilial_user_creation_b162e594 ON public.cobrox_historicalfilial USING btree (user_creation_id);


--
-- TOC entry 3238 (class 1259 OID 20825)
-- Name: cobrox_historicalfilial_user_last_update_id_5df7f1b8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalfilial_user_last_update_id_5df7f1b8 ON public.cobrox_historicalfilial USING btree (user_last_update_id);


--
-- TOC entry 3252 (class 1259 OID 21033)
-- Name: cobrox_historicalpago_credito_id_100b4499; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalpago_credito_id_100b4499 ON public.cobrox_historicalpago USING btree (credito_id);


--
-- TOC entry 3253 (class 1259 OID 21034)
-- Name: cobrox_historicalpago_history_user_id_1bf0ce89; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalpago_history_user_id_1bf0ce89 ON public.cobrox_historicalpago USING btree (history_user_id);


--
-- TOC entry 3254 (class 1259 OID 21032)
-- Name: cobrox_historicalpago_id_7cfc1599; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalpago_id_7cfc1599 ON public.cobrox_historicalpago USING btree (id);


--
-- TOC entry 3257 (class 1259 OID 21035)
-- Name: cobrox_historicalpago_user_creation_id_b544763c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalpago_user_creation_id_b544763c ON public.cobrox_historicalpago USING btree (user_creation_id);


--
-- TOC entry 3258 (class 1259 OID 21036)
-- Name: cobrox_historicalpago_user_last_update_id_10d9d77d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalpago_user_last_update_id_10d9d77d ON public.cobrox_historicalpago USING btree (user_last_update_id);


--
-- TOC entry 3246 (class 1259 OID 21024)
-- Name: cobrox_historicaltipo_cliente_history_user_id_bac484e1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicaltipo_cliente_history_user_id_bac484e1 ON public.cobrox_historicaltipo_cliente USING btree (history_user_id);


--
-- TOC entry 3247 (class 1259 OID 21023)
-- Name: cobrox_historicaltipo_cliente_id_e1ca8c6f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicaltipo_cliente_id_e1ca8c6f ON public.cobrox_historicaltipo_cliente USING btree (id);


--
-- TOC entry 3250 (class 1259 OID 21025)
-- Name: cobrox_historicaltipo_cliente_user_creation_id_0facc8ff; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicaltipo_cliente_user_creation_id_0facc8ff ON public.cobrox_historicaltipo_cliente USING btree (user_creation_id);


--
-- TOC entry 3251 (class 1259 OID 21026)
-- Name: cobrox_historicaltipo_cliente_user_last_update_id_28311691; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicaltipo_cliente_user_last_update_id_28311691 ON public.cobrox_historicaltipo_cliente USING btree (user_last_update_id);


--
-- TOC entry 3239 (class 1259 OID 20853)
-- Name: cobrox_historicalzona_filial_id_23ec1fe8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalzona_filial_id_23ec1fe8 ON public.cobrox_historicalzona USING btree (filial_id);


--
-- TOC entry 3240 (class 1259 OID 20854)
-- Name: cobrox_historicalzona_history_user_id_639bab3a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalzona_history_user_id_639bab3a ON public.cobrox_historicalzona USING btree (history_user_id);


--
-- TOC entry 3241 (class 1259 OID 20852)
-- Name: cobrox_historicalzona_id_3f849274; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalzona_id_3f849274 ON public.cobrox_historicalzona USING btree (id);


--
-- TOC entry 3244 (class 1259 OID 20855)
-- Name: cobrox_historicalzona_user_creation_id_8dedc656; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalzona_user_creation_id_8dedc656 ON public.cobrox_historicalzona USING btree (user_creation_id);


--
-- TOC entry 3245 (class 1259 OID 20856)
-- Name: cobrox_historicalzona_user_last_update_id_2f15e4d0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_historicalzona_user_last_update_id_2f15e4d0 ON public.cobrox_historicalzona USING btree (user_last_update_id);


--
-- TOC entry 3212 (class 1259 OID 21014)
-- Name: cobrox_pago_user_creation_id_60ece1a2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_pago_user_creation_id_60ece1a2 ON public.cobrox_pago USING btree (user_creation_id);


--
-- TOC entry 3213 (class 1259 OID 21015)
-- Name: cobrox_pago_user_last_update_id_947ea7c6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_pago_user_last_update_id_947ea7c6 ON public.cobrox_pago USING btree (user_last_update_id);


--
-- TOC entry 3214 (class 1259 OID 20717)
-- Name: cobrox_pagos_credito_id_94189827; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_pagos_credito_id_94189827 ON public.cobrox_pago USING btree (credito_id);


--
-- TOC entry 3199 (class 1259 OID 21016)
-- Name: cobrox_tipo_cliente_user_creation_id_13ccf899; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_tipo_cliente_user_creation_id_13ccf899 ON public.cobrox_tipo_cliente USING btree (user_creation_id);


--
-- TOC entry 3200 (class 1259 OID 21017)
-- Name: cobrox_tipo_cliente_user_last_update_id_f2720254; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_tipo_cliente_user_last_update_id_f2720254 ON public.cobrox_tipo_cliente USING btree (user_last_update_id);


--
-- TOC entry 3182 (class 1259 OID 20597)
-- Name: cobrox_zona_filial_id_baaeb21f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_zona_filial_id_baaeb21f ON public.cobrox_zona USING btree (filial_id);


--
-- TOC entry 3185 (class 1259 OID 20845)
-- Name: cobrox_zona_user_creation_id_6efa93b0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_zona_user_creation_id_6efa93b0 ON public.cobrox_zona USING btree (user_creation_id);


--
-- TOC entry 3186 (class 1259 OID 20846)
-- Name: cobrox_zona_user_last_update_id_9754e1e6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cobrox_zona_user_last_update_id_9754e1e6 ON public.cobrox_zona USING btree (user_last_update_id);


--
-- TOC entry 3170 (class 1259 OID 20555)
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- TOC entry 3173 (class 1259 OID 20556)
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- TOC entry 3174 (class 1259 OID 20575)
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- TOC entry 3177 (class 1259 OID 20574)
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- TOC entry 3189 (class 1259 OID 20611)
-- Name: user_login_cv_usuario_id_a3b0df2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_login_cv_usuario_id_a3b0df2c ON public.user_login_cv USING btree (usuario_id);


--
-- TOC entry 3192 (class 1259 OID 20644)
-- Name: user_user_rol_filial_filial_id_d741ac86; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_user_rol_filial_filial_id_d741ac86 ON public.user_user_rol_filial USING btree (filial_id);


--
-- TOC entry 3195 (class 1259 OID 20645)
-- Name: user_user_rol_filial_rol_id_df61579f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_user_rol_filial_rol_id_df61579f ON public.user_user_rol_filial USING btree (rol_id);


--
-- TOC entry 3196 (class 1259 OID 20646)
-- Name: user_user_rol_filial_usuario_id_27b72cc1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_user_rol_filial_usuario_id_27b72cc1 ON public.user_user_rol_filial USING btree (usuario_id);


--
-- TOC entry 3320 (class 1259 OID 21188)
-- Name: wsfacturae_historicalwsentorno_codigo_cb7829cc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wsfacturae_historicalwsentorno_codigo_cb7829cc ON public.wsfacturae_historicalwsentorno USING btree (codigo);


--
-- TOC entry 3321 (class 1259 OID 21189)
-- Name: wsfacturae_historicalwsentorno_codigo_cb7829cc_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wsfacturae_historicalwsentorno_codigo_cb7829cc_like ON public.wsfacturae_historicalwsentorno USING btree (codigo varchar_pattern_ops);


--
-- TOC entry 3322 (class 1259 OID 21190)
-- Name: wsfacturae_historicalwsentorno_history_user_id_6a8ff7b1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wsfacturae_historicalwsentorno_history_user_id_6a8ff7b1 ON public.wsfacturae_historicalwsentorno USING btree (history_user_id);


--
-- TOC entry 3323 (class 1259 OID 21187)
-- Name: wsfacturae_historicalwsentorno_id_1ef9d70d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wsfacturae_historicalwsentorno_id_1ef9d70d ON public.wsfacturae_historicalwsentorno USING btree (id);


--
-- TOC entry 3326 (class 1259 OID 21191)
-- Name: wsfacturae_historicalwsentorno_user_creation_id_2f73c16e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wsfacturae_historicalwsentorno_user_creation_id_2f73c16e ON public.wsfacturae_historicalwsentorno USING btree (user_creation_id);


--
-- TOC entry 3327 (class 1259 OID 21192)
-- Name: wsfacturae_historicalwsentorno_user_last_update_id_48ea90e7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wsfacturae_historicalwsentorno_user_last_update_id_48ea90e7 ON public.wsfacturae_historicalwsentorno USING btree (user_last_update_id);


--
-- TOC entry 3311 (class 1259 OID 21176)
-- Name: wsfacturae_historicalwsurl_codigo_637db079; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wsfacturae_historicalwsurl_codigo_637db079 ON public.wsfacturae_historicalwsurl USING btree (codigo);


--
-- TOC entry 3312 (class 1259 OID 21177)
-- Name: wsfacturae_historicalwsurl_codigo_637db079_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wsfacturae_historicalwsurl_codigo_637db079_like ON public.wsfacturae_historicalwsurl USING btree (codigo varchar_pattern_ops);


--
-- TOC entry 3313 (class 1259 OID 21178)
-- Name: wsfacturae_historicalwsurl_history_user_id_c74a0334; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wsfacturae_historicalwsurl_history_user_id_c74a0334 ON public.wsfacturae_historicalwsurl USING btree (history_user_id);


--
-- TOC entry 3314 (class 1259 OID 21175)
-- Name: wsfacturae_historicalwsurl_id_0c0c3bb0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wsfacturae_historicalwsurl_id_0c0c3bb0 ON public.wsfacturae_historicalwsurl USING btree (id);


--
-- TOC entry 3317 (class 1259 OID 21179)
-- Name: wsfacturae_historicalwsurl_user_creation_id_0d953ce6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wsfacturae_historicalwsurl_user_creation_id_0d953ce6 ON public.wsfacturae_historicalwsurl USING btree (user_creation_id);


--
-- TOC entry 3318 (class 1259 OID 21180)
-- Name: wsfacturae_historicalwsurl_user_last_update_id_370f0e92; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wsfacturae_historicalwsurl_user_last_update_id_370f0e92 ON public.wsfacturae_historicalwsurl USING btree (user_last_update_id);


--
-- TOC entry 3319 (class 1259 OID 21181)
-- Name: wsfacturae_historicalwsurl_wsentorno_id_a3c1f3f7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wsfacturae_historicalwsurl_wsentorno_id_a3c1f3f7 ON public.wsfacturae_historicalwsurl USING btree (wsentorno_id);


--
-- TOC entry 3296 (class 1259 OID 21148)
-- Name: wsfacturae_wsentorno_codigo_1ed079a6_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wsfacturae_wsentorno_codigo_1ed079a6_like ON public.wsfacturae_wsentorno USING btree (codigo varchar_pattern_ops);


--
-- TOC entry 3301 (class 1259 OID 21149)
-- Name: wsfacturae_wsentorno_user_creation_id_c0b2d00b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wsfacturae_wsentorno_user_creation_id_c0b2d00b ON public.wsfacturae_wsentorno USING btree (user_creation_id);


--
-- TOC entry 3302 (class 1259 OID 21150)
-- Name: wsfacturae_wsentorno_user_last_update_id_e1baafdc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wsfacturae_wsentorno_user_last_update_id_e1baafdc ON public.wsfacturae_wsentorno USING btree (user_last_update_id);


--
-- TOC entry 3303 (class 1259 OID 21166)
-- Name: wsfacturae_wsurl_codigo_a9b74248_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wsfacturae_wsurl_codigo_a9b74248_like ON public.wsfacturae_wsurl USING btree (codigo varchar_pattern_ops);


--
-- TOC entry 3308 (class 1259 OID 21167)
-- Name: wsfacturae_wsurl_user_creation_id_39c5e97e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wsfacturae_wsurl_user_creation_id_39c5e97e ON public.wsfacturae_wsurl USING btree (user_creation_id);


--
-- TOC entry 3309 (class 1259 OID 21168)
-- Name: wsfacturae_wsurl_user_last_update_id_eddbe6b4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wsfacturae_wsurl_user_last_update_id_eddbe6b4 ON public.wsfacturae_wsurl USING btree (user_last_update_id);


--
-- TOC entry 3310 (class 1259 OID 21169)
-- Name: wsfacturae_wsurl_wsentorno_id_81ce0fcb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wsfacturae_wsurl_wsentorno_id_81ce0fcb ON public.wsfacturae_wsurl USING btree (wsentorno_id);


--
-- TOC entry 3334 (class 2606 OID 20497)
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3333 (class 2606 OID 20492)
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3332 (class 2606 OID 20483)
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3336 (class 2606 OID 20512)
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3335 (class 2606 OID 20507)
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3338 (class 2606 OID 20526)
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3337 (class 2606 OID 20521)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3367 (class 2606 OID 20869)
-- Name: cobrox_cliente_archivo cobrox_cliente_archi_user_creation_id_2d19f43f_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_cliente_archivo
    ADD CONSTRAINT cobrox_cliente_archi_user_creation_id_2d19f43f_fk_auth_user FOREIGN KEY (user_creation_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3368 (class 2606 OID 20874)
-- Name: cobrox_cliente_archivo cobrox_cliente_archi_user_last_update_id_1b76b8f8_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_cliente_archivo
    ADD CONSTRAINT cobrox_cliente_archi_user_last_update_id_1b76b8f8_fk_auth_user FOREIGN KEY (user_last_update_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3366 (class 2606 OID 20778)
-- Name: cobrox_cliente_archivo cobrox_cliente_archivo_cliente_id_dee14b40_fk_cobrox_cliente_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_cliente_archivo
    ADD CONSTRAINT cobrox_cliente_archivo_cliente_id_dee14b40_fk_cobrox_cliente_id FOREIGN KEY (cliente_id) REFERENCES public.cobrox_cliente(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3352 (class 2606 OID 20666)
-- Name: cobrox_cliente cobrox_cliente_tipo_cliente_id_a6ad7b8f_fk_cobrox_ti; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_cliente
    ADD CONSTRAINT cobrox_cliente_tipo_cliente_id_a6ad7b8f_fk_cobrox_ti FOREIGN KEY (tipo_cliente_id) REFERENCES public.cobrox_tipo_cliente(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3354 (class 2606 OID 20858)
-- Name: cobrox_cliente cobrox_cliente_user_creation_id_3bfc775e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_cliente
    ADD CONSTRAINT cobrox_cliente_user_creation_id_3bfc775e_fk_auth_user_id FOREIGN KEY (user_creation_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3355 (class 2606 OID 20863)
-- Name: cobrox_cliente cobrox_cliente_user_last_update_id_2ff89019_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_cliente
    ADD CONSTRAINT cobrox_cliente_user_last_update_id_2ff89019_fk_auth_user_id FOREIGN KEY (user_last_update_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3353 (class 2606 OID 20671)
-- Name: cobrox_cliente cobrox_cliente_zona_id_91d81355_fk_cobrox_zona_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_cliente
    ADD CONSTRAINT cobrox_cliente_zona_id_91d81355_fk_cobrox_zona_id FOREIGN KEY (zona_id) REFERENCES public.cobrox_zona(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3370 (class 2606 OID 20891)
-- Name: cobrox_credito_archivo cobrox_credito_archi_user_creation_id_c877ca6e_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_credito_archivo
    ADD CONSTRAINT cobrox_credito_archi_user_creation_id_c877ca6e_fk_auth_user FOREIGN KEY (user_creation_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3371 (class 2606 OID 20896)
-- Name: cobrox_credito_archivo cobrox_credito_archi_user_last_update_id_fa8a1fe6_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_credito_archivo
    ADD CONSTRAINT cobrox_credito_archi_user_last_update_id_fa8a1fe6_fk_auth_user FOREIGN KEY (user_last_update_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3369 (class 2606 OID 20784)
-- Name: cobrox_credito_archivo cobrox_credito_archivo_credito_id_9084eacc_fk_cobrox_credito_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_credito_archivo
    ADD CONSTRAINT cobrox_credito_archivo_credito_id_9084eacc_fk_cobrox_credito_id FOREIGN KEY (credito_id) REFERENCES public.cobrox_credito(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3356 (class 2606 OID 20695)
-- Name: cobrox_credito cobrox_credito_cliente_id_f063243a_fk_cobrox_cliente_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_credito
    ADD CONSTRAINT cobrox_credito_cliente_id_f063243a_fk_cobrox_cliente_id FOREIGN KEY (cliente_id) REFERENCES public.cobrox_cliente(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3357 (class 2606 OID 20880)
-- Name: cobrox_credito cobrox_credito_user_creation_id_a89dea97_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_credito
    ADD CONSTRAINT cobrox_credito_user_creation_id_a89dea97_fk_auth_user_id FOREIGN KEY (user_creation_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3358 (class 2606 OID 20885)
-- Name: cobrox_credito cobrox_credito_user_last_update_id_1bdd946f_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_credito
    ADD CONSTRAINT cobrox_credito_user_last_update_id_1bdd946f_fk_auth_user_id FOREIGN KEY (user_last_update_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3362 (class 2606 OID 20731)
-- Name: cobrox_creditofinanc cobrox_creditofinanc_credito_financia_id_f92d6b99_fk_cobrox_cr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_creditofinanc
    ADD CONSTRAINT cobrox_creditofinanc_credito_financia_id_f92d6b99_fk_cobrox_cr FOREIGN KEY (credito_financia_id) REFERENCES public.cobrox_credito(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3363 (class 2606 OID 20736)
-- Name: cobrox_creditofinanc cobrox_creditofinanc_credito_nvo_id_188e887d_fk_cobrox_cr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_creditofinanc
    ADD CONSTRAINT cobrox_creditofinanc_credito_nvo_id_188e887d_fk_cobrox_cr FOREIGN KEY (credito_nvo_id) REFERENCES public.cobrox_credito(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3364 (class 2606 OID 20902)
-- Name: cobrox_creditofinanc cobrox_creditofinanc_user_creation_id_ce1492e1_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_creditofinanc
    ADD CONSTRAINT cobrox_creditofinanc_user_creation_id_ce1492e1_fk_auth_user_id FOREIGN KEY (user_creation_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3365 (class 2606 OID 20907)
-- Name: cobrox_creditofinanc cobrox_creditofinanc_user_last_update_id_2c8b8ae4_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_creditofinanc
    ADD CONSTRAINT cobrox_creditofinanc_user_last_update_id_2c8b8ae4_fk_auth_user FOREIGN KEY (user_last_update_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3342 (class 2606 OID 20819)
-- Name: cobrox_filial cobrox_filial_user_creation_id_a299360f_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_filial
    ADD CONSTRAINT cobrox_filial_user_creation_id_a299360f_fk_auth_user_id FOREIGN KEY (user_creation_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3341 (class 2606 OID 20814)
-- Name: cobrox_filial cobrox_filial_user_last_update_id_cf53df2d_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_filial
    ADD CONSTRAINT cobrox_filial_user_last_update_id_cf53df2d_fk_auth_user_id FOREIGN KEY (user_last_update_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3379 (class 2606 OID 21068)
-- Name: cobrox_historicalcliente_archivo cobrox_historicalcli_history_user_id_1b657f24_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalcliente_archivo
    ADD CONSTRAINT cobrox_historicalcli_history_user_id_1b657f24_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3380 (class 2606 OID 21078)
-- Name: cobrox_historicalcliente cobrox_historicalcli_history_user_id_49823d25_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalcliente
    ADD CONSTRAINT cobrox_historicalcli_history_user_id_49823d25_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3378 (class 2606 OID 21058)
-- Name: cobrox_historicalcredito cobrox_historicalcre_history_user_id_117fcd6b_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalcredito
    ADD CONSTRAINT cobrox_historicalcre_history_user_id_117fcd6b_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3376 (class 2606 OID 21037)
-- Name: cobrox_historicalcreditofinanc cobrox_historicalcre_history_user_id_1a22e061_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalcreditofinanc
    ADD CONSTRAINT cobrox_historicalcre_history_user_id_1a22e061_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3377 (class 2606 OID 21048)
-- Name: cobrox_historicalcredito_archivo cobrox_historicalcre_history_user_id_cb933a72_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalcredito_archivo
    ADD CONSTRAINT cobrox_historicalcre_history_user_id_cb933a72_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3372 (class 2606 OID 20806)
-- Name: cobrox_historicalfilial cobrox_historicalfil_history_user_id_7eb03007_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalfilial
    ADD CONSTRAINT cobrox_historicalfil_history_user_id_7eb03007_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3375 (class 2606 OID 21027)
-- Name: cobrox_historicalpago cobrox_historicalpago_history_user_id_1bf0ce89_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalpago
    ADD CONSTRAINT cobrox_historicalpago_history_user_id_1bf0ce89_fk_auth_user_id FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3374 (class 2606 OID 21018)
-- Name: cobrox_historicaltipo_cliente cobrox_historicaltip_history_user_id_bac484e1_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicaltipo_cliente
    ADD CONSTRAINT cobrox_historicaltip_history_user_id_bac484e1_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3373 (class 2606 OID 20847)
-- Name: cobrox_historicalzona cobrox_historicalzona_history_user_id_639bab3a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_historicalzona
    ADD CONSTRAINT cobrox_historicalzona_history_user_id_639bab3a_fk_auth_user_id FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3360 (class 2606 OID 20913)
-- Name: cobrox_pago cobrox_pago_user_creation_id_60ece1a2_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_pago
    ADD CONSTRAINT cobrox_pago_user_creation_id_60ece1a2_fk_auth_user_id FOREIGN KEY (user_creation_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3361 (class 2606 OID 20918)
-- Name: cobrox_pago cobrox_pago_user_last_update_id_947ea7c6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_pago
    ADD CONSTRAINT cobrox_pago_user_last_update_id_947ea7c6_fk_auth_user_id FOREIGN KEY (user_last_update_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3359 (class 2606 OID 20712)
-- Name: cobrox_pago cobrox_pagos_credito_id_94189827_fk_cobrox_credito_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_pago
    ADD CONSTRAINT cobrox_pagos_credito_id_94189827_fk_cobrox_credito_id FOREIGN KEY (credito_id) REFERENCES public.cobrox_credito(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3350 (class 2606 OID 20924)
-- Name: cobrox_tipo_cliente cobrox_tipo_cliente_user_creation_id_13ccf899_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_tipo_cliente
    ADD CONSTRAINT cobrox_tipo_cliente_user_creation_id_13ccf899_fk_auth_user_id FOREIGN KEY (user_creation_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3351 (class 2606 OID 20929)
-- Name: cobrox_tipo_cliente cobrox_tipo_cliente_user_last_update_id_f2720254_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_tipo_cliente
    ADD CONSTRAINT cobrox_tipo_cliente_user_last_update_id_f2720254_fk_auth_user FOREIGN KEY (user_last_update_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3343 (class 2606 OID 20592)
-- Name: cobrox_zona cobrox_zona_filial_id_baaeb21f_fk_cobrox_filial_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_zona
    ADD CONSTRAINT cobrox_zona_filial_id_baaeb21f_fk_cobrox_filial_id FOREIGN KEY (filial_id) REFERENCES public.cobrox_filial(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3344 (class 2606 OID 20827)
-- Name: cobrox_zona cobrox_zona_user_creation_id_6efa93b0_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_zona
    ADD CONSTRAINT cobrox_zona_user_creation_id_6efa93b0_fk_auth_user_id FOREIGN KEY (user_creation_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3345 (class 2606 OID 20832)
-- Name: cobrox_zona cobrox_zona_user_last_update_id_9754e1e6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cobrox_zona
    ADD CONSTRAINT cobrox_zona_user_last_update_id_9754e1e6_fk_auth_user_id FOREIGN KEY (user_last_update_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3339 (class 2606 OID 20545)
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3340 (class 2606 OID 20550)
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3346 (class 2606 OID 20606)
-- Name: user_login_cv user_login_cv_usuario_id_a3b0df2c_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_login_cv
    ADD CONSTRAINT user_login_cv_usuario_id_a3b0df2c_fk_auth_user_id FOREIGN KEY (usuario_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3347 (class 2606 OID 20629)
-- Name: user_user_rol_filial user_user_rol_filial_filial_id_d741ac86_fk_cobrox_filial_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_user_rol_filial
    ADD CONSTRAINT user_user_rol_filial_filial_id_d741ac86_fk_cobrox_filial_id FOREIGN KEY (filial_id) REFERENCES public.cobrox_filial(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3348 (class 2606 OID 20634)
-- Name: user_user_rol_filial user_user_rol_filial_rol_id_df61579f_fk_user_rol_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_user_rol_filial
    ADD CONSTRAINT user_user_rol_filial_rol_id_df61579f_fk_user_rol_id FOREIGN KEY (rol_id) REFERENCES public.user_rol(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3349 (class 2606 OID 20639)
-- Name: user_user_rol_filial user_user_rol_filial_usuario_id_27b72cc1_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_user_rol_filial
    ADD CONSTRAINT user_user_rol_filial_usuario_id_27b72cc1_fk_auth_user_id FOREIGN KEY (usuario_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3387 (class 2606 OID 21182)
-- Name: wsfacturae_historicalwsentorno wsfacturae_historica_history_user_id_6a8ff7b1_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wsfacturae_historicalwsentorno
    ADD CONSTRAINT wsfacturae_historica_history_user_id_6a8ff7b1_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3386 (class 2606 OID 21170)
-- Name: wsfacturae_historicalwsurl wsfacturae_historica_history_user_id_c74a0334_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wsfacturae_historicalwsurl
    ADD CONSTRAINT wsfacturae_historica_history_user_id_c74a0334_fk_auth_user FOREIGN KEY (history_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3381 (class 2606 OID 21138)
-- Name: wsfacturae_wsentorno wsfacturae_wsentorno_user_creation_id_c0b2d00b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wsfacturae_wsentorno
    ADD CONSTRAINT wsfacturae_wsentorno_user_creation_id_c0b2d00b_fk_auth_user_id FOREIGN KEY (user_creation_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3382 (class 2606 OID 21143)
-- Name: wsfacturae_wsentorno wsfacturae_wsentorno_user_last_update_id_e1baafdc_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wsfacturae_wsentorno
    ADD CONSTRAINT wsfacturae_wsentorno_user_last_update_id_e1baafdc_fk_auth_user FOREIGN KEY (user_last_update_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3383 (class 2606 OID 21151)
-- Name: wsfacturae_wsurl wsfacturae_wsurl_user_creation_id_39c5e97e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wsfacturae_wsurl
    ADD CONSTRAINT wsfacturae_wsurl_user_creation_id_39c5e97e_fk_auth_user_id FOREIGN KEY (user_creation_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3384 (class 2606 OID 21156)
-- Name: wsfacturae_wsurl wsfacturae_wsurl_user_last_update_id_eddbe6b4_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wsfacturae_wsurl
    ADD CONSTRAINT wsfacturae_wsurl_user_last_update_id_eddbe6b4_fk_auth_user_id FOREIGN KEY (user_last_update_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3385 (class 2606 OID 21161)
-- Name: wsfacturae_wsurl wsfacturae_wsurl_wsentorno_id_81ce0fcb_fk_wsfactura; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wsfacturae_wsurl
    ADD CONSTRAINT wsfacturae_wsurl_wsentorno_id_81ce0fcb_fk_wsfactura FOREIGN KEY (wsentorno_id) REFERENCES public.wsfacturae_wsentorno(id) DEFERRABLE INITIALLY DEFERRED;


-- Completed on 2023-03-22 17:57:51

--
-- PostgreSQL database dump complete
--

