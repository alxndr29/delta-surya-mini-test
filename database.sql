--
-- PostgreSQL database dump
--

-- Dumped from database version 15.5
-- Dumped by pg_dump version 15.5

-- Started on 2025-09-20 11:39:03

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 160515)
-- Name: cache; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 160522)
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


--
-- TOC entry 236 (class 1259 OID 160605)
-- Name: examinations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.examinations (
    id bigint NOT NULL,
    weight integer NOT NULL,
    height integer NOT NULL,
    systole integer NOT NULL,
    diastole integer NOT NULL,
    heart_rate integer NOT NULL,
    respiratory_rate integer NOT NULL,
    temperature integer NOT NULL,
    patient_id bigint,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    date date NOT NULL,
    status character varying(255) DEFAULT 'process'::character varying NOT NULL,
    CONSTRAINT examinations_status_check CHECK (((status)::text = ANY ((ARRAY['process'::character varying, 'done'::character varying])::text[])))
);


--
-- TOC entry 235 (class 1259 OID 160604)
-- Name: examination_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.examination_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3480 (class 0 OID 0)
-- Dependencies: 235
-- Name: examination_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.examination_id_seq OWNED BY public.examinations.id;


--
-- TOC entry 226 (class 1259 OID 160547)
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 160546)
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3481 (class 0 OID 0)
-- Dependencies: 225
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- TOC entry 240 (class 1259 OID 160640)
-- Name: files; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.files (
    id bigint NOT NULL,
    examination_id bigint,
    file_path character varying(255),
    file_name character varying(255),
    file_mime character varying(255),
    file_size bigint,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 239 (class 1259 OID 160639)
-- Name: files_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3482 (class 0 OID 0)
-- Dependencies: 239
-- Name: files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.files_id_seq OWNED BY public.files.id;


--
-- TOC entry 224 (class 1259 OID 160539)
-- Name: job_batches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


--
-- TOC entry 223 (class 1259 OID 160530)
-- Name: jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


--
-- TOC entry 222 (class 1259 OID 160529)
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3483 (class 0 OID 0)
-- Dependencies: 222
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- TOC entry 238 (class 1259 OID 160623)
-- Name: medical_prescriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.medical_prescriptions (
    id bigint NOT NULL,
    examination_id bigint,
    medicine_price_id bigint,
    qty integer NOT NULL,
    total_price double precision NOT NULL,
    description character varying(255),
    created_by bigint,
    updated_by bigint,
    deleted_by bigint,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 237 (class 1259 OID 160622)
-- Name: medical_prescription_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.medical_prescription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3484 (class 0 OID 0)
-- Dependencies: 237
-- Name: medical_prescription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.medical_prescription_id_seq OWNED BY public.medical_prescriptions.id;


--
-- TOC entry 232 (class 1259 OID 160582)
-- Name: medicine_prices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.medicine_prices (
    id bigint NOT NULL,
    uuid uuid NOT NULL,
    unit_price double precision NOT NULL,
    start_date date NOT NULL,
    end_date date,
    medicine_id bigint,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 231 (class 1259 OID 160581)
-- Name: medicine_prices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.medicine_prices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3485 (class 0 OID 0)
-- Dependencies: 231
-- Name: medicine_prices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.medicine_prices_id_seq OWNED BY public.medicine_prices.id;


--
-- TOC entry 230 (class 1259 OID 160573)
-- Name: medicines; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.medicines (
    id bigint NOT NULL,
    uuid uuid NOT NULL,
    name character varying(255) NOT NULL,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 229 (class 1259 OID 160572)
-- Name: medicines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.medicines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3486 (class 0 OID 0)
-- Dependencies: 229
-- Name: medicines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.medicines_id_seq OWNED BY public.medicines.id;


--
-- TOC entry 215 (class 1259 OID 160482)
-- Name: migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


--
-- TOC entry 214 (class 1259 OID 160481)
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3487 (class 0 OID 0)
-- Dependencies: 214
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 218 (class 1259 OID 160499)
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


--
-- TOC entry 234 (class 1259 OID 160596)
-- Name: patients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.patients (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    bhirt_place character varying(255) NOT NULL,
    bhirt_date date NOT NULL,
    address character varying(255) NOT NULL,
    phone character varying(255) NOT NULL,
    nik character varying(255) NOT NULL,
    bpjs character varying(255) NOT NULL,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 233 (class 1259 OID 160595)
-- Name: patients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.patients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3488 (class 0 OID 0)
-- Dependencies: 233
-- Name: patients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.patients_id_seq OWNED BY public.patients.id;


--
-- TOC entry 228 (class 1259 OID 160559)
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint,
    deleted_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- TOC entry 227 (class 1259 OID 160558)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3489 (class 0 OID 0)
-- Dependencies: 227
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 219 (class 1259 OID 160506)
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 160489)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    created_by bigint,
    updated_by bigint,
    deleted_by bigint,
    deleted_at timestamp(0) without time zone,
    role_id bigint
);


--
-- TOC entry 216 (class 1259 OID 160488)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3490 (class 0 OID 0)
-- Dependencies: 216
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3252 (class 2604 OID 160608)
-- Name: examinations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.examinations ALTER COLUMN id SET DEFAULT nextval('public.examination_id_seq'::regclass);


--
-- TOC entry 3246 (class 2604 OID 160550)
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- TOC entry 3255 (class 2604 OID 160643)
-- Name: files id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);


--
-- TOC entry 3245 (class 2604 OID 160533)
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- TOC entry 3254 (class 2604 OID 160626)
-- Name: medical_prescriptions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medical_prescriptions ALTER COLUMN id SET DEFAULT nextval('public.medical_prescription_id_seq'::regclass);


--
-- TOC entry 3250 (class 2604 OID 160585)
-- Name: medicine_prices id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medicine_prices ALTER COLUMN id SET DEFAULT nextval('public.medicine_prices_id_seq'::regclass);


--
-- TOC entry 3249 (class 2604 OID 160576)
-- Name: medicines id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medicines ALTER COLUMN id SET DEFAULT nextval('public.medicines_id_seq'::regclass);


--
-- TOC entry 3243 (class 2604 OID 160485)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 3251 (class 2604 OID 160599)
-- Name: patients id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patients ALTER COLUMN id SET DEFAULT nextval('public.patients_id_seq'::regclass);


--
-- TOC entry 3248 (class 2604 OID 160562)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 3244 (class 2604 OID 160492)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3454 (class 0 OID 160515)
-- Dependencies: 220
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cache (key, value, expiration) FROM stdin;
\.


--
-- TOC entry 3455 (class 0 OID 160522)
-- Dependencies: 221
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- TOC entry 3470 (class 0 OID 160605)
-- Dependencies: 236
-- Data for Name: examinations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.examinations (id, weight, height, systole, diastole, heart_rate, respiratory_rate, temperature, patient_id, created_by, updated_by, deleted_by, deleted_at, created_at, updated_at, date, status) FROM stdin;
18	100	170	100	90	100	30	36	20	1	4	\N	\N	2025-09-20 03:30:49	2025-09-20 04:23:04	2025-09-20	done
\.


--
-- TOC entry 3460 (class 0 OID 160547)
-- Dependencies: 226
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- TOC entry 3474 (class 0 OID 160640)
-- Dependencies: 240
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.files (id, examination_id, file_path, file_name, file_mime, file_size, created_by, updated_by, deleted_by, deleted_at, created_at, updated_at) FROM stdin;
3	\N	uploads/examinations/5b975f04-a72d-461a-8519-1b85bb450956.pdf	qwerty123456.pdf	application/pdf	797138	1	1	\N	\N	2025-09-20 02:53:42	2025-09-20 02:53:42
\.


--
-- TOC entry 3458 (class 0 OID 160539)
-- Dependencies: 224
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- TOC entry 3457 (class 0 OID 160530)
-- Dependencies: 223
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- TOC entry 3472 (class 0 OID 160623)
-- Dependencies: 238
-- Data for Name: medical_prescriptions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.medical_prescriptions (id, examination_id, medicine_price_id, qty, total_price, description, created_by, updated_by, deleted_by, deleted_at, created_at, updated_at) FROM stdin;
20	18	9	2	11658	\N	1	1	\N	\N	2025-09-20 03:31:09	2025-09-20 03:31:09
21	18	54	5	34310	\N	1	1	\N	\N	2025-09-20 03:31:09	2025-09-20 03:31:09
22	18	99	2	2372	\N	1	1	\N	\N	2025-09-20 03:31:09	2025-09-20 03:31:09
\.


--
-- TOC entry 3466 (class 0 OID 160582)
-- Dependencies: 232
-- Data for Name: medicine_prices; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.medicine_prices (id, uuid, unit_price, start_date, end_date, medicine_id, created_by, updated_by, deleted_by, deleted_at, created_at, updated_at) FROM stdin;
2	9cf72984-1bf4-46e4-a979-266d70a32144	4914	2024-09-14	2024-09-19	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
3	9cf72984-1c41-4628-8964-71a4982febc5	5254	2024-09-20	2024-09-23	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
4	9cf72984-1c8f-4794-aedf-c178e2201d94	4901	2024-09-24	2024-09-27	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
5	9cf72984-1cdf-4a80-a165-f7c7ee56852f	5284	2024-09-28	2024-10-01	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
6	9cf72984-1d2c-4834-9d97-1ad65c4868ad	5641	2024-10-02	2024-10-06	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
8	9cf72984-1dca-4d2d-ba66-0fefbe809894	5388	2024-10-11	2024-10-14	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
9	9cf72984-1e13-4d68-91b9-0566283fe289	5829	2024-10-15	\N	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
10	9de66f61-ea9c-4f9a-9de7-a6cac65d826b	4693	2024-12-25	2024-12-29	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
11	9de66f61-eae5-4eed-b3bc-db5cb34a183b	4985	2024-12-30	2025-01-04	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
12	9de66f61-eb2c-41ba-b79e-9f493ab13386	5483	2025-01-05	2025-01-10	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
13	9de66f61-eb75-4f0a-8721-bc10a9a2d073	4978	2025-01-11	2025-01-14	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
14	9de66f61-ebbd-46e0-b223-b08ab9ba5ebc	5381	2025-01-15	2025-01-18	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
15	9de66f61-ec04-411b-a2f3-65ec930aad0a	5687	2025-01-19	2025-01-22	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
16	9de66f61-ec4c-4e2c-b892-888adbd930dc	5152	2025-01-23	2025-01-26	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
18	9de66f61-ecd8-4c33-aa35-de38b94212da	5722	2025-01-31	\N	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
19	9e28a0e6-0748-4e55-9f2d-925fa03be453	4564	2025-02-01	2025-02-04	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
20	9e28a0e6-0792-4a1e-8aa3-d70f36da6774	4864	2025-02-05	2025-02-10	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
21	9e28a0e6-07da-4574-8a1c-f571c078fadf	5298	2025-02-11	2025-02-14	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
22	9e28a0e6-0824-45d3-9550-f6fd25bb4e60	4949	2025-02-15	2025-02-19	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
23	9e28a0e6-086e-42fe-8306-fa8367860bfe	5315	2025-02-20	2025-02-24	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
24	9e28a0e6-08b7-4368-84af-706a763bd380	5607	2025-02-25	2025-03-02	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
25	9e28a0e6-0908-409f-afe2-4210dadfbeb9	5188	2025-03-03	2025-03-06	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
26	9e28a0e6-0954-4ae2-97ac-a0400dfbbc1b	5700	2025-03-07	2025-03-11	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
28	9f7b2b01-afd4-4ab0-b29a-1d72d6adb352	4616	2025-07-01	2025-07-06	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
29	9f7b2b01-b02b-45f3-a709-1de5a8b94190	5008	2025-07-07	2025-07-10	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
30	9f7b2b01-b079-40de-8d4f-1cf634be2803	5497	2025-07-11	2025-07-16	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
31	9f7b2b01-b0cc-4016-8422-492f1c333054	5209	2025-07-17	2025-07-20	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
32	9f7b2b01-b122-412f-8b60-87a9f28208f1	5641	2025-07-21	2025-07-26	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
33	9f7b2b01-b16e-412a-bf2a-a5293c573d0e	6033	2025-07-27	2025-08-01	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
34	9f7b2b01-b1df-4e1f-a460-6955723e3051	5694	2025-08-02	2025-08-05	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
35	9f7b2b01-b238-4712-bc9f-9a0c0f223ee7	6168	2025-08-06	2025-08-11	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
37	9fe75d7e-052d-43e8-9c47-0bc2026e2cfe	4627	2025-09-01	2025-09-06	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
38	9fe75d7e-057c-4bc5-99dc-db688f40d42a	4936	2025-09-07	2025-09-11	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
39	9fe75d7e-05d0-4c1c-b19f-7a31b46f5577	5309	2025-09-12	2025-09-16	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
40	9fe75d7e-0629-4867-a08b-1032c7fded3b	4913	2025-09-17	2025-09-21	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
41	9fe75d7e-067c-4b60-8134-40699491890f	5305	2025-09-22	2025-09-27	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
42	9fe75d7e-06d2-483b-8cbb-ef9d8b0dfd98	5827	2025-09-28	2025-10-03	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
43	9fe75d7e-0727-456d-baab-b539cd8ced85	5482	2025-10-04	2025-10-08	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
44	9fe75d7e-0776-41ce-937f-2e9824f06711	5865	2025-10-09	2025-10-13	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
45	9fe75d7e-07c6-44b5-97ce-3f4df2e497f3	6236	2025-10-14	\N	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
47	9cf72984-2ed8-4c37-864f-ebcc91be8477	5803	2024-09-14	2024-09-18	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
48	9cf72984-2f1d-4ab7-9241-f4ac9bfa797f	6157	2024-09-19	2024-09-22	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
49	9cf72984-2f64-4e74-a782-be43fe62620d	5700	2024-09-23	2024-09-28	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
50	9cf72984-2faa-41fd-9c94-ac6f0a936b7c	6109	2024-09-29	2024-10-03	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
51	9cf72984-2ff0-4524-b060-26adea0ed68a	6469	2024-10-04	2024-10-07	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
52	9cf72984-3036-433d-8737-45ba5fec90c1	6032	2024-10-08	2024-10-11	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
53	9cf72984-307c-478a-8935-207d50e43136	6522	2024-10-12	2024-10-16	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
54	9cf72984-30be-45e4-be20-5044d57fa10f	6862	2024-10-17	\N	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
55	9de66f61-fc5f-4296-a727-4f5fc0e3fdf4	5487	2024-12-25	2024-12-28	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
57	9de66f61-fcf4-4a58-a580-7a3268382ada	6340	2025-01-03	2025-01-06	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
58	9de66f61-fd43-4355-970f-3c05c838b948	5853	2025-01-07	2025-01-11	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
59	9de66f61-fd8b-448b-8c80-9b21afa048c1	6362	2025-01-12	2025-01-15	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
60	9de66f61-fdd5-465a-bec0-147510053596	6845	2025-01-16	2025-01-19	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
61	9de66f61-fe20-4050-ba0d-7c0e771838b7	6283	2025-01-20	2025-01-25	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
62	9de66f61-fe73-4411-a80f-d0c4687998a6	6802	2025-01-26	2025-01-30	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
63	9de66f61-feb4-4f25-844c-1b71867f4ddc	7477	2025-01-31	\N	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
64	9e28a0e6-1bfe-426f-9558-aef331bad5c1	5567	2025-02-01	2025-02-04	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
66	9e28a0e6-1c92-4c77-b478-1642e7f577e2	6507	2025-02-09	2025-02-14	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
67	9e28a0e6-1ce3-4a8e-b78c-71cc2302ed56	5941	2025-02-15	2025-02-19	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
68	9e28a0e6-1d2f-45bf-b2f9-278c1f7879d8	6305	2025-02-20	2025-02-25	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
69	9e28a0e6-1d91-4b2d-90c5-74442b58d1c9	6746	2025-02-26	2025-03-02	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
70	9e28a0e6-1df6-42ea-acbc-237758e16f33	6245	2025-03-03	2025-03-06	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
71	9e28a0e6-1e5b-437b-87a1-d55e1fa4784f	6695	2025-03-07	2025-03-12	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
72	9e28a0e6-1eb8-4bef-b781-7b246e3119ed	7203	2025-03-13	\N	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
73	9f7b2b01-c846-4d43-b696-7006fcd6e952	5405	2025-07-01	2025-07-04	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
74	9f7b2b01-c894-4b2a-90b6-8a58323919a7	5690	2025-07-05	2025-07-09	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
77	9f7b2b01-c990-4162-964e-8ccf01380be9	5842	2025-07-21	2025-07-25	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
78	9f7b2b01-c9da-4d9a-b3a6-a4717772acec	6174	2025-07-26	2025-07-29	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
79	9f7b2b01-ca32-4c1f-af7d-c8a13691e839	5643	2025-07-30	2025-08-04	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
80	9f7b2b01-ca85-499e-aa48-0a942960885c	5942	2025-08-05	2025-08-08	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
81	9f7b2b01-cad2-4245-a54e-6cfdc266ff58	6504	2025-08-09	\N	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
83	9fe75d7e-194a-4fb5-ab11-3bbc23138f2d	5685	2025-09-05	2025-09-10	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
84	9fe75d7e-1992-45b1-8313-9702a1c3a13b	5992	2025-09-11	2025-09-15	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
85	9fe75d7e-19db-444f-8261-83c9078b5ad2	5501	2025-09-16	2025-09-19	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
86	9fe75d7e-1a23-44aa-b14c-4ee9a4ae9eb5	5874	2025-09-20	2025-09-25	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
87	9fe75d7e-1a6b-4460-9e15-2c0f9110e02f	6409	2025-09-26	2025-09-30	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
88	9fe75d7e-1ab3-4637-81bb-1e3217cdeaa8	5957	2025-10-01	2025-10-06	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
89	9fe75d7e-1afc-47fe-bb8e-412217135e1e	6488	2025-10-07	2025-10-12	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
90	9fe75d7e-1b3d-4c0a-9f7d-1955220db89d	7033	2025-10-13	\N	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
91	9cf72984-23e6-48e9-a552-7d24e2cac794	869	2024-09-09	2024-09-13	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
93	9cf72984-2483-457f-acd9-8e34239b4adc	1021	2024-09-18	2024-09-21	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
94	9cf72984-24d3-4234-bb24-fd661035dfdc	957	2024-09-22	2024-09-25	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
95	9cf72984-2521-44d5-be64-6f3eb4d2b4ea	1016	2024-09-26	2024-10-01	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
96	9cf72984-2573-4164-9e2c-8004b4429375	1091	2024-10-02	2024-10-06	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
97	9cf72984-25c1-4f17-85ca-d3161e587432	998	2024-10-07	2024-10-10	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
98	9cf72984-260f-41ad-836b-097ede643cc4	1088	2024-10-11	2024-10-15	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
99	9cf72984-2658-4374-9c85-59b03b0c2047	1186	2024-10-16	\N	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
100	9de66f61-f22a-4ad1-9292-79e89844cbb5	868	2024-12-25	2024-12-30	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
101	9de66f61-f273-49bd-8319-a5cb196410ad	922	2024-12-31	2025-01-04	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
103	9de66f61-f302-490e-987f-01f8cd1a31c0	906	2025-01-10	2025-01-14	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
104	9de66f61-f34a-4625-af43-709ff60bc02e	984	2025-01-15	2025-01-20	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
105	9de66f61-f392-46d9-b673-668134b023ce	1051	2025-01-21	2025-01-24	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
106	9de66f61-f3d9-470c-9e81-d946fc946258	983	2025-01-25	2025-01-29	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
107	9de66f61-f420-4d55-9fee-0a295961caf7	1034	2025-01-30	2025-02-03	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
108	9e28a0e6-119d-4f71-95ff-8293d0e33aa5	847	2025-02-01	2025-02-04	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
109	9de66f61-f469-431d-a579-98a4d961ad19	1111	2025-02-04	\N	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
110	9e28a0e6-11e8-420e-b173-8daf835b3503	918	2025-02-05	2025-02-08	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
112	9e28a0e6-1282-4890-ac77-321ca259b176	922	2025-02-14	2025-02-18	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
113	9e28a0e6-12cc-4932-922c-e440b3c9a07b	978	2025-02-19	2025-02-23	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
114	9e28a0e6-1318-43a7-8ada-4fa0b482cbc9	1039	2025-02-24	2025-02-28	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
115	9e28a0e6-1363-4f5c-be5c-086e4b1fe5c2	985	2025-03-01	2025-03-05	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
116	9e28a0e6-13ae-4ab6-9a07-7b705328b84e	1034	2025-03-06	2025-03-11	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
117	9e28a0e6-13f0-4ec8-9d83-b9fa5f94ba79	1098	2025-03-12	\N	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
118	9f7b2b01-ba0a-4f40-9d13-11c51d3b98c0	844	2025-07-01	2025-07-06	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
119	9f7b2b01-ba8d-422b-9478-d4b58ebe6c61	896	2025-07-07	2025-07-12	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
120	9f7b2b01-bafa-4709-9004-8f4f09cb931f	951	2025-07-13	2025-07-18	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
122	9f7b2b01-bbca-49f2-afbb-2a066b6986c5	924	2025-07-24	2025-07-29	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
123	9f7b2b01-bc2d-4dae-b05e-2bcadaf4b9a1	975	2025-07-30	2025-08-03	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
124	9f7b2b01-bc8b-4f94-856f-1fe196d60b11	886	2025-08-04	2025-08-08	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
125	9f7b2b01-bcee-4ff1-96ff-b7ef996cbb04	972	2025-08-09	2025-08-14	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
126	9f7b2b01-bd48-4285-aa0c-7d5517bf363f	1052	2025-08-15	\N	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
127	9fe75d7e-0dfe-4e6f-b3d3-8e5582118a0d	848	2025-09-01	2025-09-04	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
128	9fe75d7e-0e46-4184-9c76-e29ec076bc0a	929	2025-09-05	2025-09-09	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
129	9fe75d7e-0e8e-40f6-a688-c164f4ef8efc	1004	2025-09-10	2025-09-13	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
130	9fe75d7e-0ed7-4bfe-aeda-ea3708d1856b	949	2025-09-14	2025-09-18	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
132	9fe75d7e-0f67-4980-b517-977d7406c996	1064	2025-09-25	2025-09-28	18	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
133	9fe75d7e-0faf-453c-83be-13e120f9e00f	964	2025-09-29	2025-10-04	18	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
134	9fe75d7e-0ff7-4ae3-9432-1692a0472d88	1045	2025-10-05	2025-10-09	18	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
135	9fe75d7e-103a-492d-8cdd-a4c9c3a101a4	1098	2025-10-10	\N	18	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
136	9cf72984-2962-4da8-8ac0-840de1797872	5064	2024-09-09	2024-09-14	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
137	9cf72984-29a9-4a6d-bb97-8dd8ff55baf8	5498	2024-09-15	2024-09-20	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
138	9cf72984-29f1-4708-9ee9-a44e9a103520	5786	2024-09-21	2024-09-26	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
139	9cf72984-2a3c-4102-83fa-604f98b7c6c2	5221	2024-09-27	2024-10-01	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
141	9cf72984-2ac9-43fa-9cf6-0f991ec3d189	6012	2024-10-07	2024-10-11	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
142	9cf72984-2b10-4c8c-87be-df937b731ccc	5688	2024-10-12	2024-10-15	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
143	9cf72984-2b57-482a-96b4-94f7ebcbe3d1	6247	2024-10-16	2024-10-20	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
144	9cf72984-2b98-4a22-b2f7-d923fc6ef531	6741	2024-10-21	\N	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
145	9de66f61-f73f-4ac7-bed0-b64b67284570	5056	2024-12-25	2024-12-29	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
146	9de66f61-f787-4ba3-80e4-2e88a72c15e1	5491	2024-12-30	2025-01-02	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
147	9de66f61-f7cf-4577-ae0f-9715e3984309	5822	2025-01-03	2025-01-08	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
148	9de66f61-f81e-4cfa-8541-d8db68280652	5414	2025-01-09	2025-01-12	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
149	9de66f61-f867-4f03-bb09-269628fdff71	5808	2025-01-13	2025-01-17	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
152	9de66f61-f944-472f-913e-da949696f69d	6300	2025-01-28	2025-01-31	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
153	9de66f61-f987-45ac-90d7-e63b9a093fcf	6880	2025-02-01	\N	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
154	9e28a0e6-16d2-49b1-bce8-a7c29f518a41	5174	2025-02-01	2025-02-06	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
155	9e28a0e6-171b-4d83-a142-c29382f26420	5618	2025-02-07	2025-02-12	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
156	9e28a0e6-1762-46f3-9774-ce7eeebaf98a	6118	2025-02-13	2025-02-17	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
158	9e28a0e6-17f2-411d-9939-0359c918ea1c	6070	2025-02-22	2025-02-26	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
159	9e28a0e6-183c-4a76-8edd-89ff41cc503b	6583	2025-02-27	2025-03-04	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
160	9e28a0e6-1885-475e-91f4-fd13233d6a28	6144	2025-03-05	2025-03-09	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
161	9e28a0e6-18d2-43d9-8cdb-3435b30f7edc	6551	2025-03-10	2025-03-15	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
162	9e28a0e6-1916-438f-b9d5-3f0db0fe2b30	7038	2025-03-16	\N	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
163	9f7b2b01-c1f2-404c-9567-cf278c13e539	5093	2025-07-01	2025-07-04	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
164	9f7b2b01-c25f-4b6d-9ace-cdf30ec8084f	5531	2025-07-05	2025-07-10	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
165	9f7b2b01-c2c9-44d7-b87f-3d1f6f5a03cd	5925	2025-07-11	2025-07-16	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
166	9f7b2b01-c332-49c1-b92c-1bd72d49a45d	5394	2025-07-17	2025-07-20	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
168	9f7b2b01-c409-44f9-8b65-222c2c1d0671	6323	2025-07-25	2025-07-30	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
169	9f7b2b01-c464-44f8-b371-d6a6ff98e4fd	5866	2025-07-31	2025-08-04	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
170	9f7b2b01-c4ba-47aa-a760-4925e2d5e734	6345	2025-08-05	2025-08-09	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
171	9f7b2b01-c508-4187-9c2c-16d70b414300	6922	2025-08-10	\N	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
172	9fe75d7e-1370-4635-86cf-3d55326e8ab0	5109	2025-09-01	2025-09-04	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
173	9fe75d7e-13ca-4a05-98ae-f4fce4b0b9d6	5498	2025-09-05	2025-09-08	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
174	9fe75d7e-141d-478a-9794-91f290a4fd85	5996	2025-09-09	2025-09-14	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
175	9fe75d7e-146b-43aa-bd0e-55edc12eb240	5685	2025-09-15	2025-09-18	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
176	9fe75d7e-14bb-4d1e-a246-c4c4a7fff4c5	5971	2025-09-19	2025-09-24	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
178	9fe75d7e-1573-4666-b473-84e17f6e10b9	6017	2025-09-30	2025-10-04	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
179	9fe75d7e-15cd-48f0-96e0-d33c4ce5dffd	6344	2025-10-05	2025-10-08	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
180	9fe75d7e-1617-45de-927e-f296645780b7	6900	2025-10-09	\N	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
181	9cf72984-0b40-4d35-9c70-741ec62eaf92	14289	2024-09-09	2024-09-12	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
182	9cf72984-0b8e-4216-b8c2-c06a58be9a8a	15267	2024-09-13	2024-09-17	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
183	9cf72984-0bdd-438f-8067-f7487a4433ab	16585	2024-09-18	2024-09-23	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
184	9cf72984-0c2a-40cf-b159-0ab67722d31f	15479	2024-09-24	2024-09-28	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
185	9cf72984-0c78-4d76-8195-57a06b3e661f	16315	2024-09-29	2024-10-02	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
187	9cf72984-0d13-4dbe-ba5d-5301b5b2bad0	16213	2024-10-09	2024-10-14	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
188	9cf72984-0d61-4ea5-8977-de8edbc04732	17175	2024-10-15	2024-10-18	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
189	9cf72984-0da8-4b48-ace5-ba226e581298	18332	2024-10-19	\N	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
190	9de66f61-dace-46c8-895a-56e0932591f9	14217	2024-12-25	2024-12-28	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
191	9de66f61-db17-4f97-ac01-786ff5cdda34	15515	2024-12-29	2025-01-03	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
192	9de66f61-db60-4c3e-a10d-5c3fca43966a	16921	2025-01-04	2025-01-08	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
193	9de66f61-dbab-4ba0-9254-cf13ab86c177	15821	2025-01-09	2025-01-13	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
194	9de66f61-dbf4-4b22-b28e-7909b989e0ad	16926	2025-01-14	2025-01-18	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
195	9de66f61-dc3f-4b73-a595-aa7dce9c5d1b	17785	2025-01-19	2025-01-24	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
197	9de66f61-dcce-4998-b22d-287bcda24e2d	18144	2025-01-29	2025-02-01	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
198	9e28a0e5-f74c-43b6-804a-068a21b47075	14634	2025-02-01	2025-02-06	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
199	9de66f61-dd11-41b3-9b50-9de32c1ff5ea	19841	2025-02-02	\N	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
200	9e28a0e5-f79c-4202-9db7-00bd78d9592f	15642	2025-02-07	2025-02-10	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
201	9e28a0e5-f7e9-4c5e-bb19-e54b2cf4e7c6	16874	2025-02-11	2025-02-16	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
202	9e28a0e5-f836-42e1-95e3-c8ee3e8315d3	15455	2025-02-17	2025-02-22	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
203	9e28a0e5-f885-4a37-bf74-49729463d5aa	16979	2025-02-23	2025-02-26	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
204	9e28a0e5-f8d3-44e2-8d7f-f1384516d26a	18227	2025-02-27	2025-03-03	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
205	9e28a0e5-f920-419b-af62-a462436ab9f3	16893	2025-03-04	2025-03-09	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
207	9e28a0e5-f9c1-4668-9413-009eb1fe63f6	20000	2025-03-15	\N	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
208	9f7b2b01-7638-457e-a714-1d46ebaea2c2	14802	2025-07-01	2025-07-06	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
209	9f7b2b01-76c1-490a-bbd9-a81efd9f5bb2	15911	2025-07-07	2025-07-10	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
210	9f7b2b01-773c-4139-8a71-82c19df66e50	17082	2025-07-11	2025-07-16	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
211	9f7b2b01-77b6-43a9-8135-3c93700587d3	15513	2025-07-17	2025-07-22	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
212	9f7b2b01-7828-4cc1-859d-9d5ab998c2a1	16515	2025-07-23	2025-07-28	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
213	9f7b2b01-78a2-4852-8275-28f3b3645df9	17904	2025-07-29	2025-08-03	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
214	9f7b2b01-7925-4fbb-a08f-26b3160f2df0	16292	2025-08-04	2025-08-08	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
216	9f7b2b01-7a01-4e62-be88-6d14ba9ea120	19385	2025-08-14	\N	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
217	9fe75d7d-f582-47b5-8c0e-200e51ad76b2	14477	2025-09-01	2025-09-04	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
218	9fe75d7d-f5cb-46a6-a220-5807962e9be4	15332	2025-09-05	2025-09-09	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
219	9fe75d7d-f615-46d5-81d0-8f6b039106bb	16677	2025-09-10	2025-09-15	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
220	9fe75d7d-f65d-4f71-a4a6-78796a660a86	15169	2025-09-16	2025-09-19	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
221	9fe75d7d-f6b8-42e2-90a1-8249b0aee867	16184	2025-09-20	2025-09-23	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
222	9fe75d7d-f702-45ea-bd25-629398d9b493	17635	2025-09-24	2025-09-29	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
223	9fe75d7d-f74b-4d46-9409-f0dc59b36691	16715	2025-09-30	2025-10-04	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
224	9fe75d7d-f794-4eb4-b017-f65256247bd2	18201	2025-10-05	2025-10-10	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
227	9cf72984-1eaf-4d03-ad9f-77d1f251d43a	6970	2024-09-15	2024-09-18	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
228	9cf72984-1efe-47df-ac1f-4dd6430a509d	7373	2024-09-19	2024-09-22	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
229	9cf72984-1f4d-457a-a4d7-cccadf398c00	6919	2024-09-23	2024-09-26	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
230	9cf72984-1f9b-4bb8-b29f-eaf017ced998	7397	2024-09-27	2024-09-30	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
231	9cf72984-1fea-4699-8f25-c276866d379b	7976	2024-10-01	2024-10-04	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
233	9cf72984-2085-4343-85da-780d9e86ffe6	7589	2024-10-11	2024-10-16	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
234	9cf72984-20cd-4278-a822-fb57ace2385d	8061	2024-10-17	\N	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
235	9de66f61-ed1f-4728-a025-db8dc46e854a	6431	2024-12-25	2024-12-30	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
236	9de66f61-ed67-4ecb-bc22-015186bbdaf9	6996	2024-12-31	2025-01-04	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
237	9de66f61-edb0-4ad1-ac42-5ec7ad5d8f7a	7476	2025-01-05	2025-01-10	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
238	9de66f61-edf7-401d-a1f2-57208aaee2b4	7049	2025-01-11	2025-01-14	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
239	9de66f61-ee3f-4a65-9ad1-a91503cbfd43	7723	2025-01-15	2025-01-20	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
240	9de66f61-ee86-4ec8-85a9-e9494416d9b5	8450	2025-01-21	2025-01-25	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
241	9de66f61-eece-42fc-9366-d5ca5d6c30e7	8011	2025-01-26	2025-01-30	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
243	9e28a0e6-09e1-4e13-b856-a1045d3732f5	6638	2025-02-01	2025-02-06	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
244	9de66f61-ef58-4e9c-9783-5a36f355a750	9448	2025-02-05	\N	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
245	9e28a0e6-0a2d-4034-9db3-262a1dc7eeba	7201	2025-02-07	2025-02-10	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
246	9e28a0e6-0a77-43a3-9eb8-b103f9339b44	7763	2025-02-11	2025-02-14	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
247	9e28a0e6-0ac2-4e68-9860-178ce1330b0d	7212	2025-02-15	2025-02-19	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
248	9e28a0e6-0b0a-4b76-a00b-413e727a2171	7856	2025-02-20	2025-02-25	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
249	9e28a0e6-0b54-4606-8baa-9e074724c327	8529	2025-02-26	2025-03-02	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
250	9e28a0e6-0b9d-40d1-98dd-d17c29bd2f8a	7678	2025-03-03	2025-03-06	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
251	9e28a0e6-0be7-4e28-a14a-ba7fc6e14ef7	8440	2025-03-07	2025-03-12	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
253	9f7b2b01-b2db-4eeb-9ac2-8536f120e51f	6561	2025-07-01	2025-07-05	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
254	9f7b2b01-b33a-4b26-b850-81eacdb2907f	6910	2025-07-06	2025-07-10	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
255	9f7b2b01-b386-47ca-a390-1e06b603dd18	7450	2025-07-11	2025-07-16	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
256	9f7b2b01-b3d6-4dd0-8aab-2994ade8d3df	6979	2025-07-17	2025-07-20	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
257	9f7b2b01-b429-4dec-94b4-cbe721e80594	7378	2025-07-21	2025-07-24	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
258	9f7b2b01-b47a-4bb8-846a-89db042ee0c6	8097	2025-07-25	2025-07-29	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
259	9f7b2b01-b4d2-4038-b27a-28cc00bc3b98	7440	2025-07-30	2025-08-04	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
260	9f7b2b01-b52d-4763-9c90-9f080ef09aab	8043	2025-08-05	2025-08-10	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
262	9fe75d7e-081c-47e6-ae23-9420e2a797f8	6485	2025-09-01	2025-09-05	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
263	9fe75d7e-0875-4397-a707-c3f90d390791	6949	2025-09-06	2025-09-11	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
264	9fe75d7e-08d6-496a-9335-1b668cb0de4b	7371	2025-09-12	2025-09-17	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
265	9fe75d7e-0925-441a-a7eb-72b585208fc7	6947	2025-09-18	2025-09-21	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
266	9fe75d7e-0970-4aa0-9d91-83bb70e226a7	7582	2025-09-22	2025-09-25	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
267	9fe75d7e-09bb-4468-868f-b8054ff63a55	8283	2025-09-26	2025-09-29	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
268	9fe75d7e-0a06-4e20-9bc9-77e4c20aff71	7713	2025-09-30	2025-10-05	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
269	9fe75d7e-0a56-4b0a-9223-02a5b3536ed3	8298	2025-10-06	2025-10-11	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
270	9fe75d7e-0a9e-4ce2-a70a-81a3613d96b9	8867	2025-10-12	\N	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
272	9cf72984-13b7-4b6b-9047-b97b1c3d6080	4772	2024-09-15	2024-09-19	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
273	9cf72984-1407-41be-aa41-005f777ebfbb	5248	2024-09-20	2024-09-24	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
274	9cf72984-145a-4936-9b45-420b551979b8	4809	2024-09-25	2024-09-28	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
275	9cf72984-14a9-4f46-9fb0-e87290c087d3	5053	2024-09-29	2024-10-03	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
276	9cf72984-14f7-41b1-816e-33755976727b	5425	2024-10-04	2024-10-08	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
277	9cf72984-1547-4586-9ce0-12eb21800af5	4974	2024-10-09	2024-10-12	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
278	9cf72984-1595-4468-8756-becc48c3633d	5449	2024-10-13	2024-10-18	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
279	9cf72984-15de-4b07-b418-2b8eb90a927b	5937	2024-10-19	\N	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
280	9de66f61-e29c-497a-8a7e-7bae0981e764	4349	2024-12-25	2024-12-30	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
282	9de66f61-e331-4e1c-9862-61cdd42490ac	5111	2025-01-04	2025-01-09	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
283	9de66f61-e37e-4d7d-8cde-e8921f8515c2	4807	2025-01-10	2025-01-14	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
284	9de66f61-e3ca-4c3f-ae24-7c00ece44049	5256	2025-01-15	2025-01-19	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
285	9de66f61-e411-49db-ac47-9385d3bce065	5697	2025-01-20	2025-01-25	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
286	9de66f61-e459-435b-8b55-c613e58db946	5214	2025-01-26	2025-01-31	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
287	9de66f61-e4a0-4f02-9288-f48f1e94358d	5533	2025-02-01	2025-02-05	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
288	9e28a0e5-ff7a-4113-bd2f-069b63e86834	4523	2025-02-01	2025-02-04	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
289	9e28a0e5-ffc7-4f08-9311-eff2032bd601	4834	2025-02-05	2025-02-10	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
291	9e28a0e6-0010-4923-be86-dc9011bdbaa0	5159	2025-02-11	2025-02-16	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
292	9e28a0e6-005b-4a12-85d9-21b38a38742b	4688	2025-02-17	2025-02-21	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
293	9e28a0e6-00a6-4118-98af-ba11b35b0a29	5073	2025-02-22	2025-02-27	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
294	9e28a0e6-00f0-4fc2-866b-82ede3268f6f	5565	2025-02-28	2025-03-04	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
295	9e28a0e6-013d-4c1a-8e95-01375693d541	5127	2025-03-05	2025-03-08	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
296	9e28a0e6-0189-4596-ab5d-e47394b0533a	5520	2025-03-09	2025-03-14	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
297	9e28a0e6-01cd-49a7-b521-30eed8fffc59	6000	2025-03-15	\N	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
298	9f7b2b01-82d2-4c53-9f29-bcee9ee7583d	4400	2025-07-01	2025-07-04	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
299	9f7b2b01-8348-4a1e-abee-eceba028d6ce	4827	2025-07-05	2025-07-08	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
302	9f7b2b01-8496-4589-ba04-46c186e5a14a	5136	2025-07-17	2025-07-21	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
303	9f7b2b01-a817-4340-a6d4-4b612204c2df	5457	2025-07-22	2025-07-25	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
304	9f7b2b01-a8a6-4dab-ad80-79de7699a937	5155	2025-07-26	2025-07-29	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
305	9f7b2b01-a91e-4dea-9c49-f98f6f662bb5	5662	2025-07-30	2025-08-02	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
306	9f7b2b01-a988-43a7-83eb-f4a3410589d7	6108	2025-08-03	\N	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
308	9fe75d7d-fd83-4571-9f1b-144d51e485aa	4888	2025-09-05	2025-09-09	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
309	9fe75d7d-fdce-4c94-abb9-accf8aac03ac	5203	2025-09-10	2025-09-15	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
310	9fe75d7d-fe17-4480-a30e-9e1ece863c07	4759	2025-09-16	2025-09-21	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
311	9fe75d7d-fe6c-407b-aaf2-92771e7e957f	5117	2025-09-22	2025-09-27	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
312	9fe75d7d-feb4-42bb-a3de-bbcbee3686d7	5503	2025-09-28	2025-10-03	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
313	9fe75d7d-fefd-4571-883a-24865dcb3144	4981	2025-10-04	2025-10-07	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
314	9fe75d7d-ff46-4a02-9cf2-6779eb2dbb62	5379	2025-10-08	2025-10-12	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
315	9fe75d7d-ff88-4e49-8d6d-5cdb4c90b83b	5818	2025-10-13	\N	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
316	9cf72984-18e8-47a5-8d94-feaff255f059	2081	2024-09-09	2024-09-12	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
318	9cf72984-1986-4e64-8803-77c69bd484a0	2341	2024-09-18	2024-09-23	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
319	9cf72984-19d4-44c0-a12e-a0138ba8fc79	2134	2024-09-24	2024-09-27	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
320	9cf72984-1a23-4047-90b6-922be0f3e822	2254	2024-09-28	2024-10-02	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
321	9cf72984-1a74-49fb-a85b-6fcaa1144351	2416	2024-10-03	2024-10-08	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
322	9cf72984-1ac2-44ba-bb1c-cce9ff808c28	2178	2024-10-09	2024-10-13	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
323	9cf72984-1b10-48c1-b288-999455f9d13a	2348	2024-10-14	2024-10-18	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
324	9cf72984-1b58-4857-84dc-d37c2e73b229	2559	2024-10-19	\N	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
325	9de66f61-e80c-40d2-8396-3bd93a017c03	2069	2024-12-25	2024-12-28	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
326	9de66f61-e859-4da4-a267-029cd16808ec	2274	2024-12-29	2025-01-02	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
328	9de66f61-e8e9-4db5-b442-6991ea07c4a2	2290	2025-01-09	2025-01-12	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
329	9de66f61-e932-44ac-883b-b687987cc907	2451	2025-01-13	2025-01-18	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
330	9de66f61-e97f-469a-b409-231427eef1fd	2662	2025-01-19	2025-01-24	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
331	9de66f61-e9c9-4892-8943-5be78a615a6e	2526	2025-01-25	2025-01-30	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
332	9de66f61-ea10-49e3-9606-0864aba44f31	2707	2025-01-31	2025-02-03	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
333	9e28a0e6-04aa-4c00-9e58-c87318317675	2093	2025-02-01	2025-02-06	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
334	9de66f61-ea53-4533-aa24-f4a782626d0b	2930	2025-02-04	\N	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
335	9e28a0e6-04f5-4708-be4a-5aa4c10918dc	2291	2025-02-07	2025-02-12	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
337	9e28a0e6-058e-41d7-b198-2b10a1f4ec79	2189	2025-02-19	2025-02-24	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
338	9e28a0e6-05d9-4056-b4e4-84e37f28da49	2317	2025-02-25	2025-03-01	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
339	9e28a0e6-0624-410d-999a-18a3bc6a21b5	2514	2025-03-02	2025-03-07	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
340	9e28a0e6-0670-4161-90c5-90449bafccb1	2347	2025-03-08	2025-03-12	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
341	9e28a0e6-06b9-4620-9cd8-3fe2ea3c4a9c	2481	2025-03-13	2025-03-18	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
342	9e28a0e6-06fd-4ced-a83b-8be623859282	2711	2025-03-19	\N	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
343	9f7b2b01-ad0b-4633-a708-1b0a60c3b6bd	2066	2025-07-01	2025-07-04	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
344	9f7b2b01-ad59-4f88-a644-d0faf326d1d1	2202	2025-07-05	2025-07-10	23	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
345	9f7b2b01-ada8-419e-932a-04bdd41f876e	2346	2025-07-11	2025-07-16	23	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
347	9f7b2b01-ae4e-4b61-9189-370f98706580	2334	2025-07-21	2025-07-26	23	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
348	9f7b2b01-ae9d-4972-b9f1-8c9aaa3e19fd	2516	2025-07-27	2025-08-01	23	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
349	9f7b2b01-aeea-4e3b-8ed7-93332d9e11ab	2322	2025-08-02	2025-08-06	23	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
350	9f7b2b01-af39-4e3d-bafe-a4e7a5797da1	2524	2025-08-07	2025-08-12	23	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
351	9f7b2b01-af84-47f9-b6b5-ebc09e7f8fb7	2654	2025-08-13	\N	23	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
352	9fe75d7e-0268-4416-80da-7479ae89f8fb	2024	2025-09-01	2025-09-05	23	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
353	9fe75d7e-02b0-46a9-b35a-65ba2293fd13	2133	2025-09-06	2025-09-11	23	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
354	9fe75d7e-02f8-4e03-af0a-dbba2506f371	2261	2025-09-12	2025-09-15	23	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
355	9fe75d7e-0341-4457-b6d6-2670cc49f359	2053	2025-09-16	2025-09-20	23	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
357	9fe75d7e-03de-4295-8d1d-4136dbfe394c	2391	2025-09-27	2025-09-30	23	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
358	9fe75d7e-0433-404e-82cf-50c8ed67cf6d	2156	2025-10-01	2025-10-06	23	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
359	9fe75d7e-048d-4009-9495-8064b1a5c185	2369	2025-10-07	2025-10-10	23	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
360	9fe75d7e-04dc-4a90-ab43-04e254aaae24	2593	2025-10-11	\N	23	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
361	9cf72984-211b-48e6-8964-43dfd76f2aa3	2596	2024-09-09	2024-09-12	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
362	9cf72984-2168-4835-b4b3-4b36aadac5ed	2853	2024-09-13	2024-09-17	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
363	9cf72984-21b4-4edf-bbf9-665306e41ede	3049	2024-09-18	2024-09-21	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
364	9cf72984-2201-4c70-b9f2-ca525415611c	2804	2024-09-22	2024-09-27	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
366	9cf72984-229c-4483-9c5d-9d7d7901e111	3280	2024-10-02	2024-10-05	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
367	9cf72984-22e9-47af-a1ad-d5d76cfd47aa	2987	2024-10-06	2024-10-09	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
368	9cf72984-2338-4678-99dd-b6026259b5e5	3171	2024-10-10	2024-10-13	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
369	9cf72984-2380-4ddb-b352-abec6e70df2a	3414	2024-10-14	\N	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
370	9de66f61-efa3-406b-8dee-d71a78128953	2592	2024-12-25	2024-12-29	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
371	9de66f61-efec-4e8a-9092-b84bc692602d	2780	2024-12-30	2025-01-03	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
372	9de66f61-f034-4535-95b0-2295866673e1	3054	2025-01-04	2025-01-07	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
373	9de66f61-f07c-4578-9502-1fc375f42bbf	2755	2025-01-08	2025-01-12	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
374	9de66f61-f0c5-4be3-a9c8-6396a9402ad0	2937	2025-01-13	2025-01-18	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
377	9de66f61-f19f-493d-b3a1-cbd979b2f359	3138	2025-01-30	2025-02-04	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
378	9e28a0e6-0c72-4d62-a4f6-c91912c2f0bb	2594	2025-02-01	2025-02-05	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
379	9de66f61-f1e1-45df-bf77-c738ca5e7a0e	3369	2025-02-05	\N	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
380	9e28a0e6-0cbb-451b-86f0-954dae7046c7	2850	2025-02-06	2025-02-10	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
381	9e28a0e6-0d05-4fd5-a514-a76b3153e5d7	3073	2025-02-11	2025-02-16	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
383	9e28a0e6-0d9e-4633-9eab-60e57d0a2c20	2979	2025-02-22	2025-02-27	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
384	9e28a0e6-0de7-4bcc-b940-603ae184b7eb	3249	2025-02-28	2025-03-03	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
385	9e28a0e6-10b9-45d4-b5af-3db144819c5e	3064	2025-03-04	2025-03-07	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
386	9e28a0e6-110a-4d25-bd4b-c696ff520efc	3308	2025-03-08	2025-03-13	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
387	9e28a0e6-1153-45f1-8674-708660fa440c	3511	2025-03-14	\N	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
388	9f7b2b01-b5d9-4ae1-b46f-f71ca8621bb7	2568	2025-07-01	2025-07-04	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
389	9f7b2b01-b634-41f1-bb8d-170c5cf0582b	2714	2025-07-05	2025-07-09	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
390	9f7b2b01-b699-42ff-bb88-8f0a9ba2d469	2918	2025-07-10	2025-07-15	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
391	9f7b2b01-b6fd-4ce6-9e1c-87d8e24d67c5	2733	2025-07-16	2025-07-19	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
393	9f7b2b01-b7df-4e5d-8eb2-8b20267130dc	3145	2025-07-24	2025-07-29	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
394	9f7b2b01-b86d-46c4-9801-c5dfcd7ef0a1	2926	2025-07-30	2025-08-04	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
395	9f7b2b01-b8f4-44c1-8063-8a439cfe165b	3128	2025-08-05	2025-08-08	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
396	9f7b2b01-b967-456f-afaf-c491bd13d5be	3403	2025-08-09	\N	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
397	9fe75d7e-0ae8-4e2c-8cc7-9ee7bbece7ca	2595	2025-09-01	2025-09-06	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
398	9fe75d7e-0b32-4867-9017-17a801f010a9	2729	2025-09-07	2025-09-10	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
399	9fe75d7e-0b7b-4169-bdfe-b4b6e748070b	2975	2025-09-11	2025-09-14	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
400	9fe75d7e-0c3e-4e39-9d43-f15011f09f10	2801	2025-09-15	2025-09-18	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
401	9fe75d7e-0c8a-454b-8f70-58b94337c0fe	3032	2025-09-19	2025-09-22	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
403	9fe75d7e-0d24-4b05-b50f-10803e036d15	3032	2025-09-27	2025-10-02	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
404	9fe75d7e-0d71-4995-88dc-d9934d0fd6ce	3192	2025-10-03	2025-10-07	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
405	9fe75d7e-0db5-4efc-8a45-f75c716c9e19	3397	2025-10-08	\N	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
406	9cf72984-26a7-4bdc-bb77-6338beb7036a	5466	2024-09-09	2024-09-14	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
407	9cf72984-26f7-4b3d-8678-4c923250c1ee	5825	2024-09-15	2024-09-19	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
408	9cf72984-2746-443c-bcc5-61b532fc00bb	6335	2024-09-20	2024-09-25	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
409	9cf72984-2794-4632-8af3-859ba315a7c3	5973	2024-09-26	2024-10-01	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
410	9cf72984-27e3-4caf-9126-1ef1dd65c6a3	6530	2024-10-02	2024-10-06	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
412	9cf72984-287e-4375-ba42-5a43dc404249	6598	2024-10-12	2024-10-16	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
413	9cf72984-28d6-421d-90ec-1b5f6f31247b	7059	2024-10-17	2024-10-20	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
414	9cf72984-291a-4f12-b492-b3f435af467f	7552	2024-10-21	\N	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
415	9de66f61-f4b4-4196-b148-2a879d08cfaf	5354	2024-12-25	2024-12-30	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
416	9de66f61-f4fc-427d-b2ed-206916ee2155	5624	2024-12-31	2025-01-05	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
417	9de66f61-f544-4ec2-bfa1-edb78d029009	6065	2025-01-06	2025-01-10	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
418	9de66f61-f58f-4b1e-86cd-ef35b835fdb8	5620	2025-01-11	2025-01-15	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
419	9de66f61-f5d8-4338-8b6f-0e0a805aabc0	6052	2025-01-16	2025-01-19	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
420	9de66f61-f621-43ea-9f57-bab00163c3be	6595	2025-01-20	2025-01-25	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
422	9de66f61-f6b4-4f45-b2a2-8a3cb2d4109a	6593	2025-01-31	2025-02-04	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
423	9e28a0e6-1439-40ef-a283-c75e38387a09	5388	2025-02-01	2025-02-05	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
424	9de66f61-f6f7-4615-b732-12862b2ca300	7205	2025-02-05	\N	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
425	9e28a0e6-1482-4208-9103-ea3187630ee0	5738	2025-02-06	2025-02-11	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
426	9e28a0e6-14cd-4b10-b09e-4231d4d145b1	6254	2025-02-12	2025-02-15	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
427	9e28a0e6-1518-4e53-b219-211673bf694a	5922	2025-02-16	2025-02-19	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
428	9e28a0e6-1561-4280-ab61-29c91b94e32f	6294	2025-02-20	2025-02-25	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
429	9e28a0e6-15ab-4007-87a2-adf012b6ccc1	6886	2025-02-26	2025-03-01	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
430	9e28a0e6-15f8-491e-9563-99d3a9a38a77	6304	2025-03-02	2025-03-05	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
432	9e28a0e6-1688-436f-9f7a-3d9f9652e333	7432	2025-03-11	\N	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
433	9f7b2b01-bdd7-4119-b37f-b1481a2228f2	5402	2025-07-01	2025-07-04	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
434	9f7b2b01-be77-4a5e-aa0d-f83c3263cf15	5838	2025-07-05	2025-07-08	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
435	9f7b2b01-beea-4c5f-b8a8-e51821542072	6277	2025-07-09	2025-07-12	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
436	9f7b2b01-bf55-4d02-a969-21805aa291c5	5787	2025-07-13	2025-07-16	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
437	9f7b2b01-bfd4-40da-9509-e275b79a18c5	6133	2025-07-17	2025-07-22	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
438	9f7b2b01-c048-4f90-9c34-cd7b4941e1a6	6475	2025-07-23	2025-07-26	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
439	9f7b2b01-c0b6-4a3e-91ad-e39018f30100	5859	2025-07-27	2025-07-30	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
441	9f7b2b01-c185-449d-8494-957d915e16d8	6783	2025-08-06	\N	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
442	9fe75d7e-1085-44dc-8e53-93bafd107629	5298	2025-09-01	2025-09-04	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
443	9fe75d7e-10cf-475c-8f40-473f032c05a2	5617	2025-09-05	2025-09-09	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
444	9fe75d7e-111a-4c8f-bcc5-04e60cd0bf4a	6114	2025-09-10	2025-09-15	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
445	9fe75d7e-1163-4ee3-bd09-09dc8057ebee	5591	2025-09-16	2025-09-21	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
446	9fe75d7e-11ac-4897-be9c-042bab3a27f6	5976	2025-09-22	2025-09-27	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
447	9fe75d7e-11f6-4663-9ccf-57b9fafc4a67	6563	2025-09-28	2025-10-03	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
448	9fe75d7e-1254-4166-b471-4ea4e9133c8b	6122	2025-10-04	2025-10-08	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
449	9fe75d7e-12c2-4a7d-a130-3a786d7a375e	6692	2025-10-09	2025-10-14	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
452	9cf72984-08b3-42b6-8c74-0de73ea4db18	561	2024-09-15	2024-09-19	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
453	9cf72984-090c-46e3-9673-e07325b68954	600	2024-09-20	2024-09-23	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
454	9cf72984-0962-44a9-8d41-93439298d05e	558	2024-09-24	2024-09-29	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
455	9cf72984-09b6-4aae-826e-f7fab05e396e	608	2024-09-30	2024-10-05	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
456	9cf72984-0a08-4d17-9f36-28b63ce77075	647	2024-10-06	2024-10-10	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
458	9cf72984-0aaa-41bb-b19c-d65873bdd333	621	2024-10-16	2024-10-20	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
459	9cf72984-0af2-41ab-a8f1-ad9cd67d48d7	670	2024-10-21	\N	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
460	9de66f61-a639-4651-8407-097c7db3cef7	547	2024-12-25	2024-12-30	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
461	9de66f61-d845-44ee-aa2d-5aaa3e62d259	595	2024-12-31	2025-01-05	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
462	9de66f61-d8b4-49a9-b601-d43129047f80	651	2025-01-06	2025-01-11	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
463	9de66f61-d90a-4c63-ba8f-b9f81a1554a9	617	2025-01-12	2025-01-15	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
464	9de66f61-d959-4ea0-878e-a61a7a4c4359	648	2025-01-16	2025-01-20	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
465	9de66f61-d9a6-435e-bb8a-b13d949ed7c5	707	2025-01-21	2025-01-25	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
466	9de66f61-d9f7-4f98-a798-cfd545a76b3e	659	2025-01-26	2025-01-31	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
468	9de66f61-da40-458a-b17f-349ea98eb730	708	2025-02-01	2025-02-06	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
469	9de66f61-da84-4b24-a4f8-359701c5162a	743	2025-02-07	\N	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
470	9e28a0e5-f499-4d76-a1a9-ed52544433b6	582	2025-02-07	2025-02-11	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
471	9e28a0e5-f502-4cc7-8168-ddf6d57855ac	618	2025-02-12	2025-02-17	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
472	9e28a0e5-f556-464e-aa50-445afbfcb5c9	567	2025-02-18	2025-02-23	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
473	9e28a0e5-f5ad-44bd-86a5-595f274c9154	599	2025-02-24	2025-02-27	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
474	9e28a0e5-f605-4ec5-8374-2e94f6d7bd8a	636	2025-02-28	2025-03-03	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
475	9e28a0e5-f658-422a-928c-f74463ee1cdf	583	2025-03-04	2025-03-08	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
476	9e28a0e5-f6ad-40e2-bb5a-9d5fcda037d8	614	2025-03-09	2025-03-13	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
478	9f7b2b01-403c-4fee-95b7-3d48f87c41e2	529	2025-07-01	2025-07-06	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
479	9f7b2b01-71e4-4b29-b22b-8a78c7e9d80c	575	2025-07-07	2025-07-11	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
480	9f7b2b01-727e-4ae0-af54-42945726bace	626	2025-07-12	2025-07-15	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
481	9f7b2b01-72fc-40b6-ac0d-e30f7d52ef68	580	2025-07-16	2025-07-19	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
482	9f7b2b01-738f-4fc8-8dd1-30c104fe6ed1	624	2025-07-20	2025-07-25	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
483	9f7b2b01-741a-4e7c-a4f6-ccb0f3a8a680	664	2025-07-26	2025-07-29	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
484	9f7b2b01-74ab-47a6-8c1b-3567fc910458	615	2025-07-30	2025-08-02	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
485	9f7b2b01-7532-4e39-be2a-c123bdc50a94	649	2025-08-03	2025-08-06	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
487	9fe75d7d-e174-41f1-b376-241686d46abf	526	2025-09-01	2025-09-05	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
488	9fe75d7d-f2e6-43fe-9b92-0a5e60ab6d2a	557	2025-09-06	2025-09-10	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
489	9fe75d7d-f35b-41fb-82fd-278ec3231026	594	2025-09-11	2025-09-16	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
490	9fe75d7d-f3b2-4b20-a2d2-39a44b2a4bd6	535	2025-09-17	2025-09-21	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
491	9fe75d7d-f407-4c2e-8aec-de0cfdefb97f	561	2025-09-22	2025-09-27	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
492	9fe75d7d-f458-415d-96f9-e9e29d2c7e9b	607	2025-09-28	2025-10-01	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
493	9fe75d7d-f4a7-4b1d-8f75-b4dbab2be3d8	567	2025-10-02	2025-10-06	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
494	9fe75d7d-f4f5-469b-8b89-de83620683f7	615	2025-10-07	2025-10-11	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
495	9fe75d7d-f538-423e-b5af-ecf9fd38263b	676	2025-10-12	\N	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
497	9cf72984-10ff-4df1-970c-7d145b94ba47	136	2024-09-14	2024-09-18	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
498	9cf72984-114d-4533-93c3-8a51b3793d47	143	2024-09-19	2024-09-23	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
499	9cf72984-119a-4651-9131-57962158f235	129	2024-09-24	2024-09-29	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
500	9cf72984-11e8-4b5b-914a-b1a460dcedac	137	2024-09-30	2024-10-05	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
501	9cf72984-1234-45de-92b8-43a7542cba0c	148	2024-10-06	2024-10-10	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
502	9cf72984-1283-4248-ba71-7abedf4491c3	139	2024-10-11	2024-10-16	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
503	9cf72984-12d3-4dc0-bfc2-fce9c282ec64	145	2024-10-17	2024-10-21	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
504	9cf72984-131b-4c16-b624-3dd6ea2e1657	157	2024-10-22	\N	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
505	9de66f61-dfed-48bc-bdc5-a02905b049f9	128	2024-12-25	2024-12-28	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
507	9de66f61-e081-4c61-b36e-3f24b86db7fc	153	2025-01-03	2025-01-07	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
508	9de66f61-e0de-4673-ae58-1361657ae12c	145	2025-01-08	2025-01-11	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
509	9de66f61-e12b-4c49-9355-f959f6b4c614	153	2025-01-12	2025-01-17	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
510	9de66f61-e176-49d7-8299-55d4e7155a33	164	2025-01-18	2025-01-21	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
511	9de66f61-e1c1-4415-90c2-98a208bfd9c8	150	2025-01-22	2025-01-27	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
512	9de66f61-e20f-4799-aefd-844a88455e2d	163	2025-01-28	2025-01-31	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
513	9de66f61-e253-4d95-a8ae-f1d4a16b4aa7	178	2025-02-01	\N	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
514	9e28a0e5-fccd-46ec-949f-8c1d840066ea	125	2025-02-01	2025-02-04	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
516	9e28a0e5-fd61-4f51-96fe-373dbd5d360b	145	2025-02-09	2025-02-12	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
517	9e28a0e5-fdae-43dd-8958-0260840da60f	136	2025-02-13	2025-02-16	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
518	9e28a0e5-fdf7-44e1-866b-2995152e232b	143	2025-02-17	2025-02-20	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
519	9e28a0e5-fe4b-4e17-8746-c67c429a8af3	156	2025-02-21	2025-02-25	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
520	9e28a0e5-fea0-449e-93b1-e62ec3bbe5f3	149	2025-02-26	2025-03-02	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
521	9e28a0e5-feec-4fea-8f09-fe1fdbda5cff	162	2025-03-03	2025-03-07	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
522	9e28a0e5-ff32-4388-beb6-bfc2f231bd27	172	2025-03-08	\N	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
523	9f7b2b01-7eb8-4e1b-93bd-af8f100ec30c	129	2025-07-01	2025-07-04	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
524	9f7b2b01-7f2d-4425-bec4-bc382a4d01ac	137	2025-07-05	2025-07-08	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
527	9f7b2b01-809d-45ad-a763-4d29764e0df5	151	2025-07-18	2025-07-21	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
528	9f7b2b01-811a-436b-ae47-f9789010896e	164	2025-07-22	2025-07-27	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
529	9f7b2b01-8184-418b-8392-77bf7ea56a5f	151	2025-07-28	2025-08-02	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
530	9f7b2b01-81e1-499c-b856-547e1d16091d	163	2025-08-03	2025-08-07	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
531	9f7b2b01-824f-4755-b7dd-a8dc9bba3a63	175	2025-08-08	\N	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
533	9fe75d7d-faf3-4b65-b4e0-b2154dc2e710	136	2025-09-06	2025-09-09	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
534	9fe75d7d-fb3b-456f-8c2a-2b0a4ab6e9fe	145	2025-09-10	2025-09-13	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
535	9fe75d7d-fb84-4820-84fb-f044327a251f	136	2025-09-14	2025-09-19	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
536	9fe75d7d-fbcd-494d-abc1-c0c9e4a8bcf4	148	2025-09-20	2025-09-23	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
537	9fe75d7d-fc1b-4bd9-aef2-b539a028a8b6	162	2025-09-24	2025-09-27	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
538	9fe75d7d-fc66-463f-9cab-72c38dae11aa	150	2025-09-28	2025-10-01	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
539	9fe75d7d-fcaf-4c15-9c73-7f4feb8131d9	162	2025-10-02	2025-10-05	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
540	9fe75d7d-fcf2-4619-b8e7-68a3a00ac064	170	2025-10-06	\N	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
541	9cf72984-0df8-44a1-8efe-bd4e0b2a6239	331	2024-09-09	2024-09-13	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
543	9cf72984-0e94-46ea-a854-024e1cabf101	383	2024-09-20	2024-09-24	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
544	9cf72984-0ee3-4ea8-9ebc-a9137976bb05	364	2024-09-25	2024-09-30	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
545	9cf72984-0f32-45e5-b91e-0089beb49a95	398	2024-10-01	2024-10-05	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
546	9cf72984-0f7f-48a1-bbab-ef9675f41a34	426	2024-10-06	2024-10-10	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
547	9cf72984-0fcd-4fb7-9655-340caae43f48	405	2024-10-11	2024-10-14	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
548	9cf72984-101c-4615-8a09-cc0f4f6893dd	425	2024-10-15	2024-10-20	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
549	9cf72984-1064-461e-9fa5-7c71d45fca8c	463	2024-10-21	\N	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
550	9de66f61-dd58-4a56-9d4f-7b8e2cbeec30	335	2024-12-25	2024-12-30	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
551	9de66f61-dda1-493e-8a28-2fd0d98501a2	365	2024-12-31	2025-01-05	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
553	9de66f61-de32-4f9f-889e-6793b7d43739	380	2025-01-12	2025-01-17	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
554	9de66f61-de7b-44d2-9b08-f5b0c849d4b4	410	2025-01-18	2025-01-21	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
555	9de66f61-dec5-4b7d-8299-eb75a3492aa5	442	2025-01-22	2025-01-27	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
556	9de66f61-df11-4398-abb6-3593f5737666	415	2025-01-28	2025-01-31	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
557	9de66f61-df60-454d-8ed3-dce7382216bb	452	2025-02-01	2025-02-06	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
558	9e28a0e5-fa0c-4556-826d-8094088e6a4c	330	2025-02-01	2025-02-05	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
559	9e28a0e5-fa55-4b3f-9fce-f9febe1d7c99	360	2025-02-06	2025-02-10	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
560	9de66f61-dfa4-4993-a418-8761528bf172	488	2025-02-07	\N	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
562	9e28a0e5-faf0-4095-9a8a-9e8208a536cc	373	2025-02-17	2025-02-20	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
563	9e28a0e5-fb4f-40e7-b192-96190273658b	402	2025-02-21	2025-02-24	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
564	9e28a0e5-fb9f-4bc0-8871-2ee5f3423f55	430	2025-02-25	2025-02-28	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
565	9e28a0e5-fbee-4d6e-a7c7-080d61eae635	404	2025-03-01	2025-03-06	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
566	9e28a0e5-fc3d-4bd5-b188-4c0468169492	444	2025-03-07	2025-03-11	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
567	9e28a0e5-fc82-4d0e-a1d2-3c1aec32bbca	466	2025-03-12	\N	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
568	9f7b2b01-7a73-4e52-bb86-4f739963dbe8	325	2025-07-01	2025-07-06	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
569	9f7b2b01-7aee-4246-bbdd-474b06be2e4a	348	2025-07-07	2025-07-12	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
570	9f7b2b01-7b75-4b91-9589-fd103520690b	375	2025-07-13	2025-07-18	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
572	9f7b2b01-7c77-486a-bef9-72640c32fdf5	374	2025-07-23	2025-07-26	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
573	9f7b2b01-7cef-46e8-88b4-ad3adf490201	398	2025-07-27	2025-07-30	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
574	9f7b2b01-7d66-4234-89cb-dbf5a9e9758d	365	2025-07-31	2025-08-05	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
575	9f7b2b01-7de0-4139-82cc-976bbbc93480	384	2025-08-06	2025-08-10	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
576	9f7b2b01-7e46-4503-ab2a-6f04e60dec2c	419	2025-08-11	\N	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
577	9fe75d7d-f81c-40aa-a85b-1407f737b44d	333	2025-09-01	2025-09-04	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
578	9fe75d7d-f864-40c0-b14c-a04f4df6e1ae	354	2025-09-05	2025-09-08	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
579	9fe75d7d-f8b1-4c0e-8d50-512b62f1d89b	383	2025-09-09	2025-09-12	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
580	9fe75d7d-f8f8-4891-aa18-453e7b1b33d3	364	2025-09-13	2025-09-17	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
582	9fe75d7d-f98a-47ba-8c77-e87eb1e71663	418	2025-09-24	2025-09-29	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
583	9fe75d7d-f9d3-4d1c-93d5-b193434ddccf	390	2025-09-30	2025-10-03	28	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
584	9fe75d7d-fa1b-49c0-8688-4ef9184211eb	425	2025-10-04	2025-10-07	28	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
585	9fe75d7d-fa60-4f09-85df-5ea872a84d6d	455	2025-10-08	\N	28	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
586	9cf72984-2bdf-4621-b059-6a43b534bfd3	2489	2024-09-09	2024-09-13	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
587	9cf72984-2c26-40e0-85d1-bec0305f3288	2705	2024-09-14	2024-09-17	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
588	9cf72984-2c96-487b-9991-2b45db63b1c4	2862	2024-09-18	2024-09-22	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
589	9cf72984-2ce3-4c13-ae1b-8221014f2d1b	2639	2024-09-23	2024-09-28	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
591	9cf72984-2d7c-4a85-ad5c-d6a0ab693d4a	3024	2024-10-05	2024-10-08	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
592	9cf72984-2dc4-4eff-a2f9-bf87b378fa44	2821	2024-10-09	2024-10-12	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
593	9cf72984-2e0a-4edd-9cec-0eb586135ffa	3001	2024-10-13	2024-10-18	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
594	9cf72984-2e49-45d8-949f-b279c537636e	3215	2024-10-19	\N	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
595	9de66f61-f9d0-404c-9d0c-419376d4e3f0	2419	2024-12-25	2024-12-28	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
596	9de66f61-fa17-402b-a4f1-2f060934b508	2547	2024-12-29	2025-01-02	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
597	9de66f61-fa61-4417-9760-b30f04324f01	2694	2025-01-03	2025-01-08	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
598	9de66f61-faaf-4e15-8b66-69c2f99d972c	2449	2025-01-09	2025-01-12	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
599	9de66f61-fafb-4dce-ae72-e306cca631c4	2616	2025-01-13	2025-01-17	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
602	9de66f61-fbd3-4c37-9a39-339ee3630b4b	2855	2025-01-28	2025-02-01	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
603	9e28a0e6-1963-4551-bcaf-7bdf46487445	2516	2025-02-01	2025-02-06	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
604	9de66f61-fc16-4d8c-ab6b-4d0f51fadff4	3085	2025-02-02	\N	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
605	9e28a0e6-19af-492e-9c1e-83c4befff758	2720	2025-02-07	2025-02-11	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
606	9e28a0e6-19fa-49d0-8090-9f0473e5e798	2900	2025-02-12	2025-02-16	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
608	9e28a0e6-1a8f-49c5-908c-491856d7927c	2891	2025-02-21	2025-02-25	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
609	9e28a0e6-1ad8-4b9f-8a96-a833a0ffb6f8	3137	2025-02-26	2025-03-03	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
610	9e28a0e6-1b22-415d-8c85-3d84d8823cfd	2976	2025-03-04	2025-03-08	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
611	9e28a0e6-1b6f-477d-b04e-35140129b8bf	3158	2025-03-09	2025-03-13	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
612	9e28a0e6-1bb6-4a97-8d30-6753a992c610	3458	2025-03-14	\N	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
613	9f7b2b01-c565-4cbf-b07c-b5864a598ced	2467	2025-07-01	2025-07-05	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
614	9f7b2b01-c5c0-4235-b123-321f768fcf2d	2624	2025-07-06	2025-07-09	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
615	9f7b2b01-c613-42d2-96fe-f590e3974fbe	2796	2025-07-10	2025-07-14	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
616	9f7b2b01-c669-4248-bf08-85df0b3299be	2572	2025-07-15	2025-07-18	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
618	9f7b2b01-c715-4a29-b9ff-8c91c2417910	2898	2025-07-24	2025-07-28	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
619	9f7b2b01-c761-4f0f-83ef-ea20d65a4493	2660	2025-07-29	2025-08-01	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
620	9f7b2b01-c7af-440e-bca1-5151df4b939b	2815	2025-08-02	2025-08-06	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
621	9f7b2b01-c7fb-459c-9282-6cbe7616dd86	2976	2025-08-07	\N	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
622	9fe75d7e-1662-4577-9e4f-0c48c03905f7	2465	2025-09-01	2025-09-04	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
623	9fe75d7e-16ae-4c8b-863b-ba0b02306c15	2711	2025-09-05	2025-09-10	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
624	9fe75d7e-16f6-451e-92b8-2ee02f18841c	2857	2025-09-11	2025-09-16	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
625	9fe75d7e-173f-4be3-8357-562fa15487b6	2667	2025-09-17	2025-09-21	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
626	9fe75d7e-178f-405f-999d-cee3129e1425	2844	2025-09-22	2025-09-25	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
628	9fe75d7e-1828-4a50-b8cb-749a58a79fd1	2837	2025-10-02	2025-10-07	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
629	9fe75d7e-1872-49c9-8265-49120ffdaa2f	3041	2025-10-08	2025-10-13	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
630	9fe75d7e-18b5-4967-858d-c48c3db91fcd	3336	2025-10-14	\N	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
631	9cf72984-162b-4f36-89c2-aa7801d5f7b5	3081	2024-09-09	2024-09-12	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
632	9cf72984-1678-4195-857c-9cd7db5791b3	3365	2024-09-13	2024-09-16	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
633	9cf72984-16c6-45fb-a762-da9f7b2a086a	3563	2024-09-17	2024-09-22	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
634	9cf72984-1714-4fc7-b092-df3e85f96e2b	3298	2024-09-23	2024-09-28	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
635	9cf72984-1764-4575-908c-03414a1026e3	3485	2024-09-29	2024-10-03	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
637	9cf72984-1801-4fdd-88eb-aa1ac60c6db6	3587	2024-10-09	2024-10-13	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
638	9cf72984-1850-4fb7-af15-6f84536b6567	3916	2024-10-14	2024-10-19	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
639	9cf72984-1898-40cb-afb1-99e6048a021a	4162	2024-10-20	\N	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
640	9de66f61-e54c-4c2e-900b-2f7726fdc2d0	3061	2024-12-25	2024-12-29	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
641	9de66f61-e598-45bd-8b05-7810d34feff4	3339	2024-12-30	2025-01-04	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
642	9de66f61-e5eb-4d9d-8941-d85a96f8417e	3596	2025-01-05	2025-01-09	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
643	9de66f61-e63f-4b74-bc8e-49ce9e78d4f4	3296	2025-01-10	2025-01-14	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
644	9de66f61-e690-441c-af07-ea43e8c78fef	3554	2025-01-15	2025-01-18	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
645	9de66f61-e6e2-4575-96d0-426595c7402d	3800	2025-01-19	2025-01-23	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
647	9de66f61-e77b-4829-be79-031271a266eb	3898	2025-01-29	2025-02-03	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
648	9e28a0e6-0217-41b8-a210-7b34c5c63f50	3070	2025-02-01	2025-02-05	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
649	9de66f61-e7bf-48b9-a11c-064cff5659ee	4155	2025-02-04	\N	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
650	9e28a0e6-0261-4d66-ae79-31e956be399c	3282	2025-02-06	2025-02-10	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
651	9e28a0e6-02aa-40e0-9f0f-befcac1a5247	3520	2025-02-11	2025-02-15	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
652	9e28a0e6-02f4-471a-b667-c5b5b83b0f55	3283	2025-02-16	2025-02-20	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
653	9e28a0e6-033c-4b63-aa86-f579a8eeed7d	3567	2025-02-21	2025-02-25	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
654	9e28a0e6-0387-4311-a1c0-11eda6162adc	3919	2025-02-26	2025-03-01	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
655	9e28a0e6-03d0-4c3e-bbeb-ae91eca6e3f5	3563	2025-03-02	2025-03-06	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
657	9e28a0e6-045d-4229-8726-2e3d4572b088	4121	2025-03-11	\N	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
658	9f7b2b01-a9e5-4918-aeb7-303a18d532d9	3083	2025-07-01	2025-07-05	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
659	9f7b2b01-aa42-4255-9dde-42eb1e4e4871	3379	2025-07-06	2025-07-09	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
660	9f7b2b01-aa97-4178-bfb7-7f2ed48ced23	3652	2025-07-10	2025-07-15	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
661	9f7b2b01-aafe-4c8b-88ec-4838b8a6be3a	3390	2025-07-16	2025-07-20	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
662	9f7b2b01-ab57-4995-9fca-7d094abd33ef	3587	2025-07-21	2025-07-24	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
663	9f7b2b01-abad-40e2-ac2d-b1729a3bbf07	3854	2025-07-25	2025-07-30	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
664	9f7b2b01-ac0c-4c73-bb4c-219451db7df8	3555	2025-07-31	2025-08-04	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
666	9f7b2b01-acb9-4592-9d4c-108f9a725714	4020	2025-08-11	\N	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
667	9fe75d7d-ffd1-45ec-ae26-ba6c9abb5c71	3136	2025-09-01	2025-09-04	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
668	9fe75d7e-001d-4a51-819e-b0b6621a9aef	3307	2025-09-05	2025-09-10	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
669	9fe75d7e-0069-4ab5-a3f1-7ff79d8c3c36	3533	2025-09-11	2025-09-14	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
670	9fe75d7e-00b3-467c-834d-554cd5ac1949	3219	2025-09-15	2025-09-18	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
671	9fe75d7e-0100-47f0-91f7-0de9c2c296e6	3386	2025-09-19	2025-09-23	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
672	9fe75d7e-014c-4668-a4a1-45a0bf8fef3b	3672	2025-09-24	2025-09-29	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
673	9fe75d7e-0195-4f72-b463-f94500fbadc7	3323	2025-09-30	2025-10-05	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
674	9fe75d7e-01dc-42ac-b695-8a306387e6fa	3554	2025-10-06	2025-10-11	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
1	9cf72984-1ba7-4c6c-bd4a-332f7404035b	4574	2024-09-09	2024-09-13	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
7	9cf72984-1d7c-4f3b-8320-006afaec9fd2	5091	2024-10-07	2024-10-10	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
17	9de66f61-ec94-44d3-8f6f-4438e90c8376	5433	2025-01-27	2025-01-30	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
27	9e28a0e6-0999-475d-972c-613827f6f47f	6010	2025-03-12	\N	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
36	9f7b2b01-b28b-404a-9a7e-68ef5e0865cf	6514	2025-08-12	\N	16	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
46	9cf72984-2e91-4296-b4d8-ddb666aff70f	5490	2024-09-09	2024-09-13	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
56	9de66f61-fca8-4b12-bbe6-9f766ef358da	5891	2024-12-29	2025-01-02	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
65	9e28a0e6-1c48-4043-a624-a929c6e2ff6a	5921	2025-02-05	2025-02-08	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
75	9f7b2b01-c8e5-4ab7-9847-1393953cdb5d	6008	2025-07-10	2025-07-14	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
76	9f7b2b01-c933-4dca-bef5-f92b1fbeb0f6	5551	2025-07-15	2025-07-20	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
82	9fe75d7e-1902-4918-9288-6421e0c1548d	5397	2025-09-01	2025-09-04	17	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
92	9cf72984-2434-4cd1-b441-e30f7fb647ca	943	2024-09-14	2024-09-17	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
102	9de66f61-f2bc-4c7d-9539-0dfd6604772c	990	2025-01-05	2025-01-09	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
111	9e28a0e6-1234-46b7-8dff-1b340e4613a3	975	2025-02-09	2025-02-13	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
121	9f7b2b01-bb67-45be-adef-7b47b12ebbc1	867	2025-07-19	2025-07-23	18	1	1	\N	\N	2025-09-19 14:28:41	2025-09-19 14:41:52
131	9fe75d7e-0f1f-4bac-8544-139c4443793d	1009	2025-09-19	2025-09-24	18	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
140	9cf72984-2a83-442d-b304-fb4766f6c0c2	5675	2024-10-02	2024-10-06	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
150	9de66f61-f8af-4fc8-82c6-b1ed0343c13e	6386	2025-01-18	2025-01-23	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
151	9de66f61-f8f8-49c7-91e2-ad2757abf0a6	5829	2025-01-24	2025-01-27	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
157	9e28a0e6-17ab-4026-8c0f-23cadc2fada7	5661	2025-02-18	2025-02-21	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
167	9f7b2b01-c39d-4469-a788-f806d8097793	5816	2025-07-21	2025-07-24	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
177	9fe75d7e-1519-482b-babc-74090f4bcad0	6452	2025-09-25	2025-09-29	19	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:52
186	9cf72984-0cc6-4b67-9879-47fc6f09cd72	17859	2024-10-03	2024-10-08	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
196	9de66f61-dc87-430d-944d-7440dec5f4c3	16878	2025-01-25	2025-01-28	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
206	9e28a0e5-f976-4122-98cf-90f17d1c7572	18567	2025-03-10	2025-03-14	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
215	9f7b2b01-799a-40b5-9af7-e4f18b4a9ad1	17900	2025-08-09	2025-08-13	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
225	9fe75d7d-f7d6-4731-9dc2-623528d13a5a	19339	2025-10-11	\N	20	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
226	9cf72984-1e62-49ce-8ba1-fba621c2d7dd	6576	2024-09-09	2024-09-14	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
232	9cf72984-2037-4a75-bc0b-fe92f34e7b81	7227	2024-10-05	2024-10-10	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
242	9de66f61-ef16-4d6e-8095-744ae9230acf	8789	2025-01-31	2025-02-04	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
252	9e28a0e6-0c29-4e30-82c0-dd98dfaf1e72	9065	2025-03-13	\N	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
261	9f7b2b01-b57b-4561-9f5e-38aef5cf9a55	8519	2025-08-11	\N	21	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
271	9cf72984-136a-4db0-938a-1a8d1fb692aa	4515	2024-09-09	2024-09-14	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
281	9de66f61-e2e5-4a04-8d31-16db0e92ee33	4685	2024-12-31	2025-01-03	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
290	9de66f61-e502-4d87-b599-02773800006f	5883	2025-02-06	\N	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
300	9f7b2b01-83d2-4ccf-88e8-970db592b2de	5077	2025-07-09	2025-07-12	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
301	9f7b2b01-8430-44ad-8f35-9eae6e14a6c8	4735	2025-07-13	2025-07-16	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
307	9fe75d7d-fd3a-4ef7-9dc3-c5520316d1b3	4515	2025-09-01	2025-09-04	22	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
317	9cf72984-1937-47de-ad8c-955373ddac81	2197	2024-09-13	2024-09-17	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
327	9de66f61-e8a1-49fb-882a-9f79a18b1ef7	2459	2025-01-03	2025-01-08	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
336	9e28a0e6-0543-4163-a1c8-43320bd32664	2419	2025-02-13	2025-02-18	23	1	1	\N	\N	2025-09-19 14:28:42	2025-09-19 14:41:53
346	9f7b2b01-adfd-4a8f-a071-43f362119600	2139	2025-07-17	2025-07-20	23	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
356	9fe75d7e-038e-4d2e-832d-016717d3d843	2238	2025-09-21	2025-09-26	23	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
365	9cf72984-2250-47e5-b5c8-5e2a7d871081	2995	2024-09-28	2024-10-01	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
375	9de66f61-f10c-45b4-abee-f8cc8e6d9f6b	3135	2025-01-19	2025-01-24	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
376	9de66f61-f156-4e5c-93f9-37e1f673bd08	2872	2025-01-25	2025-01-29	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
382	9e28a0e6-0d54-4b24-b6fe-90dc88763939	2780	2025-02-17	2025-02-21	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
392	9f7b2b01-b759-44a4-ab30-1db82606485e	2966	2025-07-20	2025-07-23	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
402	9fe75d7e-0cd4-427c-bceb-ee8a27e122f8	3257	2025-09-23	2025-09-26	24	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
411	9cf72984-2831-4a09-bd7b-517e8da08609	7047	2024-10-07	2024-10-11	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:53
421	9de66f61-f66c-4046-a1ce-7c539caa37df	6193	2025-01-26	2025-01-30	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
431	9e28a0e6-1642-4ede-8ac8-ab86ab8b92f6	6896	2025-03-06	2025-03-10	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
440	9f7b2b01-c123-48d6-9356-bc265bc4c737	6224	2025-07-31	2025-08-05	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
450	9fe75d7e-1313-47e0-ab82-bdce70220046	7319	2025-10-15	\N	25	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
451	9cf72984-080d-436a-b5d4-adabcb14b78c	526	2024-09-09	2024-09-14	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
457	9cf72984-0a5b-483d-bd77-ab6b64c858cb	591	2024-10-11	2024-10-15	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
467	9e28a0e5-ec84-41cf-a4d1-61f2a6540a21	539	2025-02-01	2025-02-06	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
477	9e28a0e5-f6f8-4124-b2fa-def0127507e9	670	2025-03-14	\N	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
486	9f7b2b01-75b7-47b5-a32e-4f669ce9c91f	696	2025-08-07	\N	26	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
496	9cf72984-10b1-444f-9c81-2c1a7b6042ac	128	2024-09-09	2024-09-13	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
506	9de66f61-e038-47e7-b49a-6916dd388255	140	2024-12-29	2025-01-02	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
515	9e28a0e5-fd16-4ea3-9daa-917843cece68	134	2025-02-05	2025-02-08	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
525	9f7b2b01-7fb9-4a75-9dd8-1e1f863c9a08	148	2025-07-09	2025-07-13	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
526	9f7b2b01-8022-4b4f-ad0a-c50d46042ca6	138	2025-07-14	2025-07-17	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
532	9fe75d7d-faa8-4e24-af35-55a7c867c6cb	128	2025-09-01	2025-09-05	27	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
542	9cf72984-0e46-476e-bff9-a4df604ce9e0	361	2024-09-14	2024-09-19	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
552	9de66f61-ddea-4e7b-8978-bbd4476e2996	399	2025-01-06	2025-01-11	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
561	9e28a0e5-fa9d-4218-bcbb-befc789412b2	392	2025-02-11	2025-02-16	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
571	9f7b2b01-7bf4-43f4-9ff7-001d9a881dba	348	2025-07-19	2025-07-22	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
581	9fe75d7d-f942-492d-bf2a-17663922e5a4	398	2025-09-18	2025-09-23	28	1	1	\N	\N	2025-09-19 14:28:43	2025-09-19 14:41:54
590	9cf72984-2d34-4f19-a665-c45537d038af	2847	2024-09-29	2024-10-04	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
600	9de66f61-fb42-474a-892f-b2aaef7056e9	2867	2025-01-18	2025-01-21	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
601	9de66f61-fb8b-42c7-91a4-3a3d719d644c	2691	2025-01-22	2025-01-27	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
607	9e28a0e6-1a44-4d67-bf50-d36e5c0dbd14	2719	2025-02-17	2025-02-20	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
617	9f7b2b01-c6bc-4936-8b7e-d1170ce8c85b	2738	2025-07-19	2025-07-23	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
627	9fe75d7e-17de-46c5-9e5f-0b7d7cb571f2	3067	2025-09-26	2025-10-01	29	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:54
636	9cf72984-17b2-4e24-9621-5bb32dae9773	3817	2024-10-04	2024-10-08	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
646	9de66f61-e72d-494c-a872-cd28925bdd95	3575	2025-01-24	2025-01-28	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
656	9e28a0e6-041a-42e2-b3ab-a84cc8fb0fe6	3830	2025-03-07	2025-03-10	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
665	9f7b2b01-ac64-427e-8e60-d9f3b593842a	3808	2025-08-05	2025-08-10	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
675	9fe75d7e-0220-4016-a097-793014ecd5d1	3829	2025-10-12	\N	30	1	1	\N	\N	2025-09-19 14:28:44	2025-09-19 14:41:55
\.


--
-- TOC entry 3464 (class 0 OID 160573)
-- Dependencies: 230
-- Data for Name: medicines; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.medicines (id, uuid, name, created_by, updated_by, deleted_by, deleted_at, created_at, updated_at) FROM stdin;
16	9cf72984-047a-4c48-bc12-de0c6437b5ae	Cholecalciferol 1000 IU Tablet Kunyah (PROVE D3-1000)	1	1	\N	\N	2025-09-19 14:19:16	2025-09-19 14:19:16
17	9cf72984-075b-464a-86ac-bd6d727763e3	Desloratadine 5mg Tablet Salut Selaput (DEXA MEDICA)	1	1	\N	\N	2025-09-19 14:19:16	2025-09-19 14:19:16
18	9cf72984-05b8-40d7-9cee-b326578d67f7	Diazepam 5mg Tablet (VALISANBE)	1	1	\N	\N	2025-09-19 14:19:16	2025-09-19 14:19:16
19	9cf72984-0689-497b-adb6-96a7d50931db	Divalproex Sodium 250mg Tablet Pelepasan Lambat (DEXA MEDICA)	1	1	\N	\N	2025-09-19 14:19:16	2025-09-19 14:19:16
20	9cf72984-01ed-46fa-8efc-04ce10eae2ed	Esomeprazole Sodium 20mg Tablet (ESOFERR)	1	1	\N	\N	2025-09-19 14:19:16	2025-09-19 14:19:16
21	9cf72984-04e0-4d4b-852c-8602ce4cb30b	Lorazepam 2mg Tablet Salut Selaput (MERLOPAM 2)	1	1	\N	\N	2025-09-19 14:19:16	2025-09-19 14:19:16
22	9cf72984-033d-4af8-95cb-2b4912602c8a	Mecobalamin 500 mg Tablet (LAPIBAL)	1	1	\N	\N	2025-09-19 14:19:16	2025-09-19 14:19:16
23	9cf72984-0411-4b11-969c-e13a4b116bec	Mefenamic Acid 500mg Tablet Salut Selaput (MEFINAL 500)	1	1	\N	\N	2025-09-19 14:19:16	2025-09-19 14:19:16
24	9cf72984-054d-4925-b12e-2aaf8d613401	Metamizole Sodium 500mg Tablet (NOVALGIN)	1	1	\N	\N	2025-09-19 14:19:16	2025-09-19 14:19:16
25	9cf72984-0622-4a2b-81e8-1b92fbbdeb64	Methylprednisolone 8mg Tablet (SANEXON 8)	1	1	\N	\N	2025-09-19 14:19:16	2025-09-19 14:19:16
26	9cf72984-0015-45a4-a2b4-dcf83e8fe144	Paracetamol 500mg Tablet (SANMOL)	1	1	\N	\N	2025-09-19 14:19:16	2025-09-19 14:19:16
27	9cf72984-02d4-4270-b659-708bae3c5ca1	Propranolol Hydrochloride 10mg Tablet (KIMIA FARMA)	1	1	\N	\N	2025-09-19 14:19:16	2025-09-19 14:19:16
28	9cf72984-0265-4a83-9eba-278eae10ca92	Ranitidine Hydrochloride 150mg Tablet Salut Selaput (HEXPHARM)	1	1	\N	\N	2025-09-19 14:19:16	2025-09-19 14:19:16
29	9cf72984-06f4-40e2-b434-efea9ee0d622	Tranexamic Acid 500mg Tablet Salut Selaput (BERNOFARM)	1	1	\N	\N	2025-09-19 14:19:16	2025-09-19 14:19:16
30	9cf72984-03a8-43ad-9a57-41b8c6f2ba27	Vitamin E 30 IU/ Vitamin C 750mg/ Vitamin B1 15mg (BECOM - ZET)	1	1	\N	\N	2025-09-19 14:19:16	2025-09-19 14:19:16
\.


--
-- TOC entry 3449 (class 0 OID 160482)
-- Dependencies: 215
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	0001_01_01_000000_create_users_table	1
2	0001_01_01_000001_create_cache_table	1
3	0001_01_01_000002_create_jobs_table	1
4	2025_09_18_141549_create_roles_table	2
5	2025_09_18_141713_alter_table_users_add_timestamp_column	3
6	2025_09_18_142020_alter_table_users_add_role_id_column	4
7	2025_09_19_140123_create_medicines_table	5
8	2025_09_19_140136_create_medicine_prices_table	5
9	2025_09_19_153954_create_patient_table	6
10	2025_09_19_154036_create_examination_table	6
11	2025_09_20_020114_alter_table_examinations_add_date_column	7
12	2025_09_20_022032_alter_create_medical_prescriptions_table	7
13	2025_09_20_023358_create_files_table	8
14	2025_09_20_024951_alter_table_examinations_add_status_column	9
\.


--
-- TOC entry 3452 (class 0 OID 160499)
-- Dependencies: 218
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- TOC entry 3468 (class 0 OID 160596)
-- Dependencies: 234
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.patients (id, name, bhirt_place, bhirt_date, address, phone, nik, bpjs, created_by, updated_by, deleted_by, deleted_at, created_at, updated_at) FROM stdin;
20	Evan Alexander	Ende	2025-09-10	Tenggilis Mejoyo	081353522525	1212321234112345	1312336465456	1	1	\N	\N	2025-09-20 03:30:49	2025-09-20 03:30:49
\.


--
-- TOC entry 3462 (class 0 OID 160559)
-- Dependencies: 228
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.roles (id, name, slug, created_by, updated_by, deleted_by, deleted_at, created_at, updated_at) FROM stdin;
1	Administrator	admin	\N	\N	\N	\N	2025-09-18 14:22:50	2025-09-18 14:22:50
2	Dokter	dokter	\N	\N	\N	\N	2025-09-18 14:22:50	2025-09-18 14:22:50
3	Apoteker	apoteker	\N	\N	\N	\N	2025-09-18 14:22:50	2025-09-18 14:22:50
\.


--
-- TOC entry 3453 (class 0 OID 160506)
-- Dependencies: 219
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
SJELaZJoa0KzNsbGSfzWz4cL4PWl8bI9jIfxOjD6	1	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0	YTo1OntzOjY6Il90b2tlbiI7czo0MDoieXhiRzE0QzJGTVY0VzVkSlYzbDNrcldoSXhIMWFMS2UyTHR1NzU3eiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMwOiJodHRwOi8vbG9jYWxob3N0OjgwMDAvbWVkaWNpbmUiO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=	1758343130
\.


--
-- TOC entry 3451 (class 0 OID 160489)
-- Dependencies: 217
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at, created_by, updated_by, deleted_by, deleted_at, role_id) FROM stdin;
1	Administrator	admin@email.com	\N	$2y$12$pIdwUjbEz89dHZ6cJEi2uOYzfHP4iIBilBlHDHxngGSDhfaV7428C	\N	2025-09-18 14:15:06	2025-09-19 15:20:28	\N	\N	\N	\N	1
2	Dokter A	dokter_a@email.com	\N	$2y$12$SbuMuA6GfHNgQDVCc6h6IOz4dkNBJpW6xMVtSF7lavOaCu4K9nzHe	\N	2025-09-18 14:15:06	2025-09-19 15:20:28	\N	\N	\N	\N	2
3	Dokter B	dokter_b@email.com	\N	$2y$12$eTSjeZfUFkllzHyEtQZfceATpdtqZFR/RyR96YXrVvimReU4.sINm	\N	2025-09-18 14:15:06	2025-09-19 15:20:28	\N	\N	\N	\N	2
4	Apoteker A	apoteker_a@email.com	\N	$2y$12$6M8mzCDozd4dtH4IhLXyIeXDJBDb/IxIjKRxj6MBUyyWc5Rg4dyX2	\N	2025-09-18 14:15:06	2025-09-19 15:20:28	\N	\N	\N	\N	3
5	Apoteker B	apoteker_b@email.com	\N	$2y$12$iYwuRRl9.UWaI7BTVJPusOsz6AE1TVfULL4NxlfmWSEpZSgmZiK8q	\N	2025-09-18 14:15:06	2025-09-19 15:20:28	\N	\N	\N	\N	3
6	Apoteker C	apoteker_c@email.com	\N	$2y$12$ch4yqq3jFUIuH9FC6do0bOJVUycXgUpwIuSfpMTnfuJfvrs6zcwIu	\N	2025-09-19 15:20:28	2025-09-19 15:20:28	\N	\N	\N	\N	3
7	Apoteker D	apoteker_d@email.com	\N	$2y$12$xdzOMZrKsbDXUNaJS55/geLEOsKSbHlu2Ttemw8.T9Qm383Hcz3RG	\N	2025-09-19 15:20:28	2025-09-19 15:20:28	\N	\N	\N	\N	3
8	Apoteker E	apoteker_e@email.com	\N	$2y$12$0lgZ47WXI03ByICqletHFepz8pHkY/frufnD7SrqhCFaDxRhIqSYu	\N	2025-09-19 15:20:28	2025-09-19 15:20:28	\N	\N	\N	\N	3
9	Apoteker F	apoteker_f@email.com	\N	$2y$12$tRVuUaVsfLldRqpmkkti3OD8QJWqVHmzkbVoMB16oX..B7az09BuS	\N	2025-09-19 15:20:28	2025-09-19 15:20:28	\N	\N	\N	\N	3
10	Apoteker G	apoteker_g@email.com	\N	$2y$12$3QFO3TPCa47UuUOVFC7uVOq.aI8rti2.VCD9oop/bNNT9942o1koW	\N	2025-09-19 15:20:28	2025-09-19 15:20:28	\N	\N	\N	\N	3
11	Apoteker H	apoteker_h@email.com	\N	$2y$12$InujA1W.jr7/SOKQ056sSOWgvd6/19Tuk8BW8ngzK9SDlA50WLeDy	\N	2025-09-19 15:20:28	2025-09-19 15:20:28	\N	\N	\N	\N	3
12	Apoteker I	apoteker_i@email.com	\N	$2y$12$uiNl31Qke37KL.tj4R4Hbul08kJvo83JoqIgFgN94.NVHPO3yXGMa	\N	2025-09-19 15:20:28	2025-09-19 15:20:28	\N	\N	\N	\N	3
13	Apoteker J	apoteker_j@email.com	\N	$2y$12$J9ooF32YHBk1x.kf/V7fvO.jC3aNKju2rHH/RHnIKZGKQ/i741K4y	\N	2025-09-19 15:20:28	2025-09-19 15:20:28	\N	\N	\N	\N	3
\.


--
-- TOC entry 3491 (class 0 OID 0)
-- Dependencies: 235
-- Name: examination_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.examination_id_seq', 18, true);


--
-- TOC entry 3492 (class 0 OID 0)
-- Dependencies: 225
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- TOC entry 3493 (class 0 OID 0)
-- Dependencies: 239
-- Name: files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.files_id_seq', 3, true);


--
-- TOC entry 3494 (class 0 OID 0)
-- Dependencies: 222
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- TOC entry 3495 (class 0 OID 0)
-- Dependencies: 237
-- Name: medical_prescription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.medical_prescription_id_seq', 22, true);


--
-- TOC entry 3496 (class 0 OID 0)
-- Dependencies: 231
-- Name: medicine_prices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.medicine_prices_id_seq', 675, true);


--
-- TOC entry 3497 (class 0 OID 0)
-- Dependencies: 229
-- Name: medicines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.medicines_id_seq', 30, true);


--
-- TOC entry 3498 (class 0 OID 0)
-- Dependencies: 214
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.migrations_id_seq', 14, true);


--
-- TOC entry 3499 (class 0 OID 0)
-- Dependencies: 233
-- Name: patients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.patients_id_seq', 20, true);


--
-- TOC entry 3500 (class 0 OID 0)
-- Dependencies: 227
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, false);


