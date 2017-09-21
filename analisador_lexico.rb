# Estados finais
$estados_finais = ["q01", "q03", "qi6", "qr6", "q07", "q09", "q11", "q12", "q13", "q14", "q15", "q16", "q17", "q18", "q19", "q20", "q21", "q22", "q23", "q24", "q25", "q26"]

# Estado atual na tabela.
$estado_atual = "q00"

# Armazena o que está sendo lido antes de chegar ao estado indefinido.
$buffer = ""

# Último caracter lido.
caracter_atual = ""

# Código fonte a ser analisado em uma única string.
$codigo_fonte = IO.readlines('texto.alg')
$codigo_fonte = $codigo_fonte.join("")

# Índice do último caracter lido no código.
$indice_codigo = 0

# Contador de linha
$linha_codigo = 1

# Contador de coluna
$coluna_codigo = 1

# Tabela de símbolos com lexema, token e tipo.
$tabela_de_simbolos = Hash.new
# Inicia tabela de símbolos com as palavras reservadas.
# $tabela_de_simbolos["lexema"] = ["token", "tipo"]
$tabela_de_simbolos["inicio"] = ["inicio",""]
$tabela_de_simbolos["varinicio"] = ["varinicio",""]
$tabela_de_simbolos["varfim"] = ["varfim",""]
$tabela_de_simbolos["escreva"] = ["escreva",""]
$tabela_de_simbolos["leia"] = ["leia",""]
$tabela_de_simbolos["se"] = ["se",""]
$tabela_de_simbolos["entao"] = ["entao",""]
$tabela_de_simbolos["fimse"] = ["fimse",""]
$tabela_de_simbolos["fim"] = ["fim",""]
$tabela_de_simbolos["inteiro"] = ["inteiro",""]
$tabela_de_simbolos["literal"] = ["literal",""]
$tabela_de_simbolos["real"] = ["real",""]

