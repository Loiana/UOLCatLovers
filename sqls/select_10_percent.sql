--O nome dos campos está condizente com o arquivo create_table_catfacts.sql

--A consulta ideal para obtermos 10% dos dados da tabela catfacts é esta:
SELECT tx_catfact,dt_updated,dt_send
FROM `projeto.dataset.catfacts`
TABLESAMPLE SYSTEM (10 PERCENT)

--Porém no nosso exemplo essa tabela tem pouquíssimos dados e o recurso TABLESAMPLE foi criado para trabalhar de maneira eficiente com muitos dados. 
--Dessa forma podemos não obter o resultado desejado. 
--Deixo a seguir uma opção de obter exatamente 10% dos dados independente de a tabela ter pouquíssimos dados ou muitos, porém dessa forma será exigido mais poder computacional.


WITH numbered_data AS (
  SELECT *, ROW_NUMBER() OVER () AS row_num
  FROM (SELECT * FROM `projeto.dataset.catfacts` ORDER BY RAND())
)
SELECT  tx_catfact,dt_updated,dt_send FROM numbered_data
WHERE row_num <= (SELECT CASE WHEN COUNT(*)*0.1 < 1 THEN 1 ELSE COUNT(*)*0.1 END FROM `projeto.dataset.catfacts`);

--A consulta acima usa uma CTE para retornar nossa tabela com os dados ordenados randomicamente e com um campo a mais que numera cada linha.
--A consulta logo após a CTE usa essa numeração da linha para retornar quantos registros precisamos, nesse caso é feita uma conta para calcular 10% do total de linhas e caso esse número seja abaixo de 1, retornamos ao menos 1 linha.


--Consulta com exportação de dados para um arquivo na uri informada
EXPORT DATA OPTIONS(
  uri='gs://bucket-name/arquivo.csv',  -- Especifique o caminho do bucket do Google Cloud Storage
  format='CSV',
  overwrite=true,
  header=true 
) AS
SELECT tx_catfact,dt_updated,dt_send
FROM `projeto.dataset.catfacts`
TABLESAMPLE SYSTEM (10 PERCENT)

