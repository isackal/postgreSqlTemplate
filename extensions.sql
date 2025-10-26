-- PostgreSQL Extensions
-- This file contains all the extensions used in the database

-- UUID generation
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Advanced text search
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- Cryptographic functions
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- PostGIS for geographic objects
CREATE EXTENSION IF NOT EXISTS "postgis";

-- Additional date/time functions
-- CREATE EXTENSION IF NOT EXISTS "btree_gist";
