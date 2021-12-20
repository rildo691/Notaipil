class TeacherModel{
  String? nome;
  String? sexo;
  DateTime? dataNascimento;
  String? email;
  String? telefone;
  String? habilitacoes;
  String? regimeLaboral;
  String? categoria;
  String? numeroBI;
  DateTime? tempoServicoIpil;
  DateTime? tempoServicoEducacao;
  
  TeacherModel({
    this.nome,
    this.sexo,
    this.dataNascimento,
    this.email,
    this.telefone,
    this.habilitacoes,
    this.regimeLaboral,
    this.categoria,
    this.numeroBI,
    this.tempoServicoIpil,
    this.tempoServicoEducacao
  });

  TeacherModel copyWith({    
    String? nome,
    String? sexo,
    DateTime? dataNascimento,
    String? email,
    String? telefone,
    String? habilitacoes,
    String? regimeLaboral,
    String? categoria,
    String? numeroBI,
    DateTime? tempoServicoIpil,
    DateTime? tempoServicoEducacao
  }) {
    return TeacherModel(
      nome: nome ?? this.nome,
      sexo: sexo ?? this.sexo,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      habilitacoes: habilitacoes ?? this.habilitacoes,
      regimeLaboral: regimeLaboral ?? this.regimeLaboral,
      categoria: categoria ?? this.categoria,
      numeroBI: numeroBI ?? this.numeroBI,
      tempoServicoIpil: tempoServicoIpil ?? this.tempoServicoIpil,
      tempoServicoEducacao: tempoServicoEducacao ?? this.tempoServicoEducacao
    );
  }
  
}