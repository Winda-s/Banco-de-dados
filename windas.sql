DROP DATABASE windas;
CREATE DATABASE windas;
USE windas;


CREATE TABLE hotel (
  idHotel INT AUTO_INCREMENT,
  nomeHotel VARCHAR(100) NOT NULL,
  cnpj CHAR(18) NOT NULL,
  usuarioHotel VARCHAR(50) NOT NULL, 
  emailHotel VARCHAR(100) NOT NULL,
  senha VARCHAR(20) NOT NULL,
  PRIMARY KEY (idHotel),
  UNIQUE (nomeHotel),
  UNIQUE (usuarioHotel),
  UNIQUE (emailHotel),
  UNIQUE (cnpj)
);

CREATE TABLE funcionario (
idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
fk_gerente INT,
nomeFuncionario VARCHAR(50) NOT NULL,
usuarioFuncionario VARCHAR(50) NOT NULL, 
emailFuncionario VARCHAR(100) NOT NULL,
senha VARCHAR(20) NOT NULL,
fk_hotel INT,
CONSTRAINT fk_gerente FOREIGN KEY (fk_gerente) REFERENCES funcionario(idFuncionario), 
CONSTRAINT fk_hotel FOREIGN KEY (fk_hotel) REFERENCES hotel(idHotel)
);


CREATE TABLE quarto (
    idQuarto INT NOT NULL AUTO_INCREMENT,
    numero INT NOT NULL,
    andar VARCHAR(10) NOT NULL,
    ocupacao VARCHAR(30) CHECK (ocupacao IN('Indisponível','Disponível')),
    fk_hotel INT NOT NULL,
    PRIMARY KEY (idQuarto),
    CONSTRAINT fk_quarto_hotel FOREIGN KEY (fk_hotel) REFERENCES hotel(idHotel)
);

CREATE TABLE sistema_sensor (
  idSistema_sensor INT NOT NULL AUTO_INCREMENT,
  tipo VARCHAR(50) CHECK (tipo IN('DHT11 e TCRT5000')),
  fk_quarto INT NOT NULL,
  PRIMARY KEY (idSistema_sensor),
  CONSTRAINT fk_quarto FOREIGN KEY (fk_quarto) REFERENCES quarto(idQuarto)
);

CREATE TABLE leitura (
  idLeitura INT NOT NULL AUTO_INCREMENT,
  dht11_temperatura DECIMAL(4,2) NOT NULL,
  dht11_umidade DECIMAL(4,2) NOT NULL,
  proximidade CHAR(1) NOT NULL,
  dataHora timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
  fk_sistema_sensor INT NOT NULL,
  PRIMARY KEY (idLeitura),
  CONSTRAINT fk_sistema_sensor FOREIGN KEY (fk_sistema_sensor) REFERENCES sistema_sensor(idSistema_sensor)
);



INSERT INTO hotel (nomeHotel, cnpj, usuarioHotel, emailHotel, senha)
VALUES 
    ('Ibis São Paulo', '12.345.678/0001-90','hotel_ibis_sp', 'ibissp@gmail.com','123@IbiS'),
    ('Gran Villagio Hotel', '98.765.432/0001-21','hotel_gran','granvillagio@gmail.com','GranV56!789'),
    ('Hotel Plaza', '11.223.344/0001-55','hotel_plaza', 'hotelplaza@hotmail.com', '3456Plaz%0');


INSERT INTO funcionario (fk_gerente, nomeFuncionario, usuarioFuncionario, emailFuncionario, senha, fk_hotel)
VALUES (null,'Fernanda Menezes','fer_menezes','fernandamenezes@gmail.com','1258#f&r', 1),
       (1,'Bruno Antunes','bruno.antunes','brunoantunes@gmail.com','8596%AnT',1),
       (1,'Maria Santos','maria.s','mariasantos@gmail.com','$4253Sn',1),
       (null,'Pedro Oliveira','pedro.oliveira','pedrooliveira@gmail.com','*12$Pd', 2),
       (4,'Ana Lima','ana.lima','analima@gmail.com','&9@34AL',2),
       (null,'Ricardo Silva','ricardo_silva','ricardosilva@gmail.com','@3Ric#',3),
       (6,'Camila Pereira','camila.p','camilapereira@gmail.com','CaMi$%',3),
       (6,'Carlos Vieira','carlos_vieira','carlosvieira@gmail.com','^76&CV',3);
       
       

INSERT INTO quarto (numero, andar, ocupacao, fk_hotel)
VALUES 
    (125, '6º andar', 'Disponível', 1),
    (252, '10º andar', 'Indisponível', 2),
    (354, '15º andar', 'Disponível', 3);

INSERT INTO sistema_sensor (tipo, fk_quarto)
VALUES 
    ('DHT11 e TCRT5000', 1),
     ('DHT11 e TCRT5000', 2),
   ('DHT11 e TCRT5000', 3);
   
   


/*INSERT INTO leitura ( dht11_temperatura, dht11_umidade, proximidade, dataHora, fk_sistema_sensor)
VALUES */



SELECT * FROM hotel;

SELECT * FROM funcionario;

SELECT * FROM quarto;

SELECT * FROM sistema_sensor;

SELECT * FROM leitura;

select hotel.nomeHotel,
	   funcionario.*
from hotel inner join funcionario on funcionario.fk_hotel = hotel.idHotel; 

select
         h.idHotel,
        h.nomeHotel as 'Nome Hotel',
		gerente.idFuncionario as 'id Gerente',
		gerente.nomeFuncionario as 'Gerente', 
		funcio.idFuncionario as 'id Funcionario', 
		funcio.nomeFuncionario as 'Funcionario' 
from funcionario as gerente
inner join funcionario as funcio on funcio.fk_gerente = gerente.idFuncionario
inner join hotel as h on funcio.fk_hotel = h.idHotel;


select hotel.nomeHotel,
	   quarto.*,
       leitura.*
 from hotel inner join quarto on quarto.fk_hotel = hotel.idHotel
 inner join sistema_sensor on sistema_sensor.fk_quarto = quarto.idQuarto
 inner join leitura on leitura.fk_sistema_sensor = sistema_sensor.idSistema_sensor;


