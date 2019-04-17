%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Sistema de representação de conhecimento e raciocínio com capacidade para caracterizar um universo de discurso na área da prestação de cuidados de saúde.
% Extensão à Programação em Lógica 

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).
:- set_prolog_flag(toplevel_print_options, [quoted(true), portrayed(true), max_depth(0)]).
:- op( 900,xfy,'::' ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Permitir inserir na base de conhecimento

:-dynamic utente/4.
:-dynamic servico/4.
:-dynamic consulta/5.
:-dynamic medico/3.

%-----------------------------------------------------------------------------------------------------------------------------
%--------------------------------------------------- Base de conhecimento ----------------------------------------------------
%-----------------------------------------------------------------------------------------------------------------------------

%---- Caracterização de utente: idUt, Nome, Idade, Cidade -> {V,F}

utente( 1, anabela, 21, viana_do_castelo ).
utente( 2, bernardo, 21, porto ).
utente( 3, carlos, 80, braga ).
utente( 4, daniela, 45, guimaraes ).
utente( 5, erica, 37, setubal ).
utente( 6, filipe, 32, guarda ).
utente( 7, guilherme, 27, povoa_de_varzim ).
utente( 8, henrique, 24, portimao ).
utente( 9, ines, 20, porto ).
utente( 10, joana, 38, famalicao ).
utente( 11, luis, 40, vila_real ).
utente( 12, pedro, 65, viana_do_castelo ).
utente( 13, ricardo, 19, setubal ).
utente( 14, raul, 42, coimbra ).
utente( 15, gil, 88, viseu ).
utente( 16, osorio, 57, viseu ).
utente( 17, sandra, 31, aveiro ).
utente( 18, tania, 48, guimaraes ).
utente( 19, veronica, 71, braga ).
utente( 20, antonio, 63, povoa_de_varzim ).


-utente( ID, Nome, Idade, Cidade ) :- 
	nao( utente( ID, Nome, Idade, Cidade ) ),
	nao( excecao( utente( ID, Nome, Idade, Cidade ) ) ).

-utente( 100, fabio, 67, lisboa ).

% A cidade de um utente é desconhecida e não queremos que se saiba

utente( 21, jose, 20, cidade_desconhecida).
excecao( utente( ID, Nome, Idade, Cidade ) ) :-
	utente( ID, Nome, Idade, cidade_desconhecida ).
nulo( cidade_desconhecida ).
+utente( ID, Nome, Idade, Cidade ) :: ( solucoes( ( ID, Nome, Idade, Cidade ), ( utente( 21, jose, 20, Cidade ), nao( nulo( Cidade ) ) ), R ),
	comprimento( R, S ),
	S == 0 ).

% Não se sabe se o nome do utente com o ID 22 é luis ou tiago

excecao( utente( 22, luis, 23, coimbra ) ).
excecao( utente( 22, tiago, 23, coimbra ) ).

% Não sabemos ao certo a idade do utente Joaquina. Sabemos apenas que é entre os 20 e os 30 anos

excecao( utente( 23, joaquina, Idade, vila_real ) ) :- 
	( Idade >= 20, Idade =< 30 ).

%---- Caracterização de serviço: idServ, Descrição, Instituição, Cidade -> {V,F}

servico( 1, cardiologia, hospital_sao_joao, porto).
servico( 2, cardiologia, hospital_de_guimaraes, guimaraes).
servico( 3, oncologia, ipo, porto).
servico( 4, ortopedia, hospital_espirito_santo, evora).
servico( 5, psiquiatria, hospital_dr_francisco_zagalpo, ovar).
servico( 6, urologia, hospital_sao_jose, fafe).
servico( 7, consulta_geral, hospital_lisboa, lisboa).
servico( 8, cirurgia_geral, hospital_sao_joao, porto).
servico( 9, cardiologia, hospital_de_braga, braga).
servico( 10, endocrinologia, hospital_sao_joao, porto).
servico( 11, anestesiologia, hospital_vila_franca_de_xira, lisboa).
servico( 12, cirurgia_plastica, hospital_distrital_figueira_foz, figueira_foz).
servico( 13, nefrologia, hospital_beatriz_angelo, loures).
servico( 14, medicina_dentaria, hospital_egas_moniz, lisboa).

-servico( ID, Descricao, Instituicao, Cidade ) :- 
	nao( servico( ID, Descricao, Instituicao, Cidade ) ),
	nao( excecao( servico( ID, Descricao, Instituicao, Cidade ) ) ).

-servico( 50, pediatria, hospital_padre_americo, penafiel ).

% A instituição onde foi prestado um dado serviço não se conhece e não queremos que se saiba

servico( 15, urologia, instituicao_desconhecida, faro).
excecao( servico( ID, Descricao, Instituicao, Cidade ) ) :-
	servico( ID, Descricao, instituicao_desconhecida, faro ).
nulo( instituicao_desconhecida ).
+servico( ID, Descricao, Instituicao, Cidade ) :: ( solucoes( ( ID, Descricao, Instituicao, Cidade ), ( servico( 15, urologia, Instituicao, faro ), nao( nulo( Instituicao ) ) ), R ),
	comprimento( R, S ),
	S == 0 ).

% Não se sabe se a descricao de um serviço com o ID 30 é pediatria ou nefrologia

excecao( servico( 30, pediatria, hospital_de_braga, braga ) ).
excecao( servico( 30, nefrologia, hospital_de_braga, braga ) ).

%---- Caracterização de consulta : Data, idUt, idMed, idServ, Custo -> {V,F}

consulta( '2017_02_01', 1, 1, 1, 40 ).
consulta( '2016_01_04', 2, 3, 3, 100 ).
consulta( '2014_03_14', 3, 4, 13, 20 ).
consulta( '2015_10_30', 4, 5, 5, 5 ).
consulta( '2011_02_29', 5, 10, 2, 15 ).
consulta( '2012_12_10', 1, 9, 4, 20 ).
consulta( '2010_11_11', 7, 1, 4, 25 ).
consulta( '2019_04_01', 8, 2, 1, 100 ).
consulta( '2015_05_19', 9, 8, 5, 1000 ).
consulta( '2017_07_01', 1, 9, 2, 23 ).
consulta( '2016_09_21', 11, 10, 14, 46 ).
consulta( '2009_10_18', 12, 7, 7, 200 ).
consulta( '2007_02_01', 13, 1, 13, 20 ).
consulta( '2017_12_17', 14, 9, 1, 30 ).
consulta( '2019_11_23', 15, 8, 6, 10 ).
consulta( '2018_10_16', 16, 1, 1, 15 ).
consulta( '2016_01_12', 17, 2, 8, 150 ).
consulta( '2015_03_19', 18, 3, 11, 55 ).
consulta( '2014_10_17', 19, 8, 9, 20 ).
consulta( '2016_11_24', 20, 3, 10, 5 ).

-consulta( Data, IDU, IDM, IDS, Custo ) :- 
	nao( consulta( Data, IDU, IDM, IDS, Custo ) ),
	nao( excecao( consulta( Data, IDU, IDM, IDS, Custo ) ) ).

-consulta( '2019_12_12', 3, 4, 6, 50000 ).

% A data de uma dada consulta é desconhecida e não queremos que se saiba

consulta( data_desconhecida, 4, 7, 10, 200 ).
excecao( consulta( Data, IDU, IDM, IDS, Custo ) ) :-
	consulta( data_desconhecida, IDU, IDM, IDS, Custo ).
nulo( data_desconhecida ).
+consulta( Data, IDU, IDM, IDS, Custo ) :: ( solucoes( ( Data, IDU, IDM, IDS, Custo ), ( consulta( Data, 4, 7, 10, 200 ), nao( nulo( Data ) ) ), R ),
	comprimento( R, S ),
	S == 0 ).

% Não se conhece o número identificativo do utente que participou numa dada consulta

excecao( consulta( '2016-04-16', 1, 2, 3, 300 ) ).
excecao( consulta( '2016-04-16', 2, 2, 3, 300 ) ).

% Não sabemos ao certo quanto custou uma dada consulta mas podemos afirmar que foi entre os 100€ e os 150€

excecao( consulta( '2018_10_12', 5, 9, 3, Custo ) ) :- 
	( Custo >= 100, Custo =< 150 ).

%---- Caracterização de médico: IDM, Nome, Especialidade -> {V,F}

medico( 1, ricardo, oncologia).
medico( 2, henrique, cardiologia).
medico( 3, joao, ortopedia).
medico( 4, paula, oncologia).
medico( 5, fernando, cirurgia_geral).
medico( 6, goncalo, urologia).
medico( 7, maria, nefrologia).
medico( 8, daniel, cirurgia_geral).
medico( 9, daniela, cardiologia).
medico( 10, francisca, oncologia).

-medico( ID, Nome, Especialidade ) :- 
	nao( medico( ID, Nome, Especialidade ) ),
	nao( excecao( medico( ID, Nome, Especialidade ) ) ).

-medico( 30, rui, cardiologia ).

% A especialidade de um dado medico não se conhece mas tmbém não queremos que se saiba

medico( 11, dinis, especialidade_desconhecida ).
excecao( medico( ID, Nome, Especialidade ) ) :-
	medico( ID, Nome, especialidade_desconhecida ).
nulo( especialidade_desconhecida ).
+medico( ID, Nome, Especialidade ) :: ( solucoes( ( ID, Nome, Especialidade ), ( medico( 11, dinis, Especialidade ), nao( nulo( Especialidade ) ) ), R ),
	comprimento( R, S ),
	S == 0 ).

% Não se conhece o nome de um dado medico

excecao( medico( 12, joel, cirurgia_geral ) ).
excecao( medico( 12, joao, cirurgia_geral ) ).

%-----------------------------------------------------------------------------------------------------------------------------
%----------------------------------------------- Extensão de Meta-Predicados -------------------------------------------------
%-----------------------------------------------------------------------------------------------------------------------------

% Extensão do meta-predicado sistema de inferência si : Questão, Resposta -> {V,F}
%															Resposta = { Verdadeiro, Falso, Desconhecido }

si( Questao, verdadeiro ) :- 
	Questao.
si( Questao, falso ) :- 
	-Questao.
si( Questao, desconhecido ) :-
	nao( Questao ),
	nao( -Questao ).

% Extensao do meta-predicado sistema de inferência para várias questões siC : ListaQuestões, ListaRespostas -> {V,F}
%															ListaRespostas = [ { Verdadeiro, Falso, Desconhecido } ]

siC( [Q|Q1], [R|R1] ) :-
	si( Q, R ),
	siC( Q1, R1 ).

% Extensao do meta-predicado nao : Termo -> {V,F}

nao( Termo ) :-
	Termo, !, fail.
nao( Termo ).

% Extensao do predicado inserir: Termo -> {V,F}

inserir( T ) :-
	assert( T ).
inserir( T ) :-
	retract( T ), !, fail.

% Extensao do predicado remover: Termo -> {V,F}

remover( T ) :-
	retract( T ).
remover( T ) :-
	assert( T ), !, fail.

% Extensao do predicado solucoes: Formato, Questão, ListaSoluções -> {V,F}

solucoes( Formato, Teorema, ListaSolucoes ) :-
	findall( Formato, Teorema, ListaSolucoes ).	

% Extensao do predicado teste: Termo -> {V,F}

teste( [] ).
teste( [I|L] ) :-
	I,
	teste( L ).

% Extensao do predicado evolucao: Conhecimento -> {V,F}

evolucao( T ) :-
	solucoes( I, +T::I, LI ),
	inserir( T ),
	teste( LI ).

% Extensao do predicado involucao: Conhecimento -> {V,F}

involucao( T ) :-
	solucoes( I, -T::I, LI ),
	teste( LI ),
	remover( T ).

% Extensao do predicado comprimento : ListaElementos, Resultado -> {V,F}

comprimento( [],0 ).
comprimento( [H|T], N ) :-
	comprimento( T, X ),
	N is X+1.

	
%-----------------------------------------------------------------------------------------------------------------------------
%---------------------------------------------------- Invariantes ------------------------------------------------------------ 
%-----------------------------------------------------------------------------------------------------------------------------

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%---------------------------- Não deixa inserir utentes com o mesmo id. 

+utente( IDU, _, _, _ ) :: ( solucoes( IDU, utente( IDU, _, _, _ ), S ),
							comprimento( S,N ),
							N == 1 ).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%--------------------------- Não deixa inserir serviços com o mesmo id. 

+servico( IDS, _, _, _ ) :: ( solucoes( IDS, servico( IDS, _, _, _ ), S ), 
							comprimento( S, N),
							N == 1 ).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%---------------------------------- Não deixa inserir consultas iguais.

+consulta( Data, IDU, IDM, IDS, Custo ) :: ( solucoes( ( Data, IDU, IDM, IDS, Custo ), consulta( Data, IDU, IDM, IDS, Custo ), S),
										comprimento( S, N ),
										N == 1 ).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%-------------------------- Não deixa remover um utente que não existe.

-utente( IDU, Nome, Idade, Cidade ) :: ( solucoes( IDU, utente( IDU, _, _, _ ), S ),
										comprimento( S, N ),
										N == 1 ).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%--------- Não deixa remover um utente com uma consulta associada a si.

-utente( IDU, _, _, _ ) :: ( solucoes( IDU, consulta( _, IDU, _, _ ), S),
							comprimento( S, N ), 
							N == 0 ).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%------------------------- Não deixa remover um serviço que não existe.

-servico( IDS, Descricao, Instituicao, Cidade ) :: ( solucoes( IDS, servico( IDS, _, _, _ ), S ),
										comprimento( S, N ),
										N == 1 ).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%-------- Não deixa remover um servico com uma consulta associada a si.

-servico( IDS, _, _, _ ) :: ( solucoes( IDS, consulta( _, _, IDS, _ ), S),
							comprimento( S, N ), 
							N == 0 ).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%----------------------- Não deixa remover uma consulta que não exista.

-consulta( Data, IDU, IDM, IDS, Custo ) :: ( solucoes( ( Data, IDU, IDM, IDS, Custo ), consulta( Data, IDU, IDM, IDS, Custo ) , S ),
										comprimento( S, N ),
										N == 1 ).





















