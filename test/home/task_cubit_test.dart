import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_app/home/model/task_model.dart';
import 'package:the_app/home/cubit/task_cubit.dart';

import 'task_cubit_test.mocks.dart';


@GenerateMocks([FirebaseFirestore, DocumentReference, CollectionReference])
void main() {
  late TaskCubit taskCubit;
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockCollection;
  late MockDocumentReference mockDocument;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockCollection = MockCollectionReference();
    mockDocument = MockDocumentReference();
    when(mockFirestore.collection(any)).thenReturn(mockCollection as CollectionReference<Map<String, dynamic>>);
    when(mockCollection.doc(any)).thenReturn(mockDocument);
    when(mockDocument.set(any)).thenAnswer((_) async => {});
    when(mockDocument.delete()).thenAnswer((_) async => {});
    taskCubit = TaskCubit();
  });

  tearDown(() {
    taskCubit.close();
  });

  test('initial state is empty list', () {
    expect(taskCubit.state, []);
  });

  group('addTask', () {
    test('emits new task and calls _syncTaskToFirebase', () async {
      final taskTitle = 'New Task';
       taskCubit.addTask(title: taskTitle);

      expect(taskCubit.state.length, 1);
      expect(taskCubit.state.first.title, taskTitle);
      verify(mockFirestore.collection('tasks')).called(1);
      verify(mockDocument.set(any)).called(1);
    });
  });

  group('updateTask', () {
    test('emits updated task and calls _syncTaskToFirebase', () async {
      final initialTask = TaskModel(id: '1', title: 'Initial Task');
       taskCubit.addTask(title: initialTask.title);
      final updatedTask = initialTask.copyWith(title: 'Updated Task');
      
       taskCubit.updateTask(updatedTask);
      expect(taskCubit.state.length, 1);
      expect(taskCubit.state.first.title, 'Updated Task');
      verify(mockFirestore.collection('tasks')).called(2);
      verify(mockDocument.set(any)).called(2);
    });
  });

  group('deleteTask', () {
    test('emits task removed and calls _deleteTaskFromFirebase', () async {
      final task = TaskModel(id: '1', title: 'Task to be deleted');
       taskCubit.addTask(title: task.title);
      
       taskCubit.deleteTask(task.id);

      expect(taskCubit.state.length, 0);
      verify(mockFirestore.collection('tasks')).called(2);
      verify(mockDocument.delete()).called(1);
    });
  });

  group('toggleTaskCompletion', () {
    test('toggles task completion and calls _syncTaskToFirebase', () async {
      final task = TaskModel(id: '1', title: 'Task to toggle');
       taskCubit.addTask(title: task.title);
      
      taskCubit.toggleTaskCompletion(task.id);

      expect(taskCubit.state.length, 1);
      expect(taskCubit.state.first.isCompleted, true);
      verify(mockFirestore.collection('tasks')).called(2);
      verify(mockDocument.set(any)).called(2);
    });
  });
}
