import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

String email = 'yasmin.sousa07@aluno.ifce.edu.br';
String pass = 'pkrw bybi womx emxc';

main() async {
  // Configura as credenciais SMTP do Gmail
  final smtpServer = gmail(email, pass);

  // Cria uma mensagem de e-mail
  final message = Message()
    ..from = Address(email, 'Yasmin Sousa Oliveira ')
    ..recipients.add(email)
    ..subject = 'Teste do código da avaliação 05 de Pdm2'
    ..text = 'Enviado com sucesso!!';

  try {
    // Envia o e-mail usando o servidor SMTP do Gmail
    final sendReport = await send(message, smtpServer);

    // Exibe o resultado do envio do e-mail
    print('E-mail enviado: ${sendReport}');
  } on MailerException catch (e) {
    // Exibe informações sobre erros de envio de e-mail
    print('Erro ao enviar e-mail: ${e.toString()}');
  }
}
