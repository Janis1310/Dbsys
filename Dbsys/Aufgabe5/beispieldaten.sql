-- Länder hinzufügen
INSERT INTO Land (bezeichnung) VALUES ('Frankreich');
INSERT INTO Land (bezeichnung) VALUES ('Italien');
INSERT INTO Land (bezeichnung) VALUES ('Spanien');
INSERT INTO Land (bezeichnung) VALUES ('Niederlande');
INSERT INTO Land (bezeichnung) VALUES ('Belgien');
INSERT INTO Land (bezeichnung) VALUES ('Portugal');
INSERT INTO Land (bezeichnung) VALUES ('Dänemark');
INSERT INTO Land (bezeichnung) VALUES ('Schweden');
INSERT INTO Land (bezeichnung) VALUES ('USA');

-- Adressen hinzufügen
INSERT INTO Adresse (adressnr, strasse, hausnummer, plz, ort, landbezeichnung)
VALUES (3, 'Rue de Paris', 45, 75001, 'Paris', 'Frankreich');
INSERT INTO Adresse (adressnr, strasse, hausnummer, plz, ort, landbezeichnung)
VALUES (4, 'Via Roma', 23, 00184, 'Rom', 'Italien');
INSERT INTO Adresse (adressnr, strasse, hausnummer, plz, ort, landbezeichnung)
VALUES (5, 'Calle Mayor', 10, 28013, 'Madrid', 'Spanien');
INSERT INTO Adresse (adressnr, strasse, hausnummer, plz, ort, landbezeichnung)
VALUES (6, 'Damrak', 32, 1012, 'Amsterdam', 'Niederlande');
INSERT INTO Adresse (adressnr, strasse, hausnummer, plz, ort, landbezeichnung)
VALUES (7, 'Avenue Louise', 100, 1050, 'Brüssel', 'Belgien');
INSERT INTO Adresse (adressnr, strasse, hausnummer, plz, ort, landbezeichnung)
VALUES (8, 'Rua Augusta', 12, 1100, 'Lissabon', 'Portugal');
INSERT INTO Adresse (adressnr, strasse, hausnummer, plz, ort, landbezeichnung)
VALUES (9, 'Strøget', 56, 1000, 'Kopenhagen', 'Dänemark');
INSERT INTO Adresse (adressnr, strasse, hausnummer, plz, ort, landbezeichnung)
VALUES (10, 'Drottninggatan', 24, 1111, 'Stockholm', 'Schweden');

-- Kunden hinzufügen
INSERT INTO Kunde (email, vorname, nachname, IBAN, passwort, adressnr)
VALUES ('kunde3@example.com', 'Jean', 'Dupont', 'FR7630006000011234567890189', 'bonjour123', 3);
INSERT INTO Kunde (email, vorname, nachname, IBAN, passwort, adressnr)
VALUES ('kunde4@example.com', 'Luca', 'Rossi', 'IT60X0542811101000000123456', 'ciao123', 4);
INSERT INTO Kunde (email, vorname, nachname, IBAN, passwort, adressnr)
VALUES ('kunde5@example.com', 'Maria', 'Garcia', 'ES9121000418450200051332', 'hola123', 5);
INSERT INTO Kunde (email, vorname, nachname, IBAN, passwort, adressnr)
VALUES ('kunde6@example.com', 'Emma', 'Van den Berg', 'NL91ABNA0417164300', 'welkom123', 6);
INSERT INTO Kunde (email, vorname, nachname, IBAN, passwort, adressnr)
VALUES ('kunde7@example.com', 'Sophie', 'Dubois', 'BE62510007547061', 'salut123', 7);
INSERT INTO Kunde (email, vorname, nachname, IBAN, passwort, adressnr)
VALUES ('kunde8@example.com', 'Joao', 'Silva', 'PT50000201231234567890154', 'ola123', 8);
INSERT INTO Kunde (email, vorname, nachname, IBAN, passwort, adressnr)
VALUES ('kunde9@example.com', 'Anders', 'Hansen', 'DK5000400440116243', 'hej123', 9);
INSERT INTO Kunde (email, vorname, nachname, IBAN, passwort, adressnr)
VALUES ('kunde10@example.com', 'Elin', 'Eriksson', 'SE4550000000058398257466', 'hejhej123', 10);

