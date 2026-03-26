# Expense Tracker Database Setup Guide

## Overview
This directory contains SQL scripts to initialize the Expense Tracker database schema in Oracle SQL Developer.

## Prerequisites
- Oracle Database running and accessible at `localhost:1521`
- Oracle SQL Developer installed or any SQL client
- Database user: `c##student_mgmt_user` with password: `root`
- Connection details in `application.properties` match your setup

## Tables Structure

### Users Table
```sql
CREATE TABLE users (
    id         NUMBER IDENTITY PRIMARY KEY,
    username   VARCHAR2(100) NOT NULL UNIQUE,
    password   VARCHAR2(255) NOT NULL
);
```

### Expenses Table
```sql
CREATE TABLE expenses (
    id          NUMBER IDENTITY PRIMARY KEY,
    category    VARCHAR2(100) NOT NULL,
    amount      DECIMAL(10, 2) NOT NULL,
    comments    VARCHAR2(500),
    username    VARCHAR2(100) NOT NULL REFERENCES users(username),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## Setup Steps

### Step 1: Connect to Oracle SQL Developer
1. Open **Oracle SQL Developer**
2. Create a new connection or use existing one with your user credentials
3. Ensure the connection is active

### Step 2: Run the SQL Script
1. Go to **File → Open** and select `init-schema.sql`
2. Review the script (optional)
3. Click **Run Script** (or press `F5`)
4. Check the **Script Output** tab for execution status

**OR** Use SQL*Plus:
```bash
sqlplus c##student_mgmt_user/root@localhost:1521/xepdb1 @init-schema.sql
```

### Step 3: Verify Database Setup
Run these verification queries in SQL Developer:
```sql
SELECT * FROM users;
SELECT * FROM expenses;
SELECT COUNT(*) as total_users FROM users;
SELECT COUNT(*) as total_expenses FROM expenses;
```

Expected Output:
- **3 Users**: alice, bob, charlie
- **11 Expenses**: distributed among the three users

## Sample Credentials

You can now log in to the application with these credentials:

| Username | Password | 
|----------|----------|
| alice    | password123 |
| bob      | password456 |
| charlie  | password789 |

## Application Configuration

The `application.properties` file uses `spring.jpa.hibernate.ddl-auto=validate`

**Options:**
- `validate` - Verify schema exists (recommended for production)
- `create` - Auto-create schema on startup (development only)
- `create-drop` - Create on startup, drop on shutdown (testing)
- `update` - Update existing schema

## Running the Application

After setting up the database:
```powershell
mvn spring-boot:run
```

The application will:
1. Validate the Oracle schema matches JPA entities
2. Start on port 8080
3. Show "Started ExpenseTrackerApplication" in console

## API Endpoints

### Authentication
- **POST** `/api/auth/signup` - Register new user
- **POST** `/api/auth/login` - Login and receive JWT token

### Expenses (Requires JWT Token)
- **GET** `/api/expenses` - Get all expenses for logged-in user
- **POST** `/api/expenses` - Add new expense
- **PUT** `/api/expenses/{id}` - Update expense
- **DELETE** `/api/expenses/{id}` - Delete expense

## Troubleshooting

### Issue: "ORA-00955: name is already used by an existing object"
**Solution:** Uncomment the DROP TABLE statements at the beginning of `init-schema.sql` to delete existing tables first.

### Issue: "Connection refused" 
**Solution:** 
1. Verify Oracle is running: `SELECT * FROM dual;`
2. Check connection parameters in `application.properties`
3. Ensure firewall allows port 1521

### Issue: "User does not have ALTER SESSION privilege"
**Solution:** Ensure `c##student_mgmt_user` has necessary privileges or use SYSDBA account to create the schema.

### Issue: "Table or view does not exist" when running application
**Solution:** 
1. Verify SQL script ran successfully (check for errors)
2. Confirm `spring.jpa.hibernate.ddl-auto=validate` in application.properties
3. Check that tables are in the correct user's schema

## Notes
- Passwords in sample data are BCrypt hashed (never store plain text passwords)
- Timestamps are auto-managed by JPA (`@PrePersist` and `@PreUpdate`)
- Foreign key constraint ensures expenses can only belong to existing users
- Indexes are created for performance optimization
