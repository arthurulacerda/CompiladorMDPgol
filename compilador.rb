require 'ostruct'

######################## ANALISADOR LÉXICO #############################


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
  when "q01", "qi6", "q03", "qr6"
    "num"
    
  when "q07"
    unless $tabela_de_simbolos.key? $buffer
      $tabela_de_simbolos[$buffer] = ["id","identificador"]
    end
    $tabela_de_simbolos[$buffer][0]

  when "q09"
    "literal"

  when "q11"
    p "Comentário reconhecido e ignorado."

  #Devido à importação do arquivo em ruby, esse caso nunca será alcançado.
  when "q12"
    "$"

  when "q13", "q14", "q15", "q17", "q18", "q23"
    "opr"
    
  when "q16"
    "rcb"

  when "q19", "q20", "q21", "q22"
    "opm"

  when "q24"
    ";"

  when "q25"
    ")"

  when "q26"
    "("

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

def retorna_proximo_token

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
    "$"
  end
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


######################## ANALISADOR SINTÁTICO #############################

$gramatica = {
  "01" => OpenStruct.new(left: "P'", right: "P", size: 1),
  "02" => OpenStruct.new(left: "P", right: "inicio V A", size: 3),
  "03" => OpenStruct.new(left: "V", right: "varinicio LV", size: 2),
  "04" => OpenStruct.new(left: "LV", right: "D LV", size: 2),
  "05" => OpenStruct.new(left: "LV", right: "varfim ;", size: 2),
  "06" => OpenStruct.new(left: "D", right: "id TIPO ;", size: 3),
  "07" => OpenStruct.new(left: "TIPO", right: "inteiro", size: 1),
  "08" => OpenStruct.new(left: "TIPO", right: "real", size: 1),
  "09" => OpenStruct.new(left: "TIPO", right: "literal", size: 1),
  "10" => OpenStruct.new(left: "A", right: "ES A", size: 2),
  "11" => OpenStruct.new(left: "ES", right: "leia id ;", size: 3),
  "12" => OpenStruct.new(left: "ES", right: "escreva ARG ;", size: 3),
  "13" => OpenStruct.new(left: "ARG", right: "literal", size: 1),
  "14" => OpenStruct.new(left: "ARG", right: "num", size: 1),
  "15" => OpenStruct.new(left: "ARG", right: "id", size: 1),
  "16" => OpenStruct.new(left: "A", right: "CMD A", size: 2),
  "17" => OpenStruct.new(left: "CMD", right: "id rcb LD ;", size: 4),
  "18" => OpenStruct.new(left: "LD", right: "OPRD opm OPRD", size: 3),
  "19" => OpenStruct.new(left: "LD", right: "OPRD", size: 1),
  "20" => OpenStruct.new(left: "OPRD", right: "id", size: 1),
  "21" => OpenStruct.new(left: "OPRD", right: "num", size: 1),
  "22" => OpenStruct.new(left: "A", right: "COND A", size: 2),
  "23" => OpenStruct.new(left: "COND", right: "CABECALHO CORPO", size: 2),
  "24" => OpenStruct.new(left: "CABECALHO", right: "se ( EXP_R ) entao", size: 5),
  "25" => OpenStruct.new(left: "EXP_R", right: "OPRD opr OPRD", size: 3),
  "26" => OpenStruct.new(left: "CORPO", right: "ES CORPO", size: 2),
  "27" => OpenStruct.new(left: "CORPO", right: "CMD CORPO", size: 2),
  "28" => OpenStruct.new(left: "CORPO", right: "COND CORPO", size: 2),
  "29" => OpenStruct.new(left: "CORPO", right: "fimse", size: 1),
  "30" => OpenStruct.new(left: "A", right: "fim", size: 1),
}

