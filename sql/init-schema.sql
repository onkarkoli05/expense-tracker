-- ============================================================
-- Expense Tracker Database Schema for Oracle SQL Developer
-- ============================================================
-- Run these queries in Oracle SQL Developer before starting the application

-- Drop existing tables if they exist (optional - uncomment if needed)
-- DROP TABLE expenses;
-- DROP TABLE users;

-- ============================================================
-- Create USERS table
-- ============================================================
CREATE TABLE users (
    id          NUMBER GENERATED ALWAYS AS IDENTITY,
    username    VARCHAR2(100) NOT NULL UNIQUE,
    password    VARCHAR2(255) NOT NULL,
    PRIMARY KEY (id)
);

-- Create index on username for faster queries
CREATE INDEX idx_users_username ON users(username);

-- ============================================================
-- Create EXPENSES table
-- ============================================================
CREATE TABLE expenses (
    id          NUMBER GENERATED ALWAYS AS IDENTITY,
    category    VARCHAR2(100) NOT NULL,
    amount      DECIMAL(10, 2) NOT NULL,
    comments    VARCHAR2(500),
    username    VARCHAR2(100) NOT NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (username) REFERENCES users(username)
);

-- Create index on username for faster queries
CREATE INDEX idx_expenses_username ON expenses(username);

-- Create index on creation date for faster queries
CREATE INDEX idx_expenses_created_at ON expenses(created_at);

-- ============================================================
-- Insert Sample Users
-- ============================================================
-- Note: These passwords are BCrypt hashed versions. In production, use proper hashing.
-- Sample credentials:
--   User 1: alice / password123
--   User 2: bob / password456

INSERT INTO users (username, password) VALUES 
('alice', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcg7b3XeKeUxWdeS86E36P4/TVK2');

INSERT INTO users (username, password) VALUES 
('bob', '$2a$10$V4aJUtg6v4fk1FX4w0Zpe.Hqmt8mGdnNx.p8KnMf8Dxzps6Tq7Yx6');

INSERT INTO users (username, password) VALUES 
('charlie', '$2a$10$R8gU7aQrCh9xQvL3m2qd4.uKpL8E5vN6x9K3pQ4rF7s0T1M2N3O4');

COMMIT;

-- ============================================================
-- Insert Sample Expenses
-- ============================================================
INSERT INTO expenses (category, amount, comments, username, created_at, updated_at) VALUES
('Food', 450.50, 'Lunch at cafe', 'alice', CURRENT_TIMESTAMP - INTERVAL '5' DAY, CURRENT_TIMESTAMP - INTERVAL '5' DAY);

INSERT INTO expenses (category, amount, comments, username, created_at, updated_at) VALUES
('Travel', 2500.00, 'Cab fare to office', 'alice', CURRENT_TIMESTAMP - INTERVAL '4' DAY, CURRENT_TIMESTAMP - INTERVAL '4' DAY);

INSERT INTO expenses (category, amount, comments, username, created_at, updated_at) VALUES
('Shopping', 1200.75, 'Groceries and household items', 'alice', CURRENT_TIMESTAMP - INTERVAL '3' DAY, CURRENT_TIMESTAMP - INTERVAL '3' DAY);

INSERT INTO expenses (category, amount, comments, username, created_at, updated_at) VALUES
('Entertainment', 800.00, 'Movie tickets and snacks', 'alice', CURRENT_TIMESTAMP - INTERVAL '2' DAY, CURRENT_TIMESTAMP - INTERVAL '2' DAY);

INSERT INTO expenses (category, amount, comments, username, created_at, updated_at) VALUES
('Utilities', 3500.00, 'Monthly electricity bill', 'alice', CURRENT_TIMESTAMP - INTERVAL '1' DAY, CURRENT_TIMESTAMP - INTERVAL '1' DAY);

-- Sample expenses for Bob
INSERT INTO expenses (category, amount, comments, username, created_at, updated_at) VALUES
('Food', 550.00, 'Dinner with friends', 'bob', CURRENT_TIMESTAMP - INTERVAL '4' DAY, CURRENT_TIMESTAMP - INTERVAL '4' DAY);

INSERT INTO expenses (category, amount, comments, username, created_at, updated_at) VALUES
('Travel', 1500.00, 'Train ticket', 'bob', CURRENT_TIMESTAMP - INTERVAL '3' DAY, CURRENT_TIMESTAMP - INTERVAL '3' DAY);

INSERT INTO expenses (category, amount, comments, username, created_at, updated_at) VALUES
('Shopping', 2000.00, 'New shoes and clothing', 'bob', CURRENT_TIMESTAMP - INTERVAL '2' DAY, CURRENT_TIMESTAMP - INTERVAL '2' DAY);

INSERT INTO expenses (category, amount, comments, username, created_at, updated_at) VALUES
('Medical', 750.00, 'Doctor consultation and medicines', 'bob', CURRENT_TIMESTAMP - INTERVAL '1' DAY, CURRENT_TIMESTAMP - INTERVAL '1' DAY);

-- Sample expenses for Charlie
INSERT INTO expenses (category, amount, comments, username, created_at, updated_at) VALUES
('Food', 350.00, 'Breakfast at restaurant', 'charlie', CURRENT_TIMESTAMP - INTERVAL '3' DAY, CURRENT_TIMESTAMP - INTERVAL '3' DAY);

INSERT INTO expenses (category, amount, comments, username, created_at, updated_at) VALUES
('Entertainment', 1500.00, 'Concert tickets', 'charlie', CURRENT_TIMESTAMP - INTERVAL '2' DAY, CURRENT_TIMESTAMP - INTERVAL '2' DAY);

INSERT INTO expenses (category, amount, comments, username, created_at, updated_at) VALUES
('Shopping', 3200.00, 'Electronics purchase', 'charlie', CURRENT_TIMESTAMP - INTERVAL '1' DAY, CURRENT_TIMESTAMP - INTERVAL '1' DAY);

COMMIT;

-- ============================================================
-- Verification Queries (to check if data was inserted correctly)
-- ============================================================
-- SELECT * FROM users;
-- SELECT * FROM expenses;
-- SELECT COUNT(*) as total_users FROM users;
-- SELECT COUNT(*) as total_expenses FROM expenses;
