CREATE TABLE IF NOT EXISTS JuiceShops (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    -- Location
    location GEOGRAPHY(POINT, 4326) NOT NULL,
    description TEXT
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_juiceshops_location ON JuiceShops USING GIST(location);
CREATE INDEX IF NOT EXISTS idx_juiceshops_name ON JuiceShops(name);