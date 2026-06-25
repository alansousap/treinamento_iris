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
    Set Classe = $ZNAME
    Set core = ##class(Treinamento.Data.LogMensagem).%New()

    try {
        set statusTurma = ""
        set statusProcesso = "Metodo VerificarStatus Foi executado com sucesso!"
        Set pStatus = 1
        Set init = core.CriarEntrada("VerificarStatus",Classe)
        Set IdLog = init.%Id()

        set sql = "SELECT * FROM Treinamento_Data.Turma WHERE Curso-> Nome = '"_curso_"'"
        set resultSet = ##Class(%ResultSet).%New()
        set status = resultSet.Prepare(sql)
        set status = resultSet.Execute()

        while resultSet.%Next() {
            set statusTurma = resultSet.%Get("Status")
        }
         Set fim = core.Finalizar(IdLog,statusProcesso,pStatus)
    } Catch ex {
        Set status= ex.AsStatus()
        Set statusErroEspc = status
        Set erroMsg = $SYSTEM.Status.GetOneErrorText(status)
        Set pStatus = 0
        Set erro = "IdLog :"_IdLog_" - ErroLog :"_erroMsg_" Detalhes : "_statusErroEspc
        Set fim = core.Finalizar(IdLog,erro,pStatus)  
        Throw ex
    }

    Return statusTurma
}

ClassMethod ImprimirTurma(curso As %String) As %Status
{
    set status = $$$OK
    Set Classe = $ZNAME
    Set core = ##class(Treinamento.Data.LogMensagem).%New()   

    Try {
        set statusProcesso = "Metodo ImprimirTurma Foi executado com sucesso!"
        set pStatus = 1
        set init = core.CriarEntrada("ImprimirTurma",Classe)
        set IdLog = init.%Id()

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
        Set status = exception.AsStatus()
        Set statusErroEspc = status
        Set erroMsg = $SYSTEM.Status.GetOneErrorText(status)
        Set pStatus = 0
        set erro = "IdLog :"_IdLog_" - ErroLog :"_erroMsg_" Detalhes : "_statusErroEspc
        Set fim = core.Finalizar(IdLog,erro,pStatus)
        Throw exception 
    }
    Set fim = core.Finalizar(IdLog,statusProcesso,pStatus)
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