-- Ferienwohnungen hinzufügen
INSERT INTO Ferienwohnung (ferienwohnungsName, groesse, anzahlZimmer, preisProTag, adressnr)
VALUES ('Pariser Charme', 50, 2, 150, 3);
INSERT INTO Ferienwohnung (ferienwohnungsName, groesse, anzahlZimmer, preisProTag, adressnr)
VALUES ('Römische Eleganz', 90, 5, 200, 4);
INSERT INTO Ferienwohnung (ferienwohnungsName, groesse, anzahlZimmer, preisProTag, adressnr)
VALUES ('Spanischer Stil', 70, 3, 120, 5);
INSERT INTO Ferienwohnung (ferienwohnungsName, groesse, anzahlZimmer, preisProTag, adressnr)
VALUES ('Grachteblick Amsterdam', 60, 2, 140, 6);
INSERT INTO Ferienwohnung (ferienwohnungsName, groesse, anzahlZimmer, preisProTag, adressnr)
VALUES ('Belgischer Charme', 75, 3, 130, 7);
INSERT INTO Ferienwohnung (ferienwohnungsName, groesse, anzahlZimmer, preisProTag, adressnr)
VALUES ('Lissabonner Licht', 55, 2, 110, 8);
INSERT INTO Ferienwohnung (ferienwohnungsName, groesse, anzahlZimmer, preisProTag, adressnr)
VALUES ('Kopenhagener Stil', 80, 4, 150, 9);
INSERT INTO Ferienwohnung (ferienwohnungsName, groesse, anzahlZimmer, preisProTag, adressnr)
VALUES ('Schwedische Gemütlichkeit', 65, 3, 135, 10);
INSERT INTO Ferienwohnung (ferienwohnungsName, groesse, anzahlZimmer, preisProTag, adressnr)
VALUES ('ungebucht', 65, 3, 135, 10);


-- Bilder für die Ferienwohnungen hinzufügen
INSERT INTO Bilder (url, ferienwohnungsname)
VALUES ('https://example.com/paris.jpg', 'Pariser Charme');
INSERT INTO Bilder (url, ferienwohnungsname)
VALUES ('https://example.com/rom.jpg', 'Römische Eleganz');
INSERT INTO Bilder (url, ferienwohnungsname)
VALUES ('https://example.com/madrid.jpg', 'Spanischer Stil');
INSERT INTO Bilder (url, ferienwohnungsname)
VALUES ('https://example.com/amsterdam.jpg', 'Grachteblick Amsterdam');
INSERT INTO Bilder (url, ferienwohnungsname)
VALUES ('https://example.com/brussels.jpg', 'Belgischer Charme');
INSERT INTO Bilder (url, ferienwohnungsname)
VALUES ('https://example.com/lisbon.jpg', 'Lissabonner Licht');
INSERT INTO Bilder (url, ferienwohnungsname)
VALUES ('https://example.com/copenhagen.jpg', 'Kopenhagener Stil');
INSERT INTO Bilder (url, ferienwohnungsname)
VALUES ('https://example.com/stockholm.jpg', 'Schwedische Gemütlichkeit');

