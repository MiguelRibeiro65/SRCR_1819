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


%-----------------------------------------------------------------------------------------------------------------------------
%----------------------------------- 1 ---- Registar utentes, serviços e consultas -------------------------------------------
%-----------------------------------------------------------------------------------------------------------------------------

% Extensao do predicado registarUtente: idUt, Nome, Idade, Cidade -> {V,F} 

registarUtente( ID, Nome, Idade, Cidade ) :- 
	evolucao( utente( ID, Nome, Idade, Cidade ) ).


% Extensao do predicado registarServiço: idServ, Descrição, Instituição, Cidade -> {V,F} 

registarServico( ID, Descricao, Instituicao, Cidade ) :- 
	evolucao( servico( ID, Descricao, Instituicao, Cidade ) ).


% Extensao do predicado registarConsulta: Data, IDUt, IDServ, Custo -> {V,F} 

registarConsulta( Data, IDUt, IDMed, IDServ, Custo ) :- 
	evolucao( consulta( Data, IDUt, IDMed, IDServ, Custo ) ).

% Extensao do predicado registarMedico: idMed, Nome, Especialidade -> {V,F}

registarMedico( IDM, Nome, Especialidade ) :-
	evolucao( medico( IDM, Nome, Especialidade ) ).

%-----------------------------------------------------------------------------------------------------------------------------
%----------------------------------- 2 ---- Remover utentes, serviços e consultas --------------------------------------------
%-----------------------------------------------------------------------------------------------------------------------------

% Extensao do predicado removerUtente: idUt, Nome, Idade, Cidade -> {V,F}

removerUtente( ID, Nome, Idade, Cidade) :-
	involucao( utente( ID, Nome, Idade, Cidade ) ).

% Extensao do predicado removerServico: idServ, Descricao, Instituicao, Cidade -> {V,F}

removerServico( ID, Descricao, Instituicao, Cidade) :-
	involucao( servico( ID, Descricao, Instituicao, Cidade ) ).

% Extensao do predicado removerConsulta: Data, idUt, idServ, Custo -> {V,F}

removerConsulta( Data, IDUt, IDMed, IDServ, Custo) :-
	involucao( consulta( Data, IDUt, IDMed, IDServ, Custo ) ).

% Extensao do predicado removerMedico: IDM, Nome, Especialidade -> {V,F} 

removerMedico( IDM, Nome, Especialidade ) :-
	involucao( medico( IDM, Nome, Especialidade ) ).

%-----------------------------------------------------------------------------------------------------------------------------
%-------------------------- 3 -------Identificar as instituições prestadoras de serviços--------------------------------------
%-----------------------------------------------------------------------------------------------------------------------------

% Extensão do predicado instServ: Resposta -> {V,F}

instServ( R ) :- solucoes( ( Instituicao ) ,servico( _, _, Instituicao, _ ), G ),
	eliminarRepetidos( G, R ).

%-----------------------------------------------------------------------------------------------------------------------------
%----------------------------- 4a ------Identificar os utentes por critérios de seleção---------------------------------------
%-----------------------------------------------------------------------------------------------------------------------------

% Extensao do predicado utenteID: ID, Resultado -> {V,F}
utenteID( ID, R ) :- solucoes( ( ID, N, I, C ), utente( ID ,N ,I ,C ), R ).

% Extensao do predicado utenteNome: Nome, Resultado -> {V,F}
utenteNome( N, R ) :- solucoes( ( ID, N, I, C ), utente( ID, N, I, C ), R ).

% Extensao do predicado utenteIdade: Idade, Resultado -> {V,F}
utenteIdade( I, R ) :- solucoes( ( ID, N, I, C ), utente( ID, N, I, C ), R ).

% Extensao do predicado utenteCidade: Cidade, Resultado -> {V,F}
utenteCidade( C, R ) :- solucoes( ( ID, N, I, C ), utente( ID, N, I, C ), R ).

%-----------------------------------------------------------------------------------------------------------------------------
%------------------------------ 4b --------Identificar os serviços por critérios de seleção-----------------------------------
%-----------------------------------------------------------------------------------------------------------------------------

% Extensao do predicado servicoID: ID, Resultado -> {V,F}
servicoID( ID, R ) :- solucoes( ( ID, D, I, C ), servico( ID, D, I, C ), R ).

