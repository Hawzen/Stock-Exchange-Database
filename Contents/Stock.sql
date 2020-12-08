drop database Stock_Exchange;
create database Stock_Exchange;

	use Stock_Exchange;

	create table Stock_Market(
		Market_Name varchar(100),
		Currency char(3) not null,
		Market_Cap_in_trillion decimal(3,2),
		Number_Of_Stock_Symbols int,

		constraint Market_Name_PK primary key(Market_Name), 
		constraint Currency_Check check(Currency like "___")
		);

	create table Company(
		Commercial_Registration_Number varchar(100),
		Number_Of_Directors int,
		Company_Equity_in_thousand int,
		Company_Name varchar(50) not null,

		constraint Commercial_Registration_Number_PK primary key(Commercial_Registration_Number),
		constraint Number_Of_Directors_Check check(Number_Of_Directors >= 1)
		);

	create table Investor(
		IBAN_number varchar(100),
		National_ID varchar(50) not null,
		Sex char(1) not null,
		NetWorth int,
		First_Name varchar(20) not null,
		Middle_Name varchar(20) not null,
		Last_Name varchar(20) not null,

		constraint IBAN_number_PK primary key(IBAN_number)
		);

	create table Bank(
		Commercial_Registration_Number varchar(100),
		Name varchar(50) not null,
		Number_Of_Branches int,

		constraint Commercial_Registration_Number_PK primary key(Commercial_Registration_Number),
		constraint Number_Of_Branches_Check check(Number_Of_Branches >= 1)
		);

	create table Stock(
		Stock_Symbol varchar(10),
		Number_Of_Public_Stocks_in_thousand int,
		Stock_Price decimal(8,2),
		Market_Name varchar(100),
		Commercial_Registration_Number varchar(100),

		constraint Stock_Symbol_PK primary key(Stock_Symbol),
		constraint Market_Name_FK foreign key(Market_Name) references Stock_Market(Market_Name) on delete cascade on update cascade,
		constraint Commercial_Registration_Number_FK1 foreign key(Commercial_Registration_Number) references Company(Commercial_Registration_Number) on delete cascade on update cascade
		);

	create table CEO(
		Name varchar(100),
		Sex char(1) not null,
		Age int not null,
		Commercial_Registration_Number varchar(100),

		constraint Compound_PK primary key(Name , Commercial_Registration_Number),
		constraint Commercial_Registration_Number_FK2 foreign key(Commercial_Registration_Number) references Company(Commercial_Registration_Number) on update cascade on delete cascade,
		constraint Age_Check check(Age >= 23)
		);

	create table Secures(
		Stock_Symbol varchar(10),
		IBAN_number varchar(100),
		Commercial_Registration_Number varchar(100),

		constraint Compound_PK primary key(Stock_Symbol , IBAN_number , Commercial_Registration_Number),
		constraint Stock_Symbol_FK foreign key(Stock_Symbol) references Stock(Stock_Symbol) on update cascade on delete cascade,
		constraint IBAN_number_FK foreign key(IBAN_number) references Investor(IBAN_number) on update cascade on delete cascade,
		constraint Commercial_Registration_Number_FK3 foreign key(Commercial_Registration_Number) references Bank(Commercial_Registration_Number) on update cascade on delete cascade
		);

	create table Owns(
		Stock_Symbol varchar(10),
		IBAN_number varchar(100),
		Number_Of_Shares int,

		constraint Compound_PK primary key(Stock_Symbol , IBAN_number),
		constraint Stock_Symbol_FK2 foreign key(Stock_Symbol) references Stock(Stock_Symbol) on update cascade on delete cascade,
		constraint IBAN_number_FK2 foreign key(IBAN_number) references Investor(IBAN_number) on update cascade on delete cascade
		);

	insert into Stock_Market(
		Market_Name,
		Currency,
		Market_Cap_in_trillion,
		Number_Of_Stock_Symbols
		) values
		("NASDAQ", "USD",  1.72,  8100),
		("Tadawul", "SAR",  2.19,  202),
		("Tokyo Stock Exchange", "JPY",  5.67,  2292),
		("Euronext", "EUR",  4.52,  1462),
		("Shanghai Stock Exchange", "CNY",  5.01,  1041);

	insert into Investor(
		IBAN_number,
		National_ID,
		Sex,
		NetWorth,
		First_Name,
		Middle_Name,
		Last_Name
		) values
		('US281264541519999339','9498117064','M',3590070,'Brent','Aahil','Chamberlain'),
		('DE16500105174529546245','2126117000','M',99801000,'Andreas ','Sheikh ','Perez'),
		('US341922553675553244','8277836920','M',191000050,'Macauley','Lugo','Nguyen'),
		('JP821756900040913954463245','8409156649','M',962214000,'Masahiro ','Michiko ','Sakurai'),
		('JP601009600050571982645704','4142356652','M',1009860022,'Hideki','Matsumoto','Kamiya'),
		('CH4250514369317289437157','7734693388','M',5156,'Li','Dong','Brody'),
		('CH7550515162589388976886','4992719807','M',39059,'Bo','Zhou','Galindo'),
		('SA2125267688145539388743','1304026480','M',358630,'Abdo','Saad','Husain'),
		('SA4038369116113433969462','1011353190','M',459174,'Abdullah','Mohammed','Hamed'),
		('NL12RAB0813971873','2300599347','M',173115,'Ralphie','O Brien','Tyson');


	insert into Bank(
		Commercial_Registration_Number,
		Name,
		Number_Of_Branches
		) values
		('1110001116','New York Community Bank',255),
		('1010001054','Riyadh Bank',341),
		('5016604726','MUFG Bank',398),
		('2311911035','HSBC',4000),
		('1516125270','Bank of China',23682);
		
	insert into Company(
		Commercial_Registration_Number,
		Number_Of_Directors,
		Company_Equity_in_thousand,
		Company_Name
		) values
		('4457756495',22,62060000,'Amazon'),
		('5315073274',11,39800000,'Saudi Aramco'),
		('6229087803',2,20480000,'Toyota Motor'),
		('9598342161',20,13100000,'Volkswagen'),
		('6713620014',11,43000000,'Alibaba Group'),
		('8643657928',25,25003600,'Google'),
		('8857232768',13,70000000,'SABIC'),
		('1792169223',17,30310000,'Nokia'),
		('5098220895',2,43000000,'Sinopec'),
		('4001894494',2,89048000,'Softbank');


	insert into CEO(
		Name,
		Sex,
		Age,
		Commercial_Registration_Number
		) values
		('Jeff Bezos','M',56,'4457756495'),
		('Amin H. Nasser','M',60,'5315073274'),
		('Akio Toyoda','M',64,'6229087803'),
		('Herbert Diess','M',62,'9598342161'),
		('Daniel Zhang','M',48,'6713620014'),
		('Sundar Pichai','M',48,'8643657928'),
		('Yousef Al-Benyan','M',57,'8857232768'),
		('Pekka Lundmark','M',56,'1792169223'),
		('Fu Chengyu','M',69,'5098220895'),
		('Masayoshi Son','M',63,'4001894494');


	insert into Stock(
		Stock_Symbol,
		Number_Of_Public_Stocks_in_thousand,
		Stock_Price,
		Market_Name,
		Commercial_Registration_Number
		) values
		('AMZN',500890,3185,'NASDAQ','4457756495'),
		('2222',940699,35.9,'Tadawul','5315073274'),
		('4161',297472,7301,'Tokyo Stock Exchange','6229087803'),
		('VOW3',295089,149.08,'Euronext','9598342161'),
		('HKG',274500,269,'Shanghai Stock Exchange','6713620014'),
		('GOOGL',289886,1787,'NASDAQ','8643657928'),
		('2010',660000,96,'Tadawul','8857232768'),
		('4001',215350,7250,'Tokyo Stock Exchange','4001894494'),
		('NOKIA',988089,3.42,'Euronext','1792169223'),
		('SPC',1501,301,'Shanghai Stock Exchange','5098220895');

	insert into Owns(
		Stock_Symbol,
		IBAN_number,
		Number_Of_Shares
		) values
		("AMZN", "US281264541519999339",  420),
		("AMZN", "US341922553675553244",  321),
		("AMZN", "NL12RAB0813971873",  40),
		("2222", "SA2125267688145539388743",  1),
		("2222", "DE16500105174529546245",  91),
		("2222", "CH7550515162589388976886",  48),
		("4161", "SA2125267688145539388743",  2),
		("4161", "CH4250514369317289437157",  1323),
		("4161", "JP821756900040913954463245",  99),
		("VOW3", "CH7550515162589388976886",  123),
		("VOW3", "US341922553675553244",  2311),
		("VOW3", "DE16500105174529546245",  1053),
		("HKG", "JP601009600050571982645704",  9),
		("HKG", "SA4038369116113433969462",  32),
		("HKG", "JP821756900040913954463245",  1942),
		("GOOGL", "US341922553675553244",  26),
		("GOOGL", "NL12RAB0813971873",  861),
		("GOOGL", "SA4038369116113433969462",  34),
		("2010", "CH4250514369317289437157",  39),
		("2010", "CH7550515162589388976886",  504),
		("4001", "JP821756900040913954463245",  73),
		("4001", "NL12RAB0813971873",  163),
		("4001", "US341922553675553244",  16),
		("NOKIA", "JP601009600050571982645704",  19),
		("NOKIA", "SA2125267688145539388743",  3),
		("NOKIA", "DE16500105174529546245",  51),
		("SPC", "CH7550515162589388976886",  342),
		("SPC", "DE16500105174529546245",  4),
		("SPC", "SA2125267688145539388743",  999);


	insert into Secures(
		Stock_Symbol,
		IBAN_number,
		Commercial_Registration_Number
		) values
		("AMZN", "US281264541519999339", "1110001116"),
		("AMZN", "US341922553675553244", "1110001116"),
		("AMZN", "NL12RAB0813971873", "2311911035"),
		("2222", "SA2125267688145539388743", "1010001054"),
		("2222", "DE16500105174529546245", "2311911035"),
		("2222", "CH7550515162589388976886", "1516125270"),
		("4161", "SA2125267688145539388743", "1010001054"),
		("4161", "CH4250514369317289437157", "1516125270"),
		("4161", "JP821756900040913954463245", "5016604726"),
		("VOW3", "CH7550515162589388976886", "1516125270"),
		("VOW3", "US341922553675553244", "1110001116"),
		("VOW3", "DE16500105174529546245", "2311911035"),
		("HKG", "JP601009600050571982645704", "5016604726"),
		("HKG", "SA4038369116113433969462", "1010001054"),
		("HKG", "JP821756900040913954463245", "5016604726"),
		("GOOGL", "US341922553675553244", "1110001116"),
		("GOOGL", "NL12RAB0813971873", "1010001054"),
		("GOOGL", "SA4038369116113433969462", "2311911035"),
		("2010", "CH4250514369317289437157", "5016604726"),
		("2010", "CH7550515162589388976886", "1516125270"),
		("4001", "JP821756900040913954463245", "1010001054"),
		("4001", "NL12RAB0813971873", "2311911035"),
		("4001", "US341922553675553244", "5016604726"),
		("NOKIA", "JP601009600050571982645704", "2311911035"),
		("NOKIA", "SA2125267688145539388743", "1010001054"),
		("NOKIA", "DE16500105174529546245", "2311911035"),
		("SPC", "CH7550515162589388976886", "1516125270"),
		("SPC", "DE16500105174529546245", "1010001054"),
		("SPC", "SA2125267688145539388743", "1010001054");

	-- describe Stock_Market;
	-- describe Stock;
	-- describe Company;
	-- describe CEO;
	-- describe Investor;
	-- describe Bank;
	-- describe Secures;
	-- describe Owns;

	-- select * from Stock_Market;
	-- select * from Stock;
	-- select * from Company;
	-- select * from CEO;
	-- select * from Investor;
	-- select * from Bank;
	-- select * from Owns;
	-- select * from Secures;

	-- Queries
	-- select * from Investor where NetWorth > 420000000;
	-- select * from Stock where Number_Of_Public_Stocks_in_thousand < 2000; 
	-- select Last_Name from Investor where IBAN_number = "NL12RAB0813971873";
	/* select Investor.* from Secures natural join Investor 
	    where Secures.Commercial_Registration_Number=1110001116 group by Investor.IBAN_number;*/ 
	-- select Investor.* from Owns natural join Investor where Owns.Stock_Symbol="4001";
	-- select Company.* from Company natural join Stock where Stock.Stock_Price > 103.5;
	-- select Stock.* from Stock natural join Company where Number_Of_Directors >= 3; 
	-- select Bank.* from Owns natural join Secures natural join Bank where Stock_Symbol="4161";
	-- select CEO.* from CEO natural join Company natural join Stock where Stock_Price < 200;
	/* select CEO.* from CEO natural join Company 
	    natural join Stock natural join Investor
	    where NetWorth > 50000 and CEO.Sex="M" group by Name;*/ -- FULL SET