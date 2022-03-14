class EducatorModel{
  String? numeroBI;
  String? nome;
  String? sexo;
  DateTime? dataNascimento;
  String? email;
  String? telefone;
  String? numeroProcessoAluno;
  String? numeroBiAluno;
  
  EducatorModel({
    this.numeroBI,
    this.nome,
    this.sexo,
    this.dataNascimento,
    this.email,
    this.telefone,
    this.numeroProcessoAluno,
    this.numeroBiAluno,
  });

  EducatorModel copyWith({    
    String? numeroBI,
    String? nome,
    String? sexo,
    DateTime? dataNascimento,
    String? email,
    String? telefone,
    String? numeroProcessoAluno,
    String? numeroBiAluno,
  }) {
    return EducatorModel(
      numeroBI: numeroBI ?? this.numeroBI,
      nome: nome ?? this.nome,
      sexo: sexo ?? this.sexo,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      numeroProcessoAluno: numeroProcessoAluno ?? this.numeroProcessoAluno,
      numeroBiAluno: numeroBiAluno ?? this.numeroBiAluno,
    );
  }
  
}