import 'package:flutter/material.dart';


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

  @override
  String toString() {
    return "Estudant: {BI n.º: $numeroBI, Processo n.º: $numeroProcesso, Curso: $curso, Classe: $classe, Turma: $turma, E-mail: $emailAluno}";
  }

}