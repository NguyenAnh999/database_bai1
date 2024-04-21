create database demo01;
use demo01;
create  table Custome(
cId int primary key auto_increment,
cName varchar(50) not null,
cAge int check(cAge>18)
);
create table orders(
oID int primary key auto_increment,
cID int,
oDate date not null,
oTotalPrice int
);
alter table orders add FOREIGN key (cID) references Custome(cId);
create  table product(
pID int primary key auto_increment,
 pName varchar(50),
 pPrice int
);
create table oderDetail(
oId int,
pId int,
odQTY int
);
alter table oderDetail add foreign key (oId) references orders(oID);
alter table oderDetail add foreign key (pId) references product(pID);
select * from orders;
select * from product;
select * from oderDetail;
select * from Custome;
insert into  Custome(
cName,cAge
) values
 ('anh',19), ('Qanh',19), ('dat',19), ('tien',19), ('hieu',19) ;
 insert into orders (
cID ,
oDate,
oTotalPrice) values(1,'1997-12-12',129) ,(2,'2022-12-12',129),(3,'2022-12-12',129),(4,'2022-12-12',129);
 use test;
#bai8
select px.SoPX, Ngayban, px.GhiChu, S.TenSP, S.Donvitinh, C.SoLuong, C.GiaBan,n.HoTen
from PHIEUXUAT px
         inner join CTPHIEUXUAT C on px.SoPX = C.SoPX
         inner join SANPHAM S on S.MaSP = C.MaSP
         inner join nhanvien n on px.MaNV = n.MaNV;
#bai9
SELECT
    px.SoPX ,
    px.NgayBan,
    kh.MaKH ,
    kh.TenKH ,
    SUM(ctpx.SoLuong * ctpx.GiaBan)
FROM
    PhieuXuat px
        JOIN
    KhachHang kh ON px.MaKH = kh.MaKH
        JOIN
    ctphieuxuat ctpx ON px.SoPX = ctpx.SoPX
GROUP BY
    px.SoPX, px.NgayBan, kh.MaKH, kh.TenKH
ORDER BY
    kh.TenKH, px.NgayBan;
# bai 10
SELECT
    SUM(ctpx.SoLuong)
FROM
    SanPham sp
        JOIN
    ctphieuxuat ctpx ON sp.MaSP = ctpx.MaSP
        JOIN
    PhieuXuat px ON ctpx.SoPX = px.SoPX
WHERE
    sp.TenSP = 'Comfort' AND
    px.NgayBan BETWEEN '2018-01-01' AND '2018-06-30';
#bai11
SELECT
    EXTRACT(MONTH FROM px.NgayBan) AS 'Tháng',
    kh.MaKH ,
    kh.TenKH ,
    kh.DiaChi ,
    SUM(ctpx.SoLuong * ctpx.GiaBan)
FROM
    PhieuXuat px
        JOIN
    KhachHang kh ON px.MaKH = kh.MaKH
        JOIN
    ctphieuxuat ctpx ON px.SoPX = ctpx.SoPX
GROUP BY
    EXTRACT(MONTH FROM px.NgayBan), kh.MaKH, kh.TenKH, kh.DiaChi
ORDER BY
    EXTRACT(MONTH FROM px.NgayBan), kh.MaKH;

# bai 12
SELECT
    EXTRACT(YEAR FROM px.NgayBan) ,
    EXTRACT(MONTH FROM px.NgayBan),
    sp.MaSP,
    sp.TenSP  ,
    sp.DonViTinh ,
    SUM(ctpx.SoLuong)
FROM
    PhieuXuat px
        JOIN
    ctphieuxuat ctpx ON px.SoPX = ctpx.SoPX
        JOIN
    SanPham sp ON ctpx.MaSP = sp.MaSP
GROUP BY
    EXTRACT(YEAR FROM px.NgayBan),
    EXTRACT(MONTH FROM px.NgayBan),
    sp.MaSP,
    sp.TenSP,
    sp.DonViTinh
ORDER BY
    EXTRACT(YEAR FROM px.NgayBan),
    EXTRACT(MONTH FROM px.NgayBan),
    sp.MaSP;

 # bai 13
