package com.budgettooler.backend.model;

public class BudgetSummary {

    private double currentBalance;
    private double monthlyBudget;
    private double spentThisMonth;

    public BudgetSummary() {
    }

    public BudgetSummary(double currentBalance, double monthlyBudget, double spentThisMonth) {
        this.currentBalance = currentBalance;
        this.monthlyBudget = monthlyBudget;
        this.spentThisMonth = spentThisMonth;
    }

    public double getCurrentBalance() {
        return currentBalance;
    }

    public void setCurrentBalance(double currentBalance) {
        this.currentBalance = currentBalance;
    }

    public double getMonthlyBudget() {
        return monthlyBudget;
    }

    public void setMonthlyBudget(double monthlyBudget) {
        this.monthlyBudget = monthlyBudget;
    }

    public double getSpentThisMonth() {
        return spentThisMonth;
    }

    public void setSpentThisMonth(double spentThisMonth) {
        this.spentThisMonth = spentThisMonth;
    }

    public double getRemaining() {
        return monthlyBudget - spentThisMonth;
    }
}

