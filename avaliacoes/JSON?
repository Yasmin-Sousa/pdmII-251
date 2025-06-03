import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

main() async {
  // Configura as credenciais SMTP do Gmail
  final smtpServer =
      gmail('gabriel.joao61@aluno.ifce.edu.br', 'eucu wwse tirl psme');
  FileAttachment refeitorio = FileAttachment(
    File('./refeitorio.jpeg')
  )
  ..cid = "refeitorio"; // Mark as inline
  // Cria uma mensagem de e-mail
  final message = Message()
    ..from = Address(
        'gabriel.joao61@aluno.ifce.edu.br', 'João Gabriel Aguiar de Senna')
    ..recipients.add('kaua.sousa63@aluno.ifce.edu.br') //Adicionando só uma pessoa.
    ..recipients.addAll(["ismael.nascimento08@aluno.ifce.edu.br", "yasmin.sousa07@aluno.ifce.edu.br"]) //Adicionando uma lista de pessoas.
    ..subject = 'Daily Meeting hoje, às 15:30!😊'
    ..html = '''
    <p>Local: Refeitório do IFCE Campus Fortaleza.</p>
    <p>Veja uma foto do Local:</p>
    <img src="cid:${refeitorio.cid}" alt="Foto do Local">
    '''
    ..attachments.add(refeitorio);

  try {
    // Envia o e-mail usando o servidor SMTP do Gmail
    for (int i = 1; i <= 30; i++){ // Enviando vários emails, pra dar uma esquentada na equipe!
      message.subject = "$i - Daily Meeting hoje, às 15:30!😊";
      final resultado = await send(message, smtpServer);
      // Exibe o resultado do envio do e-mail
      print('E-mail enviado: ${resultado}');
    }
    
  } on MailerException catch (e) {
    // Exibe informações sobre erros de envio de e-mail
    print('Erro ao enviar e-mail: ${e.toString()}');
  }
}
