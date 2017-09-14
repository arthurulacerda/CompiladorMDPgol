tabela_de_simbolos = Hash.new

# Inicia tabela hash com as palavras reservadas
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

# Estado atual na tabela
estado = 0

# Tabela de transição
tabela_de_transicao = {
  "q00" => {"D"=>"q01","L"=>"q07","_"=>"def", "E"=>"q01", "\""=>"q08", "."=>"def", "{"=>"q10", "}"=>"def", "("=>"q26", ")"=>"q25", ">"=>"q17", "<"=>"q13", "-"=>"q20", "+"=>"q19", "*"=>"q21", "/"=>"q22", ";"=>"q24", "="=>"q23", "EOF"=>"q12", "ntspace"=>"def"}, 

  "q01" => {"D"=>"q01","L"=>"def","_"=>"def", "E"=>"q04", "\""=>"def", "."=>"q0", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def"}, 

  "q02" => {"D"=>"q03","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def"}, 

  "q03" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"q04", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def"}, 

  "q04" => {"D"=>"q06","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"q05", "+"=>"q05", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def"}, 

  "q05" => {"D"=>"q06","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def"}, 

  "q06" => {"D"=>"q06","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def"}, 

  "q07" => {"D"=>"q07","L"=>"q07","_"=>"q07", "E"=>"q07", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def"}, 

  "q08" => {"D"=>"q08","L"=>"q08","_"=>"q08", "E"=>"q08", "\""=>"q09", "."=>"q08", "{"=>"q08", "}"=>"q08", "("=>"q08", ")"=>"q08", ">"=>"q08", "<"=>"q08", "-"=>"q08", "+"=>"q08", "*"=>"q21", "/"=>"q08", ";"=>"q08", "="=>"q08", "EOF"=>"q08", "ntspace"=>"q08"}, 

  "q09" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def"}, 

  "q10" => {"D"=>"q10","L"=>"q10","_"=>"q10", "E"=>"q10", "\""=>"q10", "."=>"q10", "{"=>"q10", "}"=>"q11", "("=>"q10", ")"=>"q10", ">"=>"q10", "<"=>"q10", "-"=>"q10", "+"=>"q10", "*"=>"q21", "/"=>"q10", ";"=>"q10", "="=>"q10", "EOF"=>"q10", "ntspace"=>"q10"}, 

  "q11" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def"}, 

  "q12" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def"}, 

  "q13" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"q15", "<"=>"def", "-"=>"q16", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"q14", "EOF"=>"def", "ntspace"=>"def"}, 

  "q14" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def"}, 

  "q15" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def"}, 

  "q16" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def"}, 

  "q17" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"q18", "EOF"=>"def", "ntspace"=>"def"}, 

  "q18" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def"}, 

  "q19" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def"}, 

  "q20" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def"}, 

  "q21" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def"}, 

  "q22" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def"}, 

  "q23" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def"}, 

  "q24" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def"}, 

  "q25" => {"D"=>"def","L"=>"def","_"=>"def", "E"=>"def", "\""=>"def", "."=>"def", "{"=>"def", "}"=>"def", "("=>"def", ")"=>"def", ">"=>"def", "<"=>"def", "-"=>"def", "+"=>"def", "*"=>"q21", "/"=>"def", ";"=>"def", "="=>"def", "EOF"=>"def", "ntspace"=>"def"}, 

  "def" => {"D"=>"q00","L"=>"q00","_"=>"q00", "E"=>"q00", "\""=>"q00", "."=>"q00", "{"=>"q00", "}"=>"q00", "("=>"q00", ")"=>"q00", ">"=>"q00", "<"=>"q00", "-"=>"q00", "+"=>"q00", "*"=>"q21", "/"=>"q00", ";"=>"q00", "="=>"q00", "EOF"=>"q00", "ntspace"=>"q00"}
}

