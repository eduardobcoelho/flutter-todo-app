class ToDo {
  String id;
  String todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Exercícios matinais', isDone: true),
      ToDo(id: '02', todoText: 'Fazer as compras', isDone: true),
      ToDo(
        id: '03',
        todoText: 'Checar E-mails',
      ),
      ToDo(
        id: '04',
        todoText: 'Reunião do time',
      ),
      ToDo(
        id: '05',
        todoText: 'Desenvolver aplicativo de dispositivos móveis',
      ),
      ToDo(
        id: '06',
        todoText: 'Jantar com os pais',
      ),
    ];
  }
}
