
-- 1. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất.
SELECT sanpham.MaSP, sanpham.TenSP
FROM sanpham
WHERE NuocSX = 'Trung Quoc';

-- 2.In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cây”, ”quyển”.

SELECT sanpham.MaSP, sanpham.TenSP
FROM sanpham
WHERE DVT = 'cay' OR DVT = 'quyen';

-- 3.In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.

SELECT sanpham.MaSP, sanpham.TenSP
FROM sanpham
WHERE MaSP LIKE 'B%01';

-- 4.In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 20.000 đến 30.000.
SELECT sanpham.MaSP, sanpham.TenSP
FROM sanpham
WHERE (Gia BETWEEN 20000 AND 30000) AND NuocSX = 'Trung Quoc';	

-- 5.In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” hoặc “Thái Lan” sản xuất có giá từ
-- 20.000 đến 30.000.

SELECT sanpham.MaSP, sanpham.TenSP
FROM sanpham
WHERE (NuocSX = 'Trung Quoc' OR NuocSX = 'Thai Lan') AND (Gia BETWEEN 20000 AND 30000);

-- 6. In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
SELECT *
FROM hoadon
WHERE NgayMuaHang BETWEEN '2007-01-01' AND '2007-02-01';

-- 7. In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).
SELECT * 
FROM hoadon
WHERE NgayMuaHang BETWEEN '2007-1-1' AND '2007-01-31'
ORDER BY NgayMuaHang ASC, TriGia DESC;

-- 8. In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007.
SELECT hoadon.MaKH, khachhang.HoTen
From hoadon join khachhang on hoadon.MaKH = khachhang.MaKH
WHERE hoadon.NgayMuaHang = '2007/1/1';

-- 9. In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyễn Văn A” mua trong háng 10/2006.

SELECT sanpham.MaSP, sanpham.TenSP, khachhang.HoTen
FROM sanpham
JOIN cthd ON sanpham.MaSP = cthd.MaSP
JOIN hoadon ON  cthd.SoHD= hoadon.SoHoaDon
JOIN khachhang ON hoadon.MaKH = khachhang.MaKH
WHERE hoadon.NgayMuaHang LIKE '2006-10-%' AND khachhang.HoTen = 'Nguyen Van A';

-- 10. In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyễn Văn B” lập trong ngày 10/10/2006.

SELECT *
FROM hoadon
JOIN nhanvien ON hoadon.MaNV = nhanvien.MaNV
WHERE nhanvien.HoTen = 'Nguyen Van B';

-- 11. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”.
SELECT *
FROM hoadon
JOIN cthd ON hoadon.SoHoaDon = cthd.SoHD
JOIN sanpham ON cthd.MaSP = sanpham.MaSP
WHERE sanpham.MaSP = 'BB01' OR sanpham.MaSP = 'BB02';

-- 12. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số Lượng từ 10 đến 20.

SELECT *
FROM hoadon
JOIN cthd ON hoadon.SoHoaDon = cthd.SoHD
JOIN sanpham ON cthd.MaSP = sanpham.MaSP
WHERE (sanpham.MaSP = 'BB01' OR sanpham.MaSP = 'BB02') AND (cthd.SoLuong BETWEEN 10 AND 20);

-- 13. Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số ượng từ 10 đến 20.
SELECT *
FROM hoadon
JOIN cthd ON hoadon.SoHoaDon = cthd.SoHD
JOIN sanpham ON cthd.MaSP = sanpham.MaSP
WHERE (sanpham.MaSP LIKE 'BB01') AND (cthd.SoLuong BETWEEN 10 AND 20) AND 
exists (SELECT *
FROM hoadon
JOIN cthd ON hoadon.SoHoaDon = cthd.SoHD
JOIN sanpham ON cthd.MaSP = sanpham.MaSP
WHERE (sanpham.MaSP LIKE 'BB02') AND (cthd.SoLuong BETWEEN 10 AND 20));

