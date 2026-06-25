Class Treinamento.Data.Turma Extends (%Persistent, %XML.Adaptor)
{
    Property Instrutor As Treinamento.Data.Instrutor [SqlColumnNumber = 2];
    Property DataInicio As %Date [SqlColumnNumber = 3];
    Property Status As %String [SqlColumnNumber = 4];
    Property Alunos As list Of Treinamento.Data.Aluno [SqlColumnNumber = 5];
    Property Curso As Treinamento.Data.Curso [SqlColumnNumber = 6];

/// Description
Method VerificarStatus(curso As %String) As %String
{
    Set status = $$$OK
    set statusTurma = ""
    set sql = "SELECT * FROM Treinamento_Data.Turma WHERE Curso-> Nome = '"_curso_"'"
    set resultSet = ##Class(%ResultSet).%New()
    set status = resultSet.Prepare(sql)
    set status = resultSet.Execute()

    while resultSet.%Next() {
        set statusTurma = resultSet.%Get("Status")
    }

    Return statusTurma
}

ClassMethod ImprimirTurma(curso As %String) As %Status
{
    set status = $$$OK
    Try {
        set sql = "SELECT * FROM Treinamento_Data.Turma WHERE Curso-> Nome = '"_curso_"'"
        set resultSet = ##Class(%ResultSet).%New()
        
        set status = resultSet.Prepare(sql)
        if $SYSTEM.Status.IsError(status) return status

        set status = resultSet.Execute()
        if $SYSTEM.Status.IsError(status) return status

        if resultSet.%Next() {
            set idTurma = resultSet.%Get("ID")
            set turma = ##Class(Treinamento.Data.Turma).%OpenId(idTurma)
        }
        For i=1:1:turma.Alunos.Count() {
            set aluno = turma.Alunos.GetAt(i)
            Write !,"Nome: "_aluno.Nome, " Matricula: ", aluno.Matricula, " Idade: ", aluno.Idade
        }
    } Catch (exception) {
        set status = exception.AsStatus()
        Throw exception
    }
    return
}

Storage Default
{
<Data name="TurmaDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Instrutor</Value>
</Value>
<Value name="3">
<Value>DataInicio</Value>
</Value>
<Value name="4">
<Value>Status</Value>
</Value>
<Value name="5">
<Value>Alunos</Value>
</Value>
<Value name="6">
<Value>Curso</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.TurmaD</DataLocation>
<DefaultData>TurmaDefaultData</DefaultData>
<IdLocation>^Treinamento.Data.TurmaD</IdLocation>
<IndexLocation>^Treinamento.Data.TurmaI</IndexLocation>
<StreamLocation>^Treinamento.Data.TurmaS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
