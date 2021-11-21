class StudentModel{

  String? numeroBI;
  String? numeroProcesso;
  String? areaFormacao;
  String? curso;
  String? classe;
  String? turma;
  String? emailAluno;
  String? emailEncarregado;

  StudentModel({
    this.numeroBI,
    this.numeroProcesso,
    this.areaFormacao,
    this.curso,
    this.classe,
    this.turma,
    this.emailAluno,
    this.emailEncarregado
  });

  StudentModel copyWith({
    String?  numeroBI,
    String? numeroProcesso,
    String? areaFormacao,
    String? curso,
    String? classe,
    String? turma,
    String? emailAluno,
    String? emailEncarregado
  }) {
    return StudentModel(
      numeroBI: numeroBI ?? this.numeroBI,
      numeroProcesso: numeroProcesso ?? this.numeroProcesso,
      areaFormacao: areaFormacao ?? this.areaFormacao,
      curso: curso ?? this.curso,
      classe: classe ?? this.classe,
      turma: turma ?? this.turma,
      emailAluno: emailAluno ?? this.emailAluno,
      emailEncarregado: emailEncarregado ?? this.emailEncarregado
    );
  }

  @override
  String toString() {
    return "Estudante: {BI n.º: $numeroBI, Processo n.º: $numeroProcesso, Área de Formação: $areaFormacao, Curso: $curso, Classe: $classe, Turma: $turma, E-mail: $emailAluno}";
  }

}