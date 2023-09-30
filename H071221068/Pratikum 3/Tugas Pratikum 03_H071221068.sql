-- NOMOR 01
CREATE DATABASE pratikum3;
USE pratikum3;

CREATE TABLE mahasiswa (
	NIM VARCHAR(10) PRIMARY KEY NOT NULL,
	Nama VARCHAR(50) NOT NULL,
	Kelas CHAR(1) NOT NULL,
	status VARCHAR(50) NOT NULL,
	Nilai INT(11) 
);

DESC mahasiswa;
INSERT INTO mahasiswa
VALUES
('H071241056', 'Kotlina', 'A', 'Hadir', 100),
('H071241060', 'Pitonia', 'A', 'Alfa', 85),
('H071241063', 'Javano', 'A', 'Hadir', 50),
('H071241065', 'Ciplus Kuadra', 'B', 'Hadir', 65),
('H071241066', 'Pihap E', 'B', 'Hadir', 85),
('H071241079', 'Ruby', 'B', 'Alfa', 90);

SELECT * FROM mahasiswa;

-- NOMOR 02
UPDATE mahasiswa
SET nilai = 0, Kelas = 'C'
WHERE status = 'Alfa';

-- NOMOR 03
DELETE FROM mahasiswa
WHERE kelas = 'A' AND Nilai > 90;

-- NOMOR 04
INSERT INTO mahasiswa
VALUES ('H0712210068', 'Muhammad Ardiansyah Asrifah', 'C', 'Pindahan', NULL);

UPDATE mahasiswa
SET nilai = 50
WHERE status = 'Alfa';

UPDATE mahasiswa
SET kelas = 'A';


SELECT * FROM mahasiswa;
DESC mahasiswa;
INSERT INTO mahasiswa(nim, nama, kelas, nilai)
VALUES ('H071221130', 'mahen', 'C', NULL);

-- SOAL TAMBAHAN
CREATE TABLE buku (
	ID_buku INT PRIMARY KEY AUTO_INCREMENT,
	Judul VARCHAR(255),
	Pengarang VARCHAR(255),
	Tahun_Terbit INT(11),
	status VARCHAR(255)
);

INSERT INTO buku (Judul, Pengarang, Tahun_Terbit, Status)
VALUES
('Buku Web', 'Penulis A', 2020, 'Tersedia'),
('Buku Basdat', NULL, 2019, 'Tersedia'),
('Buku Matdas', 'Penulis C', NULL, 'Tersedia'),
('', 'Penulis D', 2020, '');

USE buku;

SELECT * FROM mahasiswa;
DESCRIBE mahasiswa;

CREATE TABLE PINJAM (
	ID_Pinjam INT PRIMARY KEY AUTO_INCREMENT,
	NIM_Mahasiswa VARCHAR(10),
	ID_Buku INT,
	Tanggal_Pinjam VARCHAR(50),
	Tanggal_Kembali VARCHAR(50),
	
	FOREIGN KEY (NIM_Mahasiswa) REFERENCES mahasiswa(NIM),
	FOREIGN KEY (ID_Buku) REFERENCES buku(ID_buku)
);

INSERT INTO PINJAM(NIM_Mahasiswa, ID_Buku, Tanggal_Pinjam, Tanggal_Kembali)
VALUES
('H071241060', 3, '2023-09-15', '2023-09-30'),
('H071241079', 1, '2023-09-12', '2023-09-28'),
('H071221068', 2, '2023-09-14', '2023-09-29')

SELECT * FROM PINJAM;
SELECT * FROM buku;
SELECT * FROM mahasiswa;
