# 1.
/*SELECT ultimo_nome, ator_id
 
FROM ator 
WHERE ator_id BETWEEN 20 AND 100 
ORDER BY ator_id, ultimo_nome DESC;*/

/**/
#2.
/* Paises cadastrados*/
SELECT DISTINCT *
FROM pais;

/**/
#3.
/* Conta os PAISES*/
SELECT COUNT(pais)
FROM pais;

/**/
#4.
/* Termina com a Letra A*/
SELECT *
FROM pais
WHERE pais like '%A';

/**/
#5.
/* Ano PUBLI */
SELECT DISTINCT ano_de_lancamento
FROM filme
ORDER BY ano_de_lancamento DESC;

/**/
#6.
/* Filme . 100 & Classificação "G"*/
SELECT titulo, duracao_do_filme, classificacao
FROM filme
WHERE duracao_do_filme > 100 AND classificacao = 'G';

/**/

/*Quantidade de Filmes por Classificações*/
SELECT  COUNT(DISTINCT classificacao)
FROM filme;

/**/

UPDATE filme
SET ano_de_lancamento = 2007
WHERE titulo LIKE 'B%';

/**/

SELECT ano_de_lancamento, titulo FROM filme; /* verificar */

/**/

/*SET SQL_SAFE_UPDATES=0;*/   /*  DESABILITAR A SEGURANÇA DO SQL*/

/**/
SET SQL_SAFE_UPDATES = 0;
UPDATE filme
SET ano_de_lancamento = 2008
WHERE duracao_da_locacao < 4  AND classificacao = 'PG';


/**/

SELECT ano_de_lancamento, duracao_da_locacao, classificacao, titulo FROM filme ORDER BY duracao_da_locacao ASC;

/**/

UPDATE filme
SET  idioma_id = 6
WHERE preco_da_locacao > 4;

/**/

SELECT * FROM filme;
SELECT * FROM idioma;

/**/

UPDATE filme
SET  idioma_id = 3
WHERE preco_da_locacao = 0.99;

/**/

SELECT titulo, idioma_id, preco_da_locacao FROM filme ORDER BY idioma_id ASC;

/**/

SELECT DISTINCT preco_da_locacao 
FROM filme;

SELECT preco_da_locacao, COUNT(filme_id) 
FROM filme 
GROUP BY preco_da_locacao;

SELECT COUNT(filme_id) AS tt_filmes, preco_da_locacao
FROM filme 
GROUP BY preco_da_locacao
HAVING COUNT(filme_id) > 340 ;



SELECT filme_id, COUNT(ator_id) AS quantidade_atores 
FROM filme_ator 
GROUP BY filme_id 
ORDER BY quantidade_atores ASC; 

SELECT filme_id, COUNT(ator_id) AS quantidade_atores 
FROM filme_ator 
GROUP BY filme_id  
HAVING quantidade_atores > 5 
ORDER BY quantidade_atores ASC;

SELECT titulo, nome,  COUNT(ator_id) AS quantidade_atores
FROM filme_ator, idioma
GROUP BY filme_id
HAVING quantidade_atores > 10 AND nome = 'JAPONESE';

SELECT FILME.TITULO, COUNT(ATOR.ATOR_ID)
FROM FILME, ATOR, FILME_ATOR, IDIOMA
WHERE IDIOMA.IDIOMA_ID = FILME.IDIOMA_ID
AND FILME.FILME_ID = FILME_ATOR.FILME_ID
AND ATOR.ATOR_ID = FILME_ATOR.ATOR_ID
AND IDIOMA.NOME = 'JAPANESE'
GROUP BY FILME.TITULO
HAVING COUNT(ATOR.ATOR_ID) > 10
ORDER BY FILME.TITULO ASC;

SELECT filme, filme_ator;


/**/

SELECT MAX(duracao_da_locacao) 
FROM filme;

/**/

SELECT  COUNT(filme_id) 
FROM filme
WHERE duracao_da_locacao = 7;

/**/

SELECT COUNT(filme_id)
FROM filme
WHERE idioma_id = 3 AND duracao_da_locacao = (SELECT MAX(duracao_da_locacao) FROM filme)  
OR idioma_id = 6 AND duracao_da_locacao = (SELECT MAX(duracao_da_locacao) FROM filme);

/**/

SELECT COUNT(filme_id), classificacao, preco_da_locacao
FROM filme
GROUP BY classificacao, preco_da_locacao;

/**/

SELECT COUNT(filme_id), duracao_da_locacao, classificacao
FROM filme
WHERE duracao_da_locacao =  (SELECT MAX(duracao_da_locacao) FROM filme)
GROUP BY duracao_da_locacao, classificacao;

/**/
SELECT COUNT(filme_id), classificacao
FROM filme
GROUP BY classificacao;

/**/

