# Estados finais
estados_finais = ["q01", "q03", "q06", "q07", "q09", "q11", "q12", "q13", "q14", "q15", "q16", "q17", "q18", "q19", "q20", "q21", "q22", "q23", "q24", "q25"]

# Estado atual na tabela.
estado_atual = "q00"

# Armazena o que está sendo lido antes de chegar ao estado indefinido.
buffer = ""

# Último caracter lido.
caracter_atual = ""

# Código fonte a ser analisado em uma única string.
codigo_fonte = IO.readlines('texto.alg')
codigo_fonte = codigo_fonte.join("")

# Índice do último caracter lido no código.
indice_codigo = 0

# Contador de linha
linha_codigo = 1

# Contador de coluna
coluna_codigo = 1

# Tabela de símbolos com lexema, token e tipo.
tabela_de_simbolos = Hash.new
# Inicia tabela de símbolos com as palavras reservadas.
# tabela_de_simbolos["lexema"] = ["token", "tipo"]
tabela_de_simbolos["inicio"] = ["inicio",""]
tabela_de_simbolos["varinicio"] = ["varinicio",""]
tabela_de_simbolos["varfim"] = ["varfim",""]
tabela_de_simbolos["escreva"] = ["escreva",""]
tabela_de_simbolos["leia"] = ["leia",""]
tabela_de_simbolos["se"] = ["se",""]
tabela_de_simbolos["entao"] = ["entao",""]
tabela_de_simbolos["fimse"] = ["fimse",""]
tabela_de_simbolos["fim"] = ["fim",""]
tabela_de_simbolos["inteiro"] = ["inteiro",""]
tabela_de_simbolos["literal"] = ["literal",""]
tabela_de_simbolos["real"] = ["real",""]

# Tabela de transição.
tabela_de_transicao = {
  "q00" => {"D"=>"q01","L"=>"q07","_"=>"def", "E"=>"q01", "\""=>"q08", "."=>"def", "{"=>"q10", "}"=>"def", "("=>"q26", ")"=>"q25", ">"=>"q17", "<"=>"q13", "-"=>"q20", "+"=>"q19", "*"=>"q21", "/"=>"q22", ";"=>"q24", "="=>"q23", "EOF"=>"q12", "ntspace"=>"def", "other"=>"def"}, 

  "q01" => {"D"=>"q01","L"=>"def","_"=>"def", "E"=>"q04", "\""=>"def", "."=>"q02", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 

  "q02" => {"D"=>"q03","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 

  "q03" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"q04", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 

  "q04" => {"D"=>"q06","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"q05", "+"=>"q05", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 

  "q05" => {"D"=>"q06","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 

  "q06" => {"D"=>"q06","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 

  "q07" => {"D"=>"q07","L"=>"q07","_"=>"q07", "E"=>"q07", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 

  "q08" => {"D"=>"q08","L"=>"q08","_"=>"q08", "E"=>"q08", "\""=>"q09", "."=>"q08", "{"=>"q08", "}"=>"q08", "("=>"q08", ")"=>"q08", ">"=>"q08", "<"=>"q08", "-"=>"q08", "+"=>"q08", "*"=>"q21", "/"=>"q08", ";"=>"q08", "="=>"q08", "EOF"=>"q08", "ntspace"=>"q08", "other"=>"q08"}, 

  "q09" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 

  "q10" => {"D"=>"q10","L"=>"q10","_"=>"q10", "E"=>"q10", "\""=>"q10", "."=>"q10", "{"=>"q10", "}"=>"q11", "("=>"q10", ")"=>"q10", ">"=>"q10", "<"=>"q10", "-"=>"q10", "+"=>"q10", "*"=>"q21", "/"=>"q10", ";"=>"q10", "="=>"q10", "EOF"=>"q10", "ntspace"=>"q10", "other"=>"q10"}, 

  "q11" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 

  "q12" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 

  "q13" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"q15", "<"=>"def", "-"=>"q16", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"q14", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 

  "q14" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 

  "q15" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 

  "q16" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 

  "q17" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"q18", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 

  "q18" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 

  "q19" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 

  "q20" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 

  "q21" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 

  "q22" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 

  "q23" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 

  "q24" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 

  "q25" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 
  
  "q26" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def", "other"=>"def"}, 

  "def" => {"D"=>"q00","L"=>"q00","_"=>"q00", "E"=>"q00", "\""=>"q00", "."=>"q00", "{"=>"q00", "}"=>"q00", "("=>"q00", ")"=>"q00", ">"=>"q00", "<"=>"q00", "-"=>"q00", "+"=>"q00", "*"=>"q21", "/"=>"q00", ";"=>"q00", "="=>"q00", "EOF"=>"q00", "ntspace"=>"q00", "other"=>"q00"}
}
 
def letra?(lookAhead)
  lookAhead =~ /[[:alpha:]]/
end

# Retorna zero
def numerico?(lookAhead)
  lookAhead =~ /[[:digit:]]/
end

def decide_tipo (caracter)
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

while true
  caracter_atual = codigo_fonte[indice_codigo]
  tipo_caracter = decide_tipo caracter_atual

  if tabela_de_transicao[estado_atual][tipo_caracter] != "def"
    estado_atual = tabela_de_transicao[estado_atual][tipo_caracter]
    buffer << caracter_atual
    indice_codigo = indice_codigo + 1
  else
    p buffer
    break
  end

  if caracter_atual.eql? "\n"
    linha_codigo = linha_codigo + 1
    coluna_codigo = 1
  else
    coluna_codigo = coluna_codigo + 1
  end
end