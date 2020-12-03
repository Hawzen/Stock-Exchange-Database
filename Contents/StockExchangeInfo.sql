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
		Commercial_Registriation_Number varchar(100),
		Number_Of_Directors int,
		Company_Equity_in_thousand int,
		Company_Name varchar(50) not null,

		constraint Commercial_Registriation_Number_PK primary key(Commercial_Registriation_Number),
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
		Commercial_Registriation_Number varchar(100),
		Name varchar(50) not null,
		Number_Of_Branches int,

		constraint Commercial_Registriation_Number_PK primary key(Commercial_Registriation_Number),
		constraint Number_Of_Branches_Check check(Number_Of_Branches >= 1)
		);

	create table Stock(
		Stock_Symbol varchar(10),
		Number_Of_Public_Stocks_in_thousand int,
		Stock_Price decimal(8,2),
		Market_Name varchar(100),
		Commercial_Registriation_Number varchar(100),

		constraint Stock_Symbol_PK primary key(Stock_Symbol),
		constraint Market_Name_FK foreign key(Market_Name) references Stock_Market(Market_Name) on delete set null on update cascade,
		constraint Commercial_Registriation_Number_FK1 foreign key(Commercial_Registriation_Number) references Company(Commercial_Registriation_Number) on delete set null on update cascade
		);

	create table CEO(
		Name varchar(100),
		Sex char(1) not null,
		Age int not null,
		Commercial_Registriation_Number varchar(100),

		constraint Compound_PK primary key(Name , Commercial_Registriation_Number),
		constraint Commercial_Registriation_Number_FK2 foreign key(Commercial_Registriation_Number) references Company(Commercial_Registriation_Number) on update cascade,
		constraint Age_Check check(Age >= 23)
		);

	create table Secures(
		Stock_Symbol varchar(10),
		IBAN_number varchar(100),
		Commercial_Registriation_Number varchar(100),

		constraint Compound_PK primary key(Stock_Symbol , IBAN_number , Commercial_Registriation_Number),
		constraint Stock_Symbol_FK foreign key(Stock_Symbol) references Stock(Stock_Symbol) on update cascade,
		constraint IBAN_number_FK foreign key(IBAN_number) references Investor(IBAN_number) on update cascade,
		constraint Commercial_Registriation_Number_FK3 foreign key(Commercial_Registriation_Number) references Bank(Commercial_Registriation_Number) on update cascade
		);

	create table Owns(
		Stock_Symbol varchar(10),
		IBAN_number varchar(100),
		Number_Of_Shares int,

		constraint Compound_PK primary key(Stock_Symbol , IBAN_number),
		constraint Stock_Symbol_FK2 foreign key(Stock_Symbol) references Stock(Stock_Symbol) on update cascade,
		constraint IBAN_number_FK2 foreign key(IBAN_number) references Investor(IBAN_number) on update cascade
		);

	insert into Stock_Market(
		Market_Name,
		Currency,
		Market_Cap_in_trillion,
		Number_Of_Stock_Symbols
		)values(
		'NASDAQ',
		'USD',
		1.72,
		8100
		);

		insert into Stock_Market(
		Market_Name,
		Currency,
		Market_Cap_in_trillion,
		Number_Of_Stock_Symbols
		)values(
		'Tadawul',
		'SAR',
		2.19,
		202
		);

		insert into Stock_Market(
		Market_Name,
		Currency,
		Market_Cap_in_trillion,
		Number_Of_Stock_Symbols
		)values(
		'Tokyo Stock Exchange',
		'JPY',
		5.67,
		2292
		);

		insert into Stock_Market(
		Market_Name,
		Currency,
		Market_Cap_in_trillion,
		Number_Of_Stock_Symbols
		)values(
		'Euronext',
		'EUR',
		4.52,
		1462
		);

		insert into Stock_Market(
		Market_Name,
		Currency,
		Market_Cap_in_trillion,
		Number_Of_Stock_Symbols
		)values(
		'Shanghai Stock Exchange',
		'CNY',
		5.01,
		1041
		);

		insert into Investor(
			IBAN_number,
			National_ID,
			Sex,
			NetWorth,
			First_Name,
			Middle_Name,
			Last_Name
			)values(
			'US281264541519999339',
			'9498117064',
			'M',
			35970,
			'Brent',
			'Aahil',
			'Chamberlain'
			);

		insert into Investor(
			IBAN_number,
			National_ID,
			Sex,
			NetWorth,
			First_Name,
			Middle_Name,
			Last_Name
			)values(
			'DE16500105174529546245',
			'2126117000',
			'M',
			99801,
			'Andreas ',
			'Sheikh ',
			'Perez'
			);

		insert into Investor(
			IBAN_number,
			National_ID,
			Sex,
			NetWorth,
			First_Name,
			Middle_Name,
			Last_Name
			)values(
			'US341922553675553244',
			'8277836920',
			'M',
			94207,
			'Macauley',
			'Lugo',
			'Nguyen'
			);

		insert into Investor(
			IBAN_number,
			National_ID,
			Sex,
			NetWorth,
			First_Name,
			Middle_Name,
			Last_Name
			)values(
			'JP821756900040913954463245',
			'8409156649',
			'M',
			262214,
			'Masahiro ',
			'Michiko ',
			'Sakurai'
			);

		insert into Investor(
			IBAN_number,
			National_ID,
			Sex,
			NetWorth,
			First_Name,
			Middle_Name,
			Last_Name
			)values(
			'JP601009600050571982645704',
			'4142356652',
			'M',
			598622,
			'Hideki',
			'Matsumoto',
			'Kamiya'
			);

		insert into Investor(
			IBAN_number,
			National_ID,
			Sex,
			NetWorth,
			First_Name,
			Middle_Name,
			Last_Name
			)values(
			'CH4250514369317289437157',
			'7734693388',
			'M',
			5156,
			'Li',
			'Dong',
			'Brody'
			);

		insert into Investor(
			IBAN_number,
			National_ID,
			Sex,
			NetWorth,
			First_Name,
			Middle_Name,
			Last_Name
			)values(
			'CH7550515162589388976886',
			'4992719807',
			'M',
			39059,
			'Bo',
			'Zhou',
			'Galindo'
			);

		insert into Investor(
			IBAN_number,
			National_ID,
			Sex,
			NetWorth,
			First_Name,
			Middle_Name,
			Last_Name
			)values(
			'SA2125267688145539388743',
			'1304026480',
			'M',
			358630,
			'Abdo',
			'Saad',
			'Husain'
			);

		insert into Investor(
			IBAN_number,
			National_ID,
			Sex,
			NetWorth,
			First_Name,
			Middle_Name,
			Last_Name
			)values(
			'SA4038369116113433969462',
			'1011353190',
			'M',
			459174,
			'Abdullah',
			'Mohammed',
			'Hamed'
			);

		insert into Investor(
			IBAN_number,
			National_ID,
			Sex,
			NetWorth,
			First_Name,
			Middle_Name,
			Last_Name
			)values(
			'FI3819869934513876',
			'2300599347',
			'M',
			173115,
			'Ralphie',
			'O Brien',
			'Tyson'
			);

		insert into Bank(
			Commercial_Registriation_Number,
			Name,
			Number_Of_Branches
			)values(
			'2055005270',
			'New York Community Bank',
			255
			);

		insert into Bank(
			Commercial_Registriation_Number,
			Name,
			Number_Of_Branches
			)values(
			'1010001054',
			'Riyadh Bank',
			341
			);

		insert into Bank(
			Commercial_Registriation_Number,
			Name,
			Number_Of_Branches
			)values(
			'5016604726',
			'MUFG Bank',
			398
			);

		insert into Bank(
			Commercial_Registriation_Number,
			Name,
			Number_Of_Branches
			)values(
			'2311911035',
			'HSBC',
			4000
			);

		insert into Bank(
			Commercial_Registriation_Number,
			Name,
			Number_Of_Branches
			)values(
			'1516125270',
			'Bank of China',
			23682
			);

		insert into Company(
			Commercial_Registriation_Number,
			Number_Of_Directors,
			Company_Equity_in_thousand,
			Company_Name
			)values(
			'4457756495',
			22,
			62060000,
			'Amazon'
			);

		insert into Company(
			Commercial_Registriation_Number,
			Number_Of_Directors,
			Company_Equity_in_thousand,
			Company_Name
			)values(
			'5315073274',
			11,
			39800000,
			'Saudi Aramco'
			);

		insert into Company(
			Commercial_Registriation_Number,
			Number_Of_Directors,
			Company_Equity_in_thousand,
			Company_Name
			)values(
			'6229087803',
			9,
			20480000,
			'Toyota Motor'
			);

		insert into Company(
			Commercial_Registriation_Number,
			Number_Of_Directors,
			Company_Equity_in_thousand,
			Company_Name
			)values(
			'9598342161',
			20,
			13100000,
			'Volkswagen'
			);

		insert into Company(
			Commercial_Registriation_Number,
			Number_Of_Directors,
			Company_Equity_in_thousand,
			Company_Name
			)values(
			'6713620014',
			11,
			43000000,
			'Alibaba Group'
			);

		insert into Company(
			Commercial_Registriation_Number,
			Number_Of_Directors,
			Company_Equity_in_thousand,
			Company_Name
			)values(
			'8643657928',
			25,
			25003600,
			'Google'
			);

		insert into Company(
			Commercial_Registriation_Number,
			Number_Of_Directors,
			Company_Equity_in_thousand,
			Company_Name
			)values(
			'8857232768',
			13,
			70000000,
			'SABIC'
			);

		insert into Company(
			Commercial_Registriation_Number,
			Number_Of_Directors,
			Company_Equity_in_thousand,
			Company_Name
			)values(
			'1792169223',
			17,
			30310000,
			'Nokia'
			);

		insert into Company(
			Commercial_Registriation_Number,
			Number_Of_Directors,
			Company_Equity_in_thousand,
			Company_Name
			)values(
			'5098220895',
			21,
			43000000,
			'Sinopec'
			);

		insert into Company(
			Commercial_Registriation_Number,
			Number_Of_Directors,
			Company_Equity_in_thousand,
			Company_Name
			)values(
			'3741894494',
			27,
			89048000,
			'Softbank'
			);

		insert into CEO(
			Name,
			Sex,
			Age,
			Commercial_Registriation_Number
			)values(
			'Jeff Bezos',
			'M',
			56,
			'4457756495'
			);

		insert into CEO(
			Name,
			Sex,
			Age,
			Commercial_Registriation_Number
			)values(
			'Amin H. Nasser',
			'M',
			60,
			'5315073274'
			);

		insert into CEO(
			Name,
			Sex,
			Age,
			Commercial_Registriation_Number
			)values(
			'Akio Toyoda',
			'M',
			64,
			'6229087803'
			);

		insert into CEO(
			Name,
			Sex,
			Age,
			Commercial_Registriation_Number
			)values(
			'Herbert Diess',
			'M',
			62,
			'9598342161'
			);

		insert into CEO(
			Name,
			Sex,
			Age,
			Commercial_Registriation_Number
			)values(
			'Daniel Zhang',
			'M',
			48,
			'6713620014'
			);

		insert into CEO(
			Name,
			Sex,
			Age,
			Commercial_Registriation_Number
			)values(
			'Sundar Pichai',
			'M',
			48,
			'8643657928'
			);

		insert into CEO(
			Name,
			Sex,
			Age,
			Commercial_Registriation_Number
			)values(
			'Yousef Al-Benyan',
			'M',
			57,
			'8857232768'
			);

		insert into CEO(
			Name,
			Sex,
			Age,
			Commercial_Registriation_Number
			)values(
			'Pekka Lundmark',
			'M',
			56,
			'1792169223'
			);

		insert into CEO(
			Name,
			Sex,
			Age,
			Commercial_Registriation_Number
			)values(
			'Fu Chengyu',
			'M',
			69,
			'5098220895'
			);

		insert into CEO(
			Name,
			Sex,
			Age,
			Commercial_Registriation_Number
			)values(
			'Masayoshi Son',
			'M',
			63,
			'3741894494'
			);

		insert into Stock(
			Stock_Symbol,
			Number_Of_Public_Stocks_in_thousand,
			Stock_Price,
			Market_Name,
			Commercial_Registriation_Number
			)values(
			'AMZN',
			500890,
			3185,
			'NASDAQ',
			'4457756495'
			);

		insert into Stock(
			Stock_Symbol,
			Number_Of_Public_Stocks_in_thousand,
			Stock_Price,
			Market_Name,
			Commercial_Registriation_Number
			)values(
			'2222',
			940699,
			35.9,
			'Tadawul',
			'5315073274'
			);

		insert into Stock(
			Stock_Symbol,
			Number_Of_Public_Stocks_in_thousand,
			Stock_Price,
			Market_Name,
			Commercial_Registriation_Number
			)values(
			'7203',
			297472,
			7301,
			'Tokyo Stock Exchange',
			'6229087803'
			);

		insert into Stock(
			Stock_Symbol,
			Number_Of_Public_Stocks_in_thousand,
			Stock_Price,
			Market_Name,
			Commercial_Registriation_Number
			)values(
			'VOW3',
			295089,
			149.08,
			'Euronext',
			'9598342161'
			);

		insert into Stock(
			Stock_Symbol,
			Number_Of_Public_Stocks_in_thousand,
			Stock_Price,
			Market_Name,
			Commercial_Registriation_Number
			)values(
			'HKG',
			274500,
			269,
			'Shanghai Stock Exchange',
			'6713620014'
			);

		insert into Stock(
			Stock_Symbol,
			Number_Of_Public_Stocks_in_thousand,
			Stock_Price,
			Market_Name,
			Commercial_Registriation_Number
			)values(
			'GOOGL',
			289886,
			1787,
			'NASDAQ',
			'8643657928'
			);

		insert into Stock(
			Stock_Symbol,
			Number_Of_Public_Stocks_in_thousand,
			Stock_Price,
			Market_Name,
			Commercial_Registriation_Number
			)values(
			'2010',
			660000,
			96,
			'Tadawul',
			'8857232768'
			);

		insert into Stock(
			Stock_Symbol,
			Number_Of_Public_Stocks_in_thousand,
			Stock_Price,
			Market_Name,
			Commercial_Registriation_Number
			)values(
			'3741',
			215350,
			7250,
			'Tokyo Stock Exchange',
			'3741894494'
			);

		insert into Stock(
			Stock_Symbol,
			Number_Of_Public_Stocks_in_thousand,
			Stock_Price,
			Market_Name,
			Commercial_Registriation_Number
			)values(
			'NOKIA',
			988089,
			3.42,
			'Euronext',
			'1792169223'
			);

		insert into Stock(
			Stock_Symbol,
			Number_Of_Public_Stocks_in_thousand,
			Stock_Price,
			Market_Name,
			Commercial_Registriation_Number
			)values(
			'SPC',
			154301,
			301,
			'Shanghai Stock Exchange',
			'5098220895'
			);

		insert into Owns(
			Stock_Symbol,
			IBAN_number,
			Number_Of_Shares
			)values(
			'AMZN',
			'US281264541519999339',
			420
			);

		insert into Owns(
			Stock_Symbol,
			IBAN_number,
			Number_Of_Shares
			)values(
			'AMZN',
			'FI3819869934513876',
			40
			);

		insert into Owns(
			Stock_Symbol,
			IBAN_number,
			Number_Of_Shares
			)values(
			'2222',
			'SA2125267688145539388743',
			1
			);

		insert into Owns(
			Stock_Symbol,
			IBAN_number,
			Number_Of_Shares
			)values(
			'7203',
			'SA2125267688145539388743',
			2
			);

		insert into Owns(
			Stock_Symbol,
			IBAN_number,
			Number_Of_Shares
			)values(
			'7203',
			'JP821756900040913954463245',
			99
			);

		insert into Owns(
			Stock_Symbol,
			IBAN_number,
			Number_Of_Shares
			)values(
			'VOW3',
			'US341922553675553244',
			2311
			);

		insert into Owns(
			Stock_Symbol,
			IBAN_number,
			Number_Of_Shares
			)values(
			'VOW3',
			'DE16500105174529546245',
			1053
			);

		insert into Owns(
			Stock_Symbol,
			IBAN_number,
			Number_Of_Shares
			)values(
			'HKG',
			'JP601009600050571982645704',
			9
			);

		insert into Owns(
			Stock_Symbol,
			IBAN_number,
			Number_Of_Shares
			)values(
			'HKG',
			'SA4038369116113433969462',
			32
			);

		insert into Owns(
			Stock_Symbol,
			IBAN_number,
			Number_Of_Shares
			)values(
			'GOOGL',
			'SA4038369116113433969462',
			34
			);

		insert into Secures(
			Stock_Symbol,
			IBAN_number,
			Commercial_Registriation_Number
			)values(
			'AMZN',
			'US281264541519999339',
			'2055005270'
			);

		insert into Secures(
			Stock_Symbol,
			IBAN_number,
			Commercial_Registriation_Number
			)values(
			'AMZN',
			'FI3819869934513876',
			'2311911035'
			);

		insert into Secures(
			Stock_Symbol,
			IBAN_number,
			Commercial_Registriation_Number
			)values(
			'GOOGL',
			'FI3819869934513876',
			'1010001054'
			);

		insert into Secures(
			Stock_Symbol,
			IBAN_number,
			Commercial_Registriation_Number
			)values(
			'2222',
			'CH7550515162589388976886',
			'1516125270'
			);

		insert into Secures(
			Stock_Symbol,
			IBAN_number,
			Commercial_Registriation_Number
			)values(
			'GOOGL',
			'SA4038369116113433969462',
			'1010001054'
			);

		insert into Secures(
			Stock_Symbol,
			IBAN_number,
			Commercial_Registriation_Number
			)values(
			'2010',
			'CH4250514369317289437157',
			'5016604726'
			);

		insert into Secures(
			Stock_Symbol,
			IBAN_number,
			Commercial_Registriation_Number
			)values(
			'NOKIA',
			'SA2125267688145539388743',
			'1010001054'
			);

		insert into Secures(
			Stock_Symbol,
			IBAN_number,
			Commercial_Registriation_Number
			)values(
			'NOKIA',
			'DE16500105174529546245',
			'2311911035'
			);

		insert into Secures(
			Stock_Symbol,
			IBAN_number,
			Commercial_Registriation_Number
			)values(
			'SPC',
			'CH7550515162589388976886',
			'1516125270'
			);

		insert into Secures(
			Stock_Symbol,
			IBAN_number,
			Commercial_Registriation_Number
			)values(
			'VOW3',
			'CH7550515162589388976886',
			'1516125270'
			);




	describe Stock_Market;
	describe Stock;
	describe Company;
	describe CEO;
	describe Investor;
	describe Bank;
	describe Secures;
	describe Owns;

	select * from Stock_Market;
	select * from Stock;
	select * from Company;
	select * from CEO;
	select * from Investor;
	select * from Bank;
	select * from Owns;
	select * from Secures;