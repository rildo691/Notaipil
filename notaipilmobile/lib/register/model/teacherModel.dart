class TeacherModel{
  String? numeroBI;
  String? email;
  String? telefone;
  String? habilitacoes;
  String? regimeLaboral;
  String? categoria;
  String? tempoServicoIpil;
  String? tempoServicoEducacao;
  
  TeacherModel({
    this.numeroBI,
    this.email,
    this.telefone,
    this.habilitacoes,
    this.regimeLaboral,
    this.categoria,
    this.tempoServicoIpil,
    this.tempoServicoEducacao
  });

  TeacherModel copyWith({
    String? numeroBI,
    String? email,
    String? telefone,
    String? habilitacoes,
    String? regimeLaboral,
    String? categoria,
    String? tempoServicoIpil,
    String? tempoServicoEducacao
  }) {
    return TeacherModel(
      numeroBI: numeroBI ?? this.numeroBI,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      habilitacoes: habilitacoes ?? this.habilitacoes,
      regimeLaboral: regimeLaboral ?? this.regimeLaboral,
      categoria: categoria ?? this.categoria,
      tempoServicoIpil: tempoServicoIpil ?? this.tempoServicoIpil,
      tempoServicoEducacao: tempoServicoEducacao ?? this.tempoServicoEducacao
    );
  }
  
  @override
  String toString() {
    return "Professor: {BI n.º: $numeroBI, Email n.º: $email, Telefone: $telefone, Habilitações Literárias: $habilitacoes, Categoria: $categoria, Regime Laboral: $regimeLaboral, Tempo de Servico no IPIL: $tempoServicoIpil, Tempo de Servico na Educação: $tempoServicoEducacao}";
  }
  
}