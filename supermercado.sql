create database db_sistema_supermercado;

use db_sistema_supermercado;

create table tbl_cliente (
	id int not null primary key auto_increment,
	nome_cliente varchar(45) not null,
	cpf varchar(14) unique not null,
	data_nasc date not null
);

create table tbl_cargo (
	id int not null primary key auto_increment,
	nome_cargo varchar(45) not null,
	descricao varchar(45) not null
);

create table tbl_fornecedor (
	id int not null primary key auto_increment,
    nome_fornecedor varchar(45) not null,
	contato varchar(45) not null
);

create table tbl_categoria (
	id int not null primary key auto_increment,
	nome_categoria varchar(45) not null
);

create table tbl_colaborador (
	id int not null primary key auto_increment,
	nome_colaborador varchar(45) not null,
	cpf varchar(14) unique not null,
	data_contratacao date not null,
    salario decimal(10,2) not null,
	id_cargo int not null,

	constraint FK_Cargo_Colaborador
	foreign key (id_cargo)
	references tbl_cargo (id)
);

create table tbl_endereco_cliente (
	id int not null primary key auto_increment,
	logradouro varchar(100) not null,
	bairro varchar(60) not null,
	cep varchar(9) not null,
	cidade varchar(60) not null,
	estado char(2) not null,
	pais varchar(60) not null,
	id_cliente int not null,

	constraint FK_Cliente_Endereco
	foreign key (id_cliente)
	references tbl_cliente (id)
);

create table tbl_telefone_cliente (
	id int not null primary key auto_increment,
	numero varchar(15) not null,
	id_cliente int not null,
   
    constraint FK_Cliente_Telefone
	foreign key (id_cliente)
	references tbl_cliente (id)
);

create table tbl_email_cliente (
	id int not null primary key auto_increment,
	email varchar(255) not null,
    id_cliente int not null,

	constraint FK_Cliente_Email
    foreign key (id_cliente)
	references tbl_cliente (id)
);

-- colaborador abaixo

create table tbl_endereco_colaborador (
	id int not null primary key auto_increment,
	logradouro varchar(100) not null,
	bairro varchar(60) not null,
	cep varchar(9) not null,
	cidade varchar(60) not null,
	estado char(2) not null,
	pais varchar(60) not null,
	id_colaborador int not null,

	constraint FK_Colaborador_Endereco
	foreign key (id_colaborador)
	references tbl_colaborador (id)
);

create table tbl_telefone_colaborador (
	id int not null primary key auto_increment,
	numero varchar(15) not null,
	id_colaborador int not null,
   
	constraint FK_Colaborador_Telefone
	foreign key (id_colaborador)
	references tbl_colaborador (id)
);

create table tbl_email_colaborador (
	id int not null primary key auto_increment,
	email varchar(255) not null,
    id_colaborador int not null,

	constraint FK_Colaborador_Email
	foreign key (id_colaborador)
	references tbl_colaborador (id)
);

-- fornecedor abaixo 

create table tbl_telefone_fornecedor (
	id int not null primary key auto_increment,
	numero varchar(15) not null,
	id_fornecedor int not null,
   
    constraint FK_Fornecedor_Telefone
	foreign key (id_fornecedor)
	references tbl_fornecedor (id)
);

create table tbl_email_fornecedor (
	id int not null primary key auto_increment,
	email varchar(255) not null,
    id_fornecedor int not null,

	constraint FK_Fornecedor_Email
	foreign key (id_fornecedor)
	references tbl_fornecedor (id)
);

create table tbl_fidelidade (
	id int not null primary key auto_increment,
    pontos_cliente int not null,
	id_cliente int not null,
    
    constraint FK_Cliente_Fidelidade
    foreign key (id_cliente)
    references tbl_cliente (id)
);

create table tbl_produto (
	id int not null primary key auto_increment,
    nome_produto varchar(45) not null,
    codigo_barras varchar(20) not null,
	marca varchar(45) not null,
    descricao varchar(200) not null,
    validade date,
    preco_unitario decimal(10,2) not null,
    id_fornecedor int not null,
    
    constraint FK_Fornecedor_Produto
    foreign key (id_fornecedor)
    references tbl_fornecedor (id)
);

create table tbl_produto_categoria (
	id int not null primary key auto_increment,
	id_categoria int not null,
	id_produto int not null,
    
    constraint FK_Categoria_Produto_Categoria
	foreign key (id_categoria)
    references tbl_categoria (id),
    
    constraint FK_Produto_Categoria_Produto
    foreign key (id_produto)
    references tbl_produto (id)
);

create table tbl_promocoes (
	id int not null primary key auto_increment,
	data_inicio date not null,
	data_fim date not null,
	descricao varchar(200) not null,
	porcentagem_desconto DECIMAL(5,2) not null,
    id_produto int not null,
    
    constraint FK_Produto_Promocoes
    foreign key (id_produto)
    references tbl_produto (id)
);

create table tbl_venda (
	id int not null primary key auto_increment,
    valor_total decimal(10,2) not null,
    data_hora datetime not null,
    id_cliente int not null,
    id_colaborador int not null,
    
    constraint FK_Cliente_Venda
    foreign key (id_cliente)
    references tbl_cliente (id),
    
	constraint FK_Colaborador_Venda
    foreign key (id_colaborador)
    references tbl_colaborador (id)
);

create table tbl_produto_venda (
	id int not null primary key auto_increment,
    id_produto int not null,
    id_venda int not null,
    id_promocoes int null,
    
	constraint FK_Produto_Produto_Venda
    foreign key (id_produto)
    references tbl_produto (id),

	constraint FK_Venda_Produto_Venda
    foreign key (id_venda)
    references tbl_venda (id),
    
    constraint FK_Promocoes_Produto_Venda
    foreign key (id_promocoes)
    references tbl_promocoes (id)
);

create table tbl_forma_pagamento (
	id int not null primary key auto_increment,
    tipo_pagamento varchar(45) not null,
    valor_pago decimal(10,2) not null,
    troco decimal(10,2) not null,
    numero_transacao varchar(45) not null,
    id_venda int not null,
    
	constraint FK_Venda_Forma_Pagamento
    foreign key (id_venda)
    references tbl_venda (id)
);

create table tbl_estoque (
	id int not null primary key auto_increment,
    qtdade_estoque int not null,
    data_movimentacao date not null,
    tipo_movimentacao enum('ENTRADA', 'SAIDA') not null,
    id_produto int not null,
    
    constraint FK_Produto_Estoque
    foreign key (id_produto)
    references tbl_produto (id)
);

create table tbl_recomendacoes (
	id int not null primary key auto_increment,
    id_cliente int not null,
    id_produto int not null,

	constraint FK_Cliente_Recomendacoes
    foreign key (id_cliente)
    references tbl_cliente (id),

	constraint FK_Produto_Recomendacoes
    foreign key (id_produto)
    references tbl_produto (id)
);