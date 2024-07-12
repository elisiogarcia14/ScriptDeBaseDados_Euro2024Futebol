create database euro2024_futebol;
use euro2024_futebol;

CREATE TABLE Paises (
    id INT PRIMARY KEY,
    Nome VARCHAR(100)
);

CREATE TABLE Equipas (
    CodEquipa INT PRIMARY KEY,
    Nome VARCHAR(100),
    id_pais INT,
    FOREIGN KEY (id_pais) REFERENCES Paises(id)
);

CREATE TABLE Grupo (
    CodGrupo INT PRIMARY KEY,
    Nome VARCHAR(100)
);

CREATE TABLE Jogos (
    CodJogo INT PRIMARY KEY,
    DataJogo DATE,
    Local VARCHAR(100),
    id_grupo INT,
    id_equipaA INT,
    id_equipaB INT,
    gols_equipaA INT,
    gols_equipaB INT,
    FOREIGN KEY (id_grupo) REFERENCES Grupo(CodGrupo),
    FOREIGN KEY (id_equipaA) REFERENCES Equipas(CodEquipa),
    FOREIGN KEY (id_equipaB) REFERENCES Equipas(CodEquipa)
);

CREATE TABLE Jogadores (
    CodJogador INT PRIMARY KEY,
    Nome VARCHAR(100),
    Numero INT,
    Posicao VARCHAR(50),
    id_equipa INT,
    FOREIGN KEY (id_equipa) REFERENCES Equipas(CodEquipa)
);

CREATE TABLE EstatIndividual (
    CodInd INT PRIMARY KEY,
    id_jogo INT,
    id_jogador INT,
    Passes INT,
    Assistencias INT,
    MinutosJogados INT,
    FOREIGN KEY (id_jogo) REFERENCES Jogos(CodJogo),
    FOREIGN KEY (id_jogador) REFERENCES Jogadores(CodJogador)
);

CREATE TABLE EstatGlobal (
    CodEstat INT PRIMARY KEY,
    id_jogo INT,
    id_equipa INT,
    Remates INT,
    Livres INT,
    ForasJogos INT,
    FOREIGN KEY (id_jogo) REFERENCES Jogos(CodJogo),
    FOREIGN KEY (id_equipa) REFERENCES Equipas(CodEquipa)
);

CREATE TABLE Substituicoes (
    CodSub INT PRIMARY KEY,
    id_jogo INT,
    id_equipa INT,
    id_jogadorEntrada INT,
    id_jogadorSaida INT,
    minuto INT,
    FOREIGN KEY (id_jogo) REFERENCES Jogos(CodJogo),
    FOREIGN KEY (id_equipa) REFERENCES Equipas(CodEquipa),
    FOREIGN KEY (id_jogadorEntrada) REFERENCES Jogadores(CodJogador),
    FOREIGN KEY (id_jogadorSaida) REFERENCES Jogadores(CodJogador)
);

CREATE VIEW TodasInformacoes AS 
SELECT 
    e.CodEquipa, 
    e.Nome AS NomeEquipa, 
    e.id_pais, 
    j.CodJogo, 
    j.DataJogo, 
    j.Local, 
    j.id_grupo, 
    j.id_equipaA, 
    j.id_equipaB, 
    j.gols_equipaA, 
    j.gols_equipaB, 
    p.id AS PaisId, 
    p.Nome AS NomePais, 
    s.CodSub, 
    s.id_jogo AS SubIdJogo, 
    s.id_equipa AS SubIdEquipa, 
    s.id_jogadorEntrada, 
    s.id_jogadorSaida, 
    s.Minuto, 
    eg.CodEstat, 
    eg.Remates, 
    eg.Livres, 
    eg.ForasJogos, 
    ei.CodInd, 
    ei.Passes, 
    ei.Assistencias, 
    ei.MinutosJogados, 
    g.CodGrupo, 
    g.Nome AS NomeGrupo, 
    jog.CodJogador, 
    jog.Nome AS NomeJogador, 
    jog.Numero, 
    jog.Posicao 
FROM 
    Equipas e 
LEFT JOIN 
    Jogos j ON e.CodEquipa = j.id_equipaA OR e.CodEquipa = j.id_equipaB 
LEFT JOIN 
    Paises p ON e.id_pais = p.id 
LEFT JOIN 
    Substituicoes s ON e.CodEquipa = s.id_equipa 
LEFT JOIN 
    EstatGlobal eg ON e.CodEquipa = eg.id_equipa 
LEFT JOIN 
    EstatIndividual ei ON e.CodEquipa = ei.id_jogador 
LEFT JOIN 
    Grupo g ON j.id_grupo = g.CodGrupo 
LEFT JOIN 
    Jogadores jog ON e.CodEquipa = jog.id_equipa;








