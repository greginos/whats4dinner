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
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: recipes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recipes (
    id bigint NOT NULL,
    name character varying,
    ingredients character varying[] DEFAULT '{}'::character varying[],
    rate double precision,
    image text,
    tags character varying[] DEFAULT '{}'::character varying[],
    budget character varying,
    nb_comments integer,
    total_time character varying,
    difficulty character varying,
    author_tip character varying,
    prep_time character varying,
    cook_time character varying,
    author character varying,
    people_quantity integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    flat_ingredients character varying,
    tsv tsvector
);


--
-- Name: recipes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.recipes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recipes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.recipes_id_seq OWNED BY public.recipes.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: recipes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipes ALTER COLUMN id SET DEFAULT nextval('public.recipes_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: recipes recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_recipes_on_difficulty; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_difficulty ON public.recipes USING btree (difficulty);


--
-- Name: index_recipes_on_ingredients; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_ingredients ON public.recipes USING btree (ingredients);


--
-- Name: index_recipes_on_people_quantity; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_people_quantity ON public.recipes USING btree (people_quantity);


--
-- Name: index_recipes_on_rate; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_rate ON public.recipes USING btree (rate);


--
-- Name: index_recipes_on_tags; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_tags ON public.recipes USING btree (tags);


--
-- Name: index_recipes_on_tsv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_tsv ON public.recipes USING gin (tsv);


--
-- Name: recipes tsvectorupdate; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE ON public.recipes FOR EACH ROW EXECUTE FUNCTION tsvector_update_trigger('tsv', 'pg_catalog.french', 'name', 'flat_ingredients');


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20230930125951'),
('20230930193350'),
('20230930194107'),
('20231002204440'),
('20231002211316');