--
-- TOC entry 3501 (class 0 OID 0)
-- Dependencies: 216
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- TOC entry 3272 (class 2606 OID 160528)
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- TOC entry 3270 (class 2606 OID 160521)
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- TOC entry 3295 (class 2606 OID 160610)
-- Name: examinations examination_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.examinations
    ADD CONSTRAINT examination_pkey PRIMARY KEY (id);


--
-- TOC entry 3279 (class 2606 OID 160555)
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 3281 (class 2606 OID 160557)
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- TOC entry 3299 (class 2606 OID 160647)
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- TOC entry 3277 (class 2606 OID 160545)
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- TOC entry 3274 (class 2606 OID 160537)
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 3297 (class 2606 OID 160628)
-- Name: medical_prescriptions medical_prescription_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medical_prescriptions
    ADD CONSTRAINT medical_prescription_pkey PRIMARY KEY (id);


--
-- TOC entry 3289 (class 2606 OID 160587)
-- Name: medicine_prices medicine_prices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medicine_prices
    ADD CONSTRAINT medicine_prices_pkey PRIMARY KEY (id);


--
-- TOC entry 3291 (class 2606 OID 160594)
-- Name: medicine_prices medicine_prices_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medicine_prices
    ADD CONSTRAINT medicine_prices_uuid_unique UNIQUE (uuid);


