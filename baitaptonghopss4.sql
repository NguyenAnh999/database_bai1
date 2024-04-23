create database PersonnelManager;
use PersonnelManager;
create table Department
(
    id   int primary key auto_increment,
    name varchar(100) not null unique check (LENGTH(name) > 6)
);
create table Levels
(
    id              int primary key auto_increment,
    name            varchar(100) not null unique,
    BasicSalary     float check (BasicSalary >= 3500000),
    AllowanceSalary float default (500000)
);
create table Employee
(
    id           int primary key auto_increment,
    name         varchar(150) not null,
    email        varchar(150) not null unique check (email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$'),
    phone        varchar(50)  not null unique,
    address      varchar(255),
    gender       tinyint      not null check ( gender = 0 or gender = 1 or gender = 2),
    BirthDay     date         not null,
    LevelId      int          not null,
    foreign key (LevelId) references Levels (id),
    DepartmentId int          not null,
    foreign key (DepartmentId) references Department (id)
);

create table TimeSheets
(
    id             int primary key auto_increment,
    AttendanceDate date           default (curdate()),
    EmployeeId     int   not null,
    foreign key (EmployeeId) references Employee (id),
    value          float not null default 1 check ( value = 0 or value = 0.5 or value = 1)
);

create table Salary
(
    id          int primary key auto_increment,
    employeeId  int   not null,
    foreign key (employeeId) references Employee (id),
    bonusSalary float default 0,
    insurance   float  default 0
);
insert into Department (name) value ('vận hành'),('sale team'),('MakeTing');

insert into Levels(name, BasicSalary)
values ('giám đốc', 300000000),
       ('trưởng phòng', 30000000),
       ('nhân viên', 9500000);

insert into Employee(name, email, phone, address, gender, BirthDay, LevelId, DepartmentId)
values ('abc', 'chjckylovemany100@gamil.com', '0942341199', 'ha nam', 2, '1999-06-05', 3, 4),
       ('ánh', 'chjckylovemany1@gamil.com', '0942341111', 'ha nam', 0, '1999-06-05', 3, 4),
       ('sáng', 'chjckylovemany2@gamil.com', '0942341112', 'ha nam', 0, '1999-06-05', 2, 5),
       ('tôn', 'chjckylovemany3@gamil.com', '0942341113', 'ha nam', 0, '1999-06-05', 3, 6),
       ('hiếu', 'chjckylovemany4@gamil.com', '0942341114', 'ha nam', 0, '1999-06-05', 3, 4),
       ('đạt', 'chjckylovemany5@gamil.com', '0942341115', 'ha nam', 0, '1999-06-05', 2, 5),
       ('điệp', 'chjckylovemany6@gamil.com', '0942341116', 'ha nam', 0, '1999-06-05', 2, 6),
       ('hưng', 'chjckylovemany7@gamil.com', '0942341117', 'ha nam', 0, '1999-06-05', 3, 4),
       ('quyền', 'chjckylovemany8@gamil.com', '0942341118', 'ha nam', 0, '1999-06-05', 3, 5),
       ('nhanh', 'chjckylovemany9@gamil.com', '0942341119', 'ha nam', 0, '1999-06-05', 3, 6),
       ('flash', 'chjckylovemany10@gamil.com', '0942341120', 'ha nam', 0, '1999-06-05', 3, 5),
       ('jonson', 'chjckylovemany11@gamil.com', '0942341121', 'ha nam', 0, '1999-06-05', 2, 4),
       ('山本', 'chjckylovemany12@gamil.com', '0942341122', 'ha nam', 0, '1999-06-05', 1, 6),
       ('田中', 'chjckylovemany13@gamil.com', '0942341123', 'ha nam', 0, '1999-06-05', 1, 4),
       ('sơn', 'chjckylovemany14@gamil.com', '0942341124', 'ha nam', 0, '1999-06-05', 2, 5),
       ('quỳnh anh', 'chjckylovemany16@gamil.com', '0942341134', 'ha nam', 1, '1999-06-05', 3, 6),
       ('tùng', 'chjckylovemany15@gamil.com', '0942341125', 'ha nam', 0, '1999-06-05', 2, 4);



insert into TimeSheets(EmployeeId, value)
values (17, 0.5),
       (18, 0.5),
       (19, 1),
       (20, 1),
       (21, 1),
       (22, 0),
       (23, 0),
       (24, 0),
       (25, 1),
       (26, 1),
       (27, 1),
       (28, 0.5),
       (29, 0),
       (30, 0.5),
       (31, 1),
       (32, 0.5),
       (32, 0),
       (31, 1),
       (30, 0),
       (29, 1),
       (28, 0.5),
       (27, 0),
       (26, 0.5),
       (25, 0),
       (24, 1),
       (23, 0.5),
       (22, 0),
       (21, 1),
       (20, 0),
       (19, 0.5);


DELIMITER //
CREATE TRIGGER auto_set_insurance
    BEFORE INSERT ON Salary
    FOR EACH ROW
BEGIN
    DECLARE salary FLOAT;
    -- Đảm bảo câu SELECT này gán giá trị trực tiếp vào biến 'salary'
    SELECT l.BasicSalary INTO salary
    FROM levels l
             JOIN Employee e ON l.id = e.LevelId
    WHERE e.id = NEW.employeeId;

    -- Sau đó gán giá trị của biến 'salary' vào trường 'insurance' của bản ghi mới
    SET NEW.insurance = salary/10;
END; //

DELIMITER ;

insert into Salary (employeeId)
values (25),
       (20),
       (21);
select * from  salary;
select e.id,
       e.name,
       email,
       phone,
       address,
       BirthDay,
       if(gender = 0, 'nam', (if(gender = 1, 'nu', 'BD'))) 'giới tính',
       BirthDay,
       floor(datediff(curdate(), BirthDay) / 365.25) as 'tuổi',
       D.name,
       l.name
from employee e
         join Department D on D.id = e.DepartmentId
         join Levels L on L.id = e.LevelId
order by e.name;


select s.id,
       s.insurance,
       s.bonusSalary,
       e.name,
       e.phone,
       l.BasicSalary,
       l.AllowanceSalary,
       s.bonusSalary,
       (l.BasicSalary + s.insurance + s.bonusSalary+l.AllowanceSalary) as 'tổng lương'
from Salary s
         join Employee E on E.id = s.employeeId
         join Levels L on L.id = E.LevelId;
 select d.name, d.id,  count(e.id) from department d join Employee E on d.id = E.DepartmentId group by d.id;




update salary s set s.bonusSalary = 10 where s.employeeId = any (
    select e.id from employee e
                         join timesheets t on e.id = t.EmployeeId
    where t.AttendanceDate  between '2020/10/1' and curdate()
    group by t.EmployeeId
    having count(t.id)>=2);