% Extensao do predicado servicoDescricao: Descricao, Resultado -> {V,F}
servicoDescricao( D, R ) :- solucoes( ( ID, D, I, C ), servico( ID, D, I, C ), R ).

% Extensao do predicado servicoInstituicao: Instituicao, Resultado -> {V,F}
servicoInstituicao( I, R ) :- solucoes( ( ID, D, I, C ), servico( ID, D, I, C ), R ).

% Extensao do predicado servicoCidade: Cidade, Resultado -> {V,F}
servicoCidade( C, R ) :- solucoes( ( ID, D, I, C ), servico( ID, D, I, C ), R ).

%-----------------------------------------------------------------------------------------------------------------------------
%------------------------------ 4c ------Identificar as consultas por critérios de seleção------------------------------------
%-----------------------------------------------------------------------------------------------------------------------------

% Extensao do predicado consultaData: Data , Resultado -> {V,F}
consultaData( D, R ) :- solucoes( ( D, IDU, IDM, IDS, C ), consulta( D, IDU, IDM, IDS, C ), R ).

% Extensao do predicado consultaIDUtente: IDUtente , Resultado -> {V,F}
consultaIDUtente( IDU, R ) :- solucoes( ( D, IDU, IDM,  IDS, C ), consulta( D, IDU, IDM, IDS, C ), R ).

% Extensao do predicado consultaIDServico: IDServico , Resultado -> {V,F}
consultaIDServico( IDS, R ) :- solucoes( ( D, IDU, IDM, IDS, C ), consulta( D, IDU, IDM, IDS, C ), R ).

% Extensao do predicado consultaCusto: Custo , Resultado -> {V,F}
consultaCusto( C, R ) :- solucoes( ( D, IDU, IDM, IDS, C ), consulta( D, IDU, IDM, IDS, C ), R ).

% Extensao do predicado consultaMedico: IDMedico, Resultado -> {V,F}
consultaMedico( IDM, R ) :- solucoes( ( Data, IDU, IDM, IDS, Custo ), consulta( Data, IDU, IDM, IDS, Custo ), R ).

%-----------------------------------------------------------------------------------------------------------------------------
%-----------------------5------Identificar consultas prestadas por instituição/cidade/datas/custo-----------------------------
%-----------------------------------------------------------------------------------------------------------------------------

% Extensao do predicado consultasInstituicao: Instituicao, Resposta -> {V,F}

consultasInstituicao( Instituicao, R ) :- solucoes( ( Data, IDU, IDM, IDS, Custo ), ( servico( IDS, _, Instituicao, _ ), consulta( Data, IDU, IDM, IDS, Custo ) ), R ).

% Extensao do predicado consultasCidade: Cidade, Resposta -> {V,F}

consultasCidade( Cidade , R ) :- solucoes( ( Data, IDU, IDM, IDS, Custo ), ( servico( IDS, _, _, Cidade ), consulta( Data, IDU, IDM, IDS, Custo ) ), R ).

% Extensao do predicado consultasDatas :- Data, Resposta -> {V,F}

consultasData( Data, R ) :- solucoes( (Data, IDU, IDM,  IDS, Custo ), consulta( Data, IDU, IDM, IDS, Custo ) , R ).

% Extensao do predicado consultasCusto: Custo, Resposta -> {V,F}

consultasCusto( Custo, R ) :- solucoes( (Data, IDU, IDM, IDS, Custo ), consulta( Data, IDU, IDM, IDS, Custo ), R ).

%-----------------------------------------------------------------------------------------------------------------------------
%------------------------------- 6 ---- Identificar os utentes de um serviço/instituição -------------------------------------
%-----------------------------------------------------------------------------------------------------------------------------

% Extenso do predicado utentesServicos : Descricao, Resposta -> {V,F}

utentesServicos( Descricao, R ) :- solucoes( ( IDU, Nome, Idade, Cidade ), ( servico( IDS, Descricao, _, _), consulta( _, IDU, _, IDS, _ ),  utente( IDU, Nome, Idade, Cidade ) ), LR ),
	eliminarRepetidos( LR, R ).

% Extensao do predicado utentesInstituicao : Instituicao, ListaUtentes -> {V,F}

utentesInstituicao( Instituicao, R ) :- solucoes( ( IDU, Nome, Idade, Cidade ), (servico( IDS, _, Instituicao, _ ), consulta( _, IDU, _, IDS, _ ), utente( IDU, Nome, Idade, Cidade ) ), LR ),
	eliminarRepetidos( LR, R ).

