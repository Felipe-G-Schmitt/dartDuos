import 'dart:async';
import 'dart:math';

class Usuario {
  final String id;
  final String nome;
  final String? email;

  const Usuario({
    required this.id, 
    required this.nome, 
    this.email,
  });

  String get emailFormatado => email ?? 'Não cadastrado';
}

Future<Usuario> autenticar(String token) async {
  await Future.delayed(const Duration(seconds: 1));
  
  if (token == "valido") {
    return const Usuario(
      id: "u123", 
      nome: "Dev Dart", 
      email: "dev@exemplo.com",
    );
  }
  
  throw const FormatException("Falha na autenticação: Token inválido.");
}

Future<Map<String, double>> buscarSaldos(String userId) async {
  print("[Service] Buscando saldos para o ID: $userId");

  final operacoes = [
    Future.delayed(const Duration(seconds: 2), () => 1500.50),
    Future.delayed(const Duration(seconds: 1), () => 0.054),
    Future.delayed(const Duration(seconds: 3), () => 120.00),
  ];

  try {
    final resultados = await Future.wait<double>(operacoes);
    
    return {
      'Bancário': resultados[0],
      'Crypto': resultados[1],
      'Ações': resultados[2],
    };
  } catch (e) {
    throw Exception("Erro ao consolidar saldos: $e");
  }
}

Stream<double> monitorarMercado() async* {
  final random = Random();
  double precoBase = 50000.0;

  while (true) {
    await Future.delayed(const Duration(seconds: 2));
    final variacao = (random.nextDouble() * 2 - 1) * 500;
    precoBase += variacao;
    yield precoBase;
  }
}

void main() async {
  print("=== SISTEMA DE DASHBOARD INICIADO ===\n");

  StreamSubscription<double>? mercadoSub;

  try {
    // --- Passo 1: Autenticação ---
    print("[Passo 1] Autenticando usuário...");
    final usuario = await autenticar("valido");
    print("Bem-vindo, ${usuario.nome}! (Email: ${usuario.emailFormatado})\n");

    // --- Passo 2: Dados Financeiros ---
    print("[Passo 2] Carregando dados financeiros...");
    final saldos = await buscarSaldos(usuario.id).timeout(
      const Duration(seconds: 5),
      onTimeout: () => throw TimeoutException("A busca de dados excedeu o limite de 5s."),
    );

    print("Saldos Carregados:");
    for (var entry in saldos.entries) {
      print("- ${entry.key}: R\$ ${entry.value.toStringAsFixed(2)}");
    }
    print("");

    // --- Passo 3: Stream de Mercado ---
    print("[Passo 3] Conectando ao feed do mercado ao vivo...");
    mercadoSub = monitorarMercado().listen(
      (preco) => print(">> ATUALIZAÇÃO MERCADO: \$${preco.toStringAsFixed(2)}"),
      onError: (err) => print("Erro no Stream: $err"),
      cancelOnError: true,
    );

    await Future.delayed(const Duration(seconds: 10));
    
  } on TimeoutException catch (e) {
    print("ERRO DE CONEXÃO: ${e.message}");
  } on FormatException catch (e) {
    print("ERRO DE AUTENTICAÇÃO: ${e.message}");
  } catch (e) {
    print("ERRO INESPERADO: $e");
  } finally {
    await mercadoSub?.cancel();
    print("\nSESSÃO FINALIZADA: Recursos liberados.");
  }
}