create database QuanLyDonHang;
use QuanLyDonHang;
create table Customer(
cID int primary key,
cName varchar(30) not null,
cAge int);

create table OrderProduct(
oID int primary key,
oDate date,
oTotalPrice decimal,
cid int not null,
foreign key (cid) references Customer(cid));

create table Product (
pid int primary key,
pName varchar(30),
pPrice decimal not null);

create table OrderDetail(
oid int not null,
pid int not null,
ordQQuantity int not null,
unique(oid, pid),
foreign key(oid) references OrderProduct(oID),
foreign key (pid) references Product(pid));



