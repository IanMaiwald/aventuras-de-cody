/* description: Interpreta e executa comandos no Compiland. */

/* lexical grammar */
%lex
%%

"-"                   /* skip whitespace */
"cody"                return 'CODY'
"andar"               return 'ANDAR'
"pular"               return 'PULAR'
"parar"               return 'PARAR'
"esquerda"            return 'ESQUERDA'
"direita"             return 'DIREITA'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex


%start programa

%% /* language grammar */

programa
    : comando+ EOF
        %{
            $$ = {
                nodeType: 'PROGRAMA', 
                sentenca: $1
            };
            return $$;  
        %}
    ;

cody
    : CODY
	;
	
pular
    : PULAR
	;
	
andar
	: ANDAR
	;
	
acao
	: pular
	| andar
	;
	
direcao
    : ESQUERDA
    | DIREITA
    ;

parar
	: PARAR
	;

comando
    : cody acao direcao
	{
		$$ = {
			nodeType: 'COMANDO', 
			name: 'acao_direcao', 
			params: [$2,$3] 
		};
	}
    | cody pular
        {
		$$ = {
			nodeType: 'COMANDO', 
			name: 'acao_pular', 
			params: [$2] 
		};
	}
    | cody parar
        {
		$$ = {
			nodeType: 'COMANDO', 
			name: 'acao_parar', 
			params: [$2] 
		};
	}
	;