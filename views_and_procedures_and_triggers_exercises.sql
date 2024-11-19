# PROCEDURES

DELIMITER //

CREATE PROCEDURE pais_cidade (in consulta_cidade TEXT)
BEGIN
	SELECT cidade, pais FROM cidade c
    INNER JOIN pais p ON c.pais_id = p.pais_id
    WHERE c.cidade = consulta_cidade;
END //

DELIMITER ;

CALL pais_cidade("Baku")


DELIMITER //

CREATE PROCEDURE filme_info (in consulta_FILME TEXT)
BEGIN

SELECT titulo, ano_de_lancamento, COUNT(ator_id) AS quantidade_de_atores, nome AS idioma FROM filme f
JOIN idioma i ON i.idioma_id = f.idioma_id
JOIN filme_ator fa ON fa.filme_id = f.filme_id
WHERE f.titulo = consulta_FILME
GROUP BY f.filme_id;

END //

DELIMITER ;

CALL filme_info("ACADEMY DINOSAUR")



DELIMITER //

CREATE PROCEDURE unidade_endereco (in id int)
BEGIN

SELECT loja_id AS id_loja,  endereco FROM loja l
JOIN endereco e ON l.endereco_id = e.endereco_id
WHERE l.loja_id = id;

END //

	

DELIMITER ;

CALL unidade_endereco(2);

#####################################################################################

# Views

CREATE VIEW filme_description AS
SELECT titulo, descricao FROM filme;

SELECT * FROM filme_description;



CREATE VIEW cliente_info AS
SELECT primeiro_nome, ultimo_nome, email, endereco, cidade
FROM cliente c
JOIN endereco e ON c.endereco_id = e.endereco_id 
JOIN cidade ci  ON e.cidade_id = ci.cidade_id;


SELECT * FROM cliente_info;


CREATE VIEW aluguel_info AS
SELECT aluguel_id, primeiro_nome as cliente_nome, email, data_de_aluguel, data_de_devolucao, titulo, endereco AS loja
FROM aluguel a
INNER JOIN cliente ci ON a.cliente_id = ci.cliente_id
INNER JOIN inventario i ON a.inventario_id = i.inventario_id
INNER JOIN filme f ON f.filme_id = i.filme_id
INNER JOIN loja l ON i.loja_id = l.loja_id
INNER JOIN endereco e ON e.endereco_id = l.endereco_id;

SELECT * FROM aluguel_info;

#########################################################################

#Triggers


##########################################################################

CREATE TABLE log_insert (
id INT PRIMARY KEY NOT NULL UNIQUE auto_increment,
acao VARCHAR(30),
data_hora timestamp 
);


##########################
DELIMITER //

CREATE TRIGGER log_cliente 
AFTER INSERT
ON cliente
FOR EACH ROW
BEGIN 
	INSERT INTO log_insert( acao, data_hora) VALUES ( "INSERT", NOW());
END //

DELIMITER ;
##########################
##

INSERT INTO cliente(
	loja_id,
    primeiro_nome, 
    ultimo_nome, 
    email, 
    endereco_id, 
    ativo, 
    data_criacao, 
    ultima_atualizacao
)   VALUES
(1, "João", "Silva", "joao.silva@email.com", 5, 1, '2024-11-01 10:15:30', '2024-11-18 12:00:00');


SELECT * FROM cliente;

SELECT * FROM log_insert;

##########################################################################################################

##########################
DELIMITER //

CREATE TRIGGER block_senha
BEFORE INSERT
ON funcionario
FOR EACH ROW
BEGIN
	IF NEW.senha LIKE "123%" THEN 
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = "Senha inválidada por ser muito fraca, altere";
    END IF;
END //

DELIMITER ;
##########################


SELECT * FROM funcionario;
 
 
 
 
INSERT INTO funcionario (
    primeiro_nome, 
    ultimo_nome, 
    endereco_id, 
    foto, 
    email, 
    loja_id, 
    ativo, 
    usuario, 
    senha, 
    ultima_atualizacao
) 
VALUES 
(
    'João', 
    'Silva', 
    3, 
    NULL, 
    'joao.silva@email.com', 
    1, 
    1, 
    'joaos', 
    '123456', 
    CURRENT_TIMESTAMP
);


############################################################################

##########################




##########################

DELIMITER $

CREATE TRIGGER evitar_filme_duplicado
BEFORE INSERT
ON filme
FOR EACH ROW
BEGIN
	IF EXISTS (
    SELECT 1
    FROM filme
    WHERE titulo = NEW.titulo
    )
    THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = "Erro, o filme já foi registrado";
    END if;
END $

DELIMITER ;

##########################

SELECT * FROM filme;


#################################################

INSERT INTO filme (
	filme_id,
    titulo, 
    descricao, 
    ano_de_lancamento, 
    idioma_id, 
    idioma_original_id, 
    duracao_da_locacao, 
    preco_da_locacao, 
    duracao_do_filme, 
    custo_de_substituicao, 
    classificacao, 
    recursos_especiais, 
    ultima_atualizacao
)
VALUES 
(
	1001,
    'ACADEMY DINOSAUR', 
    'Uma jornada emocionante de autodescoberta e aventura.', 
    2023, 
    3, 
    NULL, 
    7, 
    3.99, 
    120, 
    19.99, 
    'PG', 
    'Trailers,Commentaries', 
    CURRENT_TIMESTAMP
);


####################################################







