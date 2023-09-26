-- No1
CREATE DATABASE praktikum3
USE praktikum3

CREATE TABLE mahasiswa (
	NIM VARCHAR(10) NOT NULL PRIMARY KEY,
	Nama VARCHAR (50) NOT NULL,
	Kelas CHAR(1) NOT NULL,
	`Status` VARCHAR(50) NOT NULL,
	Nilai INT(11)
)

DESC mahasiswa

INSERT INTO mahasiswa (NIM, Nama, Kelas, `Status`, Nilai)
				VALUE ('H071241056', 'Kotlina', 'A', 'Hadir', 100),
						('H071241060', 'Pitonia', 'A', 'Alfa', 85),
						('H071241063', 'Javano', 'A', 'Hadir', 50),
						('H071241065', 'Ciplus Kuadra', 'B', 'Hadir', 65),
						('H071241066', 'Pihap E', 'B', 'Hadir', 85),
						('H071241079', 'Ruby', 'B', 'Alfa', 90);
SELECT * FROM mahasiswa

-- No2
UPDATE mahasiswa
SET Nilai = 0, Kelas = 'C'
WHERE `Status` = 'Alfa';

SELECT * FROM mahasiswa

-- No3
DELETE FROM mahasiswa
WHERE Kelas = 'A' AND Nilai > 90;

SELECT * FROM mahasiswa

-- No4
INSERT INTO mahasiswa (NIM, Nama, Kelas, `Status`)
				VALUE ('H071221070', 'Farrel', 'D', 'Pindahan')
				
UPDATE mahasiswa
SET Nilai = 50
WHERE `Status` = 'Alfa'

UPDATE mahasiswa
SET Kelas = 'A';

INSERT INTO mahasiswa 
				VALUES ('H071221010', 'Halo', 'D', 'Tambahan', 10)
INSERT INTO mahasiswa (NIM, Kelas, `Status`)
				VALUES ('H071221000', 'C', 'Single')
				
SELECT * FROM mahasiswa

-- Soal Tambahan
CREATE TABLE buku (
	ID_Buku INT(1) PRIMARY KEY,
	Judul  VARCHAR (30) NOT NULL,
	Pengarang VARCHAR (20),
	Tahun_Terbit INT(4),
	`Status` VARCHAR(10) NOT NULL
)
SELECT * FROM buku

INSERT INTO buku (ID_Buku, Judul, Pengarang, Tahun_Terbit, `Status`)
				VALUES (1, 'Buku Web', 'Penulis A', 2020, 'Tersedia'),
						(2, 'Buku Basdat', NULL, 2019, 'Tersedia'),
						(3, 'Buku Matdas', 'Penulis C', NULL, 'Dipinjam'),
						(4, '', 'Penulis D', 2020, '')

USE praktikum3						
CREATE TABLE PINJAM (
	ID_Pinjam INT(1) PRIMARY KEY,
	NIM_Mahasiswa VARCHAR(10),
	ID_Buku INT(1),
	Tanggal_Pinjam DATE,
	Tanggal_Kembali DATE,
	FOREIGN KEY(NIM_Mahasiswa) REFERENCES mahasiswa(NIM),
	FOREIGN KEY(ID_Buku) REFERENCES buku(ID_Buku)
)

SELECT * FROM pinjam
INSERT INTO pinjam (ID_Pinjam, NIM_Mahasiswa, ID_Buku, Tanggal_Pinjam, Tanggal_Kembali)
				VALUES (1, 'H071241060', 3, '2023-09-15', '2023-09-30'),
						(2, 'H071241079', 1, '2023-09-12', '2023-09-28'),
						(3, 'H071221070', 2, '2023-09-14', '2023-09-29')