%-----------------------------------------------------------------------------------------------------------------------------
%-------------------- 7 ---- Identificar serviços realizados por utente/instituição/cidade; ----------------------------------
%-----------------------------------------------------------------------------------------------------------------------------

% Extensao do predicado servicosUtente : IDUtente, Resposta -> {V,F}

servicosUtente( IDU, R ) :- solucoes( Servico,(consulta( _, IDU, _, IDS, _), servico(IDS, Servico, _, _ ) ) , LR ),
	eliminarRepetidos( LR, R ).

% Extensao do predicado servicosInstituicao : Instituicao, Resposta -> {V,F}

servicosInstituicao( Instituicao, R ) :- solucoes( Servico, servico( _, Servico, Instituicao, _ ), LR ),
	eliminarRepetidos( LR, R ).

% Extensao do predicado servicosCidade : Cidade , Resposta -> {V,F}

servicosCidade( Cidade, R ) :- solucoes( Servico, servico( _, Servico, _, Cidade ), LR ),
	eliminarRepetidos( LR, R ).

%-----------------------------------------------------------------------------------------------------------------------------
%----------- 8 ---- Calcular o custo total dos cuidados de saúde por utente/serviço/instituição/data. ------------------------
%-----------------------------------------------------------------------------------------------------------------------------

% Extensao do predicado custoUtente : Utente -> {V,F}

custoUtente( IDU ) :- solucoes( Custo, consulta( _, IDU, _, _, Custo), R ),
	somarLista( R, G ),
	write('Custo do utente '),write(IDU),write(' é '),write(G),write('€'),nl.

% Extensao do predicado custoServiço : Serviço -> {V,F}

custoServico( IDS ) :- solucoes( Custo, consulta( _, _, _, IDS, Custo), R ),
	somarLista( R, G ),
	write('Custo total do servico '),write(IDS),write(' é '),write(G),write('€'),nl.

% Extensao do predicado custoInstituicao : Instituição -> {V,F}

custoInstituicao( Instituicao ) :- solucoes( Custo, (servico( IDS, _, Instituicao, _ ), consulta( _, _, _, IDS, Custo) ), R ),
	somarLista( R, G ),
	write('Rendimento total da instituicao '),write(Instituicao),write(' é '),write(G),write('€'),nl.

% Extensao do predicado custoData : Data -> {V,F}

custoData( Data ) :- solucoes( Custo, consulta( Data, _, _, _, Custo), R ),
	somarLista( R, G ),
	write('Rendimento total na data '),write(Data),write(' é '),write(G),write('€'),nl.

%-----------------------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------- Extras ------------------------------------------------------------ 
%-----------------------------------------------------------------------------------------------------------------------------

%------------------------------------------------------------------------
%-------- Identificar os medicos por critérios de seleção----------------
%------------------------------------------------------------------------

% Extensao do predicado medicoID: ID, Resultado -> {V,F}
medicoID( ID, R ) :- solucoes( ( ID, N, E ), medico( ID, N, E), R ).

% Extensao do predicado medicoNome: Nome, Resultado -> {V,F}
medicoNome( N, R ) :- solucoes( ( ID, N, E ), medico( ID, N, E), R ).

% Extensao do predicado medicoEspecialidade: Especialidade, Resultado -> {V,F}
medicoEspecialidade( E, R ) :- solucoes( ( ID, N, E ), medico( ID, N, E ), R ).

%------------------------------------------------------------------------
%-------- Identificar consultas realizadas por médicos ------------------
%------------------------------------------------------------------------

% Extensao do predicado consultasMedico: IDMed, Resposta -> {V,F}

consultasMedico( IDM, R ) :- solucoes( ( Data, IDU, IDM, IDS, Custo ) , consulta( Data, IDU, IDM, IDS, Custo ), R ).

%------------------------------------------------------------------------
%-------- Rendimento de um dado médico ----------------------------------
%------------------------------------------------------------------------

% Extensao do predicado rendimentoMedico : IDMed -> {V,F}

rendimentoMedico( IDM ) :- solucoes( Custo, consulta( _, _, IDM, _, Custo ), LR ),
	somarLista( LR , R ),
	write( 'O(A) Dr(a). com o ID ' ),write( IDM ),write( ' teve um rendimento de ' ),write( R ),write( '€' ),nl.

