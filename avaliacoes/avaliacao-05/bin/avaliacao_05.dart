import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

String email = 'ismael.nascimento08@aluno.ifce.edu.br';
String pass = 'pkrw bybi womx emxc';

main() async {
  // Configura as credenciais SMTP do Gmail
  final smtpServer = gmail(email, pass);

  // Cria uma mensagem de e-mail
  final message = Message()
    ..from = Address(email, 'Ismael Lira Nascimento')
    ..recipients.add(email)
    ..subject = 'Estou testando o código da avaliação 05 de PDMII'
    ..text = 'Esse é um email de teste! 🤪';

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
