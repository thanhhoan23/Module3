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
WHERE hoadon.NgayMuaHang like '2006%')
; 




