%------------------------------------------------------------------------
%--------- Número de utentes que frequentam uma certa instituição -------
%------------------------------------------------------------------------

% Extensao do predicado nUtentesInstituicao : Instituicao -> {V,F}

nUtentesInstituicao( Instituicao ) :- solucoes( IDU, ( servico( IDS, _, Instituicao, _ ), consulta( _, IDU, IDS, _ ) ), R ),
	eliminarRepetidos( R, N),
	comprimento( N, G ),
	write('Na instituição '),write( Instituicao ),write(' frequenta(m) '),write(G),write(' utente(s).'),nl.

%------------------------------------------------------------------------
%--------- Número de serviços de uma instituição ------------------------
%------------------------------------------------------------------------

% Extensao do predicado nServicosInstituicao : Instituicao -> {V,F}

nServicosInstituicao( Instituicao ) :- solucoes( IDS, servico( IDS, _, Instituicao, _ ), R ),
	comprimento( R, N ),
	write( 'Na instituicao '),write( Instituicao ),write( ' existem '),write( N ),write( ' serviços.'),nl.

%------------------------------------------------------------------------
%--------- Número de pacientes de um médico -----------------------------
%------------------------------------------------------------------------

% Extensao do predicado nUtentesMedico : IDMed -> {V,F}

nUtentesMedico( IDM ) :- solucoes( IDU, consulta( _, IDU, IDM, _, _ ), LR ),
	comprimento( LR, N ),
	write( 'O médico com o ID ' ),write( IDM ),write( ' possui ' ),write( N ),write( ' paciente(s).'),nl.

%------------------------------------------------------------------------
%--------- Número de instituições que um médico  frequentou -------------
%------------------------------------------------------------------------

% Extensao do predicado nInstituicoesMedico : IDMed -> {V,F}

nInstituicoesMedico( IDM ) :- solucoes( Instituicao, ( consulta( _, _, IDM, IDS, _ ), servico( IDS, _, Instituicao, _ ) ), LR ),
	eliminarRepetidos( LR, G ),
	comprimento( G, N ),
	write( 'O médico com o ID '),write( IDM ),write( ' frequenta '),write( N ),write( ' instituições'),nl.

%------------------------------------------------------------------------
%--------- Rendimento de uma instituição entre duas datas ---------------
%------------------------------------------------------------------------

% Extensao do predicado rendimentoInstituicaoEntre : Instituição, Data1, Data2 -> {V,F}

rendimentoInstituicaoEntre( Instituicao, Data1, Data2 ) :- solucoes( Custo, ( servico( IDS, _, Instituicao, _ ), consulta( Data, _, _, IDS, Custo), ( Data1 @=< Data ), ( Data @=< Data2 ) ), R ),
	somarLista( R, G ),
	write( 'Rendimento da instituição ' ),write( Instituicao ),write( ' entre ' ),write( Data1 ),write( ' e ' ),write( Data2 ),write( ' é de ' ),write( G ),nl.


%-----------------------------------------------------------------------------------------------------------------------------
%----------------------------------------------- Extensao de Meta-Predicados ------------------------------------------------- 
%-----------------------------------------------------------------------------------------------------------------------------

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

% Extensao do predicado nao: Termo -> {V,F}

nao( T ) :-
	T, !, fail.
nao( T ).

% Extensao do predicado eliminarElemento: Elemento, ListaElementos, ListaResultado -> {V,F}

eliminarElemento( _, [], [] ).
eliminarElemento( E, [E|T1], T2 ) :- eliminarElemento(E, T1, T2 ).
eliminarElemento( E, [H|T1], [H|T2] ) :-
	E \== H,
	eliminarElemento( E, T1, T2 ).

% Extensao do predicado eliminarRepetidos: ListaElementos, ListaResultado -> {V,F}

eliminarRepetidos( [], [] ).
eliminarRepetidos( [H|T], [H|R] ) :-
	eliminarElemento( H, T, T2 ),
	eliminarRepetidos( T2, R ).

% Extensao do predicado somarLista : ListaElementos, Resultado -> {V,F}

somarLista( [], 0 ).
somarLista( [H|T], R ) :-
	somarLista( T, N ),
	R is H+N.

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



















