grammar CAA ;

/*
    PARSER RULES
 */
actions         :   OUTERSEP?
                    '('
                        (OUTERSEP? action OUTERSEP?)+
                    ')'
                    OUTERSEP? EOF ;

action			:	'(' OUTERSEP? LABEL
                        OUTERSEP? conjunction
                        OUTERSEP? filters
                        OUTERSEP? consequence
                        OUTERSEP? ')' ;

consequence     :   '(' (OUTERSEP (rhsconjunction | message))+ OUTERSEP? ')' ;

message         :   'message(' OUTERSEP?
                    messagefrom OUTERSEP?
                    messageto OUTERSEP?
                    messagebody OUTERSEP?
                    ')' ;

// TODO: include lexers for the level names to ease extratiction in code.
messageto       :   '(to' INNERSEP ('reactive' | 'instinctive' | 'cognitive') INNERSEP? ')' ;

messagefrom     :   '(from' INNERSEP ('reactive' | 'instinctive' | 'cognitive') INNERSEP? ')' ;

// TODO: verify why it HAS to be an "INNERSEP" here (fails with "OUTERSEP").
messagebody     :   '(body' INNERSEP rhsconjunction+ OUTERSEP? ')' ;

rhsconjunction  :   '~'? conjunction ;

filters         :   '(' OUTERSEP? comparison
                        ((OUTERSEP|INNERSEP)? comparison)*
                        OUTERSEP? ')' ;

comparison          :   'filter('
                        INNERSEP? symbol
                        INNERSEP ('==' | '!=')
                        INNERSEP symbol
                        INNERSEP? ')' ;

conjunction		:	'(' OUTERSEP? logic
                        ((OUTERSEP|INNERSEP)? logic)*
                        OUTERSEP? ')' ;

logic			:	'logic('
                            INNERSEP? symbol
                            INNERSEP symbol
                            INNERSEP symbol
                            INNERSEP? ')' ;

symbol          :   LABEL ;

/*
    LEXER RULES
 */
fragment QUESTION   :   '?' ;

LABEL		        :	QUESTION? [a-zA-Z0-9]+ ;

fragment WHITESPACE	:	(' ' | '\t') ;

fragment NEWLINE    :   ('\r'? '\n' | '\r') ;

INNERSEP            :   WHITESPACE+ ;

OUTERSEP            :   (WHITESPACE | NEWLINE)+ ;