-- Ausstattung hinzufügen
INSERT INTO Ausstattung (bezeichnung) VALUES ('WLAN');
INSERT INTO Ausstattung (bezeichnung) VALUES ('Küche');
INSERT INTO Ausstattung (bezeichnung) VALUES ('Parkplatz');
INSERT INTO Ausstattung (bezeichnung) VALUES ('Balkon');
INSERT INTO Ausstattung (bezeichnung) VALUES ('Waschmaschine');
INSERT INTO Ausstattung (bezeichnung) VALUES ('Pool');
INSERT INTO Ausstattung (bezeichnung) VALUES ('Klimaanlage');
INSERT INTO Ausstattung (bezeichnung) VALUES ('Fahrradverleih');
INSERT INTO Ausstattung (bezeichnung) VALUES ('Fitnessstudio');
INSERT INTO Ausstattung (bezeichnung) VALUES ('Haustierfreundlich');
INSERT INTO Ausstattung (bezeichnung) VALUES ('Sauna');

-- Zuordnungen zur Ausstattung hinzufügen
INSERT INTO Besitzt (ausstatungsbezeichnung, ferienwohnungsname)
VALUES ('WLAN', 'Pariser Charme');
INSERT INTO Besitzt (ausstatungsbezeichnung, ferienwohnungsname)
VALUES ('Küche', 'Römische Eleganz');
INSERT INTO Besitzt (ausstatungsbezeichnung, ferienwohnungsname)
VALUES ('Parkplatz', 'Spanischer Stil');
INSERT INTO Besitzt (ausstatungsbezeichnung, ferienwohnungsname)
VALUES ('Balkon', 'Grachteblick Amsterdam');
INSERT INTO Besitzt (ausstatungsbezeichnung, ferienwohnungsname)
VALUES ('Waschmaschine', 'Belgischer Charme');
INSERT INTO Besitzt (ausstatungsbezeichnung, ferienwohnungsname)
VALUES ('Pool', 'Lissabonner Licht');
INSERT INTO Besitzt (ausstatungsbezeichnung, ferienwohnungsname)
VALUES ('Klimaanlage', 'Kopenhagener Stil');
INSERT INTO Besitzt (ausstatungsbezeichnung, ferienwohnungsname)
VALUES ('Fahrradverleih', 'Schwedische Gemütlichkeit');
INSERT INTO Besitzt (ausstatungsbezeichnung, ferienwohnungsname)
VALUES ('Fitnessstudio', 'Pariser Charme');
INSERT INTO Besitzt (ausstatungsbezeichnung, ferienwohnungsname)
VALUES ('Haustierfreundlich', 'Römische Eleganz');

-- Touristenattraktionen hinzufügen
INSERT INTO Touristenattraktion (bezeichnung, beschreibung)
VALUES ('Eiffelturm', 'Berühmtes Wahrzeichen in Paris.');
INSERT INTO Touristenattraktion (bezeichnung, beschreibung)
VALUES ('Kolosseum', 'Antikes Amphitheater in Rom.');
INSERT INTO Touristenattraktion (bezeichnung, beschreibung)
VALUES ('Prado Museum', 'Weltberühmtes Kunstmuseum in Madrid.');
INSERT INTO Touristenattraktion (bezeichnung, beschreibung)
VALUES ('Anne-Frank-Haus', 'Historisches Museum in Amsterdam.');
INSERT INTO Touristenattraktion (bezeichnung, beschreibung)
VALUES ('Atomium', 'Architektonisches Wahrzeichen in Brüssel.');
INSERT INTO Touristenattraktion (bezeichnung, beschreibung)
VALUES ('Belém-Turm', 'Historisches Denkmal in Lissabon.');
INSERT INTO Touristenattraktion (bezeichnung, beschreibung)
VALUES ('Tivoli', 'Berühmter Freizeitpark in Kopenhagen.');
INSERT INTO Touristenattraktion (bezeichnung, beschreibung)
VALUES ('Vasa-Museum', 'Historisches Schiffs-Museum in Stockholm.');

