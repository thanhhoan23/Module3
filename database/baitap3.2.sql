create database QuanLyBanHang;
use QuanLyBanHang;
create table Customer(
cID int primary key,
cName varchar(25),
cAge tinyint);

create table Orderr (
oID int primary key,
cID int not null,
oDate datetime,
oTotalPrice int,
foreign key (cID) references Customer(cID));

create table Product(
pID int primary key,
pName varchar(25),
pPrice int);

create table OrderDetail(
oID int not null,
pID int not null,
odQuantity int,
unique (oID,pID),
foreign key (oID) references Orderr(oID),
foreign key (pID) references Product(pID));

insert into Customer
value (1,"Minh Quan",10);
insert into Customer
value (2,"Ngoc Oanh",20);

-- hien thi hoa don trong bang order
select oID,cid,oTotalPrice
from Orderr;

-- hien thi danh sach khach hang da mua va danh sach duoc mua boi khach hang

select  Customer.cName, Product.pName
from Customer 
inner join Orderr on Customer.cID= Orderr.cID
inner join OrderDetail on Orderr.oID = OrderDetail.oID
inner join Product on OrderDetail.pID = Product.pID;

-- Hien thi ten cua khach hang khong mua sp nao

select Customer.cName 
from Customer
where Customer.cID not in (select Orderr.cID from Orderr);

-- Hien thi ma don hang, ngay ban va gia tien cua tung hoa don






