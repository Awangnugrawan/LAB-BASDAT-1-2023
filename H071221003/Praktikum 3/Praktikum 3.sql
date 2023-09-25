-- nomor 1 

CREATE DATABASE praktikum3

USE praktikum3

CREATE TABLE mahasiswa (
	nim VARCHAR(10) PRIMARY KEY,
	nama VARCHAR(50) NOT NULL,
	kelas CHAR(1) NOT NULL,
	STATUS VARCHAR(50) NOT NULL,
	nilai INT (11)
)

INSERT INTO mahasiswa (nim,nama,kelas,STATUS,nilai)
VALUE ('H071241056', 'Kotlina', 'A', 'Hadir', 100),
		('H071241060', 'Pitonia', 'A', 'Alfa', 85),
		('H071241063', 'Javano','A', 'Hadir', 50),
		('H071241065', 'Ciplus Kuadra','B', 'Hadir', 65),
		('H071241066', 'Pihap E', 'B', 'Hadir', 85),
		('H071241079', 'Ruby', 'B', 'Alfa', 90)
		
SELECT  * FROM mahasiswa 
DROP TABLE mahasiswa

-- nomor 2
UPDATE mahasiswa
SET nilai = 0 AND kelas = 'C'
WHERE STATUS = 'alfa'

-- nomor 3
DELETE FROM mahasiswa
WHERE kelas = 'A' AND nilai >90

-- nomor 4
INSERT INTO mahasiswa (nim,nama,kelas,STATUS)
VALUE ('H071221003', 'Rabiatul Awalyah', 'C', 'Pindahan')

UPDATE mahasiswa
SET nilai = 50 
WHERE STATUS = 'alfa'

UPDATE mahasiswa
SET kelas = 'A'

-- INSERT INTO mahasiswa
-- VALUE ('H071241080', 'Tia', 'A', 'Alfa', 50)
-- 
-- USE library
-- 
-- DESCRIBE books
-- 
-- SELECT * FROM books
-- 
-- INSERT INTO books (id,isbn,title,pages,genre,summary)
-- VALUE (1,'071221003','dikta',200,'sad','itu')
-- 
-- INSERT INTO books 
-- VALUE (2,'071221004','hukum',200,'horor','zzz')
-- 
-- INSERT INTO books (isbn,title,pages,genre,summary)
-- VALUE ('071221005','dikta',200,'sad','itu');
-- 
-- INSERT INTO books 
-- VALUE ('071221006','abc',200,'sad','itu');


INSERT INTO mahasiswa (nim,nama,kelas,STATUS,nilai)
VALUE ('H071221012', 'Nabila Athira', ' ', 'Pindahan', NULL)

INSERT INTO mahasiswa (nim,nama,STATUS)
VALUE ('H071221004', 'Rahmatia', 'Pindahan')




