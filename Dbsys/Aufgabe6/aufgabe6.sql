-- Bearbeitung aufgabe 6

-- Aufgabe a)
SELECT * FROM Buchung;
DROP TABLE StornierteBuchungen;
DROP TRIGGER buchungStornieren;

CREATE TABLE StornierteBuchungen(
    StornoID INT PRIMARY KEY, -- buchungsnr nehmen
    buchungsnr INT NOT NULL,
    buchungsdatum DATE NOT NULL,
    storno DATE, -- Kann attribut
    abreise DATE NOT NULL,
    anreise DATE NOT NULL,
    sternanzahl INT CHECK (sternanzahl <= 5) CHECK (sternanzahl > 0), -- kann attribut
    betrag NUMBER NOT NULL CHECK (betrag > 0),
    email VARCHAR2(255), -- Muss ich das auch prüfen? Ist ja schon in Kunde geprüft
    ferienwohnungsname VARCHAR2(255) NOT NULL,
    bewertungsdatum DATE, -- kann attribut
    zahlungsart VARCHAR2(255) NOT NULL,
    rechnungsdatum DATE NOT NULL,
    storniertDatum Date DEFAULT SYSDATE
);

CREATE SEQUENCE SEQ_StornierteBuchungen
START WITH 1
INCREMENT BY 1;


CREATE TRIGGER buchungStornieren
BEFORE DELETE ON Buchung
FOR EACH ROW
BEGIN
    Insert Into StornierteBuchungen(stornoID, buchungsnr, buchungsdatum, storno, abreise, anreise, sternanzahl, betrag, email, ferienwohnungsname, bewertungsdatum, zahlungsart, rechnungsdatum)
    VALUES (SEQ_StornierteBuchungen.NEXTVAL,
        :OLD.buchungsnr,
        :OLD.buchungsdatum,
        :OLD.storno,
        :OLD.abreise,
        :OLD.anreise,
        :OLD.sternanzahl,
        :OLD.betrag,
        :OLD.email,
        :OLD.ferienwohnungsname,
        :OLD.bewertungsdatum,
        :OLD.zahlungsart,
        :OLD.rechnungsdatum
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


-- Aufgabe c)
-- Hilfstabelle gemeinsame Bewertungen
CREATE VIEW GemeinsameBewertungen
AS
SELECT
    b1.email AS kunde1,
    b2.email AS kunde2,
    b1.ferienwohnungsname
FROM Buchung b1
JOIN Buchung b2 ON b1.ferienwohnungsname = b2.ferienwohnungsname
WHERE b1.sternanzahl = 5
AND b2.sternanzahl = 5
AND b1.email != b2.email;

SELECT * FROM GEMEINSAMEBEWERTUNGEN;
drop view GemeinsameBewertungen;

SELECT * FROM Buchung;


-- View Empfohlene Wohnungen
CREATE VIEW EmpfohleneWohnungen 
AS
SELECT g.kunde1 AS empf_kunde, b2.ferienwohnungsname AS empfohlene_wohnung
FROM GemeinsameBewertungen g
JOIN Buchung b2 ON g.kunde2 = b2.email
       
WHERE b2.sternanzahl = 5
AND b2.ferienwohnungsname NOT IN ( -- nur empfehlungen, wo Kunde noch nicht war
    SELECT b1.ferienwohnungsname
    FROM Buchung b1
    WHERE b1.email = g.kunde1
);
DROP VIEW EmpfohleneWohnungen;


SELECT * FROM EmpfohleneWohnungen
ORDER BY empf_kunde, empfohlene_wohnung;


-- Aufgabe d)
SELECT f.ferienwohnungsName, AVG(b.sternanzahl) as DurchschnittlicheSterne
FROM Ferienwohnung f
JOIN Buchung b ON f.ferienwohnungsName = b.ferienwohnungsName
JOIN Adresse a ON f.adressnr = a.adressnr
JOIN Land l ON a.landbezeichnung = l.bezeichnung
JOIN Ferienwohnung_Touristenattraktion fta ON f.ferienwohnungsName = fta.ferienwohnungsName
JOIN Touristenattraktion ta ON fta.touristenattraktionsBezeichnung = ta.bezeichnung
WHERE l.bezeichnung = 'Spanien'
AND ta.bezeichnung = 'Sauna'
AND b.anreise > TO_DATE('2024-05-01', 'YYYY-MM-DD')
AND b.abreise < TO_DATE('2024-05-21', 'YYYY-MM-DD')
AND f.ferienwohnungsName NOT IN (
    SELECT f.ferienwohnungsName
    FROM Buchung b
    WHERE b.anreise < TO_DATE('2024-05-21', 'YYYY-MM-DD')
    AND b.abreise > TO_DATE('2024-05-01', 'YYYY-MM-DD')
)
GROUP BY f.ferienwohnungsName
ORDER BY DurchschnittlicheSterne DESC;


-- ab hier die Indizes zur Beschleundigung
CREATE INDEX idx_buchung_ferienwohnung ON Buchung (ferienwohnungsName);
-- CREATE INDEX idx_ferienwohnung_name ON Ferienwohnung (ferienwohnungsName); -- kann weggelassen werden, da über Primärschlüssel automatisch ein Index ist
CREATE INDEX idx_buchung_anreise_abreise ON Buchung (anreise, abreise);

SELECT index_name, column_name
FROM all_ind_columns
WHERE table_name = 'FERIENWOHNUNG' AND column_name = 'FERIENWOHNUNGSNAME';