SELECT filme_id f, filme_id c,  classificacao , nome, filme_id fc, COUNT(f.filme_id)
FROM filme, filme_categoria, categoria
WHERE  f.filme_id = c.filme_id 
AND    c.filme_id = fc_filme_id
GROUP BY classificacao, nome;


/**/


#30. Listar os anos de lançamento que possuem mais de 400 filmes?

SELECT COUNT(titulo) AS total_de_filme, ano_de_lancamento
FROM filme
GROUP BY ano_de_lancamento
HAVING COUNT(titulo) > 400;

-- Econtrar valor correspondente a cada filme
-- SELECT COUNT( titulo) as TOTAL FROM filme 
-- WHERE ano_de_lancamento = 2007
-- LIMIT 100;


#31. Listar os anos de lançamento dos filmes que possuem mais de 100 filmes com preço da
#locação maior que a média do preço da locação dos filmes da categoria "Children"?


SELECT COUNT(f.filme_id) AS total_filmes, f.ano_de_lancamento
FROM filme f, filme_categoria fc
WHERE f.preco_da_locacao > (SELECT AVG(preco_da_locacao) FROM filme)
AND f.filme_id = fc.filme_id
AND fc.categoria_id = 3
GROUP BY f.ano_de_lancamento
HAVING COUNT(f.filme_id) > 100 ;


#32 Quais as cidades e seu pais correspondente que pertencem a um país que inicie com a


# cidade_id,cidade FROM TABLE cidade, pais_id, pais FROM TABLE país

SELECT * FROM pais;
SELECT * FROM cidade;

SELECT c.cidade , p.pais 
FROM cidade c, pais p
WHERE c.pais_id = p.pais_id
AND p.pais LIKE "A%";


#33. Qual a quantidade de cidades por pais em ordem decrescente?

SELECT COUNT(c.cidade_id) as quantidade_cidade, p.pais
FROM cidade c, pais p
WHERE c.pais_id = p.pais_id
GROUP BY p.pais 
ORDER BY quantidade_cidade DESC
LIMIT 1000;

#Conferir as cidades e seus respectivos paises 
SELECT cidade, pais FROM cidade c, pais p
WHERE c.pais_id = p.pais_id;

#34. Qual a quantidade de cidades que iniciam com a Letra “A” por pais em ordem crescente?

SELECT COUNT(cidade_id) AS quantidade_cidade, pais 
FROM pais p, cidade c
WHERE p.pais_id = c.pais_id
AND cidade LIKE "A%"
GROUP BY pais
ORDER BY COUNT(cidade_id) ASC;

#35. Quais os países que possuem mais de 3 cidades que iniciam com a Letra "A"?

SELECT COUNT(cidade_id) AS quantidade_cidade, pais 
FROM pais p, cidade c
WHERE p.pais_id = c.pais_id
AND cidade LIKE "A%"
GROUP BY pais
HAVING COUNT(cidade_id) > 3
ORDER BY COUNT(cidade_id) ASC;

#36. Quais os países que possuem mais de 3 cidades que iniciam com a Letra "A" ou tenha "R"

SELECT COUNT(cidade_id) AS quantidade_cidade, pais 
FROM pais p, cidade c
WHERE p.pais_id = c.pais_id
AND ((cidade LIKE "A%")  OR cidade LIKE "%R%")
GROUP BY pais
ORDER BY COUNT(cidade_id) ASC;

#VERIFICAR
SELECT COUNT(cidade_id) AS quant, pais
FROM pais p, cidade c
WHERE p.pais_id = c.pais_id
AND p.pais = "Japan"
AND ((cidade LIKE "A%")  OR cidade LIKE "%R%")
GROUP BY pais;
# 

#37. Quais os clientes moram no país "United States"?

SELECT primeiro_nome, pais FROM endereco e, pais p, cliente c, cidade ci
WHERE c.endereco_id = e.endereco_id
AND   e.cidade_id  = ci.cidade_id
AND   ci.pais_id = p.pais_id
AND pais = "United States";

#38. Quantos clientes moram no país "Brazil"?

SELECT COUNT(primeiro_nome), pais FROM endereco e, pais p, cliente c, cidade ci
WHERE c.endereco_id = e.endereco_id
AND   e.cidade_id  = ci.cidade_id
AND   ci.pais_id = p.pais_id
AND pais = "Brazil"
GROUP BY p.pais;

#39. Qual a quantidade de clientes por pais?

SELECT COUNT(primeiro_nome), pais FROM endereco e, pais p, cliente c, cidade ci
WHERE c.endereco_id = e.endereco_id
AND   e.cidade_id  = ci.cidade_id
AND   ci.pais_id = p.pais_id
GROUP BY p.pais
ORDER BY COUNT(primeiro_nome) DESC;

#40. Quais países possuem mais de 10 clientes?

