-- Nomor 1
CREATE DATABASE praktikum3;
USE praktikum3;

CREATE TABLE mahasiswa (
	NIM VARCHAR(10) PRIMARY KEY NOT NULL,
	Nama VARCHAR(50) NOT NULL,
	Kelas CHAR(1) NOT NULL,
	Status VARCHAR(50) NOT NULL,
	Nilai INT(11)
);

SELECT * FROM mahasiswa;

INSERT INTO mahasiswa
VALUES ('H071241056', 'Kotlina', 'A', 'Hadir', 100),
		 ('H071241060', 'Pitonia', 'A', 'Alfa', 85),
		 ('H071241063', 'Javano', 'A', 'Hadir', 50),
		 ('H071241065', 'Ciplus Kuadra', 'B', 'Hadir', 65),
		 ('H071241066', 'Pihap E', 'B', 'Hadir', 85),
		 ('H071241079', 'Ruby', 'B', 'Alfa', 90);

-- Nomor 2		 
UPDATE mahasiswa
SET Nilai = 0, Kelas = 'C'
WHERE Status = 'Alfa';

-- Nomor 3
DELETE FROM mahasiswa
WHERE Kelas = 'A' AND Nilai > 90;

-- Nomor 4
INSERT INTO mahasiswa
VALUES ('H071221021', 'Natalia', 'C', 'Pindahan', NULL);

UPDATE mahasiswa
SET Nilai = 50
WHERE Status = 'Alfa';

UPDATE mahasiswa
SET Kelas = 'A';

INSERT INTO mahasiswa(Nama, Kelas, Status, Nilai)
VALUES ('Mutia', 'B', 'Alfa', NULL);

INSERT INTO mahasiswa(NIM, Kelas, Status)
VALUES('H071221023', 'B', 'Hadir');

DELETE FROM mahasiswa
WHERE Nama = 'Mutia'; 

-- Soal Tambahan
CREATE TABLE Buku (
	ID_Buku INT(10) PRIMARY KEY AUTO_INCREMENT,
	Judul VARCHAR(50) NOT NULL,
	Pengarang VARCHAR(50),
	Tahun_Terbit INT(4),
	Status varchar(50) NOT NULL
);

SELECT * FROM Buku; 
SELECT * FROM pinjam;

CREATE TABLE pinjam (
	ID_pinjam INT(10) PRIMARY KEY AUTO_INCREMENT,
	NIM_Mahasiswa VARCHAR(20),
	ID_Buku INT,
	Tanggal_Pinjam VARCHAR(50),
	Tanggal_Kembali VARCHAR(50),
	
	FOREIGN KEY (NIM_Mahasiswa) REFERENCES mahasiswa(NIM),
	FOREIGN KEY (ID_Buku) REFERENCES Buku(ID_Buku)
);

DROP TABLE pinjam;
DROP TABLE Buku;

INSERT INTO Buku (Judul, Pengarang, Tahun_Terbit, STATUS)
VALUES ('Buku WEB', 'Penulis A', 2020, 'Tersedia');

INSERT INTO Buku (Judul, Tahun_Terbit, STATUS)
VALUES ('Buku Basdat', 2019, 'Tersedia');

INSERT INTO Buku (Judul, Pengarang, STATUS)
VALUES ('Buku WEB', 'Penulis C', 'Dipinjam');

INSERT INTO Buku (Pengarang, Tahun_Terbit)
VALUES ('Penulis D', 2020);

INSERT INTO pinjam (NIM_Mahasiswa, ID_Buku, Tanggal_Pinjam, Tanggal_Kembali)
VALUES ('H071241060', 3, '2023-09-15', '2023-09-30');

INSERT INTO pinjam (NIM_Mahasiswa, ID_Buku, Tanggal_Pinjam, Tanggal_Kembali)
VALUES ('H071241079', 1, '2023-09-12', '2023-09-28');

INSERT INTO pinjam (NIM_Mahasiswa, ID_Buku, Tanggal_Pinjam, Tanggal_Kembali)
VALUES ('H071221021', 2, '2023-09-14', '2023-09-29');

USE library;

DESCRIBE books;

SELECT * FROM books;

INSERT INTO books (isbn, title, pages, genre, summary)
VALUES ('123456', 'Nana', 649, 'horror', 'bghrgygrbfi');

INSERT INTO books
VALUES ('4', '7766334', 'jluo', 768, 'Romance', 'hfegfhbefeuwhggu');
