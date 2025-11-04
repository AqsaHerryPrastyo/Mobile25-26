import '../models/data_layer.dart';
import '../provider/plan_provider.dart';
import 'package:flutter/material.dart';

class PlanScreen extends StatefulWidget {
  final Plan plan;
  const PlanScreen({super.key, required this.plan});

  @override
  State createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late ScrollController scrollController;
  Plan get plan => widget.plan;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(title: const Text('Master Plan Herry')),
    body: ValueListenableBuilder<List<Plan>>(
      valueListenable: PlanProvider.of(context),
      builder: (context, plans, child) {
        Plan currentPlan = plans.firstWhere((p) => p.name == plan.name);
        return Column(
          children: [
            Expanded(child: _buildList(currentPlan)),
            SafeArea(child: Text(currentPlan.completenessMessage)),
          ],
        );
      },
    ),
    floatingActionButton: _buildAddTaskButton(context),
   );
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        // remove focus from any TextField while scrolling (fixes iOS keyboard overlap)
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  Widget _buildAddTaskButton(BuildContext context) {
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        final plans = planNotifier.value;
        final planIndex = plans.indexWhere((p) => p.name == plan.name);
        if (planIndex == -1) return;
        final currentPlan = plans[planIndex];
        final updatedTasks = List<Task>.from(currentPlan.tasks)..add(const Task());
        planNotifier.value = List<Plan>.from(plans)
          ..[planIndex] = Plan(name: currentPlan.name, tasks: updatedTasks);
      },
    );
  }
  Widget _buildList(Plan plan) {
    return ListView.builder(
     controller: scrollController,
     keyboardDismissBehavior: Theme.of(context).platform ==
             TargetPlatform.iOS
         ? ScrollViewKeyboardDismissBehavior.onDrag
         : ScrollViewKeyboardDismissBehavior.manual,
     itemCount: plan.tasks.length,
     itemBuilder: (context, index) => _buildTaskTile(plan.tasks[index], index, context),
    );
  }
  Widget _buildTaskTile(Task task, int index, BuildContext context) {
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);
    return ListTile(
      leading: Checkbox(
        value: task.complete,
        onChanged: (selected) {
          final plans = planNotifier.value;
          final planIndex = plans.indexWhere((p) => p.name == plan.name);
          if (planIndex == -1) return;
          final currentPlan = plans[planIndex];
          final newTasks = List<Task>.from(currentPlan.tasks)
            ..[index] = Task(description: task.description, complete: selected ?? false);
          planNotifier.value = List<Plan>.from(plans)..[planIndex] = Plan(name: currentPlan.name, tasks: newTasks);
        },
      ),
      title: TextFormField(
        initialValue: task.description,
        onChanged: (text) {
          final plans = planNotifier.value;
          final planIndex = plans.indexWhere((p) => p.name == plan.name);
          if (planIndex == -1) return;
          final currentPlan = plans[planIndex];
          final newTasks = List<Task>.from(currentPlan.tasks)
            ..[index] = Task(description: text, complete: task.complete);
          planNotifier.value = List<Plan>.from(plans)..[planIndex] = Plan(name: currentPlan.name, tasks: newTasks);
        },
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
