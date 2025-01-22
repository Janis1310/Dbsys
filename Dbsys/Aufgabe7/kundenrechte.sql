-- Berechtigungen für Ferienwohnung
GRANT SELECT ON Ferienwohnung TO dbsys16;

-- Berechtigungen für Buchungen
GRANT SELECT, INSERT ON Buchung TO dbsys16;

-- Berechtigungen für Touristenattraktion
GRANT SELECT ON Touristenattraktion TO dbsys16;

-- Berechtigungen für Ausstattung
GRANT SELECT ON Ausstattung TO dbsys16;

-- Berechtigungen für Land
GRANT SELECT ON Land TO dbsys16;

-- Berechtigungen für Adresse
GRANT SELECT, INSERT ON Adresse TO dbsys16;

-- Berechtigungen für Bilder
GRANT SELECT ON Bilder TO dbsys16;

-- Berechtigungen für Kunden (eigene Daten)
GRANT SELECT, UPDATE ON Kunde TO dbsys16;

SELECT * FROM USER_TAB_PRIVS WHERE GRANTEE = 'DBSYS16';