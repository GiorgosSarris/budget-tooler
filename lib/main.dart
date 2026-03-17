import 'package:flutter/material.dart';

void main() {
  runApp(const BudgetToolerApp());
}

class BudgetToolerApp extends StatelessWidget {
  const BudgetToolerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Tooler',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const BudgetHomePage(),
    );
  }
}

class BudgetHomePage extends StatefulWidget {
  const BudgetHomePage({super.key});

  @override
  State<BudgetHomePage> createState() => _BudgetHomePageState();
}

class _BudgetHomePageState extends State<BudgetHomePage> {
  double currentBalance = 1250.0;
  double monthlyBudget = 2000.0;
  double spentThisMonth = 750.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Budget Tooler'),
      ),
      body: Row(
        children: [
          Container(
            width: 220,
            color: Theme.of(context).colorScheme.surfaceVariant,
            padding: const EdgeInsets.all(16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Budget Tooler',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Sidebar (coming soon)',
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ανασκόπηση Μήνα',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildSummaryCards(),
                  const SizedBox(height: 24),
                  Expanded(
                    child: _buildBudgetChart(),
                  ),
                  const SizedBox(height: 16),
                  _buildActionsRow(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    final remaining = monthlyBudget - spentThisMonth;
    return Row(
      children: [
        _SummaryCard(
          label: 'Υπόλοιπο λογαριασμού',
          value: '€${currentBalance.toStringAsFixed(2)}',
          color: Colors.teal,
        ),
        const SizedBox(width: 12),
        _SummaryCard(
          label: 'Μηνιαίο budget',
          value: '€${monthlyBudget.toStringAsFixed(2)}',
          color: Colors.blueGrey,
        ),
        const SizedBox(width: 12),
        _SummaryCard(
          label: 'Απομένει στο budget',
          value: '€${remaining.toStringAsFixed(2)}',
          color: remaining >= 0 ? Colors.green : Colors.red,
        ),
      ],
    );
  }

  Widget _buildBudgetChart() {
    final total = monthlyBudget;
    final spentRatio = (spentThisMonth / total).clamp(0.0, 1.0);
    final remainingRatio = 1 - spentRatio;

    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Γράφημα budget μήνα',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _Bar(
                    label: 'Ξοδεύτηκαν',
                    ratio: spentRatio,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(width: 16),
                  _Bar(
                    label: 'Απομένουν',
                    ratio: remainingRatio,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsRow() {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // TODO: σύνδεση με backend/λογική για προσθήκη εξόδου
          },
          icon: const Icon(Icons.remove_circle_outline),
          label: const Text('Προσθήκη εξόδου'),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: () {
            // TODO: σύνδεση με backend/λογική για προσθήκη εσόδου
          },
          icon: const Icon(Icons.add_circle_outline),
          label: const Text('Προσθήκη εσόδου'),
        ),
        const SizedBox(width: 12),
        OutlinedButton.icon(
          onPressed: () {
            // TODO: σύνδεση με backend/λογική για επαναφορά budget
          },
          icon: const Icon(Icons.restart_alt),
          label: const Text('Επαναφορά μήνα'),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: color.withOpacity(0.08),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black54),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({
    required this.label,
    required this.ratio,
    required this.color,
  });

  final String label;
  final double ratio;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 40,
                height: 150 * ratio,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style:
                Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11),
          ),
        ],
      ),
    );
  }
}
