show tables;

insert into tbl_fornecedor (
	nome_fornecedor, 
	contato
	) 	values   (
	'Fornecedor Produtos de Limpeza',
	'Joelma'
);

insert into tbl_produto (
	nome_produto, 
	codigo_barras,
	marca,
	descricao,
	validade,
	preco_unitario,
	id_fornecedor
	) values (
    'Detergente Neutro',
    '789123456789',
    'LimpaTop',
    'Detergente Neutro, ideal para a limpeza de superfícies sensíveis',
    '2027-04-20',
    2.79,
    '1'
);

insert into tbl_categoria (
	nome_categoria
    ) values (
    'Produto de Limpeza'
);

insert into tbl_estoque (
	qtdade_estoque,
    data_movimentacao,
    tipo_movimentacao,
    id_produto
    ) values (
    '50',
    '2025-05-13',
    'ENTRADA',
    '1'
);

select 
p.nome_produto,
f.nome_fornecedor,
e.qtdade_estoque
from tbl_produto p
inner join tbl_fornecedor f
on p.id_fornecedor = f.id
inner join tbl_estoque e 
on p.id = e.id_produto;
