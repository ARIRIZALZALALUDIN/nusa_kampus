import '../../data/repositories/task_repository.dart';
import '../../domain/models/task.dart';
import '../core/base_view_model.dart';

class TasksViewModel extends BaseViewModel {
  TasksViewModel({required TaskRepository repository})
      : _repository = repository {
    _repository.addListener(notifyListeners);
  }

  final TaskRepository _repository;

  List<Task> get pendingTasks => _repository.pendingTasks;
  List<Task> get doneTasks => _repository.doneTasks;

  @override
  Future<void> load() => runLoad(_repository.load);

  void toggle(Task task, bool isDone) => _repository.setDone(task.id, isDone);

  @override
  void dispose() {
    _repository.removeListener(notifyListeners);
    super.dispose();
  }
}