--
-- TOC entry 3285 (class 2606 OID 160578)
-- Name: medicines medicines_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medicines
    ADD CONSTRAINT medicines_pkey PRIMARY KEY (id);


--
-- TOC entry 3287 (class 2606 OID 160580)
-- Name: medicines medicines_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medicines
    ADD CONSTRAINT medicines_uuid_unique UNIQUE (uuid);


--
-- TOC entry 3258 (class 2606 OID 160487)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3264 (class 2606 OID 160505)
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- TOC entry 3293 (class 2606 OID 160603)
-- Name: patients patients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (id);


--
-- TOC entry 3283 (class 2606 OID 160566)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 3267 (class 2606 OID 160512)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 3260 (class 2606 OID 160498)
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- TOC entry 3262 (class 2606 OID 160496)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3275 (class 1259 OID 160538)
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- TOC entry 3265 (class 1259 OID 160514)
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- TOC entry 3268 (class 1259 OID 160513)
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- TOC entry 3302 (class 2606 OID 160611)
-- Name: examinations examination_patient_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.examinations
    ADD CONSTRAINT examination_patient_id_foreign FOREIGN KEY (patient_id) REFERENCES public.patients(id) ON DELETE SET NULL;


--
-- TOC entry 3305 (class 2606 OID 160648)
-- Name: files files_examination_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_examination_id_foreign FOREIGN KEY (examination_id) REFERENCES public.examinations(id) ON DELETE SET NULL;


--
-- TOC entry 3303 (class 2606 OID 160629)
-- Name: medical_prescriptions medical_prescription_examination_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medical_prescriptions
    ADD CONSTRAINT medical_prescription_examination_id_foreign FOREIGN KEY (examination_id) REFERENCES public.examinations(id) ON DELETE SET NULL;


--
-- TOC entry 3304 (class 2606 OID 160634)
-- Name: medical_prescriptions medical_prescription_medicine_price_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medical_prescriptions
    ADD CONSTRAINT medical_prescription_medicine_price_id_foreign FOREIGN KEY (medicine_price_id) REFERENCES public.medicine_prices(id) ON DELETE SET NULL;


--
-- TOC entry 3301 (class 2606 OID 160588)
-- Name: medicine_prices medicine_prices_medicine_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medicine_prices
    ADD CONSTRAINT medicine_prices_medicine_id_foreign FOREIGN KEY (medicine_id) REFERENCES public.medicines(id) ON DELETE SET NULL;


--
-- TOC entry 3300 (class 2606 OID 160567)
-- Name: users users_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE SET NULL;


-- Completed on 2025-09-20 11:39:04

--
-- PostgreSQL database dump complete
--

