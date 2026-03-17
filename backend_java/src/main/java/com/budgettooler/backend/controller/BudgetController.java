package com.budgettooler.backend.controller;

import com.budgettooler.backend.model.BudgetSummary;
import com.budgettooler.backend.model.TransactionRequest;
import com.budgettooler.backend.service.BudgetService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/budget")
@CrossOrigin(origins = "*")
public class BudgetController {

    private final BudgetService budgetService;

    public BudgetController(BudgetService budgetService) {
        this.budgetService = budgetService;
    }

    @GetMapping("/summary")
    public ResponseEntity<BudgetSummary> getSummary() {
        return ResponseEntity.ok(budgetService.getSummary());
    }

    @PostMapping("/expense")
    public ResponseEntity<BudgetSummary> addExpense(@RequestBody TransactionRequest request) {
        if (request.getAmount() <= 0) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(budgetService.addExpense(request.getAmount()));
    }

    @PostMapping("/income")
    public ResponseEntity<BudgetSummary> addIncome(@RequestBody TransactionRequest request) {
        if (request.getAmount() <= 0) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(budgetService.addIncome(request.getAmount()));
    }

    @PostMapping("/reset")
    public ResponseEntity<BudgetSummary> resetMonth() {
        return ResponseEntity.ok(budgetService.resetMonth());
    }

    @PostMapping("/budget")
    public ResponseEntity<BudgetSummary> updateMonthlyBudget(@RequestBody TransactionRequest request) {
        if (request.getAmount() <= 0) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(budgetService.updateMonthlyBudget(request.getAmount()));
    }
}