$tabela_sintatica = {
  "00" => {"inicio"=>"S02", "varinicio"=>"E00", "varfim"=>"E00", ";"=>"E00", "id"=>"E00", "inteiro"=>"E00", "real"=>"E00", "literal"=>"E00", "leia"=>"E00", "escreva"=>"E00", "num"=>"E00", "rcb"=>"E00", "opm"=>"E00", "se"=>"E00", "("=>"E00", ")"=>"E00", "entao"=>"E00", "opr"=>"E00", "fimse"=>"E00", "fim"=>"E00", "$"=>"E00", "P'"=>"NUL", "P"=>"T01", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "01" => {"inicio"=>"E01", "varinicio"=>"E01", "varfim"=>"E01", ";"=>"E01", "id"=>"E01", "inteiro"=>"E01", "real"=>"E01", "literal"=>"E01", "leia"=>"E01", "escreva"=>"E01", "num"=>"E01", "rcb"=>"E01", "opm"=>"E01", "se"=>"E01", "("=>"E01", ")"=>"E01", "entao"=>"E01", "opr"=>"E01", "fimse"=>"E01", "fim"=>"E01", "$"=>"ACC", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "02" => {"inicio"=>"E02", "varinicio"=>"S04", "varfim"=>"E02", ";"=>"E02", "id"=>"E02", "inteiro"=>"E02", "real"=>"E02", "literal"=>"E02", "leia"=>"E02", "escreva"=>"E02", "num"=>"E02", "rcb"=>"E02", "opm"=>"E02", "se"=>"E02", "("=>"E02", ")"=>"E02", "entao"=>"E02", "opr"=>"E02", "fimse"=>"E02", "fim"=>"E02", "$"=>"E02", "P'"=>"NUL", "P"=>"NUL", "V"=>"T03", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "03" => {"inicio"=>"E03", "varinicio"=>"E03", "varfim"=>"E03", ";"=>"E03", "id"=>"S12", "inteiro"=>"E03", "real"=>"E03", "literal"=>"E03", "leia"=>"S10", "escreva"=>"S11", "num"=>"E03", "rcb"=>"E03", "opm"=>"E03", "se"=>"S14", "("=>"E03", ")"=>"E03", "entao"=>"E03", "opr"=>"E03", "fimse"=>"E03", "fim"=>"S09", "$"=>"E03", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"T05", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"T06", "ARG"=>"NUL", "CMD"=>"T07", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"T08", "CABECALHO"=>"T13", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "04" => {"inicio"=>"E04", "varinicio"=>"E04", "varfim"=>"S17", ";"=>"E04", "id"=>"S18", "inteiro"=>"E04", "real"=>"E04", "literal"=>"E04", "leia"=>"E04", "escreva"=>"E04", "num"=>"E04", "rcb"=>"E04", "opm"=>"E04", "se"=>"E04", "("=>"E04", ")"=>"E04", "entao"=>"E04", "opr"=>"E04", "fimse"=>"E04", "fim"=>"E04", "$"=>"E04", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"T15", "D"=>"T16", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "05" => {"inicio"=>"R02", "varinicio"=>"R02", "varfim"=>"R02", ";"=>"R02", "id"=>"R02", "inteiro"=>"R02", "real"=>"R02", "literal"=>"R02", "leia"=>"R02", "escreva"=>"R02", "num"=>"R02", "rcb"=>"R02", "opm"=>"R02", "se"=>"R02", "("=>"R02", ")"=>"R02", "entao"=>"R02", "opr"=>"R02", "fimse"=>"R02", "fim"=>"R02", "$"=>"R02", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 

  "06" => {"inicio"=>"E06", "varinicio"=>"E06", "varfim"=>"E06", ";"=>"E06", "id"=>"S12", "inteiro"=>"E06", "real"=>"E06", "literal"=>"E06", "leia"=>"S10", "escreva"=>"S11", "num"=>"E06", "rcb"=>"E06", "opm"=>"E06", "se"=>"S14", "("=>"E06", ")"=>"E06", "entao"=>"E06", "opr"=>"E06", "fimse"=>"E06", "fim"=>"S09", "$"=>"E06", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"T19", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"T06", "ARG"=>"NUL", "CMD"=>"T07", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"T08", "CABECALHO"=>"T13", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "07" => {"inicio"=>"E07", "varinicio"=>"E07", "varfim"=>"E07", ";"=>"E07", "id"=>"S12", "inteiro"=>"E07", "real"=>"E07", "literal"=>"E07", "leia"=>"S10", "escreva"=>"S11", "num"=>"E07", "rcb"=>"E07", "opm"=>"E07", "se"=>"S14", "("=>"E07", ")"=>"E07", "entao"=>"E07", "opr"=>"E07", "fimse"=>"E07", "fim"=>"S09", "$"=>"E07", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"T20", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"T06", "ARG"=>"NUL", "CMD"=>"T07", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"T08", "CABECALHO"=>"T13", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "08" => {"inicio"=>"E08", "varinicio"=>"E08", "varfim"=>"E08", ";"=>"E08", "id"=>"S12", "inteiro"=>"E08", "real"=>"E08", "literal"=>"E08", "leia"=>"S10", "escreva"=>"S11", "num"=>"E08", "rcb"=>"E08", "opm"=>"E08", "se"=>"S14", "("=>"E08", ")"=>"E08", "entao"=>"E08", "opr"=>"E08", "fimse"=>"E08", "fim"=>"S09", "$"=>"E08", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"T21", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"T06", "ARG"=>"NUL", "CMD"=>"T07", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"T08", "CABECALHO"=>"T13", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "09" => {"inicio"=>"R30", "varinicio"=>"R30", "varfim"=>"R30", ";"=>"R30", "id"=>"R30", "inteiro"=>"R30", "real"=>"R30", "literal"=>"R30", "leia"=>"R30", "escreva"=>"R30", "num"=>"R30", "rcb"=>"R30", "opm"=>"R30", "se"=>"R30", "("=>"R30", ")"=>"R30", "entao"=>"R30", "opr"=>"R30", "fimse"=>"R30", "fim"=>"R30", "$"=>"R30", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "10" => {"inicio"=>"E10", "varinicio"=>"E10", "varfim"=>"E10", ";"=>"E10", "id"=>"S22", "inteiro"=>"E10", "real"=>"E10", "literal"=>"E10", "leia"=>"E10", "escreva"=>"E10", "num"=>"E10", "rcb"=>"E10", "opm"=>"E10", "se"=>"E10", "("=>"E10", ")"=>"E10", "entao"=>"E10", "opr"=>"E10", "fimse"=>"E10", "fim"=>"E10", "$"=>"E10", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 

  "11" => {"inicio"=>"E11", "varinicio"=>"E11", "varfim"=>"E11", ";"=>"E11", "id"=>"S26", "inteiro"=>"E11", "real"=>"E11", "literal"=>"S24", "leia"=>"E11", "escreva"=>"E11", "num"=>"S25", "rcb"=>"E11", "opm"=>"E11", "se"=>"E11", "("=>"E11", ")"=>"E11", "entao"=>"E11", "opr"=>"E11", "fimse"=>"E11", "fim"=>"E11", "$"=>"E11", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"T23", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "12" => {"inicio"=>"E12", "varinicio"=>"E12", "varfim"=>"E12", ";"=>"E12", "id"=>"E12", "inteiro"=>"E12", "real"=>"E12", "literal"=>"E12", "leia"=>"E12", "escreva"=>"E12", "num"=>"E12", "rcb"=>"S27", "opm"=>"E12", "se"=>"E12", "("=>"E12", ")"=>"E12", "entao"=>"E12", "opr"=>"E12", "fimse"=>"E12", "fim"=>"E12", "$"=>"E12", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "13" => {"inicio"=>"E13", "varinicio"=>"E13", "varfim"=>"E13", ";"=>"E13", "id"=>"S12", "inteiro"=>"E13", "real"=>"E13", "literal"=>"E13", "leia"=>"S10", "escreva"=>"S11", "num"=>"E13", "rcb"=>"E13", "opm"=>"E13", "se"=>"S14", "("=>"E13", ")"=>"E13", "entao"=>"E13", "opr"=>"E13", "fimse"=>"S32", "fim"=>"E13", "$"=>"E13", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"T29", "ARG"=>"NUL", "CMD"=>"T30", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"T31", "CABECALHO"=>"T13", "CORPO"=>"T28", "EXP_R"=>"NUL"}, 
  "14" => {"inicio"=>"E14", "varinicio"=>"E14", "varfim"=>"E14", ";"=>"E14", "id"=>"E14", "inteiro"=>"E14", "real"=>"E14", "literal"=>"E14", "leia"=>"E14", "escreva"=>"E14", "num"=>"E14", "rcb"=>"E14", "opm"=>"E14", "se"=>"E14", "("=>"S33", ")"=>"E14", "entao"=>"E14", "opr"=>"E14", "fimse"=>"E14", "fim"=>"E14", "$"=>"E14", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "15" => {"inicio"=>"R03", "varinicio"=>"R03", "varfim"=>"R03", ";"=>"R03", "id"=>"R03", "inteiro"=>"R03", "real"=>"R03", "literal"=>"R03", "leia"=>"R03", "escreva"=>"R03", "num"=>"R03", "rcb"=>"R03", "opm"=>"R03", "se"=>"R03", "("=>"R03", ")"=>"R03", "entao"=>"R03", "opr"=>"R03", "fimse"=>"R03", "fim"=>"R03", "$"=>"R03", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 

  "16" => {"inicio"=>"E16", "varinicio"=>"E16", "varfim"=>"S17", ";"=>"E16", "id"=>"S18", "inteiro"=>"E16", "real"=>"E16", "literal"=>"E16", "leia"=>"E16", "escreva"=>"E16", "num"=>"E16", "rcb"=>"E16", "opm"=>"E16", "se"=>"E16", "("=>"E16", ")"=>"E16", "entao"=>"E16", "opr"=>"E16", "fimse"=>"E16", "fim"=>"E16", "$"=>"E16", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"T34", "D"=>"T16", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "17" => {"inicio"=>"E17", "varinicio"=>"E17", "varfim"=>"E17", ";"=>"S35", "id"=>"E17", "inteiro"=>"E17", "real"=>"E17", "literal"=>"E17", "leia"=>"E17", "escreva"=>"E17", "num"=>"E17", "rcb"=>"E17", "opm"=>"E17", "se"=>"E17", "("=>"E17", ")"=>"E17", "entao"=>"E17", "opr"=>"E17", "fimse"=>"E17", "fim"=>"E17", "$"=>"E17", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "18" => {"inicio"=>"E18", "varinicio"=>"E18", "varfim"=>"E18", ";"=>"E18", "id"=>"E18", "inteiro"=>"S37", "real"=>"S38", "literal"=>"S39", "leia"=>"E18", "escreva"=>"E18", "num"=>"E18", "rcb"=>"E18", "opm"=>"E18", "se"=>"E18", "("=>"E18", ")"=>"E18", "entao"=>"E18", "opr"=>"E18", "fimse"=>"E18", "fim"=>"E18", "$"=>"E18", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"T36", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "19" => {"inicio"=>"R10", "varinicio"=>"R10", "varfim"=>"R10", ";"=>"R10", "id"=>"R10", "inteiro"=>"R10", "real"=>"R10", "literal"=>"R10", "leia"=>"R10", "escreva"=>"R10", "num"=>"R10", "rcb"=>"R10", "opm"=>"R10", "se"=>"R10", "("=>"R10", ")"=>"R10", "entao"=>"R10", "opr"=>"R10", "fimse"=>"R10", "fim"=>"R10", "$"=>"R10", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "20" => {"inicio"=>"R16", "varinicio"=>"R16", "varfim"=>"R16", ";"=>"R16", "id"=>"R16", "inteiro"=>"R16", "real"=>"R16", "literal"=>"R16", "leia"=>"R16", "escreva"=>"R16", "num"=>"R16", "rcb"=>"R16", "opm"=>"R16", "se"=>"R16", "("=>"R16", ")"=>"R16", "entao"=>"R16", "opr"=>"R16", "fimse"=>"R16", "fim"=>"R16", "$"=>"R16", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 

  "21" => {"inicio"=>"R22", "varinicio"=>"R22", "varfim"=>"R22", ";"=>"R22", "id"=>"R22", "inteiro"=>"R22", "real"=>"R22", "literal"=>"R22", "leia"=>"R22", "escreva"=>"R22", "num"=>"R22", "rcb"=>"R22", "opm"=>"R22", "se"=>"R22", "("=>"R22", ")"=>"R22", "entao"=>"R22", "opr"=>"R22", "fimse"=>"R22", "fim"=>"R22", "$"=>"R22", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "22" => {"inicio"=>"E22", "varinicio"=>"E22", "varfim"=>"E22", ";"=>"S40", "id"=>"E22", "inteiro"=>"E22", "real"=>"E22", "literal"=>"E22", "leia"=>"E22", "escreva"=>"E22", "num"=>"E22", "rcb"=>"E22", "opm"=>"E22", "se"=>"E22", "("=>"E22", ")"=>"E22", "entao"=>"E22", "opr"=>"E22", "fimse"=>"E22", "fim"=>"E22", "$"=>"E22", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "23" => {"inicio"=>"E23", "varinicio"=>"E23", "varfim"=>"E23", ";"=>"S41", "id"=>"E23", "inteiro"=>"E23", "real"=>"E23", "literal"=>"E23", "leia"=>"E23", "escreva"=>"E23", "num"=>"E23", "rcb"=>"E23", "opm"=>"E23", "se"=>"E23", "("=>"E23", ")"=>"E23", "entao"=>"E23", "opr"=>"E23", "fimse"=>"E23", "fim"=>"E23", "$"=>"E23", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "24" => {"inicio"=>"R13", "varinicio"=>"R13", "varfim"=>"R13", ";"=>"R13", "id"=>"R13", "inteiro"=>"R13", "real"=>"R13", "literal"=>"R13", "leia"=>"R13", "escreva"=>"R13", "num"=>"R13", "rcb"=>"R13", "opm"=>"R13", "se"=>"R13", "("=>"R13", ")"=>"R13", "entao"=>"R13", "opr"=>"R13", "fimse"=>"R13", "fim"=>"R13", "$"=>"R13", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "25" => {"inicio"=>"R14", "varinicio"=>"R14", "varfim"=>"R14", ";"=>"R14", "id"=>"R14", "inteiro"=>"R14", "real"=>"R14", "literal"=>"R14", "leia"=>"R14", "escreva"=>"R14", "num"=>"R14", "rcb"=>"R14", "opm"=>"R14", "se"=>"R14", "("=>"R14", ")"=>"R14", "entao"=>"R14", "opr"=>"R14", "fimse"=>"R14", "fim"=>"R14", "$"=>"R14", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 

  "26" => {"inicio"=>"R15", "varinicio"=>"R15", "varfim"=>"R15", ";"=>"R15", "id"=>"R15", "inteiro"=>"R15", "real"=>"R15", "literal"=>"R15", "leia"=>"R15", "escreva"=>"R15", "num"=>"R15", "rcb"=>"R15", "opm"=>"R15", "se"=>"R15", "("=>"R15", ")"=>"R15", "entao"=>"R15", "opr"=>"R15", "fimse"=>"R15", "fim"=>"R15", "$"=>"R15", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "27" => {"inicio"=>"E27", "varinicio"=>"E27", "varfim"=>"E27", ";"=>"E27", "id"=>"S44", "inteiro"=>"E27", "real"=>"E27", "literal"=>"E27", "leia"=>"E27", "escreva"=>"E27", "num"=>"S45", "rcb"=>"E27", "opm"=>"E27", "se"=>"E27", "("=>"E27", ")"=>"E27", "entao"=>"E27", "opr"=>"E27", "fimse"=>"E27", "fim"=>"E27", "$"=>"E27", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"T42", "OPRD"=>"T43", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "28" => {"inicio"=>"R23", "varinicio"=>"R23", "varfim"=>"R23", ";"=>"R23", "id"=>"R23", "inteiro"=>"R23", "real"=>"R23", "literal"=>"R23", "leia"=>"R23", "escreva"=>"R23", "num"=>"R23", "rcb"=>"R23", "opm"=>"R23", "se"=>"R23", "("=>"R23", ")"=>"R23", "entao"=>"R23", "opr"=>"R23", "fimse"=>"R23", "fim"=>"R23", "$"=>"R23", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "29" => {"inicio"=>"E29", "varinicio"=>"E29", "varfim"=>"E29", ";"=>"E29", "id"=>"S12", "inteiro"=>"E29", "real"=>"E29", "literal"=>"E29", "leia"=>"S10", "escreva"=>"S11", "num"=>"E29", "rcb"=>"E29", "opm"=>"E29", "se"=>"S14", "("=>"E29", ")"=>"E29", "entao"=>"E29", "opr"=>"E29", "fimse"=>"S32", "fim"=>"E29", "$"=>"E29", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"T29", "ARG"=>"NUL", "CMD"=>"T30", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"T31", "CABECALHO"=>"T13", "CORPO"=>"T46", "EXP_R"=>"NUL"}, 
  "30" => {"inicio"=>"E30", "varinicio"=>"E30", "varfim"=>"E30", ";"=>"E30", "id"=>"S12", "inteiro"=>"E30", "real"=>"E30", "literal"=>"E30", "leia"=>"S10", "escreva"=>"S11", "num"=>"E30", "rcb"=>"E30", "opm"=>"E30", "se"=>"S14", "("=>"E30", ")"=>"E30", "entao"=>"E30", "opr"=>"E30", "fimse"=>"S32", "fim"=>"E30", "$"=>"E30", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"T29", "ARG"=>"NUL", "CMD"=>"T30", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"T31", "CABECALHO"=>"T13", "CORPO"=>"T47", "EXP_R"=>"NUL"}, 

  "31" => {"inicio"=>"E31", "varinicio"=>"E31", "varfim"=>"E31", ";"=>"E31", "id"=>"S12", "inteiro"=>"E31", "real"=>"E31", "literal"=>"E31", "leia"=>"S10", "escreva"=>"S11", "num"=>"E31", "rcb"=>"E31", "opm"=>"E31", "se"=>"S14", "("=>"E31", ")"=>"E31", "entao"=>"E31", "opr"=>"E31", "fimse"=>"S32", "fim"=>"E31", "$"=>"E31", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"T29", "ARG"=>"NUL", "CMD"=>"T30", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"T31", "CABECALHO"=>"T13", "CORPO"=>"T48", "EXP_R"=>"NUL"}, 
  "32" => {"inicio"=>"R29", "varinicio"=>"R29", "varfim"=>"R29", ";"=>"R29", "id"=>"R29", "inteiro"=>"R29", "real"=>"R29", "literal"=>"R29", "leia"=>"R29", "escreva"=>"R29", "num"=>"R29", "rcb"=>"R29", "opm"=>"R29", "se"=>"R29", "("=>"R29", ")"=>"R29", "entao"=>"R29", "opr"=>"R29", "fimse"=>"R29", "fim"=>"R29", "$"=>"R29", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "33" => {"inicio"=>"E33", "varinicio"=>"E33", "varfim"=>"E33", ";"=>"E33", "id"=>"S44", "inteiro"=>"E33", "real"=>"E33", "literal"=>"E33", "leia"=>"E33", "escreva"=>"E33", "num"=>"S45", "rcb"=>"E33", "opm"=>"E33", "se"=>"E33", "("=>"E33", ")"=>"E33", "entao"=>"E33", "opr"=>"E33", "fimse"=>"E33", "fim"=>"E33", "$"=>"E33", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"T50", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"T49"}, 
  "34" => {"inicio"=>"R04", "varinicio"=>"R04", "varfim"=>"R04", ";"=>"R04", "id"=>"R04", "inteiro"=>"R04", "real"=>"R04", "literal"=>"R04", "leia"=>"R04", "escreva"=>"R04", "num"=>"R04", "rcb"=>"R04", "opm"=>"R04", "se"=>"R04", "("=>"R04", ")"=>"R04", "entao"=>"R04", "opr"=>"R04", "fimse"=>"R04", "fim"=>"R04", "$"=>"R04", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "35" => {"inicio"=>"R05", "varinicio"=>"R05", "varfim"=>"R05", ";"=>"R05", "id"=>"R05", "inteiro"=>"R05", "real"=>"R05", "literal"=>"R05", "leia"=>"R05", "escreva"=>"R05", "num"=>"R05", "rcb"=>"R05", "opm"=>"R05", "se"=>"R05", "("=>"R05", ")"=>"R05", "entao"=>"R05", "opr"=>"R05", "fimse"=>"R05", "fim"=>"R05", "$"=>"R05", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 

  "36" => {"inicio"=>"E36", "varinicio"=>"E36", "varfim"=>"E36", ";"=>"S51", "id"=>"E36", "inteiro"=>"E36", "real"=>"E36", "literal"=>"E36", "leia"=>"E36", "escreva"=>"E36", "num"=>"E36", "rcb"=>"E36", "opm"=>"E36", "se"=>"E36", "("=>"E36", ")"=>"E36", "entao"=>"E36", "opr"=>"E36", "fimse"=>"E36", "fim"=>"E36", "$"=>"E36", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "37" => {"inicio"=>"R07", "varinicio"=>"R07", "varfim"=>"R07", ";"=>"R07", "id"=>"R07", "inteiro"=>"R07", "real"=>"R07", "literal"=>"R07", "leia"=>"R07", "escreva"=>"R07", "num"=>"R07", "rcb"=>"R07", "opm"=>"R07", "se"=>"R07", "("=>"R07", ")"=>"R07", "entao"=>"R07", "opr"=>"R07", "fimse"=>"R07", "fim"=>"R07", "$"=>"R07", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "38" => {"inicio"=>"R08", "varinicio"=>"R08", "varfim"=>"R08", ";"=>"R08", "id"=>"R08", "inteiro"=>"R08", "real"=>"R08", "literal"=>"R08", "leia"=>"R08", "escreva"=>"R08", "num"=>"R08", "rcb"=>"R08", "opm"=>"R08", "se"=>"R08", "("=>"R08", ")"=>"R08", "entao"=>"R08", "opr"=>"R08", "fimse"=>"R08", "fim"=>"R08", "$"=>"R08", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "39" => {"inicio"=>"R09", "varinicio"=>"R09", "varfim"=>"R09", ";"=>"R09", "id"=>"R09", "inteiro"=>"R09", "real"=>"R09", "literal"=>"R09", "leia"=>"R09", "escreva"=>"R09", "num"=>"R09", "rcb"=>"R09", "opm"=>"R09", "se"=>"R09", "("=>"R09", ")"=>"R09", "entao"=>"R09", "opr"=>"R09", "fimse"=>"R09", "fim"=>"R09", "$"=>"R09", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "40" => {"inicio"=>"R11", "varinicio"=>"R11", "varfim"=>"R11", ";"=>"R11", "id"=>"R11", "inteiro"=>"R11", "real"=>"R11", "literal"=>"R11", "leia"=>"R11", "escreva"=>"R11", "num"=>"R11", "rcb"=>"R11", "opm"=>"R11", "se"=>"R11", "("=>"R11", ")"=>"R11", "entao"=>"R11", "opr"=>"R11", "fimse"=>"R11", "fim"=>"R11", "$"=>"R11", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 

  "41" => {"inicio"=>"R12", "varinicio"=>"R12", "varfim"=>"R12", ";"=>"R12", "id"=>"R12", "inteiro"=>"R12", "real"=>"R12", "literal"=>"R12", "leia"=>"R12", "escreva"=>"R12", "num"=>"R12", "rcb"=>"R12", "opm"=>"R12", "se"=>"R12", "("=>"R12", ")"=>"R12", "entao"=>"R12", "opr"=>"R12", "fimse"=>"R12", "fim"=>"R12", "$"=>"R12", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "42" => {"inicio"=>"E42", "varinicio"=>"E42", "varfim"=>"E42", ";"=>"S52", "id"=>"E42", "inteiro"=>"E42", "real"=>"E42", "literal"=>"E42", "leia"=>"E42", "escreva"=>"E42", "num"=>"E42", "rcb"=>"E42", "opm"=>"E42", "se"=>"E42", "("=>"E42", ")"=>"E42", "entao"=>"E42", "opr"=>"E42", "fimse"=>"E42", "fim"=>"E42", "$"=>"E42", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "43" => {"inicio"=>"E43", "varinicio"=>"E43", "varfim"=>"E43", ";"=>"R19", "id"=>"E43", "inteiro"=>"E43", "real"=>"E43", "literal"=>"E43", "leia"=>"E43", "escreva"=>"E43", "num"=>"E43", "rcb"=>"E43", "opm"=>"S53", "se"=>"E43", "("=>"E43", ")"=>"E43", "entao"=>"E43", "opr"=>"E43", "fimse"=>"E43", "fim"=>"E43", "$"=>"E43", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "44" => {"inicio"=>"R20", "varinicio"=>"R20", "varfim"=>"R20", ";"=>"R20", "id"=>"R20", "inteiro"=>"R20", "real"=>"R20", "literal"=>"R20", "leia"=>"R20", "escreva"=>"R20", "num"=>"R20", "rcb"=>"R20", "opm"=>"R20", "se"=>"R20", "("=>"R20", ")"=>"R20", "entao"=>"R20", "opr"=>"R20", "fimse"=>"R20", "fim"=>"R20", "$"=>"R20", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "45" => {"inicio"=>"R21", "varinicio"=>"R21", "varfim"=>"R21", ";"=>"R21", "id"=>"R21", "inteiro"=>"R21", "real"=>"R21", "literal"=>"R21", "leia"=>"R21", "escreva"=>"R21", "num"=>"R21", "rcb"=>"R21", "opm"=>"R21", "se"=>"R21", "("=>"R21", ")"=>"R21", "entao"=>"R21", "opr"=>"R21", "fimse"=>"R21", "fim"=>"R21", "$"=>"R21", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 

  "46" => {"inicio"=>"R26", "varinicio"=>"R26", "varfim"=>"R26", ";"=>"R26", "id"=>"R26", "inteiro"=>"R26", "real"=>"R26", "literal"=>"R26", "leia"=>"R26", "escreva"=>"R26", "num"=>"R26", "rcb"=>"R26", "opm"=>"R26", "se"=>"R26", "("=>"R26", ")"=>"R26", "entao"=>"R26", "opr"=>"R26", "fimse"=>"R26", "fim"=>"R26", "$"=>"R26", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "47" => {"inicio"=>"R27", "varinicio"=>"R27", "varfim"=>"R27", ";"=>"R27", "id"=>"R27", "inteiro"=>"R27", "real"=>"R27", "literal"=>"R27", "leia"=>"R27", "escreva"=>"R27", "num"=>"R27", "rcb"=>"R27", "opm"=>"R27", "se"=>"R27", "("=>"R27", ")"=>"R27", "entao"=>"R27", "opr"=>"R27", "fimse"=>"R27", "fim"=>"R27", "$"=>"R27", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "48" => {"inicio"=>"R28", "varinicio"=>"R28", "varfim"=>"R28", ";"=>"R28", "id"=>"R28", "inteiro"=>"R28", "real"=>"R28", "literal"=>"R28", "leia"=>"R28", "escreva"=>"R28", "num"=>"R28", "rcb"=>"R28", "opm"=>"R28", "se"=>"R28", "("=>"R28", ")"=>"R28", "entao"=>"R28", "opr"=>"R28", "fimse"=>"R28", "fim"=>"R28", "$"=>"R28", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "49" => {"inicio"=>"E49", "varinicio"=>"E49", "varfim"=>"E49", ";"=>"E49", "id"=>"E49", "inteiro"=>"E49", "real"=>"E49", "literal"=>"E49", "leia"=>"E49", "escreva"=>"E49", "num"=>"E49", "rcb"=>"E49", "opm"=>"E49", "se"=>"E49", "("=>"E49", ")"=>"S54", "entao"=>"E49", "opr"=>"E49", "fimse"=>"E49", "fim"=>"E49", "$"=>"E49", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "50" => {"inicio"=>"E50", "varinicio"=>"E50", "varfim"=>"E50", ";"=>"E50", "id"=>"E50", "inteiro"=>"E50", "real"=>"E50", "literal"=>"E50", "leia"=>"E50", "escreva"=>"E50", "num"=>"E50", "rcb"=>"E50", "opm"=>"E50", "se"=>"E50", "("=>"E50", ")"=>"E50", "entao"=>"E50", "opr"=>"S55", "fimse"=>"E50", "fim"=>"E50", "$"=>"E50", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 

  "51" => {"inicio"=>"R06", "varinicio"=>"R06", "varfim"=>"R06", ";"=>"R06", "id"=>"R06", "inteiro"=>"R06", "real"=>"R06", "literal"=>"R06", "leia"=>"R06", "escreva"=>"R06", "num"=>"R06", "rcb"=>"R06", "opm"=>"R06", "se"=>"R06", "("=>"R06", ")"=>"R06", "entao"=>"R06", "opr"=>"R06", "fimse"=>"R06", "fim"=>"R06", "$"=>"R06", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "52" => {"inicio"=>"R17", "varinicio"=>"R17", "varfim"=>"R17", ";"=>"R17", "id"=>"R17", "inteiro"=>"R17", "real"=>"R17", "literal"=>"R17", "leia"=>"R17", "escreva"=>"R17", "num"=>"R17", "rcb"=>"R17", "opm"=>"R17", "se"=>"R17", "("=>"R17", ")"=>"R17", "entao"=>"R17", "opr"=>"R17", "fimse"=>"R17", "fim"=>"R17", "$"=>"R17", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "53" => {"inicio"=>"E53", "varinicio"=>"E53", "varfim"=>"E53", ";"=>"E53", "id"=>"S44", "inteiro"=>"E53", "real"=>"E53", "literal"=>"E53", "leia"=>"E53", "escreva"=>"E53", "num"=>"S45", "rcb"=>"E53", "opm"=>"E53", "se"=>"E53", "("=>"E53", ")"=>"E53", "entao"=>"E53", "opr"=>"E53", "fimse"=>"E53", "fim"=>"E53", "$"=>"E53", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"T56", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "54" => {"inicio"=>"E54", "varinicio"=>"E54", "varfim"=>"E54", ";"=>"E54", "id"=>"E54", "inteiro"=>"E54", "real"=>"E54", "literal"=>"E54", "leia"=>"E54", "escreva"=>"E54", "num"=>"E54", "rcb"=>"E54", "opm"=>"E54", "se"=>"E54", "("=>"E54", ")"=>"E54", "entao"=>"S57", "opr"=>"E54", "fimse"=>"E54", "fim"=>"E54", "$"=>"E54", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "55" => {"inicio"=>"E55", "varinicio"=>"E55", "varfim"=>"E55", ";"=>"E55", "id"=>"S44", "inteiro"=>"E55", "real"=>"E55", "literal"=>"E55", "leia"=>"E55", "escreva"=>"E55", "num"=>"S45", "rcb"=>"E55", "opm"=>"E55", "se"=>"E55", "("=>"E55", ")"=>"E55", "entao"=>"E55", "opr"=>"E55", "fimse"=>"E55", "fim"=>"E55", "$"=>"E55", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"T58", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 

  "56" => {"inicio"=>"R18", "varinicio"=>"R18", "varfim"=>"R18", ";"=>"R18", "id"=>"R18", "inteiro"=>"R18", "real"=>"R18", "literal"=>"R18", "leia"=>"R18", "escreva"=>"R18", "num"=>"R18", "rcb"=>"R18", "opm"=>"R18", "se"=>"R18", "("=>"R18", ")"=>"R18", "entao"=>"R18", "opr"=>"R18", "fimse"=>"R18", "fim"=>"R18", "$"=>"R18", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "57" => {"inicio"=>"R24", "varinicio"=>"R24", "varfim"=>"R24", ";"=>"R24", "id"=>"R24", "inteiro"=>"R24", "real"=>"R24", "literal"=>"R24", "leia"=>"R24", "escreva"=>"R24", "num"=>"R24", "rcb"=>"R24", "opm"=>"R24", "se"=>"R24", "("=>"R24", ")"=>"R24", "entao"=>"R24", "opr"=>"R24", "fimse"=>"R24", "fim"=>"R24", "$"=>"R24", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
  "58" => {"inicio"=>"R25", "varinicio"=>"R25", "varfim"=>"R25", ";"=>"R25", "id"=>"R25", "inteiro"=>"R25", "real"=>"R25", "literal"=>"R25", "leia"=>"R25", "escreva"=>"R25", "num"=>"R25", "rcb"=>"R25", "opm"=>"R25", "se"=>"R25", "("=>"R25", ")"=>"R25", "entao"=>"R25", "opr"=>"R25", "fimse"=>"R25", "fim"=>"R25", "$"=>"R25", "P'"=>"NUL", "P"=>"NUL", "V"=>"NUL", "A"=>"NUL", "LV"=>"NUL", "D"=>"NUL", "TIPO"=>"NUL", "ES"=>"NUL", "ARG"=>"NUL", "CMD"=>"NUL", "LD"=>"NUL", "OPRD"=>"NUL", "COND"=>"NUL", "CABECALHO"=>"NUL", "CORPO"=>"NUL", "EXP_R"=>"NUL"}, 
}

$pilha = ["00"]

$ip = retorna_proximo_token

while $indice_codigo <= $codigo_fonte.length do
  action = $tabela_sintatica[ $pilha[-1] ] [ $ip ]
  case action[0]
  when "S"
    $pilha.push($ip)
    $pilha.push(action[1..-1])
    $ip = retorna_proximo_token
  when "R"
    # Remove 2|B| da pilha
    for count in 1..(2 * $gramatica[action[1..-1]].size)
      $pilha.pop
    end
    # Empilha A
    $pilha.push($gramatica[action[1..-1]].left)
    # Empilha desvio[s'A]
    if $tabela_sintatica[$pilha[-2]][$pilha[-1]][0] == "T"
      $pilha.push($tabela_sintatica[$pilha[-2]][$pilha[-1]][1..-1])
    else
      p action
      p "Erro na tabela sintática"
      exit!
    end
    p $gramatica[action[1..-1]].left + " -> " + $gramatica[action[1..-1]].right
  when "E"
    p "Error " + action + "| ip: " + $ip + "| topo pilha: " + $pilha[-1]
    exit!
  when "A"
    p "Accept"
    break
  end
  #p $pilha
end




