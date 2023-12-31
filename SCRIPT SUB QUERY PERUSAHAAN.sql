CREATE DATABASE perusahaan01;

USE perusahaan01;

CREATE TABLE p(
id_p VARCHAR(50) NOT NULL PRIMARY KEY,
nama VARCHAR(50) NOT NULL,
alamat VARCHAR(50)
);

INSERT INTO `perusahaan01`.`p` (`id_p`, `nama`) VALUES ('P01', 'Kantor Pusat');
INSERT INTO `perusahaan01`.`p` (`id_p`, `nama`) VALUES ('P02', 'Cabang Bekasi');

SELECT * FROM p;

CREATE TABLE dept(
id_dept VARCHAR(50) NOT NULL PRIMARY KEY,
nama VARCHAR(50) NOT NULL,
id_p VARCHAR(50)NOT NULL,
manajer_nik VARCHAR(50)
);

INSERT INTO `perusahaan01`.`dept` (`id_dept`, `nama`, `id_p`, `manajer_nik`) VALUES ('D01', 'Produksi', 'P02', 'N01');
INSERT INTO `perusahaan01`.`dept` (`id_dept`, `nama`, `id_p`, `manajer_nik`) VALUES ('D02', 'Marketing', 'P01', 'N03');
INSERT INTO `perusahaan01`.`dept` (`id_dept`, `nama`, `id_p`) VALUES ('D03', 'RnD', 'P02');
INSERT INTO `perusahaan01`.`dept` (`id_dept`, `nama`, `id_p`) VALUES ('D04', 'Logistik', 'P02');

SELECT * FROM dept;

CREATE TABLE proj(
id_proj VARCHAR(50) NOT NULL PRIMARY KEY,
nama VARCHAR(50) NOT NULL,
tgl_mulai DATE NOT NULL,
tgl_selesai DATE NOT NULL,
status VARCHAR(50)
);

INSERT INTO `perusahaan01`.`proj` (`id_proj`, `nama`, `tgl_mulai`, `tgl_selesai`, `status`) VALUES ('PJ01', 'A', '2019-01-10', '2019-03-10', '1');
INSERT INTO `perusahaan01`.`proj` (`id_proj`, `nama`, `tgl_mulai`, `tgl_selesai`, `status`) VALUES ('PJ02', 'B', '2019-02-15', '2019-04-10', '1');
INSERT INTO `perusahaan01`.`proj` (`id_proj`, `nama`, `tgl_mulai`, `tgl_selesai`, `status`) VALUES ('PJ03', 'C', '2019-03-21', '2019-05-10', '1');

SELECT * FROM proj;

CREATE TABLE k(
nik VARCHAR(50) NOT NULL PRIMARY KEY,
nama VARCHAR(100) NOT NULL,
id_dept VARCHAR(50) NOT NULL,
sup_nik VARCHAR(50)
);

ALTER TABLE `perusahaan01`.`k` 
DROP PRIMARY KEY,
ADD PRIMARY KEY (`nik`, `id_dept`);
;

INSERT INTO `perusahaan01`.`k` (`nik`, `nama`, `id_dept`) VALUES ('N01', 'Ari', 'D01');
INSERT INTO `perusahaan01`.`k` (`nik`, `nama`, `id_dept`) VALUES ('N02', 'Dina', 'D01');
INSERT INTO `perusahaan01`.`k` (`nik`, `nama`, `id_dept`) VALUES ('N03', 'Rika', 'D03');
INSERT INTO `perusahaan01`.`k` (`nik`, `nama`, `id_dept`, `sup_nik`) VALUES ('N04', 'Ratih', 'D01', 'N01');
INSERT INTO `perusahaan01`.`k` (`nik`, `nama`, `id_dept`, `sup_nik`) VALUES ('N05', 'Riko', 'D01', 'N01');
INSERT INTO `perusahaan01`.`k` (`nik`, `nama`, `id_dept`) VALUES ('N06', 'Dani', 'D02');
INSERT INTO `perusahaan01`.`k` (`nik`, `nama`, `id_dept`, `sup_nik`) VALUES ('N07', 'Anis', 'D02', 'N06');
INSERT INTO `perusahaan01`.`k` (`nik`, `nama`, `id_dept`, `sup_nik`) VALUES ('N08', 'Dika', 'D02', 'N06');


ALTER TABLE k ADD gaji_pokok VARCHAR(100) AFTER sup_nik;

UPDATE `perusahaan01`.`k` SET `gaji_pokok` = '2000000' WHERE (`nik` = 'N01') and (`id_dept` = 'D01');
UPDATE `perusahaan01`.`k` SET `gaji_pokok` = '2500000' WHERE (`nik` = 'N02') and (`id_dept` = 'D01');
UPDATE `perusahaan01`.`k` SET `gaji_pokok` = '2400000' WHERE (`nik` = 'N03') and (`id_dept` = 'D03');
UPDATE `perusahaan01`.`k` SET `gaji_pokok` = '3000000' WHERE (`nik` = 'N04') and (`id_dept` = 'D01');
UPDATE `perusahaan01`.`k` SET `gaji_pokok` = '2800000' WHERE (`nik` = 'N05') and (`id_dept` = 'D01');
UPDATE `perusahaan01`.`k` SET `gaji_pokok` = '2100000' WHERE (`nik` = 'N06') and (`id_dept` = 'D02');
UPDATE `perusahaan01`.`k` SET `gaji_pokok` = '5000000' WHERE (`nik` = 'N07') and (`id_dept` = 'D02');
UPDATE `perusahaan01`.`k` SET `gaji_pokok` = '4000000' WHERE (`nik` = 'N08') and (`id_dept` = 'D02');
INSERT INTO `perusahaan01`.`k` (`nik`, `nama`, `id_dept`, `sup_nik`, `gaji_pokok`) VALUES ('N09', 'Raka', 'D03', 'N06', '2000000');

