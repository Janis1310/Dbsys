-- a) Wie viele Ferienwohnungen wurden noch nie gebucht?
SELECT count(*) as "Anzahl ungebuchter Ferienwohnungen"
FROM Ferienwohnung f
WHERE f.ferienwohnungsName NOT IN (
    SELECT ferienwohnungsName
    FROM Buchung
);
-- b) Welche Kunden haben EINE Ferienwohnung bereits mehrmals gebucht?
SELECT email, COUNT(*) as buchungsanzahl
FROM Buchung
Group by email
HAVING COUNT(*) > 1;
-- c) Welche Ferienwohnungen in Spanien haben durchschnittlich mehr als 4 Sterne erhalten?
SELECT f.ferienwohnungsName, AVG(b.sternanzahl) as DurchschnittlicheSterne
FROM Ferienwohnung f
JOIN Buchung b ON f.ferienwohnungsName = b.ferienwohnungsName
JOIN Adresse a ON f.adressnr = a.adressnr
JOIN Land l ON a.landbezeichnung = l.bezeichnung
WHERE l.bezeichnung = 'Spanien'
GROUP BY f.ferienwohnungsName
HAVING AVG(b.sternanzahl) > 4;


-- d) Welche Ferienwohnung hat die meisten Ausstattungen? Falls mehrere Ferienwohnungen das Maximum an Ausstattungen erreichen, sollen diese alle ausgegeben werden.
SELECT Ferienwohnungsname, COUNT(*) as AnzahlAusstattungen
FROM Besitzt
GROUP BY ferienwohnungsName
HAVING COUNT(*) = (
    SELECT MAX(AnzahlAusstattungen)
    FROM (
        SELECT Ferienwohnungsname, COUNT(*) as AnzahlAusstattungen
        FROM Besitzt
        GROUP BY ferienwohnungsName
    )
);

-- e) Wie viele Reservierungen gibt es für die einzelnen Länder? Länder, in denen keine Reservierungen existieren, sollen mit der Anzahl 0 ebenfalls aufgeführt werden. Das Ergebnis soll nach der Anzahl Reservierungen absteigend sortiert werden.
SELECT l.bezeichnung, COUNT(b.buchungsnr) as AnzahlReservierungen
FROM Land l
-- Hier muss ein LEFT JOIN verwendet werden, da auch Länder ohne Reservierungen aufgeführt werden sollen
LEFT JOIN Adresse a ON l.bezeichnung = a.landbezeichnung
LEFT JOIN Ferienwohnung f ON a.adressnr = f.adressnr
LEFT JOIN Buchung b ON f.ferienwohnungsname = b.ferienwohnungsname
--and anreise > SYSDATE
GROUP BY l.bezeichnung
ORDER BY AnzahlReservierungen DESC;

-- f) Wie viele Ferienwohnungen sind pro Stadtnamen gespeichert?
SELECT a.ort, COUNT(f.ferienwohnungsName) as AnzahlFerienwohnungen
FROM Adresse a
JOIN Ferienwohnung f ON a.adressnr = f.adressnr
GROUP BY a.ort;

-- g) Welche Ferienwohnungen haben bisher NUR Bewertungen mit einem oder zwei Sternen erhalten?
SELECT f.ferienwohnungsName
FROM Ferienwohnung f
JOIN Buchung b ON f.ferienwohnungsName = b.ferienwohnungsName
GROUP BY f.ferienwohnungsName
HAVING MAX(b.sternanzahl) <= 2;
-- h) Welche Ferienwohnungen mit Sauna sind in Spanien in der Zeit vom 01.05.2024 – 21.05.2024 noch frei? Geben Sie den Ferienwohnungs-Namen und deren durchschnittliche Bewertung an. Ferienwohnungen mit guten Bewertungen sollen zuerst angezeigt werden. Ferienwohnungen ohne Bewertungen sollen am Ende ausgegeben werden.
-- noch falsch
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

SELECT * FROM BUCHUNG;