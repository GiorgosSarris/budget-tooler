package com.budgettooler.backend.model;

public class TransactionRequest {

    private double amount;
    private String description;

    public TransactionRequest() {
    }

    public TransactionRequest(double amount, String description) {
        this.amount = amount;
        this.description = description;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}

