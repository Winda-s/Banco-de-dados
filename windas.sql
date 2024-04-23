Create database windas;
use windas;

CREATE TABLE endereco (
  cep INT NOT NULL,
  logradouro VARCHAR(100) NOT NULL,
  numLogradouro VARCHAR(10) NOT NULL,
  cidade VARCHAR(50) NOT NULL,
  estado VARCHAR(50) NOT NULL,
  bairro VARCHAR(50) NOT NULL,
  PRIMARY KEY (cep)
);
CREATE TABLE cadastro (
  idCadastro INT NOT NULL AUTO_INCREMENT,
  nomeHotel VARCHAR(100) NOT NULL,
  usuarioHotel VARCHAR(50) NOT NULL,
  emailHotel VARCHAR(100) NOT NULL,
  senha VARCHAR(50) NOT NULL,
  endereco_cep INT NOT NULL,
  PRIMARY KEY (idCadastro),
  UNIQUE (nomeHotel),
  UNIQUE (usuarioHotel),
  UNIQUE (emailHotel),
  INDEX fk_cadastro_endereco_idx (endereco_cep),
  CONSTRAINT fk_cadastro_endereco
    FOREIGN KEY (endereco_cep)
    REFERENCES endereco (cep)
);

CREATE TABLE hotel (
  idHotel INT NOT NULL AUTO_INCREMENT,
  nomeFantasia VARCHAR(100) NOT NULL,
  cnpj VARCHAR(20) NOT NULL,
  endereco_cep INT NOT NULL,
  PRIMARY KEY (idHotel),
  UNIQUE (cnpj),
  CONSTRAINT fk_hotel_endereco
    FOREIGN KEY (endereco_cep)
    REFERENCES endereco (cep)
);

CREATE TABLE quarto (
    idQuarto INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(100) NULL,
    andar VARCHAR(50) NULL,
    ocupacao VARCHAR(10) NULL,
    idHotel INT NULL,
    PRIMARY KEY (idQuarto),
    CONSTRAINT fk_quarto_hotel
        FOREIGN KEY (idHotel)
        REFERENCES hotel (idHotel)
);

CREATE TABLE sensor (
  idSensor INT NOT NULL AUTO_INCREMENT,
  tipo VARCHAR(100) NOT NULL,
  quarto_idQuarto INT NOT NULL,
  PRIMARY KEY (idSensor),
  CONSTRAINT fk_sensor_quarto
    FOREIGN KEY (quarto_idQuarto)
    REFERENCES quarto (idQuarto)
);

CREATE TABLE registro (
  idRegistro INT NOT NULL AUTO_INCREMENT,
  leitura VARCHAR(100) NOT NULL,
  dataHora DATETIME NOT NULL,
  temperatura VARCHAR(50) NOT NULL,
  umidade VARCHAR(50) NOT NULL,
  proximidade VARCHAR(50) NOT NULL,
  PRIMARY KEY (idRegistro)
);

CREATE TABLE logs_sistema (
  idLogs INT NOT NULL AUTO_INCREMENT,
  falha_sensor VARCHAR(100) NULL,
  sensor_idSensor INT NOT NULL,
  dtHoraLog DATETIME NULL,
  PRIMARY KEY (idLogs),
  CONSTRAINT fk_logs_sistema_sensor
    FOREIGN KEY (sensor_idSensor)
    REFERENCES sensor (idSensor)
);

INSERT INTO endereco (cep, logradouro, numLogradouro, cidade, estado, bairro)
VALUES 
    (12345678, 'Rua das Flores', '100', 'São Paulo', 'SP', 'Jardim Paulista'),
    (23456789, 'Avenida Brasil', '500', 'Rio de Janeiro', 'RJ', 'Copacabana'),
    (34567890, 'Rua da Paz', '300', 'Belo Horizonte', 'MG', 'Savassi');

INSERT INTO cadastro (nomeHotel, usuarioHotel, emailHotel, senha, endereco_cep)
VALUES 
    ('Hotel São Paulo', 'hotel_sp', 'contato@hotelsp.com', 'senha123', 12345678),
    ('Hotel Rio', 'hotel_rio', 'contato@hotelrio.com', 'senha456', 23456789),
    ('Hotel Minas', 'hotel_minas', 'contato@hotelminas.com', 'senha789', 34567890);

INSERT INTO hotel (nomeFantasia, cnpj, endereco_cep)
VALUES 
    ('Hotel Luxo Paulista', '12345678901234', 12345678),
    ('Hotel Beira-Mar', '23456789012345', 23456789),
    ('Hotel Charme Mineiro', '34567890123456', 34567890);

INSERT INTO quarto (descricao, andar, ocupacao, idHotel)
VALUES 
    ('Suíte Executiva', '5º andar', 'Disponível', 1),
    ('Quarto Standard', '2º andar', 'Ocupado', 2),
    ('Suíte Master', '10º andar', 'Disponível', 3);

INSERT INTO sensor (tipo, quarto_idQuarto)
VALUES 
    ('Sensor de Temperatura', 1),
    ('Sensor de Umidade', 2),
    ('Sensor de Proximidade', 3);

INSERT INTO registro (leitura, dataHora, temperatura, umidade, proximidade)
VALUES 
    ('Leitura 1', '2024-04-14 12:00:00', '25', '40', '1'),
    ('Leitura 2', '2024-04-14 12:15:00', '23', '50', '0'),
    ('Leitura 3', '2024-04-14 12:30:00', '22', '45', '1');

INSERT INTO logs_sistema (falha_sensor, sensor_idSensor, dtHoraLog)
VALUES 
    ('Falha no sensor 1', 1, '2024-04-14 12:00:00'),
    ('Falha no sensor 2', 2, '2024-04-14 12:15:00'),
    ('Falha no sensor 3', 3, '2024-04-14 12:30:00');

SELECT * FROM endereco;

SELECT * FROM cadastro;

SELECT * FROM hotel;

SELECT * FROM quarto;

SELECT * FROM sensor;

SELECT * FROM registro;

SELECT * FROM logs_sistema;

SELECT * FROM sensor_DHT11;

SELECT * FROM sensor_LDR;


-- Mudanças
alter table logs_sistema drop constraint fk_logs_sistema_sensor;
alter table logs_sistema drop column sensor_idSensor;
truncate table sensor;

alter table logs_sistema add column idSensor_DHT11 int;
alter table logs_sistema add column idSensor_LDR int;

create table sensor_DHT11 (
idSensor_DHT11 int primary key auto_increment,
id_quarto int
);

create table sensor_LDR (
idSensor_LDR int primary key auto_increment,
id_quarto int
);

alter table registro add column idSensor_DHT11 int;
alter table registro add column idSensor_LDR int;

alter table sensor_LDR add foreign key (id_quarto) references quarto(idQuarto);
alter table sensor_DHT11 add foreign key (id_quarto) references quarto(idQuarto);

alter table logs_sistema add foreign key (idSensor_DHT11) references sensor_DHT11(idSensor_DHT11);
alter table logs_sistema add foreign key (idSensor_LDR) references sensor_LDR(idSensor_LDR);

alter table registro add foreign key (idSensor_DHT11) references sensor_DHT11(idSensor_DHT11);
alter table registro add foreign key (idSensor_LDR) references sensor_LDR(idSensor_LDR);