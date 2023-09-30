-- Nomor 1
CREATE DATABASE praktikum3;
USE praktikum3;

CREATE TABLE mahasiswa (
NIM VARCHAR(10) PRIMARY KEY,
Nama VARCHAR(50) NOT NULL,
Kelas CHAR(1) NOT NULL,
`status` VARCHAR(50) NOT NULL,
Nilai INT(11));

DESCRIBE mahasiswa;

SELECT * FROM mahasiswa;

INSERT INTO mahasiswa
VALUES 
('H071241056', 'Kotlina', 'A', 'Hadir', '100'),
('H071241060', 'Pitonia', 'A', 'Alfa', '85'),
('H071241063', 'Javano', 'A', 'Hadir', '50'),
('H071241065', 'Ciplus Kuadra', 'B', 'Hadir', '65'),
('H071241066', 'Pihap E', 'B', 'Hadir', '85'),
('H071241079', 'Ruby', 'B', 'Alfa', '90');

-- Nomor 2
UPDATE mahasiswa
SET Nilai = 0, Kelas = 'C'
WHERE `status` = 'Alfa';

-- Nomor 3
DELETE FROM mahasiswa
WHERE Nilai > 90;

INSERT INTO mahasiswa
VALUES 
('H071221023', 'Trisman', 'A', 'Pindahan', NULL),
('J011231120', 'Difa', 'A', 'Pindahan', NULL);

UPDATE mahasiswa 
SET Nilai = 50
WHERE `status` = 'Alfa';
 
UPDATE mahasiswa
SET kelas = 'A'; 

INSERT INTO mahasiswa (NIM, Nama, `status`)
VALUES ('H071221033', 'Biba', 'Hadir'); 

INSERT INTO mahasiswa 
VALUES ('Wiratama', 'H071221099', 'Hadir', '77', 'A');

USE library;
DESCRIBE books;
SELECT * FROM books;

INSERT INTO books (isbn, title, pages, genre, summary) 
VALUES ('H071221045', 'Tegar', 24, 'Comedy', 'xixiixxi');

INSERT INTO books 
VALUES (3, 'H071221033', 'Wiratama', 88, 'Thriller', 'wkwkwkw');

-- Soal Tambahan
CREATE TABLE buku (
ID_Buku INT PRIMARY KEY, 
Judul VARCHAR(50) NOT NULL,
Pengarang VARCHAR(50),
Tahun_Terbit INT(11),
`Status` VARCHAR(50) NOT NULL);

SELECT * FROM buku;
DESCRIBE buku;

INSERT INTO buku 
VALUES 
(1,'Buku Web', 'Penulis A', 2020, 'Tersedia'),
(2,'Buku Basdat', NULL , 2019, 'Tersedia'),
(3,'Buku Web', 'Penulis C', NULL, 'Dipinjam');

INSERT INTO buku (Id_Buku, Pengarang, Tahun_Terbit) 
VALUES 
(4,'Penulis A', 2020);

DELETE FROM buku;

CREATE TABLE pinjam (
ID_Pinjam INT(11) PRIMARY KEY AUTO_INCREMENT, 
NIM_Mahasiswa VARCHAR(10),
ID_Buku INT,
Tanggal_Pinjam DATE,
Tanggal_Kembali DATE,
FOREIGN KEY(NIM_Mahasiswa) REFERENCES Mahasiswa(NIM),
FOREIGN KEY(ID_Buku) REFERENCES Buku(ID_Buku));

SELECT * FROM PINJAM;

DELETE FROM PINJAM;
SELECT * FROM mahasiswa;

INSERT INTO pinjam
VALUES 
(1,'H071241060', 3, '2023-09-15', '2023-09-30'),
(2,'H071241079', 1 , '2023-09-12', '2023-09-28'),
(3,'H071221023', 2, '2023-09-14', '2023-09-29');

   


