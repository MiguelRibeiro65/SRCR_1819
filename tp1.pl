%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Sistema de representação de conhecimento e raciocínio com capacidade para caracterizar um universo de discurso na área da prestação de cuidados de saúde.

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
:-dynamic consulta/4.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de conhecimento

%---- Caracterização de utente: idUt, Nome, Idade, Cidade -> {V,F}

utente( 1, anabela, 21, viana_do_castelo ).
utente( 2, bernardo, 16, porto ).
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

%---- Caracterização de serviço: idServ, Descrição, Instituição, Cidade -> {V,F}

servico( 1, cardiologia, hospital_sao_joao, porto).
servico( 2, neurologia, hospital_de_guimaraes, guimaraes).
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


%---- Caracterização de consulta : Data, idUt, idServ, Custo

consulta( '01_02_2017', 1, 1, 40 ).
consulta( '04_01_2016', 2, 3, 100 ).
consulta( '14_03_2014', 3, 13, 20 ).
consulta( '30_10_2015', 4, 5, 5 ).
consulta( '29_02_2011', 5, 2, 15 ).
consulta( '10_12_2012', 6, 4, 20 ).
consulta( '11_11_2010', 7, 4, 25 ).
consulta( '01_04_2019', 8, 1, 100 ).
consulta( '19_05_2015', 9, 5, 1000 ).
consulta( '01_07_2017', 10, 2, 23 ).
consulta( '21_09_2016', 11, 14, 46 ).
consulta( '18_10_2009', 12, 7, 200 ).
consulta( '01_02_2007', 13, 13, 20 ).
consulta( '17_12_2017', 14, 1, 30 ).
consulta( '23_11_2019', 15, 6, 10 ).
consulta( '16_10_2018', 16, 12, 15 ).
consulta( '12_01_2016', 17, 8, 150 ).
consulta( '19_03_2015', 18, 11, 55 ).
consulta( '17_10_2014', 19, 9, 20 ).
consulta( '24_11_2016', 20, 10, 5 ).



%----------------------------------- 1 ---- Registar utentes, serviços e consultas -------------------------------------------

% Extensao do predicado registarUtente: idUt, Nome, Idade, Cidade -> {V,F} 

registarUtente( ID, Nome, Idade, Cidade ) :- 
	evolucao( utente( ID, Nome, Idade, Cidade ) ).


% Extensao do predicado registarServiço: idServ, Descrição, Instituição, Cidade -> {V,F} 

registarServico( ID, Descricao, Instituicao, Cidade ) :- 
	evolucao( servico( ID, Descricao, Instituicao, Cidade ) ).


% Extensao do predicado registarConsulta: Data, IDUt, IDServ, Custo -> {V,F} 

registarConsulta( Data, IDUt, IDServ, Custo ) :- 
	evolucao( consulta( Data, IDUt, IDServ, Custo ) ).

%----------------------------------- 2 ---- Remover utentes, serviços e consultas -------------------------------------------

% Extensao do predicado removerUtente: idUt, Nome, Idade, Cidade -> {V,F}

removerUtente( ID, Nome, Idade, Cidade) :-
	involucao( utente( ID, Nome, Idade, Cidade ) ).

% Extensao do predicado removerServico: idServ, Descricao, Instituicao, Cidade -> {V,F}

removerServico( ID, Descricao, Instituicao, Cidade) :-
	involucao( servico( ID, Descricao, Instituicao, Cidade ) ).

% Extensao do predicado removerConsulta: Data, idUt, idServ, Custo -> {V,F}

removerConsulta( Data, IDUt, IDServ, Custo) :-
	involucao( consulta( Data, IDUt, IDServ, Custo ) ).

%-------------------------- 3 -------Identificar as instituições prestadoras de serviços-------------------------------------

% Extensao do predicado instituicoeServicos: 



%------------------------------- 6 ---- Identificar os utentes de um serviço/instituição ------------------------------------
% Extensoa do predicado utentesInstituicao : Instituicao, ListaUtentes -> {V,F}


%----------------------------------------------- Extensao de Meta-Predicados ------------------------------------------------ 

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
	remover( T ),
	teste( LI ).
	

% Extensao do predicado comprimento : ListaElementos, Resultado -> {V,F}

comprimento( [],0 ).
comprimento( [H|T], N ) :-
	comprimento( T, X ),
	N is X+1.

% Extensao do predicado construir: ListaSoluções -> {V,F}

% Extensao do predicado nao: Termo -> {V,F}

nao( T ) :-
	T, !, fail.
nao( T ).

%---------------------------------------------------- Invariantes ---------------------------------------------------------- 

%-------------------- Não deixa inserir utentes com o mesmo id. 

+utente( IDU, _, _, _ ) :: ( solucoes( IDU, utente( IDU, _, _, _ ), S ),
							comprimento( S,N ),
							N == 1 ).

%-------------------- Não deixa inserir serviços com o mesmo id. 

+servico( IDS, _, _, _ ) :: ( solucoes( IDS, servico( IDS, _, _, _ ), S ), 
							comprimento( S, N),
							N == 1 ).

%-------------------- Não deixa inserir consultas iguais

+consulta( Data, IDU, IDS, Custo) :: ( solucoes( ( Data, IDU, IDS, Custo ), consulta( Data, IDU, IDS, Custo ), S),
										comprimento( S, N),
										N == 1 ).














