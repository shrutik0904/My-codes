----Data model scripts

create schema data_model;



create table data_model.product (StockCode varchar(255) primary key,
Description text);

create table data_model.customer(CustomerID int primary key ,
Country text);

create table data_model.invoice_metadata (InvoiceNumber int,
InvoiceDate datetime,
CustomerID int,
StockCode varchar(255),
foreign key (CustomerID) references data_model.customer(CustomerID),
foreign key (StockCode) references data_model.product(StockCode),
unique(InvoiceNumber,CustomerID,StockCode));


create table data_model.invoice_details (
InvoiceNumber int,
Cancellation varchar(50),
Quantity int,
UnitPrice float,
InvoiceDate datetime,
foreign key (InvoiceNumber) references data_model.invoice_metadata(InvoiceNumber));



----------------------------

--Added data to source table
create schema source_data;


LOAD DATA LOCAL INFILE  'C:Users/Admin/Downloads/archive (3)/online_retail.csv'
INTO TABLE online_retail 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS (`InvoiceNo`,`StockCode`,`Description`,`Quantity`,`InvoiceDate`,`UnitPrice`,`CustomerID`,`Country`);