SELECT
    EXTRACT(MONTH FROM px.NgayBan) ,
    SUM(ctpx.SoLuong * ctpx.GiaBan)
FROM
    PhieuXuat px
        JOIN
    ctphieuxuat ctpx ON px.SoPX = ctpx.SoPX
WHERE
    EXTRACT(YEAR FROM px.NgayBan) = 2018 AND EXTRACT(MONTH FROM px.NgayBan) <= 6
GROUP BY
    EXTRACT(MONTH FROM px.NgayBan)
ORDER BY
    EXTRACT(MONTH FROM px.NgayBan);
# bai 14
SELECT
    px.SoPX,
    px.NgayBan,
    nv.HoTen,
    kh.TenKH,
    SUM(ctpx.SoLuong * ctpx.GiaBan)
FROM
    PhieuXuat px
        JOIN
    NhanVien nv ON px.MaNV = nv.MaNV
        JOIN
    KhachHang kh ON px.MaKH = kh.MaKH
        JOIN
    ctphieuxuat ctpx ON px.SoPX = ctpx.SoPX
WHERE
    (EXTRACT(YEAR FROM px.NgayBan) = 2018) AND
    (EXTRACT(MONTH FROM px.NgayBan) IN (5, 6))
GROUP BY
    px.SoPX, px.NgayBan, nv.HoTen, kh.TenKH
ORDER BY
    px.NgayBan;
#bai15
SELECT
    px.SoPX ,
    kh.MaKH ,
    kh.TenKH,
    nv.HoTen ,
    px.NgayBan,
    SUM(ctpx.SoLuong * ctpx.GiaBan)
FROM
    PhieuXuat px
        JOIN
    KhachHang kh ON px.MaKH = kh.MaKH
        JOIN
    NhanVien nv ON px.MaNV = nv.MaNV
        JOIN
    ctphieuxuat ctpx ON px.SoPX = ctpx.SoPX
WHERE
    px.NgayBan = CURRENT_DATE
GROUP BY
    px.SoPX, kh.MaKH, kh.TenKH, nv.HoTen, px.NgayBan
ORDER BY
    px.NgayBan;

#bai16
SELECT
    nv.MaNV,
    nv.HoTen,
    sp.MaSP ,
    sp.TenSP,
    sp.DonViTinh,
    SUM(ctpx.SoLuong)
FROM
    NhanVien nv
        JOIN
    PhieuXuat px ON nv.MaNV = px.MaNV
        JOIN
    ctphieuxuat ctpx ON px.SoPX = ctpx.SoPX
        JOIN
    SanPham sp ON ctpx.MaSP = sp.MaSP
GROUP BY
    nv.MaNV, nv.HoTen, sp.MaSP, sp.TenSP, sp.DonViTinh
ORDER BY
    nv.MaNV, sp.MaSP;
#bai17
SELECT
    px.SoPX,
    px.NgayBan ,
    sp.MaSP ,
    sp.TenSP ,
    sp.DonViTinh,
    ctpx.SoLuong ,
    ctpx.GiaBan ,
    (ctpx.SoLuong * ctpx.GiaBan)
FROM
    PhieuXuat px
        JOIN
    ctphieuxuat ctpx ON px.SoPX = ctpx.SoPX
        JOIN
    SanPham sp ON ctpx.MaSP = sp.MaSP
WHERE
    px.MaKH = 'KH01' AND
    px.NgayBan BETWEEN '2018-04-01' AND '2018-06-30'
ORDER BY
    px.NgayBan, sp.MaSP;
# bai 18
SELECT
    sp.MaSP ,
    sp.TenSP ,
    lsp.TenloaiSP ,
    sp.DonViTinh
FROM
    SanPham sp
        LEFT JOIN
    LoaiSP lsp ON sp.MaLoaiSP = lsp.MaLoaiSP
        LEFT JOIN
    ctphieuxuat ctpx ON sp.MaSP = ctpx.MaSP
        LEFT JOIN
    PhieuXuat px ON ctpx.SoPX = px.SoPX AND px.NgayBan BETWEEN '2018-01-01' AND '2018-06-30'
