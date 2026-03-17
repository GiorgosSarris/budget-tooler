package com.budgettooler.backend.service;

import com.budgettooler.backend.model.BudgetSummary;
import org.springframework.stereotype.Service;

@Service
public class BudgetService {

    private double currentBalance = 1250.0;
    private double monthlyBudget = 2000.0;
    private double spentThisMonth = 750.0;

    public BudgetSummary getSummary() {
        return new BudgetSummary(currentBalance, monthlyBudget, spentThisMonth);
    }

    public BudgetSummary addExpense(double amount) {
        spentThisMonth += amount;
        currentBalance -= amount;
        return getSummary();
    }

    public BudgetSummary addIncome(double amount) {
        currentBalance += amount;
        return getSummary();
    }

    public BudgetSummary resetMonth() {
        spentThisMonth = 0.0;
        return getSummary();
    }

    public BudgetSummary updateMonthlyBudget(double amount) {
        monthlyBudget = amount;
        return getSummary();
    }
}

