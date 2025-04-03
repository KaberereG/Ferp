CREATE EXTENSION IF NOT EXISTS citext;

-- Add new columns
ALTER TABLE users
ADD COLUMN firstname VARCHAR(255) NOT NULL,
ADD COLUMN lastname VARCHAR(255) NOT NULL;

-- Drop username column
ALTER TABLE users DROP COLUMN username;

-- Change password column type from BYTEA to VARCHAR(255)
ALTER TABLE users ADD COLUMN new_password VARCHAR(255);
UPDATE users SET new_password = encode(password, 'hex'); -- Convert BYTEA to HEX string
ALTER TABLE users DROP COLUMN password;
ALTER TABLE users RENAME COLUMN new_password TO password;
;