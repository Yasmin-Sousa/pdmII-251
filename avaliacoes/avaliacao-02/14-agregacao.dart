import 'dart:convert';
  
class Dependente {
  late String _nome;

Dependente(String nome) {
    this._nome = nome;
  }
  
  Map<String, dynamic> toJson() {
    return {'nome': _nome};
  }
}

class Funcionario {
  late String _nome; 
  late List<Dependente> _dependentes;

   Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': _nome,
      'dependentes': _dependentes.map((d) => d.toJson()).toList(),
    };
  }
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeProjeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeProjeto;
    _funcionarios = funcionarios;
  }

  Map<String, dynamic> toJson() {
    return {
      'nomeProjeto': _nomeProjeto,
      'funcionarios': _funcionarios.map((f) => f.toJson()).toList(), 
    };
  }
}

void main() {
  // 1. Criar varios objetos Dependentes
  var dependente1 = Dependente("Ruby");
  var dependente2 = Dependente("Paulo");
  var dependente3 = Dependente("Leah");

 // 2. Criar varios objetos Funcionario
 // 3. Associar os Dependentes criados aos respectivos
 //    funcionarios
  var funcionario1 = Funcionario("Pedro", [dependente1]);
  var funcionario2 = Funcionario("Anna", [dependente2, dependente3]);

 // 4. Criar uma lista de Funcionarios
  var funcionarios = [funcionario1, funcionario2];

 // 5. criar um objeto Equipe Projeto chamando o metodo
 //    contrutor que da nome ao projeto e insere uma
 //    coleção de funcionario
  var equipeProjeto = EquipeProjeto("Levar os cachorro pra passear", funcionarios);

// 6. Printando o objeto Equipe Projeto sem interpolação
  var projetoJson = equipeProjeto.toJson();

  print("Equipe do Projeto: " + projetoJson['nomeProjeto']);
  print("=====================================");
  for (var funcionario in projetoJson['funcionarios']) {
    print("Funcionário: " + funcionario['nome']);
    print("Dependentes:");
    for (var dependente in funcionario['dependentes']) {
      print("  - " + dependente['nome']);
    }
    print("-------------------------------------");
  }
}
