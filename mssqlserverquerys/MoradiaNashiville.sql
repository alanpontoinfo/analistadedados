

/*  Apos criar view , fazer um repositorio no github e subir os arquivos
baxar o arquivo neishvale.xls e imortar para o sql*/


Select * from ProjetoPortfolio.dbo.MoradiaNashiville


/* Cleaning data in sql queries / Limpando dados com consultas em sql*/

-- Standardize Date Format/ Padronizar Formato de Data

Select DataDaVenda, CONVERT(Date, DataDaVenda, 103) from ProjetoPortfolio.dbo.MoradiaNashiville

/*convertendo data para formato brasileiro*/
Select DataDaVenda, CONVERT(Varchar(10), DataDaVenda, 103) as datav 
from ProjetoPortfolio.dbo.MoradiaNashiville /*com alias*/
Select DataDaVenda, CONVERT(Varchar, DataDaVenda, 103) 
from ProjetoPortfolio.dbo.MoradiaNashiville /*sem alias*/


/*UPDATE MoradiaNashiville
set DataDaVenda = CONVERT(Varchar, DataDaVenda, 103)
erro => Msg 242, Level 16, State 3, Line 54
The conversion of a varchar data type to a datetime data type resulted in an out-of-range value.
The statement has been terminated.
*/

UPDATE MoradiaNashiville /*teste essa clausula e veja o erro mostrado a incompatibilidade na conversao dentre varchar e datatime*/
set DataDaVenda = CONVERT(varchar,DataDaVenda, 103)

/*Solucionamos criando uma coluna do tipo varchar para atualizar a data para formato brasileiro com a Função CONVERT()  */
Alter Table MoradiaNashiville
Add DataDaVendaConvertido Varchar(10)
UPDATE MoradiaNashiville
set DataDaVendaConvertido =  CONVERT(varchar(10), DataDaVenda, 103) 

Select DataDaVenda,DataDaVendaConvertido , CONVERT(varchar(10), DataDaVenda, 103) from ProjetoPortfolio.dbo.MoradiaNashiville

Select DataDaVendaConvertido  from ProjetoPortfolio.dbo.MoradiaNashiville


/* Populate Property address data/ Preenchendo dados EnderecoDoProprietario*/

select *  from ProjetoPortfolio.dbo.MoradiaNashiville
order by ParcelID

/*  Procurando Endereço nulos*/
select EnderecoDoProprietario from ProjetoPortfolio.dbo.MoradiaNashiville where EnderecoDoProprietario is null

Select a.ParcelID, a.EnderecoDoProprietario, b.ParcelID, b.EnderecoDoProprietario, 
ISNULL(a.EnderecoDoProprietario, b.EnderecoDoProprietario)
 from ProjetoPortfolio.dbo.MoradiaNashiville a
Join ProjetoPortfolio.dbo.MoradiaNashiville b
   on a.ParcelID = b.ParcelID
   and a.[UniqueID ] <> b.[UniqueID ]
Where a.EnderecoDoProprietario is null

Update a
set EnderecoDoProprietario=ISNULL(a.EnderecoDoProprietario, b.EnderecoDoProprietario)
 from ProjetoPortfolio.dbo.MoradiaNashiville a
Join ProjetoPortfolio.dbo.MoradiaNashiville b
   on a.ParcelID = b.ParcelID
   and a.[UniqueID ] <> b.[UniqueID ]
where a.EnderecoDoProprietario is null


/* Breaking out Address into Individual Columns /Dividindo o endereço em colunas individuais(Endereco, Cidade, Estado) */

Select EnderecoDoProprietario
from ProjetoPortfolio.dbo.MoradiaNashiville

SELECT
SUBSTRING(EnderecoDaPropriedade, 1, CHARINDEX(',',EnderecoDaPropriedade )-1) as Endereco
, SUBSTRING(EnderecoDaPropriedade, CHARINDEX(',', EnderecoDaPropriedade) +1, LEN(EnderecoDaPropriedade)) as Endereco
from ProjetoPortfolio.dbo.MoradiaNashiville

/* Criando mais tabela*/

Alter Table MoradiaNashiville
Add EnderecoDoProprietarioDividido nVarchar(255)

UPDATE MoradiaNashiville
set EnderecoDaPropriedadeDividido = SUBSTRING(EnderecoDaPropriedade, 1, 
CHARINDEX( ',', EnderecoDaPropriedade) -1)

 Alter Table MoradiaNashiville
Add CidadeDoProprietarioDividio nVarchar(255)

UPDATE MoradiaNashiville  
set CidadeDaPropriedadeDividido = SUBSTRING(EnderecoDaPropriedade, CHARINDEX(',',EnderecoDaPropriedade) +1, LEN(EnderecoDaPropriedade)) 

