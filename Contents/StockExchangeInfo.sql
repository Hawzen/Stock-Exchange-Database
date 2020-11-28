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
		Market_Name varchar(100) not null,
		Commercial_Registriation_Number varchar(100) not null,

		constraint Stock_Symbol_PK primary key(Stock_Symbol),
		constraint Market_Name_FK foreign key(Market_Name) references Stock_Market(Market_Name),
		constraint Commercial_Registriation_Number_FK1 foreign key(Commercial_Registriation_Number) references Company(Commercial_Registriation_Number)
		);

	create table CEO(
		Name varchar(100),
		Sex char(1) not null,
		Age int not null,
		Commercial_Registriation_Number varchar(100) not null,

		constraint Compound_PK primary key(Name , Commercial_Registriation_Number),
		constraint Commercial_Registriation_Number_FK2 foreign key(Commercial_Registriation_Number) references Company(Commercial_Registriation_Number),
		constraint Age_Check check(Age >= 23)
		);

	create table Secures(
		Stock_Symbol varchar(10),
		IBAN_number varchar(100),
		Commercial_Registriation_Number varchar(100),

		constraint Compound_PK primary key(Stock_Symbol , IBAN_number , Commercial_Registriation_Number),
		constraint Stock_Symbol_FK foreign key(Stock_Symbol) references Stock(Stock_Symbol),
		constraint IBAN_number_FK foreign key(IBAN_number) references Investor(IBAN_number),
		constraint Commercial_Registriation_Number_FK3 foreign key(Commercial_Registriation_Number) references Bank(Commercial_Registriation_Number)
		);

	create table Owns(
		Stock_Symbol varchar(10),
		IBAN_number varchar(100),

		constraint Compound_PK primary key(Stock_Symbol , IBAN_number),
		constraint Stock_Symbol_FK2 foreign key(Stock_Symbol) references Stock(Stock_Symbol),
		constraint IBAN_number_FK2 foreign key(IBAN_number) references Investor(IBAN_number)
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
			0,
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
			'US341922553675553244',
			'8277836920',
			'M',
			1,
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
			'SA2125267688145539388743',
			'1304026480',
			'M',
			2,
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
			3,
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
			4,
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