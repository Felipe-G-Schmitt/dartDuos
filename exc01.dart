class Item {
  String nome;
  int paginas;
  int quant;

  Item(this.nome, this.paginas, this.quant);

  void emprestarL(quant) {
    quant -1;
    print ('Livro $nome emprestado!');
  }

  void emprestarR(quant) {
    quant -1;
    print ('Revista $nome emprestada!');
  }

  void mostrarQuantL(quant) {
    print ('O livro $nome possui $quant unidades disponíveis!');
  }

  void mostrarQuantR(quant) {
    print ('A revista $nome possui $quant unidades disponíveis!');
  }
}

class Livro extends Item{
  String autor;

  Livro( String nome, int paginas, int quant, this.autor ):super(nome, paginas, quant);
}

class Revista extends Item{
  String editora;

  Revista(String nome, int paginas, int quant, this.editora ):super(nome, paginas, quant);
}

void main() {  
  var reservaL = Livro('Dom Quixote', 232, 10, 'Miguel de Cervantes Saavedra');
  var reservaR = Livro('VEJA 11/03', 50, 10, 'VEJA');

  //quantL.mostrarQuantL();

  reservaL.emprestarL(1);
  reservaR.emprestarR(1);
}

/*class ContaBancaria {
  String titular;
  double saldo;

  ContaBancaria(this.titular, this.saldo);

  void depositar(double valor) {
    saldo += valor;
    print('Depositou R\$ $valor. Novo saldo: $saldo');
  }

  void sacar(double valor) {
    if (valor <= saldo) {
      saldo -= valor;
      print('Sacou R\$ $valor. Novo saldo: $saldo');
    } else {
      print('Saldo insuficiente.');
    }
  }
}

class ContaPoupanca extends ContaBancaria {
  ContaPoupanca(String titular, double saldo) : super(titular, saldo);  
   
  void aplicarRendimento(double taxa) {   
      saldo += saldo * taxa;  
      print('Rendimento aplicado! Saldo atualizado: $saldo');
  } 
}

void main() {
  var minhaConta = ContaPoupanca('José', 1000.0);
  minhaConta.depositar(200.0);
  minhaConta.sacar(100.0);
  minhaConta.aplicarRendimento(0.05);
}*/