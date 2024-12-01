SELECT Fname -- aufgabe5 a)
FROM Ferienwohnung
WHERE Fname NOT IN ( SELECT ferienwohnung_name
					 FROM Buchung
                     WHERE buchungsdatum = NULL);

SELECT vorname, nachname -- aufageb5 b) 
FROM Kunde k;
-- WHERE k.email IN (SELECT email
				  -- FROM Buchung b 
                  
SELECT ferienwohnung_name
FROM Buchung b
WHERE b.sternAnz >= 4 AND b.ferienwohnung_name IN (SELECT Fname 
											   FROM Ferienwohnung f, Adresse a		
                                               WHERE a.landName = 'Spanien')

