create database bai4;
use bai4;
create table Class
(
    classId   int PRIMARY KEY AUTO_INCREMENT,
    className varchar(45),
    statDate  date,
    status    boolean
);
create table Student
(
    studentId   int primary key auto_increment,
    classId     int,
    foreign key (classId) references Class (classId),
    studentName varchar(45),
    phone       varchar(15),
    status      boolean,
    address     varchar(100)
);
create table Subject
(
    subId   int auto_increment primary key,
    subName varchar(50),
    credit  varchar(20),
    status  boolean
);
create table Mark
(
    markId    int primary key auto_increment,
    point     float,
    subId     int,
    foreign key (subId) references Subject (subId),
    studentId int,
    foreign key (studentId) references Student (studentId),
    examTime  timestamp
);
INSERT INTO Class (className, statDate, status)
VALUES ('Lớp 1', '2023-09-01', TRUE),
       ('Lớp 2', '2023-09-05', FALSE),
       ('Lớp 3', '2023-09-10', TRUE),
       ('Lớp 4', '2023-09-15', FALSE),
       ('Lớp 5', '2023-09-20', TRUE),
       ('Lớp 6', '2023-09-25', FALSE),
       ('Lớp 7', '2023-09-30', TRUE),
       ('Lớp 8', '2023-10-05', FALSE),
       ('Lớp 9', '2023-10-10', TRUE),
       ('Lớp 10', '2023-10-15', FALSE);

INSERT INTO Student (classId, studentName, phone, status, address)
VALUES (1, 'Nguyễn Văn A', '1234567890', TRUE, '123 Đường Chính'),
       (2, 'Trần Thị B', '2345678901', TRUE, '123 Đường Chính'),
       (1, 'Phạm Văn C', '3456789012', TRUE, '345 Đường Nhánh'),
       (2, 'Lê Thị D', '4567890123', TRUE, '456 Đường Ngõ'),
       (1, 'Hoàng Văn E', '5678901234', TRUE, '567 Đường Lớn'),
       (2, 'Nguyễn Thị F', '6789012345', TRUE, '678 Đường Nhỏ'),
       (1, 'Võ Văn G', '7890123456', TRUE, '345 Đường Nhánh'),
       (2, 'Đặng Thị H', '8901234567', TRUE, '890 Đường Gần'),
       (1, 'Bùi Văn I', '9012345678', TRUE, '901 Đường Thẳng'),
       (2, 'Dương Thị K', '0123456789', TRUE, '678 Đường Nhỏ');

INSERT INTO Subject (subName, credit, status)
VALUES ('Toán', '4', TRUE),
       ('Văn học', '3', TRUE),
       ('Vật lý', '4', TRUE),
       ('Hóa học', '4', TRUE),
       ('Sinh học', '3', TRUE),
       ('Lịch sử', '2', TRUE),
       ('Địa lý', '2', TRUE),
       ('Giáo dục công dân', '2', TRUE),
       ('Mỹ thuật', '1', TRUE),
       ('Âm nhạc', '1', TRUE);

INSERT INTO Mark (point, subId, studentId, examTime)
VALUES (9.5, 1, 1, CURRENT_TIMESTAMP),
       (8.0, 2, 1, CURRENT_TIMESTAMP),
       (7.5, 1, 2, CURRENT_TIMESTAMP),
       (6.0, 2, 2, CURRENT_TIMESTAMP),
       (9.0, 1, 3, CURRENT_TIMESTAMP),
       (8.5, 2, 3, CURRENT_TIMESTAMP),
       (7.0, 1, 4, CURRENT_TIMESTAMP),
       (6.5, 2, 4, CURRENT_TIMESTAMP),
       (9.2, 1, 5, CURRENT_TIMESTAMP),
       (8.8, 2, 5, CURRENT_TIMESTAMP);
SELECT address, count(studentId) 'số học sinh'
FROM Student
GROUP BY address;

select *
from Subject
where subId = (select subId from Mark where point = (select max(mark.point) from Mark));

select s.studentName, avg(m.point)
from mark m
         join student s on m.studentId = s.studentId
where s.studentId = m.studentId
group by s.studentId;


select s.studentName, avg(m.point) as avgpoint
from mark m
         join student s on m.studentId = s.studentId
where s.studentId = m.studentId
group by s.studentId
having avgpoint<=7;


select s.*, avg(m.point) as avgpoint
from mark m
         join student s on m.studentId = s.studentId
where s.studentId = m.studentId
group by s.studentId
having avgpoint>= all (select avg(point) from Mark group by mark.studentId);


select s.studentName, avg(m.point) a
from mark m
         join student s on m.studentId = s.studentId
where s.studentId = m.studentId
group by s.studentId
order by a desc;

