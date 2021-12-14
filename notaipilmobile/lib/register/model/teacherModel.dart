class TeacherModel{
  String? email;
  String? telefone;
  String? habilitacoes;
  String? regimeLaboral;
  String? categoria;
  String? numeroBI;
  String? tempoServicoIpil;
  String? tempoServicoEducacao;
  
  TeacherModel({
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
    String? email,
    String? telefone,
    String? habilitacoes,
    String? regimeLaboral,
    String? categoria,
    String? numeroBI,
    String? tempoServicoIpil,
    String? tempoServicoEducacao
  }) {
    return TeacherModel(
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
  
  @override
  String toString() {
    return "Professor: {BI n.º: $numeroBI, Email n.º: $email, Telefone: $telefone, Habilitações Literárias: $habilitacoes, Categoria: $categoria, Regime Laboral: $regimeLaboral, Tempo de Servico no IPIL: $tempoServicoIpil, Tempo de Servico na Educação: $tempoServicoEducacao}";
  }
  
}