select * from ProjetoPortfolio.dbo.MoradiaNashiville

select EnderecoDaPropriedade,EnderecoDoProprietario from ProjetoPortfolio.dbo.MoradiaNashiville

Select 
PARSENAME(REPLACE(EnderecoDoProprietario, ',', '.'), 3),
PARSENAME(REPLACE(EnderecoDoProprietario, ',', '.'), 2),
PARSENAME(REPLACE(EnderecoDoProprietario, ',', '.'), 1)
 from ProjetoPortfolio.dbo.MoradiaNashiville

  Alter Table MoradiaNashiville
Add EnderecoDoProprietarioDividido nVarchar(255)

 UPDATE MoradiaNashiville
set EnderecoDoProprietarioDividido = PARSENAME(REPLACE(EnderecoDoProprietario, ',', '.'), 3)

 Alter Table MoradiaNashiville
Add CidadeDoProprietarioDividido nVarchar(255)

 UPDATE MoradiaNashiville
set CidadeDoProprietarioDividido = PARSENAME(REPLACE(EnderecoDoProprietario, ',', '.'), 2)

 Alter Table MoradiaNashiville
Add EstadoDoProprietarioDividido nVarchar(255)

 UPDATE MoradiaNashiville
set EstadoDoProprietarioDividido = PARSENAME(REPLACE(EnderecoDoProprietario, ',', '.'), 1)


select * from ProjetoPortfolio.dbo.MoradiaNashiville


/*Change y and N to yes and No In "sold as vacant" field/ Mude Y e N para Yes e No em Campo "VendidoComoVago"*/

 select distinct(VendidoComoVago), count(VendidoComoVago)
from ProjetoPortfolio.dbo.MoradiaNashiville
group by VendidoComoVago
order by 2

 select VendidoComoVago,
Case When VendidoComoVago = 'y' then 'yes'
      When VendidoComoVago = 'N' Then 'No'
      else VendidoComoVago
      End
from ProjetoPortfolio.dbo.MoradiaNashiville


update MoradiaNashiville
set VendidoComoVago = Case When VendidoComoVago = 'y' then 'yes'
      When VendidoComoVago = 'N' Then 'No'
      else VendidoComoVago
      End


/* Removendo dados duplicados/ remove duplicates*/
/*Usando o cte para particionar as colunas que não podem ter informações duplicadas*/

WITH RowNumCTE AS(
select * ,
   ROW_NUMBER() Over (
   PARTITION BY ParcelID,
                EnderecoDaPropriedade,
                PrecoDaVenda,
                DataDaVenda,
                ReferenciaJuridica
             Order By
               UniqueID)
                row_num
from ProjetoPortfolio.dbo.MoradiaNashiville
 --order by ParcelID
)
select * from RowNumCTE
where row_num > 1
order by EnderecoDaPropriedade

delete from RowNumCTE
where row_num > 1

/* Delete unused Columns/ Detetando colunas sem utilidade*/

Select * 
From  ProjetoPortfolio.dbo.MoradiaNashiville

Alter Table ProjetoPortfolio.dbo.MoradiaNashiville
Drop Column EnderecoDoProprietario ,DistritoFiscal, EnderecoDaPropriedade

Alter Table ProjetoPortfolio.dbo.MoradiaNashiville
Drop Column DataDaVenda, DataDaVendaConvertida


 /*Renomeando nome das Colunas  atualizadas para o nome original*/
 
  EXEC sp_rename 'ProjetoPortfolio.dbo.MoradiaNashiville.EnderecoDaPropriedadeDividido', 'EnderecoDaPropriedade', 'COLUMN';
  EXEC sp_rename '[ProjetoPortfolio].[dbo].[MoradiaNashiville].[CidadeDaPropriedadeDividido]', 'CidadeDaPropriedade', 'COLUMN';
  EXEC sp_rename '[ProjetoPortfolio].[dbo].[MoradiaNashiville].[EnderecoDoProprietarioDividido]', 'EnderecoDaProprietario', 'COLUMN';
  EXEC sp_rename '[ProjetoPortfolio].[dbo].[MoradiaNashiville].[CidadeDoProprietarioDividido]', 'CidadeDoProprietario', 'COLUMN';
  EXEC sp_rename '[ProjetoPortfolio].[dbo].[MoradiaNashiville].[EstadoDoProprietarioDividido]', 'EstadoDoProprietario', 'COLUMN';
  EXEC sp_rename '[ProjetoPortfolio].[dbo].[MoradiaNashiville].[DataDaVendaConvertido]', 'DataDaVenda', 'COLUMN';
	   
 */