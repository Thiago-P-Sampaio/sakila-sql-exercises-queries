

/*SELECT ultimo_nome, ator_id
 
FROM ator 
WHERE ator_id BETWEEN 20 AND 100 
ORDER BY ator_id, ultimo_nome DESC;*/

##################################################################################################################################################
#1. Quais os países cadastrados?
SELECT *  FROM pais;

#2. Quantos países estão cadastrados?

SELECT COUNT(pais) FROM pais
WHERE pais IS NOT NULL;

#3. Quantos países que terminam com a letra "A" estão cadastrados?
SELECT * FROM pais
WHERE pais LIKE "%A";

# 4. Listar, sem repetição, os anos que houveram lançamento de filme.

SELECT DISTINCT ano_de_lancamento FROM filme;

#5. Alterar o ano de lançamento (deixar igual a 2007) para filmes que iniciem com a Letra "B".

UPDATE  filme
SET ano_de_lancamento = 2007
WHERE titulo LIKE "A%";

#6. Listar os filmes que possuem duração do filme maior que 100 e classificação igual a "G". 

SELECT titulo, classificacao FROM filme
WHERE duracao_do_filme > 100
AND classificacao = "G";

#7. Alterar o ano de lançamento igual 2008 para filmes que possuem duração da locação menor
#que 4 e classificação igual a "PG". 

#
SET SQL_SAFE_UPDATES = 0;  -- Desativar Segurança --
#
UPDATE filme
SET ano_de_lancamento = 2008
WHERE duracao_da_locacao < 4 AND classificacao = "PG";


#8. Listar a quantidade de filmes que estejam classificados como "PG-13" e preço da locação
#maior que 2.40.

SELECT COUNT(titulo) AS quantidade_filme, classificacao, preco_da_locacao FROM filme
WHERE classificacao = "PG-13" 
AND preco_da_locacao > 2.40
GROUP BY  preco_da_locacao;

#9. Quais os idiomas que possuem filmes cadastrados? 

SELECT nome FROM idioma;

#10. Alterar o idioma para "GERMAN" dos filmes que possuem preço da locação maior que 4.

#
SELECT DISTINCT f.idioma_id, nome FROM filme f, idioma i
WHERE f.idioma_id = i.idioma_id;
#
UPDATE filme
SET idioma_id = 6
WHERE preco_da_locacao > 4;

#11. Alterar o idioma para "JAPANESE" dos filmes que possuem preço da locação igual 0.99.
#
SELECT DISTINCT f.idioma_id, nome FROM filme f, idioma i
WHERE f.idioma_id = i.idioma_id;
#
UPDATE filme
SET idioma_id = 3
WHERE preco_da_locacao = 0.99;
#

#12. Listar a quantidade de filmes por classificação.

SELECT COUNT(DISTINCT classificacao) FROM filme;
#
SELECT DISTINCT classificacao FROM filme;

#13. Listar, sem repetição, os preços de locação dos filmes cadastrados.

SELECT DISTINCT preco_da_locacao FROM filme;


#14. Listar a quantidade de filmes por preço da locação.

SELECT COUNT(filme_id), preco_da_locacao FROM filme
GROUP BY preco_da_locacao;

#15. Listar os precos da locação que possuam mais de 340 filmes

SELECT COUNT(filme_id), preco_da_locacao FROM filme
GROUP BY preco_da_locacao
HAVING COUNT(filme_id) > 340;

#16. Listar a quantidade de atores por filme ordenando por quantidade de atores crescente.

SELECT  titulo, COUNT(ator_id) AS quantidade_atores FROM filme f , filme_ator fa
WHERE fa.filme_id = f.filme_id
GROUP BY f.titulo
ORDER BY COUNT(fa.ator_id) ASC;

#17. Listar a quantidade de atores para os filmes que possuem mais de 5 atores ordenando por
#quantidade de atores decrescente.

SELECT  titulo, COUNT(ator_id) AS quantidade_atores FROM filme f , filme_ator fa
WHERE fa.filme_id = f.filme_id
GROUP BY f.titulo
HAVING COUNT(fa.ator_id) > 5
ORDER BY COUNT(fa.ator_id) DESC;

#18. Listar o título e a quantidade de atores para os filmes que possuem o idioma "JAPANESE"
#e mais de 10 atores ordenando por ordem alfabética de título e ordem crescente de quantidade
#de atores.

SELECT titulo, COUNT(ator_id) AS quantidade_atores FROM filme f, filme_ator fa, idioma i
WHERE f.filme_id = fa.filme_id
AND   f.idioma_id = i.idioma_id
AND  i.idioma_id = "JAPANESE"
GROUP BY titulo 
HAVING COUNT(fa.ator_id) > 10
ORDER BY quantidade_atores ASC, titulo ASC ;

#19. Qual a maior duração da locação dentre os filmes?

SELECT MAX(duracao_da_locacao)  FROM filme;

#20. Quantos filmes possuem a maior duração de locação?

SELECT COUNT(titulo) AS quantidade_de_filmes FROM filme
WHERE duracao_da_locacao = (SELECT MAX(duracao_da_locacao) FROM filme);

################################################################################################################################################
################################################################################################################################################

#20. Quantos filmes possuem a maior duração de locação?
SELECT titulo, duracao_da_locacao FROM filme
WHERE duracao_da_locacao = (SELECT MAX(duracao_da_locacao) FROM filme);

#Quantos filmes do idioma "JAPANESE" ou "GERMAN" possuem a maior duração de locação?
SELECT titulo, duracao_da_locacao FROM filme f, idioma i
WHERE duracao_da_locacao = (SELECT MAX(duracao_da_locacao) FROM filme)
AND  f.idioma_id = i.idioma_id
AND i.nome = "JAPANESE" OR i.idioma_id = "GERMAN";

