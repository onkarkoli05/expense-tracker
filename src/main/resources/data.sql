-- Optional: Auto-initialization script for Spring Boot
-- File: src/main/resources/data.sql
-- This file will automatically execute on application startup if:
--   1. spring.jpa.hibernate.ddl-auto=create or update
--   2. This file exists in src/main/resources

-- Insert sample users
INSERT INTO users (username, password) VALUES 
('alice', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcg7b3XeKeUxWdeS86E36P4/TVK2');

INSERT INTO users (username, password) VALUES 
('bob', '$2a$10$V4aJUtg6v4fk1FX4w0Zpe.Hqmt8mGdnNx.p8KnMf8Dxzps6Tq7Yx6');

INSERT INTO users (username, password) VALUES 
('charlie', '$2a$10$R8gU7aQrCh9xQvL3m2qd4.uKpL8E5vN6x9K3pQ4rF7s0T1M2N3O4');

-- Insert sample expenses
INSERT INTO expenses (category, amount, comments, username) VALUES
('Food', 450.50, 'Lunch at cafe', 'alice');

INSERT INTO expenses (category, amount, comments, username) VALUES
('Travel', 2500.00, 'Cab fare to office', 'alice');

INSERT INTO expenses (category, amount, comments, username) VALUES
('Shopping', 1200.75, 'Groceries and household items', 'alice');

INSERT INTO expenses (category, amount, comments, username) VALUES
('Entertainment', 800.00, 'Movie tickets and snacks', 'alice');

INSERT INTO expenses (category, amount, comments, username) VALUES
('Utilities', 3500.00, 'Monthly electricity bill', 'alice');

INSERT INTO expenses (category, amount, comments, username) VALUES
('Food', 550.00, 'Dinner with friends', 'bob');

INSERT INTO expenses (category, amount, comments, username) VALUES
('Travel', 1500.00, 'Train ticket', 'bob');

INSERT INTO expenses (category, amount, comments, username) VALUES
('Shopping', 2000.00, 'New shoes and clothing', 'bob');

INSERT INTO expenses (category, amount, comments, username) VALUES
('Medical', 750.00, 'Doctor consultation and medicines', 'bob');

INSERT INTO expenses (category, amount, comments, username) VALUES
('Food', 350.00, 'Breakfast at restaurant', 'charlie');

INSERT INTO expenses (category, amount, comments, username) VALUES
('Entertainment', 1500.00, 'Concert tickets', 'charlie');

INSERT INTO expenses (category, amount, comments, username) VALUES
('Shopping', 3200.00, 'Electronics purchase', 'charlie');
