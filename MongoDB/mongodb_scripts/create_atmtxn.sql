CREATE TABLE atmtxn_orc(
	InternalID bigint,
	OldID int ,
	RecordInternalID int ,
	ProcessorID int ,
	Terminal varchar(50) ,
	TxnTypeID int ,
	ResponseCodeID int ,
	RejectCodeID int ,
	BankID int ,
	NetworkID int ,
	TerminalSequenceNumber int ,
	SettlementDate STRING  ,
	SettlementTime STRING  ,
	ActivityDate STRING  ,
	ActivityTime STRING  ,
	Amount decimal  ,
	Fee decimal  ,
	Surcharge decimal  ,
	Interchange decimal  ,
	Txn BOOLEAN ,
	OurBank BOOLEAN ,
	EBTTransaction BOOLEAN ,
	LogID int ,
	P_NetworkCode varchar(20) ,
	P_TxnCode varchar(20) ,
	P_ResponseCode varchar(20) ,
	P_RejectCode varchar(20) ,
	P_Field1 varchar(20) ,
	P_Field2 varchar(20) ,
	ATMInternalID int ,
	EP varchar(50) ,
	InterchangeCalc decimal  ,
	International BOOLEAN ,
	IchgRateID int ,
	Branded BOOLEAN ,
	DenyTxnType int ,
	CardID int ,
	DCCAmount decimal  ,
	DCCTotal decimal  ,
	DCCTXn BOOLEAN ,
	Deny711 BOOLEAN ,
	CountryCode varchar(50) ,
	HP4 varchar(120) ,
	HP5 varchar(120) ,
	HP6 varchar(120) ,
	HP7 varchar(120) ,
	HP8 varchar(120) ,
	HP9 varchar(120) ,
	HP10 varchar(120) ,
	HP11 varchar(120) ,
	HP12 varchar(120) ,
	HP13 varchar(120) ,
	HP14 varchar(120) ,
	HP15 varchar(120) ,
	HPCATM varchar(120) ,
	PAN varchar(120)

) stored as orc;