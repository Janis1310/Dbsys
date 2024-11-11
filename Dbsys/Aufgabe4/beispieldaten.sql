-- Zuerst Länder hinzufügen
INSERT INTO Land (bezeichnung) VALUES ('Deutschland');
INSERT INTO Land (bezeichnung) VALUES ('Österreich');
INSERT INTO Land (bezeichnung) VALUES ('Schweiz');

-- Adressen hinzufügen
INSERT INTO Adresse (adressnr, strasse, hausnummer, plz, ort, landbezeichnung)
VALUES (1, 'Hauptstraße', 12, 10115, 'Berlin', 'Deutschland');

INSERT INTO Adresse (adressnr, strasse, hausnummer, plz, ort, landbezeichnung)
VALUES (2, 'Berggasse', 5, 5020, 'Salzburg', 'Österreich');

-- Kunden hinzufügen
INSERT INTO Kunde (email, vorname, nachname, IBAN, passwort, adressnr)
VALUES ('kunde1@example.com', 'Max', 'Mustermann', 'DE89370400440532013000', 'passwort123', 1);

INSERT INTO Kunde (email, vorname, nachname, IBAN, passwort, adressnr)
VALUES ('kunde2@example.com', 'Anna', 'Musterfrau', 'AT611904300234573201', 'geheim123', 2);

-- Ferienwohnungen hinzufügen
INSERT INTO Ferienwohnung (ferienwohnungsName, groesse, anzahlZimmer, preisProTag, adressnr)
VALUES ('Ferienwohnung Berlin', 70, 3, 100, 1);

INSERT INTO Ferienwohnung (ferienwohnungsName, groesse, anzahlZimmer, preisProTag, adressnr)
VALUES ('Alpenblick Salzburg', 80, 4, 120, 2);

-- Bilder für die Ferienwohnungen hinzufügen
INSERT INTO Bilder (url, ferienwohnungsname)
VALUES ('https://example.com/berlin.jpg', 'Ferienwohnung Berlin');

INSERT INTO Bilder (url, ferienwohnungsname)
VALUES ('https://example.com/salzburg.jpg', 'Alpenblick Salzburg');

-- Ausstattung hinzufügen
INSERT INTO Ausstattung (bezeichnung) VALUES ('WLAN');
INSERT INTO Ausstattung (bezeichnung) VALUES ('Küche');
INSERT INTO Ausstattung (bezeichnung) VALUES ('Parkplatz');

-- Zuordnungen zur Ausstattung hinzufügen
INSERT INTO Besitzt (ausstatungsbezeichnung, ferienwohnungsname)
VALUES ('WLAN', 'Ferienwohnung Berlin');

INSERT INTO Besitzt (ausstatungsbezeichnung, ferienwohnungsname)
VALUES ('Küche', 'Alpenblick Salzburg');

-- Touristenattraktionen hinzufügen
INSERT INTO Touristenattraktion (bezeichnung, beschreibung)
VALUES ('Brandenburger Tor', 'Historisches Wahrzeichen in Berlin.');

INSERT INTO Touristenattraktion (bezeichnung, beschreibung)
VALUES ('Salzburger Dom', 'Historische Kathedrale in Salzburg.');

-- Ferienwohnung-Touristenattraktion Beziehungen hinzufügen
INSERT INTO Ferienwohnung_Touristenattraktion (ferienwohnungsName, touristenattraktionsBezeichnung, entfernung)
VALUES ('Ferienwohnung Berlin', 'Brandenburger Tor', 5);

INSERT INTO Ferienwohnung_Touristenattraktion (ferienwohnungsName, touristenattraktionsBezeichnung, entfernung)
VALUES ('Alpenblick Salzburg', 'Salzburger Dom', 2);

-- Buchungen hinzufügen
INSERT INTO Buchung (buchungsnr, buchungsdatum, abreise, anreise, sternanzahl, betrag, email, ferienwohnungsname, bewertungsdatum, zahlungsart, rechnungsdatum)
VALUES (1, TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-07-10', 'YYYY-MM-DD'), TO_DATE('2023-07-01', 'YYYY-MM-DD'), 5, 1000, 'kunde1@example.com', 'Ferienwohnung Berlin', TO_DATE('2023-07-10', 'YYYY-MM-DD'), 'Kreditkarte', TO_DATE('2023-07-01', 'YYYY-MM-DD'));

INSERT INTO Buchung (buchungsnr, buchungsdatum, abreise, anreise, sternanzahl, betrag, email, ferienwohnungsname, bewertungsdatum, zahlungsart, rechnungsdatum)
VALUES (2, TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-08-05', 'YYYY-MM-DD'), TO_DATE('2023-08-01', 'YYYY-MM-DD'), 4, 500, 'kunde2@example.com', 'Alpenblick Salzburg', TO_DATE('2023-08-05', 'YYYY-MM-DD'), 'Überweisung', TO_DATE('2023-08-01', 'YYYY-MM-DD'));

-- Bezahlungen hinzufügen
INSERT INTO Bezahlung (bezahlungsnr, betrag, zahlungsdatum, buchungsnr)
VALUES (1, 1000, TO_DATE('2023-07-01', 'YYYY-MM-DD'), 1);

INSERT INTO Bezahlung (bezahlungsnr, betrag, zahlungsdatum, buchungsnr)
VALUES (2, 500, TO_DATE('2023-08-01', 'YYYY-MM-DD'), 2);
