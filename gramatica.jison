/* description: Interpreta e executa comandos n as Aventuras de Cody. */

/* lexical grammar */
%lex
%%

"-"                   /* skip whitespace */
"cody"                	return 'CODY'
"andar"               	return 'ANDAR'
"pular"               	return 'PULAR'
"parar"               	return 'PARAR'
"esquerda"            	return 'ESQUERDA'
"direita"             	return 'DIREITA'
"."			return '.'
";"			return ';'
"("			return '('
")"			return ')'
<<EOF>>               	return 'EOF'
.                     	return 'INVALID'

/lex


%start programa

%% /* language grammar */

programa
    : (comando ';')+ EOF
        %{
            $$ = {
                nodeType: 'PROGRAMA', 
                sentenca: $1
            };
            return $$;  
        %}
    ;
	
acao
    : pular
    | andar
    ;
	
direcao
    : ESQUERDA
    | DIREITA
    ;

comando
    : CODY '.' funcao
    ;

funcao
    : ANDAR '('direcao')'
       {
		$$ = {
			nodeType: 'FUNCAO', 
			name: 'acao_direcao', 
			params: [$1,$3] 
		};
	}
    | PULAR '(' direcao')'
        {
		$$ = {
			nodeType: 'FUNCAO', 
			name: 'acao_direcao', 
			params: [$1,$3] 
		};
	}
    | PULAR '(' ')'
        {
		$$ = {
			nodeType: 'FUNCAO', 
			name: 'acao_direcao', 
			params: [$1] 
		};
	}
    | PARAR '(' ')'
	{
		$$ = {
			nodeType: 'FUNCAO', 
			name: 'acao_direcao', 
			params: [$1] 
		};
	}
    
	;