-- 14. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007.
SELECT sanpham.MaSP, sanpham.TenSP
FROM sanpham
JOIN cthd ON sanpham.MaSP = cthd.MaSP
JOIN hoadon ON cthd.SoHD = hoadon.SoHoaDon
WHERE NuocSX = 'Trung Quoc' OR hoadon.NgayMuaHang LIKE '2007-01-01';

-- 15. In ra danh sách các sản phẩm (MASP,TENSP) không bán được.

SELECT sanpham.MaSP, sanpham.TenSP
FROM sanpham
WHERE sanpham.MaSP NOT IN (SELECT sanpham.MaSP
FROM sanpham
JOIN cthd ON sanpham.MaSP = cthd.MaSP
JOIN hoadon ON cthd.SoHD = hoadon.SoHoaDon);

-- 16. In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
SELECT sanpham.MaSP, sanpham.TenSP
FROM sanpham
WHERE sanpham.MaSP NOT IN (SELECT sanpham.MaSP
FROM sanpham
JOIN cthd ON sanpham.MaSP = cthd.MaSP
JOIN hoadon ON cthd.SoHD = hoadon.SoHoaDon
WHERE hoadon.NgayMuaHang LIKE '2006%');

-- 17. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất không bán được trong năm 2006.

SELECT sanpham.MaSP, sanpham.TenSP 
FROM sanpham
JOIN cthd ON sanpham.MaSP = cthd.MaSP
JOIN hoadon ON cthd.SoHD = hoadon.SoHoaDon
WHERE sanpham.NuocSX = 'Trung Quoc' AND sanpham.MaSP NOT IN (SELECT sanpham.MaSP
FROM sanpham
JOIN cthd ON sanpham.MaSP = cthd.MaSP
JOIN hoadon ON cthd.SoHD = hoadon.SoHoaDon
WHERE hoadon.NgayMuaHang LIKE '2006%');

-- 18. Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?

SELECT hoadon.MaKH, hoadon.SoHoaDon
FROM hoadon
WHERE hoadon.MaKH NOT IN(SELECT hoadon.MaKH
FROM hoadonSAIII
JOIN khachhang ON hoadon.MaKH = khachhang.MaKH);

SELECT COUNT(hoadon.SoHoaDon)
FROM hoadon
WHERE hoadon.MaKH IS NULL;

-- 19. Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu ?

SELECT  MAX(hoadon.TriGia), MIN(hoadon.TriGia)
FROM hoadon;

-- 20. Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?

SELECT AVG(hoadon.TriGia)
FROM hoadon
WHERE NgayMuaHang like '2006%';

-- 21. Tính doanh thu bán hàng trong năm 2006.
SELECT SUM(hoadon.TriGia)
FROM hoadon
WHERE NgayMuaHang like '2006%';

-- 22. Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
SELECT hoadon.SoHoaDon
FROM hoadon
where TriGia= (SELECT MAX(hoadon.TriGia)
FROM hoadon
WHERE NgayMuaHang like '2006%');

SELECT hoadon.SoHoaDon
FROM hoadon where trigia=(SELECT MAX(hoadon.TriGia)
FROM hoadon
WHERE hoadon.NgayMuaHang like '2006%');

-- 23.Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006. 
SELECT khachhang.HoTen
FROM khachhang
JOIN hoadon ON khachhang.MaKH= hoadon.MaKH
where trigia =(SELECT MAX(hoadon.TriGia)
FROM hoadon
WHERE hoadon.NgayMuaHang like '2006%');

-- 24.In ra danh sách 3 khách hàng (MAKH, HOTEN) có đơn hàng cao nhất.

    SELECT distinct TriGia
    FROM   hoadon
    ORDER BY TriGia DESC
    LIMIT 3;
    
    -- 25. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
    
SELECT *
FROM sanpham sp JOIN (select distinct Gia
FROM sanpham
ORDER BY Gia DESC
LIMIT 3) temp on sp.Gia = temp.Gia;

