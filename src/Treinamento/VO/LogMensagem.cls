Class Treinamento.VO.LogMensagem Extends (%SerialObject, %XML.Adaptor)
{
    Property ID As %String;
    Property Metodo As %String;
    Property Classe As %String;
    Property Inicio As %String;
    Property Fim As %String;
    Property Status As %Boolean;
    Property StatusProcesso As %String;

Storage Default
{
<Data name="LogMensagemState">
<Value name="1">
<Value>ID</Value>
</Value>
<Value name="2">
<Value>Metodo</Value>
</Value>
<Value name="3">
<Value>Classe</Value>
</Value>
<Value name="4">
<Value>Inicio</Value>
</Value>
<Value name="5">
<Value>Fim</Value>
</Value>
<Value name="6">
<Value>Status</Value>
</Value>
<Value name="7">
<Value>StatusProcesso</Value>
</Value>
</Data>
<State>LogMensagemState</State>
<StreamLocation>^Treinamento.VO.LogMensagemS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
