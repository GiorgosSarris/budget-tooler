import 'package:flutter/material.dart';

void main() {
  runApp(const BudgettoolerApp());
}

class BudgettoolerApp extends StatelessWidget {
  const BudgettoolerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: const BudgetDashboard(),
    );
  }
}

class BudgetDashboard extends StatefulWidget {
  const BudgetDashboard({super.key});

  @override
  State<BudgetDashboard> createState() => _BudgetDashboardState();
}

class _BudgetDashboardState extends State<BudgetDashboard> {
  final TextEditingController _totalBudgetController = TextEditingController(text: "1000");
  final TextEditingController _spentController = TextEditingController(text: "450");

  @override
  Widget build(BuildContext context) {
    double total = double.tryParse(_totalBudgetController.text) ?? 1.0;
    double spent = double.tryParse(_spentController.text) ?? 0.0;
    double percent = (spent / total).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(title: const Text('Budgettooler'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Διάγραμμα Προόδου
            Stack(
              alignment: Alignment.center,
              children: [
                S SixizedBox(
                  height: 200,
                  width: 200,
                  child: CircularProgressIndicator(
                    value: percent,
                    strokeWidth: 12,
                    backgroundColor: Colors.grey[200],
                    color: percent > 0.9 ? Colors.red : Colors.indigo,
                  ),
                ),
                Column(
                  children: [
                    Text('${(percent * 100).toStringAsFixed(1)}%', 
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    const Text('Κατανάλωση'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            
            // Πεδία Εισαγωγής
            TextField(
              controller: _totalBudgetController,
              decoration: const InputDecoration(labelText: 'Συνολικό Budget (€)', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              onChanged: (val) => setState(() {}),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _spentController,
              decoration: const InputDecoration(labelText: 'Έξοδα μέχρι τώρα (€)', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              onChanged: (val) => setState(() {}),
            ),
            
            const SizedBox(height: 30),
            Text(
              'Υπόλοιπο: ${(total - spent).toStringAsFixed(2)} €',
              style: TextStyle(fontSize: 20, color: (total - spent) < 0 ? Colors.red : Colors.green, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}