SELECT COUNT(primeiro_nome), pais FROM endereco e, pais p, cliente c, cidade ci
WHERE c.endereco_id = e.endereco_id
AND   e.cidade_id  = ci.cidade_id
AND   ci.pais_id = p.pais_id
GROUP BY p.pais
HAVING COUNT(primeiro_nome) > 10
ORDER BY COUNT(primeiro_nome) DESC;

#41. Qual a média de duração dos filmes por idioma?

SELECT AVG(duracao_do_filme), nome FROM idioma i, filme f
WHERE f.idioma_id = i.idioma_id
GROUP BY  i.nome;

#42. Qual a quantidade de atores que atuaram nos filmes do idioma "English"?

SELECT COUNT(a.ator_id) AS quant_atores, nome FROM filme f, filme_ator  fa, idioma i, ator a
WHERE f.filme_id = fa.filme_id
AND   fa.ator_id = a.ator_id
AND   f.idioma_id = i.idioma_id
AND  i.nome = "English"
GROUP BY i.nome;

#43. Quais os atores do filme "BLANKET BEVERLY"?

SELECT primeiro_nome, titulo FROM filme f, filme_ator fa, ator a
WHERE f.filme_id = fa.filme_id
AND  fa.ator_id = a.ator_id
AND  f.titulo = "BLANKET BEVERLY";

#44.Quais categorias possuem mais de 60 filmes cadastrados?

SELECT COUNT(titulo), nome FROM categoria c, filme f, filme_categoria fc
WHERE f.filme_id = fc.filme_id
AND   fc.categoria_id = c.categoria_id
GROUP BY c.nome
HAVING COUNT(titulo) > 60;

#45. Quais os filmes alugados (sem repetição) para clientes que moram na "Argentina"?

#########################################################################################################
SELECT distinct f.titulo FROM  aluguel a, filme f, cliente c, endereco e, cidade ci, pais p, inventario inv
WHERE  a.cliente_id = c.cliente_id
AND    a.inventario_id = inv.inventario_id
AND    inv.filme_id = f.filme_id
AND    c.endereco_id = e.endereco_id
AND    e.cidade_id  = ci.cidade_id
AND    ci.pais_id  = p.pais_id
AND    p.pais = "Argentina";
###############################################################################################################


#46. Qual a quantidade de filmes alugados por Clientes que moram na "Chile"?

SELECT COUNT( f.titulo ) as Quantidade FROM  aluguel a, filme f, cliente c, endereco e, cidade ci, pais p, inventario inv
WHERE  a.cliente_id = c.cliente_id
AND    a.inventario_id = inv.inventario_id
AND    inv.filme_id = f.filme_id
AND    c.endereco_id = e.endereco_id
AND    e.cidade_id  = ci.cidade_id
AND    ci.pais_id  = p.pais_id
AND    p.pais = "Chile";


#47. Qual a quantidade de filmes alugados por funcionário?
SELECT fun.funcionario_id, COUNT( f.titulo ) as Quantidade FROM  aluguel a, filme f, funcionario fun, endereco e, cidade ci, pais p, inventario inv
WHERE  a.funcionario_id = fun.funcionario_id
AND    a.inventario_id = inv.inventario_id
AND    inv.filme_id = f.filme_id
AND    fun.endereco_id = e.endereco_id
AND    e.cidade_id  = ci.cidade_id
AND    ci.pais_id  = p.pais_id
GROUP BY fun.funcionario_id;


#48. Qual a quantidade de filmes alugados por funcionário para cada categoria?
SELECT fun.funcionario_id, COUNT( f.titulo ) as Quantidade, ca.nome
FROM  aluguel a, filme f, funcionario fun, endereco e, cidade ci, pais p, inventario inv, categoria ca, filme_categoria fa
WHERE  a.funcionario_id = fun.funcionario_id
AND    a.inventario_id = inv.inventario_id
AND    inv.filme_id = f.filme_id
AND    fun.endereco_id = e.endereco_id
AND    e.cidade_id  = ci.cidade_id
AND    ci.pais_id  = p.pais_id
--
AND    f.filme_id = fa.filme_id
AND    fa.categoria_id = ca.categoria_id
--
GROUP BY fun.funcionario_id, ca.nome;


#.49 Quais Filmes possuem preço da Locação maior que a média de preço da locação?

SELECT titulo, preco_da_locacao FROM filme
WHERE preco_da_locacao > (SELECT AVG(preco_da_locacao) FROM filme WHERE preco_da_locacao IS NOT NULL); -- Dispensar no cálculo da média valores nulos (se tiver)

#50. Qual a soma da duração dos Filmes por categoria?

SELECT SUM(f.duracao_do_filme), a.nome FROM filme f, categoria a, filme_categoria fa
WHERE f.filme_id = fa.filme_id
AND   fa.categoria_id = a.categoria_id
GROUP BY a.nome;

# 51. Qual a quantidade de filmes locados mês a mês por ano?






 



