-- a) Wie viele Ferienwohnungen wurden noch nie gebucht?

-- b) Welche Kunden haben EINE Ferienwohnung bereits mehrmals gebucht?
-- c) Welche Ferienwohnungen in Spanien haben durchschnittlich mehr als 4 Sterne erhalten?
-- d) Welche Ferienwohnung hat die meisten Ausstattungen? Falls mehrere Ferienwohnungen das Maximum an Ausstattungen erreichen, sollen diese alle ausgegeben werden.
-- e) Wie viele Reservierungen gibt es für die einzelnen Länder? Länder, in denen keine Reservierungen existieren, sollen mit der Anzahl 0 ebenfalls aufgeführt werden. Das Ergebnis soll nach der Anzahl Reservierungen absteigend sortiert werden.
-- f) Wie viele Ferienwohnungen sind pro Stadtnamen gespeichert?
-- g) Welche Ferienwohnungen haben bisher NUR Bewertungen mit einem oder zwei Sternen erhalten?
-- h) Welche Ferienwohnungen mit Sauna sind in Spanien in der Zeit vom 01.05.2024 – 21.05.2024 noch frei? Geben Sie den Ferienwohnungs-Namen und deren durchschnittliche Bewertung an. Ferienwohnungen mit guten Bewertungen sollen zuerst angezeigt werden. Ferienwohnungen ohne Bewertungen sollen am Ende ausgegeben werden.

Select * FROM dbsys16.Kunde;
SELECT * FROM dbsys16.Ferienwohnung;
SELECT bezeichnung FROM dbsys16.AUSSTATTUNG;
SELECT * FROM ADRESSE;


