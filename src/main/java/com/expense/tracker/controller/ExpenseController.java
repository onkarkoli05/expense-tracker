package com.expense.tracker.controller;

import com.expense.tracker.model.Expense;
import com.expense.tracker.repository.ExpenseRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/expenses")
public class ExpenseController {

    private final ExpenseRepository expenseRepository;

    public ExpenseController(ExpenseRepository expenseRepository) {
        this.expenseRepository = expenseRepository;
    }

    /**
     * GET /api/expenses
     * Returns all expenses for the logged-in user, newest first.
     */
    @GetMapping
    public List<Expense> getExpenses(Authentication auth) {
        String username = auth.getName(); // extracted from JWT by JwtFilter
        return expenseRepository.findByUsernameOrderByCreatedAtDesc(username);
    }

    /**
     * POST /api/expenses
     * Body: { "category": "Food", "amount": 500, "comments": "Lunch" }
     * Adds a new expense for the logged-in user.
     */
    @PostMapping
    public ResponseEntity<?> addExpense(@RequestBody Expense expense, Authentication auth) {
        if (expense.getCategory() == null || expense.getAmount() == null) {
            return ResponseEntity.badRequest().body(Map.of("message", "Category and amount are required"));
        }

        expense.setUsername(auth.getName()); // bind expense to logged-in user
        Expense saved = expenseRepository.save(expense);
        return ResponseEntity.ok(saved);
    }

    /**
     * PUT /api/expenses/{id}
     * Body: { "category": "Travel", "amount": 1000, "comments": "Flight" }
     * Updates an existing expense.
     */
    @PutMapping("/{id}")
    public ResponseEntity<?> updateExpense(@PathVariable Long id,
                                           @RequestBody Expense updated,
                                           Authentication auth) {
        Optional<Expense> expenseOpt = expenseRepository.findById(id);

        if (expenseOpt.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Expense expense = expenseOpt.get();

        // Security check: user can only edit their own expenses
        if (!expense.getUsername().equals(auth.getName())) {
            return ResponseEntity.status(403).body(Map.of("message", "Access denied"));
        }

        expense.setCategory(updated.getCategory());
        expense.setAmount(updated.getAmount());
        expense.setComments(updated.getComments());

        return ResponseEntity.ok(expenseRepository.save(expense));
    }

    /**
     * DELETE /api/expenses/{id}
     * Deletes an expense by ID.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteExpense(@PathVariable Long id, Authentication auth) {
        Optional<Expense> expenseOpt = expenseRepository.findById(id);

        if (expenseOpt.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        // Security check: user can only delete their own expenses
        if (!expenseOpt.get().getUsername().equals(auth.getName())) {
            return ResponseEntity.status(403).body(Map.of("message", "Access denied"));
        }

        expenseRepository.deleteById(id);
        return ResponseEntity.ok(Map.of("message", "Expense deleted"));
    }
}
