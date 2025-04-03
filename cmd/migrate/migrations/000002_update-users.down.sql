-- Add back the username column
ALTER TABLE users
ADD COLUMN username VARCHAR(255) UNIQUE NOT NULL;

-- Remove firstname and lastname columns
ALTER TABLE users DROP COLUMN firstname,
DROP COLUMN lastname;

-- Convert password back to BYTEA
ALTER TABLE users ADD COLUMN new_password BYTEA NOT NULL;
UPDATE users SET new_password = decode(password, 'hex'); -- Convert back to BYTEA
ALTER TABLE users DROP COLUMN password;
ALTER TABLE users RENAME COLUMN new_password TO password;
