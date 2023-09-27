-- no 1
CREATE DATABASE praktikum3;

USE praktikum3;

CREATE TABLE mahasiswa(
NIM VARCHAR(10) PRIMARY KEY NOT NULL,
Nama VARCHAR(50) NOT NULL,
Kelas CHAR(1) NOT NULL,
STATUS VARCHAR(50) NOT NULL,
NIlai INT(11));

DESCRIBE mahasiswa;

INSERT INTO mahasiswa
VALUES('H071241056' , 'Kotlina', 'A', 'Hadir', 100),
('H071241060' , 'Pitonia', 'A', 'Alfa', 85),
('H071241063' , 'Javano', 'A', 'Hadir', 50),
('H071241065' , 'Ciplus Kuadra', 'B', 'Hadir', 65),
('H071241066 ' , 'Pihap E', 'B', 'Hadir', 85),
('H071241079' , 'Ruby', 'B', 'Alfa', 90);

SELECT* FROM mahasiswa;

-- no 2
UPDATE mahasiswa
SET nilai = 0, kelas = 'C'
WHERE STATUS = 'Alfa'

-- no 3
DELETE FROM mahasiswa
WHERE kelas = 'A' AND nilai > 90

-- no 4
INSERT INTO mahasiswa (nim, nama, kelas, status)
VALUE('H071221041', 'Andi Muthia', 'A', 'pindahan');

INSERT INTO mahasiswa
VALUE('H071221000', 'Kia', ' ', 'Hadir', NULL)

INSERT INTO mahasiswa (nim, nama, kelas, nilai)
VALUE('H071221001', 'Lia','B', null)

UPDATE mahasiswa
SET nilai = 50 
WHERE STATUS = 'Alfa'

UPDATE mahasiswa
SET kelas = 'A'

USE library;
DESCRIBE books;

INSERT INTO books (isbn, title, pages, genre, summary)
VALUE('0000000000001', 'hujan', '111', 'Fiction', 'ini summary')

SELECT * FROM books

INSERT INTO books
VALUE(3,'0000000000002','Komet', '111', 'Fiction', 'ini summary')

-- no 5
USE praktikum3

CREATE TABLE buku (
	id_buku INT(11) PRIMARY KEY AUTO_INCREMENT,
	judul VARCHAR (20),
	pengarang VARCHAR (20),
	tahun_terbit INT (11),
	STATUS VARCHAR (20)
);

CREATE TABLE pinjam (
	id_pinjam INT (11) PRIMARY KEY AUTO_INCREMENT,
	nim_mahasiswa VARCHAR (10),
	id_buku INT (11),
	tanggal_pinjam VARCHAR (20),
	tanggal_kembali VARCHAR (20),
	
	FOREIGN KEY (nim_mahasiswa) REFERENCES mahasiswa(NIM),
	FOREIGN KEY (id_buku) REFERENCES buku(id_buku)
);

DESCRIBE pinjam

INSERT INTO buku (id_buku,judul,pengarang,tahun_terbit,STATUS)
VALUES (1, 'Buku Web', 'Penulis A', 2020, 'Tersedia'),
(2, 'Buku Basdat',NULL, 2019,'Tersedia'),
(3, 'Buku Matdas', 'Penulis C', NULL, 'Dipinjam'),
(4, ' ', 'Penulis D', 2020, ' ')

SELECT * FROM buku;

DELETE FROM pinjam;

INSERT INTO pinjam
VALUES 
(1, 'H071241060', 3, '2023-09-15', '2023-09-30'),
(2, 'H071241079', 1, '2023-09-12', '2023-09-28'),
(3, 'H071221041', 2, '2023-09-14', '2023-09-29');

SELECT * FROM pinjam;
SELECT * FROM buku


