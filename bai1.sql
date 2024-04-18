use fisrt_db;
create table customer(
cId int primary key auto_increment,
cName varchar(100),
cAge int
);
create table orders(
oId int primary key auto_increment,
cId int,
foreign key(cId) references customer (cId),
oDate date,
oTotalPrice int 
);
create table product(
pId int primary key auto_increment,
pName varchar(45),
pPrice int 
);
create table oderdetail(
oId int ,foreign key(oId) references orders (oId),
pId int,foreign key(pId) references product (pId),
odQTY int
);
insert into customer(cName,cAge)values('anh',18),('sang',19),('thao',12),('qanh',18),('nhanh',18);
insert into orders(cId,oDate,oTotalPrice)values(1,'2022-12-12',3),(1,'2022-12-12',3),(1,'2022-12-12',3),(1,'2022-12-12',3),(1,'2022-12-12',3);
insert into product(pName,pPrice)values('quan',100),('jent',100),('ao',106),('mu',101),('dep',120);
insert into oderdetail(oId,pId,odQTY)values(1,1,6),(1,1,6),(1,1,6),(1,1,6),(1,1,6),(1,1,6),(1,1,6),(1,1,6);
select * from orders;
select * from customer;
select * from product;
select * from oderdetail;