WHERE
    px.SoPX IS NULL
GROUP BY
    sp.MaSP, sp.TenSP, lsp.TenloaiSP, sp.DonViTinh;

#bai19
SELECT
    ncc.MaNCC ,
    ncc.TenNCC ,
    ncc.DiaChi,
    ncc.DienThoai
FROM
    NhaCungCap ncc
        LEFT JOIN
    PhieuNhap pn ON ncc.MaNCC = pn.MaNCC
        AND pn.NgayNhap BETWEEN '2018-04-01' AND '2018-06-30'
WHERE
    pn.SoPN IS NULL
GROUP BY
    ncc.MaNCC, ncc.TenNCC, ncc.DiaChi, ncc.DienThoai
ORDER BY
    ncc.MaNCC;
#bai20
SELECT
    kh.MaKH ,
    kh.TenKH,
    SUM(ctpx.SoLuong * ctpx.GiaBan)
FROM
    PhieuXuat px
        JOIN
    ctphieuxuat ctpx ON px.SoPX = ctpx.SoPX
        JOIN
    KhachHang kh ON px.MaKH = kh.MaKH
WHERE
    px.NgayBan BETWEEN '2018-01-01' AND '2018-06-30'
GROUP BY
    kh.MaKH, kh.TenKH
ORDER BY
    'Tổng Trị Giá' DESC
LIMIT 1;
#bai21
SELECT
    kh.MaKH ,
    COUNT(px.SoPX)
FROM
    KhachHang kh
        LEFT JOIN
    PhieuXuat px ON kh.MaKH = px.MaKH
GROUP BY
    kh.MaKH
ORDER BY
    'Số Lượng Đơn Đặt Hàng' DESC;
#bai22
SELECT
    nv.MaNV,
    nv.HoTen,
    COALESCE(kh.TenKH, 'Không có khách hàng')
FROM
    NhanVien nv
        LEFT JOIN
    PhieuXuat px ON nv.MaNV = px.MaNV
        LEFT JOIN
    KhachHang kh ON px.MaKH = kh.MaKH
GROUP BY
    nv.MaNV, nv.HoTen, kh.TenKH
ORDER BY
    nv.MaNV;
#bai23
SELECT
    nv.GioiTinh,
    COUNT(nv.MaNV)
FROM
    NhanVien nv
GROUP BY
    nv.GioiTinh;
#bai24
#??????????????????????
#bai25
#??????????????????????
#bai26
#????????????????????
#bai27
#?????????????????
#bai28
SELECT
    sp.MaSP,
    sp.TenSP,
    sp.DonViTinh
FROM
    SanPham sp
        JOIN
    LoaiSP lsp ON sp.MaLoaiSP = lsp.MaLoaiSP
WHERE
    lsp.TenLoaiSP = 'Hóa mỹ phẩm';
#bai29

SELECT
    sp.MaSP,
    sp.TenSP ,
    sp.DonViTinh
FROM
    SanPham sp
        JOIN
    LoaiSP lsp ON sp.MaLoaiSP = lsp.MaLoaiSP
WHERE
    lsp.TenLoaiSP = 'Quần áo';
#bai30
SELECT
    COUNT(sp.MaSP)
FROM
    SanPham sp
        JOIN
    LoaiSP lsp ON sp.MaLoaiSP = lsp.MaLoaiSP
WHERE
    lsp.TenLoaiSP = 'Quần áo';
#bai31
SELECT
    COUNT(DISTINCT lsp.MaLoaiSP)
FROM
    LoaiSP lsp
        JOIN
    SanPham sp ON lsp.MaLoaiSP = sp.MaLoaiSP
WHERE
    lsp.TenLoaiSP LIKE '%Hóa mỹ phẩm%';
#bai32
SELECT
    lsp.TenLoaiSP ,
    COUNT(sp.MaSP)
FROM
    LoaiSP lsp
        JOIN
    SanPham sp ON lsp.MaLoaiSP = sp.MaLoaiSP
GROUP BY
    lsp.TenLoaiSP;





 