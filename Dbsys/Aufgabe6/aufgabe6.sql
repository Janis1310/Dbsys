-- Bearbeitung aufgabe 6

-- Aufgabe a)
SELECT * FROM Buchung;
DROP TABLE StornierteBuchungen;
DROP TRIGGER buchungStornieren;

CREATE TABLE StornierteBuchungen(
    StornoID INT PRIMARY KEY,
    buchungsnr INT NOT NULL,
    email VARCHAR2(255) NOT NULL,
    storniertDatum Date DEFAULT SYSDATE
);

CREATE SEQUENCE SEQ_StornierteBuchungen
START WITH 1
INCREMENT BY 1;


CREATE TRIGGER buchungStornieren
BEFORE DELETE ON Buchung
FOR EACH ROW
BEGIN
    Insert Into StornierteBuchungen(stornoID, buchungsnr, email, storniertDatum)
    VALUES (SEQ_StornierteBuchungen.NEXTVAL,
        :OLD.buchungsnr,
        :OLD.email,
        SYSDATE
    );

END;
/

DELETE FROM Buchung WHERE buchungsnr > 7;
ROLLBACK;


SELECT * FROM STORNIERTEBUCHUNGEN;
SELECT * FROM BUCHUNG;


-- Aufgabe b)
CREATE VIEW Kundenstatistik
AS
SELECT 
    k.email, 
    COALESCE(b.anzahl_Buchungen, 0) AS anzahl_Buchungen, 
    COALESCE(a.Anzahl_Stornierungen, 0) AS Anzahl_Stornierungen, 
    COALESCE(s.Sum_bereits_gezahlt, 0) AS Sum_bereits_gezahlt
FROM Kunde k
LEFT JOIN AnzahlBuchungen b ON k.email = b.email
LEFT JOIN SummeBereitsGezahlt s ON k.email = s.email
LEFT JOIN AnzahlStornierungen a ON k.email = a.email;

SELECT * FROM Kundenstatistik;
DROP VIEW Kundenstatistik;


-- Hilfstabelle Anzahl-Buchungen
CREATE VIEW AnzahlBuchungen
AS 
SELECT email, COUNT(*) as anzahl_Buchungen
FROM Buchung
GROUP BY email;

SELECT * FROM AnzahlBuchungen;
DROP VIEW AnzahlBuchungen;


-- Hilfstabelle Summe aller bisher gezahlter Rechungsbeiträge
CREATE VIEW SummeBereitsGezahlt
as
SELECT email, SUM(Bezahlung.betrag) as Sum_bereits_gezahlt
FROM Buchung
JOIN Bezahlung ON Bezahlung.buchungsnr = Buchung.buchungsnr

GROUP BY email;

SELECT * FROM SummeBereitsGezahlt;


-- Hilfstabelle für Anzahl Stornierungen
CREATE VIEW AnzahlStornierungen
AS 
SELECT email, COUNT(*) as Anzahl_Stornierungen
FROM StornierteBuchungen
GROUP BY email;
SELECT * FROM AnzahlStornierungen;