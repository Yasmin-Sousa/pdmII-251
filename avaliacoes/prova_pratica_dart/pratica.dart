import 'dart:io';

import 'package:sqlite3/sqlite3.dart';

void main() async {

  print('Using sqlite3 ${sqlite3.version}');

  final db = sqlite3.openInMemory();


  
  // Ceriando a tabela

  db.execute('''
    CREATE TABLE TB_Curso (
    id INTEGER NOT NULL PRIMARY KEY, 
    nome TEXT NOT NULL,
    descricao TEXT   
    );

  ''');
  
db.execute('''
    CREATE TABLE TB_Aluno (
    id INTEGER NOT NULL PRIMARY KEY, 
    nome TEXT NOT NULL,
    matricula TEXT NOT NULL   
    );

  ''');

db.execute('''
    CREATE TABLE TB_Disciplina (
    id INTEGER NOT NULL PRIMARY KEY, 
    nome TEXT NOT NULL,
    descricao TEXT,
    qtdAulas INTEGER   
    );

  ''');

  db.execute('''
    CREATE TABLE TB_Professor (
    id INTEGER NOT NULL PRIMARY KEY, 
    codigo TEXT
    nome TEXT NOT NULL,  
    );

  ''');

  // Inserção assíncrona de registros
  await inserirCurso(db, 'Informatica', 'curso de informatica');
  await inserirCurso(db, 'Telecomunicacoes', 'curso de telecomunicacoes');
  await inserirCurso(db, 'Mecanica', 'curso de mecanica');



  // Consulta assíncrona de registros
  print('\n Dados após inserção:');
  await consultarCurso(db);


  // Atualização assíncrona de registros
  await atualizarCurso(db, 1, 'Informatica', 'curso de informatica');
  await atualizarCurso(db, 1, 'Telecomunicacoes' 'curso de telecomunicacoes');



  print('\n Dados após atualização:');

  await consultarCurso(db);

  
  // Exclusão assíncrona de registros
  await excluirCurso(db, 2);
  print('\n Dados após exclusão:');
  await consultarCurso(db);



  // Encerramento do banco
  db.dispose();

}



// Função assíncrona para inserir registros
Future<void> inserirCurso(Database db, String nome, String descricao) async {
  await Future(() {
   final stmt = db.prepare('INSERT INTO TB_Curso (nome, descricao);
   stmt.execute([nome, descricao]);
   stmt.dispose();
   print('Registro inserido: $nome, $descricao');

  });

}

Future<void> inserirProfessor(Database db, String nome, String codigo) async {
  await Future(() {
   final stmt = db.prepare('INSERT INTO TB_Curso (nome, descricao);
   stmt.execute([nome, descricao]);
   stmt.dispose();
   print('Registro inserido: $nome, $descricao');

  });

}


//Função assíncrona para consultar registros

Future<void> consultarEstudantes(Database db) async {
   await Future(() {
    final resultSet = db.select('SELECT * FROM TB_Curso');
    for (final row in resultSet) {
    print('Curso[id: ${row['id']}, nome: ${row['nome']}, descricao: ${row['descricao']}]');

    }

  });

}



// Função assíncrona para atualizar registros
Future<void> atualizarEstudante(Database db, int id, String novoNome, int novaIdade) async {
  await Future(() {
    db.execute('UPDATE TB_Curso SET nome = ?, idade = ? WHERE id = ?', [novoNome, novaDescricao, id]);
    print('Registro atualizado: id=$id -> $novoNome, $novaDescricao');

  });

}



// Função assíncrona para excluir registros
Future<void> excluirEstudante(Database db, int id) async {
  await Future(() {
    db.execute('DELETE FROM TB_Curso WHERE id = ?', [id]);
   print('Registro excluído: id=$id');

  });

}
