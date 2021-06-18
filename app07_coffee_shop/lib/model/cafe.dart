// Modelo de dados que sera utilizado para 
// encapsular os dados recuperados do Cloud Firestore

class Cafe {
  // Atributos = Campos do documento
  late String id;
  late String nome;
  late String preco;

  // Construtor
  Cafe(this.id, this.nome, this.preco);

  // Converter um DOCUMENTO em um OBJETO
  Cafe.fromJson(Map<String, dynamic> map, String id) {
    // se id != null, entao this.id=id, senao, this.id=''
    this.id = id;
    this.nome = map['nome'];
    this.preco = map['preco'];
  }

  // Converter um OBJETO em um DOCUMENTO
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "nome": this.nome,
      "preco": this.preco,
    };
  }
}