-- 26. In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quốc” sản xuất có giá bằng 1 trong 3 mức giá thấp nhất (của tất cả các sản phẩm).
SELECT sanpham.MaSP, sanpham.TenSP
FROM sanpham JOIN (SELECT DISTINCT Gia
FROM sanpham
WHERE NuocSX = 'Trung Quoc'
ORDER BY Gia ASC
LIMIT 3) temp ON sanpham.Gia = temp.Gia;
-- 27. In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quốc” sản xuất có giá bằng 1 trong 3 mức iá thấp nhất (của sản phẩm do “Trung Quốc” sản xuất).

-- 28. In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất (sắp xếp theo kiểu xếp hạng).
SELECT khachhang.MaKH, khachhang.HoTen, hoadon.TriGia, hoadon.SoHoaDon
FROM khachhang
JOIN hoadon ON khachhang.MaKH = hoadon.MaKH
ORDER BY hoadon.TriGia DESC;
select sum(hoadon.MaKH = 'KH01')
from hoadon;

-- 29. Tính tổng số sản phẩm do “Trung Quốc” sản xuất.
SELECT  count(MaSP)
FROM sanpham
WHERE sanpham.NuocSX = 'Trung Quoc';

-- 30. Tính tổng số sản phẩm của từng nước sản xuất.
SELECT NuocSX, COUNT(MaSP)
FROM sanpham
GROUP BY NuocSX;

-- 31. Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
SELECT NuocSX, MAX(Gia), MIN(Gia), AVG(Gia)
FROM sanpham
GROUP BY NuocSX;

-- 32 Tinh doanh thu ban hang moi ngay
SELECT NgayMuaHang, sum(TriGia)
from hoadon
group by NgayMuaHang
order by NgayMuaHang DESC;

-- 34. Tính doanh thu bán hàng của từng tháng trong năm 2006.

SELECT MONTH(NgayMuaHang),sum(TriGia)
from hoadon
WHERE YEAR(NgayMuaHang) = '2006'
group by MONTH(NgayMuaHang)
order by MONTH(NgayMuaHang) DESC;

-- 33. Tính tổng số lượng của từng sản phẩm bán ra trong ngày 28/10/2006.

SELECT sum(cthd.SoLuong)
FROM sanpham
JOIN cthd ON sanpham.MaSP = cthd.MaSP
JOIN hoadon ON cthd.SoHD = hoadon.SoHoaDon
where NgayMuaHang = '2006-10-28'
group by sanpham.MaSP;

-- 35 Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất

SELECT hoadon.MaKH, COUNT(hoadon.MaKH), khachhang.HoTen
FROM hoadon
JOIN khachhang ON hoadon.MaKH = khachhang.MaKH
GROUP BY MaKH
ORDER BY COUNT(hoadon.MaKH) DESC
LIMIT 1;

-- 36. Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
SELECT  sum(cthd.SoLuong),sanpham.MaSP
FROM sanpham
JOIN cthd ON sanpham.MaSP = cthd.MaSP
JOIN hoadon ON cthd.SoHD = hoadon.SoHoaDon
where hoadon.NgayMuaHang LIKE '2006%'
Group By sanpham.MaSP;

SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

SELECT sp.MaSP, sum(ct.SoLuong)
FROM sanpham sp
JOIN cthd ct ON sp.MaSP = ct.MaSP
JOIN hoadon hd ON ct.SoHD = hd.SoHoaDon
where hd.NgayMuaHang LIKE '2006%'
Group By sp.MaSP;
-- 37. Tháng mấy trong năm 2006, doanh số bán hàng thấp nhất ?
SELECT SUM(TriGia), MONTH(NgayMuaHang)
FROM hoadon
WHERE YEAR (NgayMuaHang) = '2006'
GROUP BY MONTH (NgayMuaHang)
ORDER BY MONTH(NgayMuaHang) ASC
LIMIT 0,1;

-- 38. Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất.
SELECT NuocSX, MaSP, TenSP
FROM sanpham a
Where gia = (select max(Gia)
from sanpham b
where a.NuocSX = b.NuocSX)
GROUP BY NuocSX, MaSP, TenSP;

-- 39. *Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.


-- 40. *Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau





























