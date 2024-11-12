
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

CALL unidade_endereco(2)





