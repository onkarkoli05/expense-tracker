# Expense Tracker — Full Stack Java (Spring Boot)

## Project Structure
```
expense-tracker/
├── pom.xml                          ← Maven dependencies
└── src/main/
    ├── java/com/expense/tracker/
    │   ├── ExpenseTrackerApplication.java   ← Main entry point
    │   ├── model/
    │   │   ├── User.java                    ← User entity
    │   │   └── Expense.java                 ← Expense entity
    │   ├── repository/
    │   │   ├── UserRepository.java          ← DB queries for User
    │   │   └── ExpenseRepository.java       ← DB queries for Expense
    │   ├── security/
    │   │   ├── JwtUtil.java                 ← JWT generation & validation
    │   │   └── JwtFilter.java               ← Reads JWT from every request
    │   ├── config/
    │   │   └── SecurityConfig.java          ← Spring Security setup
    │   └── controller/
    │       ├── AuthController.java          ← /api/auth/signup & /api/auth/login
    │       └── ExpenseController.java       ← /api/expenses CRUD
    └── resources/
        ├── application.properties           ← Config (DB, JWT secret)
        └── static/index.html                ← Frontend (HTML + CSS + JS)
```

---

## How to Run in VS Code

### Prerequisites
- Java 17+
- Maven 3.6+

### Steps
1. Open the `expense-tracker` folder in VS Code
2. Open a terminal and run:
   ```bash
   mvn spring-boot:run
   ```
3. Open browser at: **http://localhost:8080**

---

## API Endpoints

| Method | URL | Description | Auth Required |
|--------|-----|-------------|---------------|
| POST | /api/auth/signup | Register a new user | No |
| POST | /api/auth/login | Login, get JWT token | No |
| GET | /api/expenses | Get all my expenses | Yes (JWT) |
| POST | /api/expenses | Add new expense | Yes (JWT) |
| PUT | /api/expenses/{id} | Edit an expense | Yes (JWT) |
| DELETE | /api/expenses/{id} | Delete an expense | Yes (JWT) |

---

## Key Concepts to Explain

### Authentication (JWT)
- User logs in → server verifies password (BCrypt) → generates JWT token
- Frontend stores token in localStorage
- Every API call sends token in `Authorization: Bearer <token>` header
- `JwtFilter` runs on every request to validate the token

### Database
- H2 in-memory database — no installation needed, auto-creates tables
- Tables reset when app restarts (good for development)

### Security
- Passwords are hashed with BCrypt — never stored in plain text
- Users can only view/edit/delete their own expenses (checked by username)

### Frontend
- Single HTML page with embedded CSS and JavaScript
- Chart.js library for pie chart
- Tabs switch between expenses table and pie chart