SELECT * FROM k;




SELECT k.nik, k.id_dept, k.nama
FROM k
WHERE id_dept = (
SELECT id_dept
FROM k
WHERE nama ='Dika'
);

SELECT AVG (gaji_pokok) AS RerataGaji
FROM k;

SELECT nik, nama, gaji_pokok AS "Rerata Gaji"
FROM k
WHERE gaji_pokok > (
SELECT AVG(gaji_pokok)
FROM k
ORDER BY gaji_pokok
);

SELECT nik, nama
FROM k
WHERE nama IN ( 
SELECT nama
FROM k
WHERE nama LIKE'__k%' 
);

SELECT nik, nama
FROM k
WHERE id_dept = (
SELECT id_dept
FROM dept
WHERE id_p = 
(SELECT id_p FROM p WHERE nama='Kantor Pusat')
);

SELECT nik, nama, gaji_pokok
FROM k
WHERE gaji_pokok > (
SELECT AVG (gaji_pokok) 
FROM k) 
AND nama IN ( 
SELECT nama
FROM k
WHERE nama LIKE'__k%' 
);


 



CREATE TABLE projectdetail(
id_proj VARCHAR(50) NOT NULL PRIMARY KEY,
nik VARCHAR(50) NOT NULL
);

ALTER TABLE `perusahaan01`.`projectdetail` 
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id_proj`, `nik`);
;

INSERT INTO `perusahaan01`.`projectdetail` (`id_proj`, `nik`) VALUES ('PJ01', 'N01');
INSERT INTO `perusahaan01`.`projectdetail` (`id_proj`, `nik`) VALUES ('PJ01', 'N02');
INSERT INTO `perusahaan01`.`projectdetail` (`id_proj`, `nik`) VALUES ('PJ01', 'N03');
INSERT INTO `perusahaan01`.`projectdetail` (`id_proj`, `nik`) VALUES ('PJ01', 'N04');
INSERT INTO `perusahaan01`.`projectdetail` (`id_proj`, `nik`) VALUES ('PJ01', 'N05');
INSERT INTO `perusahaan01`.`projectdetail` (`id_proj`, `nik`) VALUES ('PJ01', 'N07');
INSERT INTO `perusahaan01`.`projectdetail` (`id_proj`, `nik`) VALUES ('PJ01', 'N08');
INSERT INTO `perusahaan01`.`projectdetail` (`id_proj`, `nik`) VALUES ('PJ02', 'N01');
INSERT INTO `perusahaan01`.`projectdetail` (`id_proj`, `nik`) VALUES ('PJ02', 'N03');
INSERT INTO `perusahaan01`.`projectdetail` (`id_proj`, `nik`) VALUES ('PJ02', 'N05');
INSERT INTO `perusahaan01`.`projectdetail` (`id_proj`, `nik`) VALUES ('PJ03', 'N03');
INSERT INTO `perusahaan01`.`projectdetail` (`id_proj`, `nik`) VALUES ('PJ03', 'N07');
INSERT INTO `perusahaan01`.`projectdetail` (`id_proj`, `nik`) VALUES ('PJ03', 'N08');

SELECT * FROM projectdetail;



SELECT dept.nama, k.nama
FROM dept
LEFT JOIN k ON k.nik = dept.manajer_nik;

SELECT  k.nik, k.nama, dept.id_dept AS "departemen", k.sup_nik AS "supervisor"
FROM k
LEFT JOIN projectdetail ON k.nik = k.sup_nik
LEFT JOIN dept ON dept.id_dept = k.id_dept;

SELECT proj.nama AS "Nama Project", k.nama
FROM k
JOIN projectdetail ON k.nik = projectdetail.nik
JOIN Proj ON Projectdetail.id_proj = Proj.id_proj
WHERE proj.nama = 'A';



SELECT dept.id_dept, dept.nama
FROM k
JOIN dept ON k.id_dept = dept.id_dept;

SELECT dept.nama AS "Departemen", proj.nama AS "Nama Project", COUNT(k.nik) AS "jumlah karyawan"
FROM dept
JOIN k ON dept.id_dept = k.id_dept
JOIN projectdetail ON k.nik = projectdetail.nik
JOIN proj ON projectdetail.id_proj = proj.id_proj
GROUP BY dept.nama, proj.nama;

SELECT dept.nama AS "Departemen", COUNT(*) AS "Jumlah Project"
FROM k
right JOIN dept ON dept.id_dept = k.id_dept
WHERE dept.nama = 'RnD';

SELECT k.nama, count(*) AS "jumlah project"
FROM k
JOIN projectdetail ON k.nik = projectdetail.nik
WHERE k.nama = 'Ari';

SELECT proj.nama AS "Nama Project", k.nama
FROM k
JOIN projectdetail ON k.nik = projectdetail.nik
JOIN Proj ON Projectdetail.id_proj = Proj.id_proj
WHERE proj.nama = 'B';