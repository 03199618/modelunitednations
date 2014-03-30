--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: announcements; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE announcements (
    id integer NOT NULL,
    title text,
    content text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    conference_id integer
);


--
-- Name: announcements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE announcements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: announcements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE announcements_id_seq OWNED BY announcements.id;


--
-- Name: chairs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE chairs (
    id integer NOT NULL,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: chairs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE chairs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: chairs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE chairs_id_seq OWNED BY chairs.id;


--
-- Name: comittees; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE comittees (
    id integer NOT NULL,
    name text,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: comittees_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comittees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comittees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comittees_id_seq OWNED BY comittees.id;


--
-- Name: conference_managers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE conference_managers (
    id integer NOT NULL,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: conference_managers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE conference_managers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: conference_managers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE conference_managers_id_seq OWNED BY conference_managers.id;


--
-- Name: conferences; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE conferences (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name text
);


--
-- Name: conferences_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE conferences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: conferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE conferences_id_seq OWNED BY conferences.id;


--
-- Name: delegates; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE delegates (
    id integer NOT NULL,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: delegates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delegates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delegates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE delegates_id_seq OWNED BY delegates.id;


--
-- Name: delegations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE delegations (
    id integer NOT NULL,
    conference_id integer,
    name text,
    ambassador_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: delegations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delegations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delegations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE delegations_id_seq OWNED BY delegations.id;


--
-- Name: participant_groups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE participant_groups (
    id integer NOT NULL,
    conference_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name text
);


--
-- Name: participant_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE participant_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: participant_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE participant_groups_id_seq OWNED BY participant_groups.id;


--
-- Name: participants; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE participants (
    id integer NOT NULL,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    conference_id integer,
    delegation_id integer
);


--
-- Name: participants_comittees; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE participants_comittees (
    participant_id integer,
    comittee_id integer
);


--
-- Name: participants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE participants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE participants_id_seq OWNED BY participants.id;


--
-- Name: participants_participant_groups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE participants_participant_groups (
    participant_id integer,
    participant_group_id integer
);


--
-- Name: participants_roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE participants_roles (
    participant_id integer,
    role_id integer
);


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE roles (
    id integer NOT NULL,
    name text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name text,
    surname text
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY announcements ALTER COLUMN id SET DEFAULT nextval('announcements_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY chairs ALTER COLUMN id SET DEFAULT nextval('chairs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY comittees ALTER COLUMN id SET DEFAULT nextval('comittees_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY conference_managers ALTER COLUMN id SET DEFAULT nextval('conference_managers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY conferences ALTER COLUMN id SET DEFAULT nextval('conferences_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY delegates ALTER COLUMN id SET DEFAULT nextval('delegates_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY delegations ALTER COLUMN id SET DEFAULT nextval('delegations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY participant_groups ALTER COLUMN id SET DEFAULT nextval('participant_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY participants ALTER COLUMN id SET DEFAULT nextval('participants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY announcements
    ADD CONSTRAINT announcements_pkey PRIMARY KEY (id);


--
-- Name: chairs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY chairs
    ADD CONSTRAINT chairs_pkey PRIMARY KEY (id);


--
-- Name: comittees_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY comittees
    ADD CONSTRAINT comittees_pkey PRIMARY KEY (id);


--
-- Name: conference_managers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY conference_managers
    ADD CONSTRAINT conference_managers_pkey PRIMARY KEY (id);


--
-- Name: conferences_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY conferences
    ADD CONSTRAINT conferences_pkey PRIMARY KEY (id);


--
-- Name: delegates_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY delegates
    ADD CONSTRAINT delegates_pkey PRIMARY KEY (id);


--
-- Name: delegations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY delegations
    ADD CONSTRAINT delegations_pkey PRIMARY KEY (id);


--
-- Name: participant_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY participant_groups
    ADD CONSTRAINT participant_groups_pkey PRIMARY KEY (id);


--
-- Name: participants_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY participants
    ADD CONSTRAINT participants_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20140329135800');

INSERT INTO schema_migrations (version) VALUES ('20140329151251');

INSERT INTO schema_migrations (version) VALUES ('20140329151347');

INSERT INTO schema_migrations (version) VALUES ('20140329151431');

INSERT INTO schema_migrations (version) VALUES ('20140329151453');

INSERT INTO schema_migrations (version) VALUES ('20140329151539');

INSERT INTO schema_migrations (version) VALUES ('20140329152006');

INSERT INTO schema_migrations (version) VALUES ('20140329152410');

INSERT INTO schema_migrations (version) VALUES ('20140329152611');

INSERT INTO schema_migrations (version) VALUES ('20140329152658');

INSERT INTO schema_migrations (version) VALUES ('20140329152838');

INSERT INTO schema_migrations (version) VALUES ('20140329153310');

INSERT INTO schema_migrations (version) VALUES ('20140329153428');

INSERT INTO schema_migrations (version) VALUES ('20140329153554');

INSERT INTO schema_migrations (version) VALUES ('20140329153818');

INSERT INTO schema_migrations (version) VALUES ('20140329154140');

INSERT INTO schema_migrations (version) VALUES ('20140329154206');

INSERT INTO schema_migrations (version) VALUES ('20140329154915');

INSERT INTO schema_migrations (version) VALUES ('20140329155449');

INSERT INTO schema_migrations (version) VALUES ('20140329155654');

INSERT INTO schema_migrations (version) VALUES ('20140329155859');
