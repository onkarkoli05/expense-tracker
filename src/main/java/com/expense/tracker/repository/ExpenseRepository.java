package com.expense.tracker.repository;

import com.expense.tracker.model.Expense;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ExpenseRepository extends JpaRepository<Expense, Long> {
    // Find all expenses for a specific user, sorted newest first
    List<Expense> findByUsernameOrderByCreatedAtDesc(String username);
}
