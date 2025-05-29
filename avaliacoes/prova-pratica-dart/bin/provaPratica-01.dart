import 'dart:convert';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';

//Classe Cliente
class Cliente{
  int codigo;
  String nome;
  int tipoCliente;

  // Fazendo construtor de Cliente, com parâmetros nomeados e obrigatórios.
  Cliente({
    required this.codigo,
    required this.nome,
    required this.tipoCliente
  });

  Map<String, dynamic> toJson() => {
    "codigo": codigo,
    "descricao": nome,
    "tipoCliente": tipoCliente
  };
}

//Classe Vendedor
class Vendedor{
  int codigo;
  String nome;
  double comissao;

  // Fazendo construtor de Vendedor, com parâmetros nomeados e obrigatórios.
  Vendedor({
    required this.codigo,
    required this.nome,
    required this.comissao
  });

  Map<String, dynamic> toJson() => {
    "codigo": codigo,
    "nome": nome,
    "comissao": comissao
  };
}

//Classe Veículo
class Veiculo{
  int codigo;
  String descricao;
  double valor;

  // Fazendo construtor de Veiculo, com parâmetros nomeados e obrigatórios.
  Veiculo({
    required this.codigo,
    required this.descricao,
    required this.valor
  });

  Map<String, dynamic> toJson() => {
    "codigo": codigo,
    "descricao": descricao,
    "valor": valor
  };
}

//Classe ItemPedido
class ItemPedido{
  int sequencial;
  String descricao;
  int quantidade;
  double valor;

  // Fazendo construtor de ItemPedido, com parâmetros nomeados e obrigatórios.
  ItemPedido({
    required this.sequencial,
    required this.descricao,
    required this.quantidade,
    required this.valor
  });

  Map<String, dynamic> toJson() => {
    "sequencial": sequencial,
    "descricao": descricao,
    "quantidade": quantidade,
    "valor": valor
  };
}

//Classe PedidoVenda
class PedidoVenda {
  String codigo;
  DateTime data;
  double valorPedido;
  Cliente cliente;
  Vendedor vendedor;
  Veiculo veiculo;
  List<ItemPedido> acessorios;

  // Fazendo construtor de PedidoVenda, com parâmetros nomeados e obrigatórios.
  PedidoVenda({
    required this.codigo,
    required this.data,
    this.valorPedido = 0.0, //O valor do pedido começa com zero, porque será calculado posteriormente - ao instanciar um objeto - pela função calcular pedido e atribuído a este atributo.
    required this.cliente,
    required this.vendedor,
    required this.veiculo,
    required this.acessorios,
  });

  double calcularPedido() {
    double valor = 0.0;
    for (var acessorio in acessorios) {
      valor = valor + (acessorio.valor * acessorio.quantidade);
    }
    valor = valor + veiculo.valor;

    return valor;
  }

  Map<String, dynamic> toJson() => {
    "codigo": codigo,
    "data": data.toIso8601String(),
    "valorPedido": valorPedido,
    "cliente": cliente.toJson(), // OBS.: Tem que chamar o toJson de cada classe criada!
    "vendedor": vendedor.toJson(),
    "veiculo": veiculo.toJson(),
    "acessorios": acessorios
        .map((item) => item.toJson())
        .toList(), // OBS.: Tem que, para cada acessório, chamar seu .toJson e converter pra lista!
  };
}

//Função que conecta com o e-mail -> Criada por mim em outro código: https://github.com/Jot4g3/pdmII-251/blob/main/estudos/provapratica1_estudo/lib/toemail.dart
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
  //Criando objeto Cliente
  Cliente cliente1 = Cliente(codigo: 1, nome: "João Gabriel Aguiar", tipoCliente: 1);

  //Criando objeto Vendedor
  Vendedor vendedor1 = Vendedor(codigo: 1, nome: "Ricardo Duarte Taveira", comissao: 10.0);

  //Criando objeto Veiculo
  Veiculo laFerrari = Veiculo(codigo: 1, descricao: "La Ferrari é um dos carros mais incríveis da Ferrari. Conta com mais de 960 cavalos de pura potência!", valor: 38990000.00);

  //Criando objetos ItemPedido
  ItemPedido tapetes = ItemPedido(sequencial: 1, descricao: "Tapetes para La Ferrari - Produzido na Holanda, manualmente.", quantidade: 5, valor: 2499.90);
  ItemPedido cheirinhoDeArCondicionado = ItemPedido(sequencial: 2, descricao: "Cheirinho sabor menta especial para Ferraris. Deixa o carro com um ar de paz indescritível!", quantidade: 2, valor: 39.90);

  //Criando objeto PedidoVenda
  PedidoVenda venda1 = PedidoVenda(codigo: "123abc", data: DateTime.parse('2025-05-29T14:29:04Z'), cliente: cliente1, vendedor: vendedor1, veiculo: laFerrari, acessorios: [tapetes, cheirinhoDeArCondicionado]);
  venda1.valorPedido = venda1.calcularPedido();

  //Criando JSON da venda1
  String pedidoVendaJSON = jsonEncode(venda1);

  sendEmail(nomeRemetente: "João Gabriel Aguiar de Senna", emailRemetente: "gabriel.joao61@aluno.ifce.edu.br", senhaRemetente: "fpsy fvmo osag juuz", emailDestinatario: "taveira@ifce.edu.br", assuntoEmail: "Envio de JSON - Pedido Venda 123abc", conteudoEmail: pedidoVendaJSON, quantidadeEnvios: 1);
}
