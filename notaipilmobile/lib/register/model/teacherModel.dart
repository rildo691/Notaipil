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

  TeacherModelcopyWith({
    String? numeroBI,
    String? email,
    String? telefone,
    String? habiitacoes,
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
  
  
  
}