-- Ferienwohnung-Touristenattraktion Beziehungen hinzufügen
INSERT INTO Ferienwohnung_Touristenattraktion (ferienwohnungsName, touristenattraktionsBezeichnung, entfernung)
VALUES ('Pariser Charme', 'Eiffelturm', 3);
INSERT INTO Ferienwohnung_Touristenattraktion (ferienwohnungsName, touristenattraktionsBezeichnung, entfernung)
VALUES ('Römische Eleganz', 'Kolosseum', 2);
INSERT INTO Ferienwohnung_Touristenattraktion (ferienwohnungsName, touristenattraktionsBezeichnung, entfernung)
VALUES ('Spanischer Stil', 'Prado Museum', 5);
INSERT INTO Ferienwohnung_Touristenattraktion (ferienwohnungsName, touristenattraktionsBezeichnung, entfernung)
VALUES ('Grachteblick Amsterdam', 'Anne-Frank-Haus', 1);
INSERT INTO Ferienwohnung_Touristenattraktion (ferienwohnungsName, touristenattraktionsBezeichnung, entfernung)
VALUES ('Belgischer Charme', 'Atomium', 4);
INSERT INTO Ferienwohnung_Touristenattraktion (ferienwohnungsName, touristenattraktionsBezeichnung, entfernung)
VALUES ('Lissabonner Licht', 'Belém-Turm', 3);
INSERT INTO Ferienwohnung_Touristenattraktion (ferienwohnungsName, touristenattraktionsBezeichnung, entfernung)
VALUES ('Kopenhagener Stil', 'Tivoli', 2);
INSERT INTO Ferienwohnung_Touristenattraktion (ferienwohnungsName, touristenattraktionsBezeichnung, entfernung)
VALUES ('Schwedische Gemütlichkeit', 'Vasa-Museum', 6);