# Tabela de transição.
$tabela_de_transicao = {
  "q00" => {"D"=>"q01","L"=>"q07","_"=>"idf", "E"=>"q07", "\""=>"q08", "."=>"idf", "{"=>"q10", "}"=>"idf", "("=>"q26", ")"=>"q25", ">"=>"q17", "<"=>"q13", "-"=>"q20", "+"=>"q19", "*"=>"q21", "/"=>"q22", ";"=>"q24", "="=>"q23", "EOF"=>"q12", "ntspace"=>"idf", "other"=>"idf"}, 

  "q01" => {"D"=>"q01","L"=>"idf","_"=>"idf", "E"=>"qi4", "\""=>"idf", "."=>"q02", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "q02" => {"D"=>"q03","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "q03" => {"D"=>"q03","L"=>"idf","_"=>"idf", "E"=>"qr4", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "qi4" => {"D"=>"qi6","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"qi5", "+"=>"qi5", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "qi5" => {"D"=>"qi6","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "qi6" => {"D"=>"qi6","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "qr4" => {"D"=>"qr6","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"qr5", "+"=>"qr5", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "qr5" => {"D"=>"qr6","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "qr6" => {"D"=>"qr6","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "q07" => {"D"=>"q07","L"=>"q07","_"=>"q07", "E"=>"q07", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "q08" => {"D"=>"q08","L"=>"q08","_"=>"q08", "E"=>"q08", "\""=>"q09", "."=>"q08", "{"=>"q08", "}"=>"q08", "("=>"q08", ")"=>"q08", ">"=>"q08", "<"=>"q08", "-"=>"q08", "+"=>"q08", "*"=>"q08", "/"=>"q08", ";"=>"q08", "="=>"q08", "EOF"=>"q08", "ntspace"=>"q08", "other"=>"q08"}, 

  "q09" => {"D"=>"idf","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "q10" => {"D"=>"q10","L"=>"q10","_"=>"q10", "E"=>"q10", "\""=>"q10", "."=>"q10", "{"=>"q10", "}"=>"q11", "("=>"q10", ")"=>"q10", ">"=>"q10", "<"=>"q10", "-"=>"q10", "+"=>"q10", "*"=>"q10", "/"=>"q10", ";"=>"q10", "="=>"q10", "EOF"=>"q10", "ntspace"=>"q10", "other"=>"q10"}, 

  "q11" => {"D"=>"idf","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "q12" => {"D"=>"idf","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "q13" => {"D"=>"idf","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"q15", "<"=>"idf", "-"=>"q16", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"q14", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "q14" => {"D"=>"idf","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "q15" => {"D"=>"idf","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "q16" => {"D"=>"idf","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "q17" => {"D"=>"idf","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"q18", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "q18" => {"D"=>"idf","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "q19" => {"D"=>"idf","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "q20" => {"D"=>"idf","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "q21" => {"D"=>"idf","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "q22" => {"D"=>"idf","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "q23" => {"D"=>"idf","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "q24" => {"D"=>"idf","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 

  "q25" => {"D"=>"idf","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 
  
  "q26" => {"D"=>"idf","L"=>"idf","_"=>"idf", "E"=>"idf", "\""=>"idf", "."=>"idf", "{"=>"idf", "}"=>"idf", "("=>"idf", ")"=>"idf", ">"=>"idf", "<"=>"idf", "-"=>"idf", "+"=>"idf", "*"=>"idf", "/"=>"idf", ";"=>"idf", "="=>"idf", "EOF"=>"idf", "ntspace"=>"idf", "other"=>"idf"}, 
}

# Retorna zero se o caracter for uma letra o nil caso contrario 
def letra?(lookAhead)
  lookAhead =~ /[[:alpha:]]/
end

# Retorna zero se o caracter for numérico o nil caso contrario
def numerico?(lookAhead)
  lookAhead =~ /[[:digit:]]/
end

# Generaliza o caracter passado como parâmetro, para o correspondente à tabela de transição.
def generaliza_caracter (caracter)
  if numerico?(caracter) == 0
    "D"

  elsif letra?(caracter) == 0
    if caracter.eql? "E"
      "E"
    else
      "L"
    end

  elsif "_\".{}()<>-+*/=;".include? caracter
    caracter

  elsif " \n\t".include? caracter
    "ntspace"

  else
    "other"
  end
end

# Dado um lexema finalizado em um estado final, grava-o na tabela de simbolos com lexema e tipo se não estiver e imprime na tela.
def conclui_lexema
  case $estado_atual
  when "q01", "qi6"
    "Lexema: " + $buffer + " | Token: Num | Tipo: inteiro"
  
  when "q03", "qr6"
    "Lexema: " + $buffer + " | Token: Num | Tipo: real"
    
  when "q07"
    unless $tabela_de_simbolos.key? $buffer
      $tabela_de_simbolos[$buffer] = ["id","identificador"]
    end
    "Lexema: " + $buffer + " | Token: " + $tabela_de_simbolos[$buffer][0] + " | Tipo: " + $tabela_de_simbolos[$buffer][1]

  when "q09"
    "Lexema: " + $buffer + " | Token: Literal | Tipo: literal"

  when "q11"
    p "Comentário reconhecido e ignorado."

  #Devido à importação do arquivo em ruby, esse caso nunca será alcançado.
  when "q12"
    "Token: EOF"

  when "q13", "q14", "q15", "q17", "q18", "q23"
    "Lexema: " + $buffer + " | Token: OPR"
    
  when "q16"
    "Lexema: " + $buffer + " | Token: RCB"

  when "q19", "q20", "q21", "q22"
    "Lexema: " + $buffer + " | Token: OPM"

  when "q24"
    "Lexema: " + $buffer + " | Token: PT_V"

  when "q25"
    "Lexema: " + $buffer + " | Token: FC_P"

  when "q26"
    "Lexema: " + $buffer + " | Token: AB_P"

  end
end

# Dado o lexema incompleto, o caracter atual e o estado atual não final, retorna um erro.
def mensagem_de_erro (caracter_atual)
  case $estado_atual
  when "q00"
    "Erro 1: Caracter '" + caracter_atual + "' não esperado para início de lexema" 
  when "q02", "qi5", "qr5"
    "Erro 2: Esperava Digito após '" + $buffer + "', em vez de '" + caracter_atual + "'"
  when "qi4", "qr4"
    "Erro 3: Esperava Digito ou '+' ou '-' após '" + $buffer + "', em vez de '" + caracter_atual + "'"
  end
end

def retorna_proximo_lexema

  while $indice_codigo < $codigo_fonte.length do
    caracter_atual = $codigo_fonte[$indice_codigo]
    tipo_caracter = generaliza_caracter caracter_atual

    # Se o próximo estado for indefinido
    if $tabela_de_transicao[$estado_atual][tipo_caracter] == "idf"

      # Ignora caracteres espaço, quebra de linha e tabulação
      if ($buffer.empty?) && (tipo_caracter.eql? "ntspace")
        if caracter_atual.eql? "\n"
          $coluna_codigo = 1
          $linha_codigo = $linha_codigo + 1
        else
          $coluna_codigo = $coluna_codigo + 1
        end
        $indice_codigo = $indice_codigo + 1
        next
      end

      # Se o estado anterior ao indefinido for final
      if $estados_finais.include? $estado_atual
        retorno = conclui_lexema
        $buffer = ""
        $estado_atual = "q00"
        return retorno unless retorno.eql?("Comentário reconhecido e ignorado.")
      else
      # Se o estado anterior ao indefinido não for final
        p mensagem_de_erro(caracter_atual)
        p "Erro na linha " + $linha_codigo.to_s + ", coluna " + $coluna_codigo.to_s 
        exit(1)
      end
    # Se o próximo estado for definido
    else
      # Atualiza Estado
      $estado_atual = $tabela_de_transicao[$estado_atual][tipo_caracter]
      # Inclui caracter no $buffer
      $buffer << caracter_atual
      # Aumenta o índice para avançar ao próximo caracter
      $indice_codigo = $indice_codigo + 1
      $coluna_codigo = $coluna_codigo + 1

      if caracter_atual.eql? "\n"
        $coluna_codigo = 1
        $linha_codigo = $linha_codigo + 1
      end
    end
  end
  if $indice_codigo == $codigo_fonte.length
    if $estado_atual.eql? "q08"
      p "Erro 4: Faltando caracter '\"' para finalizar literal"
      p "Erro na linha " + $linha_codigo.to_s + ", coluna " + $coluna_codigo.to_s 
      exit(1)
    elsif $estado_atual.eql? "q10"
      p "Erro 5: Faltando caracter '}' para finalizar comentário"
      p "Erro na linha " + $linha_codigo.to_s + ", coluna " + $coluna_codigo.to_s 
      exit(1)
    end
    "Token: EOF"
  end
end


while $indice_codigo < $codigo_fonte.length do
  p retorna_proximo_lexema
end

# Remova =begin e =end caso queira imprimir a tabela de símbolos
=begin
p ""
p "==========Tabela de Simbolos=========="
$tabela_de_simbolos.each do |key, value|
  p "Token: " + value[0]
  p "Lexema: " + key
  if !value[1].empty? 
    p "Tipo: " + value[1] 
  end
  p "--------------------------------------"
end
=end