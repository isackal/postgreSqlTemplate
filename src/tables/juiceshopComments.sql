-- Drop the table if it exists
-- DROP TABLE IF EXISTS JuiceShopComment;

CREATE TABLE IF NOT EXISTS JuiceShopComment (
    id SERIAL PRIMARY KEY,
    juiceShopId INT NOT NULL,
    comment TEXT NOT NULL,
    userId INT NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (juiceShopId) REFERENCES JuiceShops(id) ON DELETE CASCADE,
    FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE
);

-- Full-Text Search Index
CREATE INDEX IF NOT EXISTS idx_juiceshopcomment_comment ON JuiceShopComment USING GIN(to_tsvector('english', comment));
-- Fuzzy Search Index
CREATE INDEX IF NOT EXISTS idx_juiceshopcomment_comment_trgm ON JuiceShopComment USING GIN(comment gin_trgm_ops);

CREATE INDEX IF NOT EXISTS idx_juiceshopcomment_userid ON JuiceShopComment(userId);
CREATE INDEX IF NOT EXISTS idx_juiceshopcomment_juiceshopid ON JuiceShopComment(juiceShopId);