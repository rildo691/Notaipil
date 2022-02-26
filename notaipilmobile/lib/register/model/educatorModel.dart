class EducatorModel{
  String? numeroBI;
  String? nome;
  String? sexo;
  DateTime? dataNascimento;
  String? email;
  String? telefone;
  String? numeroBiAluno;
  String? numeroProcessoAluno;
  
  EducatorModel({
    this.numeroBI,
    this.nome,
    this.sexo,
    this.dataNascimento,
    this.email,
    this.telefone,
    this.numeroBiAluno,
    this.numeroProcessoAluno,
  });

  EducatorModel copyWith({    
    String? numeroBI,
    String? nome,
    String? sexo,
    DateTime? dataNascimento,
    String? email,
    String? telefone,
    String? numeroBiAluno,
    String? numeroProcessoAluno,
  }) {
    return EducatorModel(
      numeroBI: numeroBI ?? this.numeroBI,
      nome: nome ?? this.nome,
      sexo: sexo ?? this.sexo,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      numeroBiAluno: numeroBiAluno ?? this.numeroBiAluno,
      numeroProcessoAluno: numeroProcessoAluno ?? this.numeroProcessoAluno,
    );
  }
  
}