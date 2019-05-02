import 'dart:async';
import 'dart:html' if (dart.library.io) 'package:RAL/html_i.dart';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:untitled/src/ral_container.dart';

import 'todo_list_service.dart';

@Component(
  selector: 'todo-list',
  styleUrls: ['todo_list_component.css'],
  templateUrl: 'todo_list_component.html',
  directives: [
    MaterialCheckboxComponent,
    MaterialFabComponent,
    MaterialIconComponent,
    materialInputDirectives,
    NgFor,
    NgIf,
  ],
  providers: [ClassProvider(TodoListService)],
)
class TodoListComponent implements OnInit {
  final TodoListService todoListService;
  final Element _element;
  List<String> items = [];
  String newTodo = '';

  TodoListComponent(this.todoListService, this._element);

  @override
  Future<Null> ngOnInit() async {
    final cont = RalContainer(_element);
    print(cont);
    items = await todoListService.getTodoList();
  }

  void add() {
    items.add(newTodo);
    newTodo = '';
  }

  String remove(int index) => items.removeAt(index);
}
