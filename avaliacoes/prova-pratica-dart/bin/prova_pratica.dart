import 'dart:convert';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';

//Classe Curso
class Curso{
  int id;
  String descricao;

  // Fazendo construtor de Curso, com parâmetros nomeados e obrigatórios.
  Curso({
    required this.id,
    required this.descricao
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "descricao": nome,
  };
}

//Classe Aluno
class Aluno{
  int id;
  String nome;
  String matricula

  // Fazendo construtor de Aluno, com parâmetros nomeados e obrigatórios.
  Aluno({
    required this.id,
    required this.nome,
    required this.matricula
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "matricula": matricula
  };
}

//Classe Disciplina 
class Disciplina{
  int id;
  String descricao;
  int qtdAulas;

  // Fazendo construtor de Disciplina, com parâmetros nomeados e obrigatórios.
  Disciplina({
    required this.id,
    required this.descricao,
    required this.quantidadesAulas
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "descricao": descricao,
    "qntAulas": qntAulas
  };
}

 

//Função que conecta com o e-mail -> Criada por mim em outro código:https://github.com/Yasmin-Sousa/pdmII-251/tree/main/avaliacoes/avaliacao-05
void sendEmail({
  required String nomeRemetente,
  required String emailRemetente,
  required String senhaRemetente,
  required String emailDestinatario,
  required String assuntoEmail,
  required String conteudoEmail,
  required int quantidadeEnvios,
}) async {
  final smtpServer = gmail(emailRemetente, senhaRemetente);

  final message = Message()
  ..from = Address(emailRemetente, nomeRemetente)
  ..recipients.add(emailDestinatario)
  ..subject = assuntoEmail
  ..text = conteudoEmail;

  try{
    for (int i = 1; i <= quantidadeEnvios; i++){
      final result = await send(message, smtpServer);
      print('E-mail enviado: ${result}');
    }
  } on MailerException catch (err) {
    print('Erro ao enviar e-mail: ${err.toString()}');
  }
}

void main(List<String> arguments) {
  //Criando objeto Aluno
  Aluno aluno1 = Aluno(id: 1, nome: "Yasmin Sousa Oliveira");

  //Criando objeto Professor
  Professor professor1 = Professor(id: 1, nome: "Ricardo Duarte Taveira");

  //Criando objeto Disciplina
  Disciplina PDM2 = Disciplina(id: 1, descricao: "Programacao para dispositivos moveis, qtdAulas: 80);

  //Criando objeto Curso
  Curso Informatica = Curso(id1, descricao: "curso de informatica");
  
  //Criando JSON
  String EnvioDeAatividadeJSON = jsonEncode(aluno1);

  sendEmail(nomeRemetente: "Yasmin Sousa Oliveira ", emailRemetente: "yasmin.sousa07@aluno.ifce.edu.br", senhaRemetente: "fpsy fvmo osag juuz", emailDestinatario: "taveira@ifce.edu.br", assuntoEmail: "Envio de JSON - Envio de atividade", conteudoEmail: EnvioDeAatividadeJSON, quantidadeEnvios: 1);
}