#22. Qual a quantidade de filmes por classificação e preço da locação?
SELECT COUNT(filme_id), preco_da_locacao, classificacao
FROM filme
GROUP BY classificacao, preco_da_locacao;

#23. Qual o maior tempo de duração de filme por categoria?
SELECT MAX(duracao_do_filme), nome FROM filme f, categoria c, filme_categoria fc
WHERE fc.categoria_id = c.categoria_id
AND   fc.filme_id = f.filme_id 
GROUP BY c.nome;

#24. Listar a quantidade de filmes por categoria
SELECT COUNT(titulo), nome FROM filme f, categoria c, filme_categoria fc
WHERE  f.filme_id = fc.filme_id
AND   fc.categoria_id = c.categoria_id
GROUP BY c.nome;

#25. Listar a quantidade de filmes classificados como "G" por categoria.
SELECT COUNT(titulo), nome, classificacao FROM filme f, categoria c, filme_categoria fc
WHERE  f.filme_id = fc.filme_id
AND   fc.categoria_id = c.categoria_id
AND  f.classificacao = "G"
GROUP BY c.nome;

#26. Listar a quantidade de filmes classificados como "G" OU "PG" por categoria.
SELECT COUNT(titulo), nome, classificacao FROM filme f, categoria c, filme_categoria fc
WHERE  f.filme_id = fc.filme_id
AND   fc.categoria_id = c.categoria_id
AND  (f.classificacao = "G"  OR f.classificacao = "PG")
GROUP BY c.nome;

#27. Listar a quantidade de filmes por categoria e classificação.
SELECT COUNT(f.filme_id) as Quantidade, nome, classificacao FROM filme f, categoria c, filme_categoria fc
WHERE f.filme_id = fc.filme_id
AND   fc.categoria_id = c.categoria_id
GROUP BY c.nome, f.classificacao;

#28. Qual a quantidade de filmes por Ator ordenando decrescente por quantidade?
SELECT COUNT(f.filme_id) as quantidade, primeiro_nome as nome_ator FROM filme f, filme_ator fa, ator a
WHERE f.filme_id = fa.filme_id
AND   fa.ator_id = a.ator_id
GROUP BY a.primeiro_nome
ORDER BY COUNT(f.filme_id) DESC;

#29. Qual a quantidade de filmes por ano de lançamento ordenando por quantidade crescente?
SELECT DISTINCT ano_de_lancamento as ano, COUNT(titulo) as quantidade 
FROM filme
GROUP BY ano_de_lancamento
ORDER BY COUNT(titulo) ASC;


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
-- Possível Erro de consulta --
SELECT DISTINCT MONTH(data_de_aluguel) AS mes, YEAR(data_de_aluguel) AS ano, COUNT(titulo) AS quantidade
FROM aluguel a, filme f, inventario inv
WHERE a.inventario_id = inv.inventario_id
AND   inv.inventario_id  = f.filme_id
GROUP BY MONTH(data_de_aluguel)
ORDER  BY MONTH(data_de_aluguel) ASC;
 
 #52. Qual o total pago por classificação de filmes alugados no ano de 2006?
# Tabela: aluguel, filme, 

######################################
SELECT SUM(valor), classificacao
FROM filme f, inventario inv, aluguel a, pagamento p
WHERE a.aluguel_id = p.aluguel_id
AND a.inventario_id = inv.inventario_id
AND inv.filme_id = f.filme_id
AND   a.data_de_aluguel LIKE "2006%"
GROUP BY f.classificacao;
###########################################
#SELECT SUM(preco_da_locacao), classificacao
#FROM filme f, inventario inv, aluguel a
#WHERE a.inventario_id = inv.inventario_id
#AND inv.filme_id = f.filme_id
#AND   a.data_de_aluguel LIKE "2006%"
#GROUP BY f.classificacao;


#53. Qual a média mensal do valor pago por filmes alugados no ano de 2005?
SELECT DISTINCT MONTH(a.data_de_aluguel) AS mes, AVG(p.valor) AS valor_mes
FROM filme f, inventario inv, aluguel a, pagamento p
WHERE a.aluguel_id = p.aluguel_id
AND a.inventario_id = inv.inventario_id
AND inv.filme_id = f.filme_id
AND  a.data_de_aluguel LIKE "2005%"
GROUP BY MONTH(data_de_aluguel);

#54. Qual o total pago por filme alugado no mês de Junho de 2006 por cliente?
##
-- Cod My--
SELECT MONTH(a.data_de_aluguel) AS mes, AVG(p.valor) AS valor_mes, primeiro_nome
FROM filme f, inventario inv, aluguel a, pagamento p, cliente cl
WHERE a.aluguel_id = p.aluguel_id
AND a.inventario_id = inv.inventario_id
AND inv.filme_id = f.filme_id
--
AND a.cliente_id = cl.cliente_id
AND p.cliente_id = cl.cliente_id
--
AND  a.data_de_aluguel LIKE "2006%"
AND MONTH(a.data_de_aluguel) = 6
GROUP BY cl.primeiro_nome;


##############
-- Cod - Madruga
SELECT primeiro_nome, SUM(valor) as total 
FROM cliente c, aluguel a, pagamento p, inventario i, filme f

WHERE a.cliente_id  = c.cliente_id = p.cliente_id

AND a.aluguel_id = p.aluguel_id
AND a.inventario_id = i.inventario_id
AND f.filme_id = i.filme_id
AND MONTH(a.data_de_aluguel) = 6
AND YEAR(a.data_de_aluguel) = 6
GROUP BY c.cliente_id;

####################################################





 