-- Buchungen hinzufügen
INSERT INTO Buchung (buchungsnr, buchungsdatum, abreise, anreise, sternanzahl, betrag, email, ferienwohnungsname, bewertungsdatum, zahlungsart, rechnungsdatum)
VALUES (3, TO_DATE('2023-09-01', 'YYYY-MM-DD'), TO_DATE('2023-09-05', 'YYYY-MM-DD'), TO_DATE('2023-09-01', 'YYYY-MM-DD'), 5, 750, 'kunde3@example.com', 'Pariser Charme', TO_DATE('2023-09-05', 'YYYY-MM-DD'), 'Kreditkarte', TO_DATE('2023-09-01', 'YYYY-MM-DD'));
INSERT INTO Buchung (buchungsnr, buchungsdatum, abreise, anreise, sternanzahl, betrag, email, ferienwohnungsname, bewertungsdatum, zahlungsart, rechnungsdatum)
VALUES (4, TO_DATE('2023-10-01', 'YYYY-MM-DD'), TO_DATE('2023-10-07', 'YYYY-MM-DD'), TO_DATE('2023-10-01', 'YYYY-MM-DD'), 2, 1400, 'kunde4@example.com', 'Römische Eleganz', TO_DATE('2023-10-07', 'YYYY-MM-DD'), 'PayPal', TO_DATE('2023-10-01', 'YYYY-MM-DD'));
INSERT INTO Buchung (buchungsnr, buchungsdatum, abreise, anreise, sternanzahl, betrag, email, ferienwohnungsname, bewertungsdatum, zahlungsart, rechnungsdatum)
VALUES (7, TO_DATE('2023-09-15', 'YYYY-MM-DD'), TO_DATE('2023-09-20', 'YYYY-MM-DD'), TO_DATE('2023-09-15', 'YYYY-MM-DD'), 5, 1000, 'kunde5@example.com', 'Spanischer Stil', TO_DATE('2023-09-20', 'YYYY-MM-DD'), 'Kreditkarte', TO_DATE('2023-09-15', 'YYYY-MM-DD'));
INSERT INTO Buchung (buchungsnr, buchungsdatum, abreise, anreise, sternanzahl, betrag, email, ferienwohnungsname, bewertungsdatum, zahlungsart, rechnungsdatum)
VALUES (8, TO_DATE('2023-10-10', 'YYYY-MM-DD'), TO_DATE('2023-10-15', 'YYYY-MM-DD'), TO_DATE('2023-10-10', 'YYYY-MM-DD'), 2, 700, 'kunde6@example.com', 'Grachteblick Amsterdam', NULL, 'PayPal', TO_DATE('2023-10-10', 'YYYY-MM-DD'));
INSERT INTO Buchung (buchungsnr, buchungsdatum, abreise, anreise, sternanzahl, betrag, email, ferienwohnungsname, bewertungsdatum, zahlungsart, rechnungsdatum)
VALUES (9, TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-08-05', 'YYYY-MM-DD'), TO_DATE('2023-08-01', 'YYYY-MM-DD'), 4, 500, 'kunde7@example.com', 'Belgischer Charme', TO_DATE('2023-08-05', 'YYYY-MM-DD'), 'Kreditkarte', TO_DATE('2023-08-01', 'YYYY-MM-DD'));
INSERT INTO Buchung (buchungsnr, buchungsdatum, abreise, anreise, sternanzahl, betrag, email, ferienwohnungsname, bewertungsdatum, zahlungsart, rechnungsdatum)
VALUES (10, TO_DATE('2023-06-15', 'YYYY-MM-DD'), TO_DATE('2023-06-20', 'YYYY-MM-DD'), TO_DATE('2023-06-15', 'YYYY-MM-DD'), 4, 550, 'kunde9@example.com', 'Kopenhagener Stil', NULL, 'Überweisung', TO_DATE('2023-06-15', 'YYYY-MM-DD'));
INSERT INTO Buchung (buchungsnr, buchungsdatum, abreise, anreise, sternanzahl, betrag, email, ferienwohnungsname, bewertungsdatum, zahlungsart, rechnungsdatum)
VALUES (11, TO_DATE('2023-11-10', 'YYYY-MM-DD'), TO_DATE('2023-11-15', 'YYYY-MM-DD'), TO_DATE('2023-11-10', 'YYYY-MM-DD'), 5, 675, 'kunde10@example.com', 'Schwedische Gemütlichkeit', NULL, 'Kreditkarte', TO_DATE('2023-11-10', 'YYYY-MM-DD'));
INSERT INTO Buchung (buchungsnr, buchungsdatum, abreise, anreise, sternanzahl, betrag, email, ferienwohnungsname, bewertungsdatum, zahlungsart, rechnungsdatum)
VALUES (13, TO_DATE('2023-05-10', 'YYYY-MM-DD'), TO_DATE('2023-05-15', 'YYYY-MM-DD'), TO_DATE('2023-05-10', 'YYYY-MM-DD'), 3, 600, 'kunde8@example.com', 'Lissabonner Licht', TO_DATE('2023-05-15', 'YYYY-MM-DD'), 'Kreditkarte', TO_DATE('2023-05-10', 'YYYY-MM-DD'));
INSERT INTO Buchung (buchungsnr, buchungsdatum, abreise, anreise, sternanzahl, betrag, email, ferienwohnungsname, bewertungsdatum, zahlungsart, rechnungsdatum)
VALUES (14, TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-07-06', 'YYYY-MM-DD'), TO_DATE('2023-07-01', 'YYYY-MM-DD'), 5, 900, 'kunde6@example.com', 'Grachteblick Amsterdam', NULL, 'Kreditkarte', TO_DATE('2023-07-01', 'YYYY-MM-DD'));


-- Bezahlungen hinzufügen
INSERT INTO Bezahlung (bezahlungsnr, betrag, zahlungsdatum, buchungsnr)
VALUES (3, 750, TO_DATE('2023-09-01', 'YYYY-MM-DD'), 3);
INSERT INTO Bezahlung (bezahlungsnr, betrag, zahlungsdatum, buchungsnr)
VALUES (4, 1400, TO_DATE('2023-10-01', 'YYYY-MM-DD'), 4);

COMMIT;
