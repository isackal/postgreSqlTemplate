CREATE TABLE IF NOT EXISTS Users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50),
    -- Extern user type could be e.g. microsoft, google etc.
    externUserType VARCHAR(50) NOT NULL,
    externUserId VARCHAR(100) UNIQUE NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
-- Unique combination of externUserType and externUserId
CREATE UNIQUE INDEX IF NOT EXISTS idx_users_extern_usertype_extern_userid ON Users(externUserType, externUserId);
CREATE INDEX IF NOT EXISTS idx_users_username ON Users(username);
CREATE INDEX IF NOT EXISTS idx_users_extern_usertype ON Users(externUserType);