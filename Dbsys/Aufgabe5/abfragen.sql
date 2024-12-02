-- a) Wie viele Ferienwohnungen wurden noch nie gebucht?
SELECT *
FROM dbsys16.Ferienwohnung
WHERE Ferienwohnung.ferienwohnungsName NOT IN (
    SELECT ferienwohnungsName
    FROM dbsys16.Buchung
);
-- b) Welche Kunden haben EINE Ferienwohnung bereits mehrmals gebucht?
SELECT email, COUNT(*) as buchungsanzahl
FROM dbsys16.Buchung
Group by email
HAVING COUNT(*) > 1;
-- c) Welche Ferienwohnungen in Spanien haben durchschnittlich mehr als 4 Sterne erhalten?
SELECT ferienwohnungsName
FROM dbsys16.Buchung
WHERE sternanzahl > 4
AND ferienwohnungsName IN (
    
)
-- d) Welche Ferienwohnung hat die meisten Ausstattungen? Falls mehrere Ferienwohnungen das Maximum an Ausstattungen erreichen, sollen diese alle ausgegeben werden.
-- e) Wie viele Reservierungen gibt es für die einzelnen Länder? Länder, in denen keine Reservierungen existieren, sollen mit der Anzahl 0 ebenfalls aufgeführt werden. Das Ergebnis soll nach der Anzahl Reservierungen absteigend sortiert werden.
-- f) Wie viele Ferienwohnungen sind pro Stadtnamen gespeichert?
-- g) Welche Ferienwohnungen haben bisher NUR Bewertungen mit einem oder zwei Sternen erhalten?
-- h) Welche Ferienwohnungen mit Sauna sind in Spanien in der Zeit vom 01.05.2024 – 21.05.2024 noch frei? Geben Sie den Ferienwohnungs-Namen und deren durchschnittliche Bewertung an. Ferienwohnungen mit guten Bewertungen sollen zuerst angezeigt werden. Ferienwohnungen ohne Bewertungen sollen am Ende ausgegeben werden.


