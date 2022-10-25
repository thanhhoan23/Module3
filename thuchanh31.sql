create database thuchanh31;
use thuchanh31;

create table Class(
ClassID int primary key,
ClassName varchar(30) not null,
StarDate date,
StatusClass int);

create table Student (
StudentID int primary key,
StudentName varchar(20) not null,
Address varchar(30),
Phone int,
StatusStudent int,
ClassID int,
foreign key (ClassID) references Class(ClassID));

create table Subjectt (
SubID int primary key,
SubName varchar(20)not null,
Credit int,
StatusSubject int);

create table Mark(
MarkID int primary key,
SubID int not null,
StudentID int not null,
Mark int not null,
ExamTimes int,
foreign key (SubID) references Subjectt(SubID),
foreign key (StudentID) references Student(StudentID));

insert into Class
value(1,"A1","2008/12/20",1);
insert into Class
value(2,"A2","2008/12/22",1);
insert into Class
value(3,"B3",current_date(),0);

insert into Student
value(1, "Hung", "Ha noi", 097895766, 1,1);
insert into Student
value(2, "Hoa", "Hai phong",08756756, 1,1);
insert into Student
value(3, "Manh", "Hcm", 0978976789, 0,2);

insert into Subjectt
value(1, "cf",5,1);

insert into Subjectt
value(2, "c",6,1);
insert into Subjectt
value(3, "hdj",5,1);
insert into Subjectt
value(4, "rdbms",10,1);

insert into Mark
value(1,1,1,8,1);
insert into Mark
value(2,1,2,10,2);

-- Hien thi danh sach tat ca cac hoc sinh
select *
from Student;

-- hien thi danh sach hoc vien dang theo hoc
select *
from Student
where StatusStudent = true;

-- hien thi danh sach cac mon hoc cos thoi gian nho hon 10

select *
from Subjectt
where Credit <10;

-- hien thi danh sach hoc vien lop A1
-- su dung cau lenh join va where

select S.StudentID, S.StudentName, C.ClassName
from Student S join Class C ON S.ClassID = C.ClassID
where C.ClassName = "A1";





 
