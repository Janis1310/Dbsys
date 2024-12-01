INSERT INTO Land (bezeichnung) VALUES 
('Deutschland'), 
('Spanien'), 
('Italien'), 
('Frankreich'), 
('Österreich'),
('Schweden'),
('Vereinigtes Königreich'),
('Portugal'),
('USA'),
('Australien'),
('Russland'),
('Thailand'),
('Niederlande'),
('China');

INSERT INTO Adresse (adressNr, hausNr, strasse, ort, postleihzahl, landName) VALUES 
(1, 12, 'Berliner Allee', 'Berlin', '10115', 'Deutschland'),
(2, 45, 'Hauptstraße', 'München', '80331', 'Deutschland'),
(3, 7, 'Schlossallee', 'Hamburg', '20457', 'Deutschland'),
(4, 3, 'Plaza Mayor', 'Madrid', '28013', 'Spanien'),
(5, 16, 'Carrer del Paradís', 'Barcelona', '08002', 'Spanien'),
(6, 10, 'Via Roma', 'Rom', '00184', 'Italien'),
(7, 24, 'Rue de Rivoli', 'Paris', '75001', 'Frankreich'),
(8, 35, 'Mariahilfer Straße', 'Wien', '1060', 'Österreich'),
(12, 47, 'Fifth Avenue', 'New York', '10011', 'USA'),
(13, 99, 'George Street', 'Sydney', '2000', 'Australien');

INSERT INTO Ferienwohnung (Fname, groesse, anzahlZimmer, preisProTag, adresseNr) VALUES 
('Berliner Loft', 50.5, 2, 120.00, 1),
('Münchner Villa', 120.0, 4, 250.00, 2),
('Hamburger Hafenblick', 80.0, 3, 180.00, 3),
('Madrid Penthouse', 70.0, 2, 200.00, 4),
('Barcelona Beach Retreat', 90.0, 3, 220.00, 5),
('Italienisches Paradies', 110.0, 4, 280.00, 6),
('Pariser Eleganz', 75.0, 2, 240.00, 7),
('Wiener Chalet', 95.0, 3, 190.00, 8),
('New Yorker Loft', 100.0, 4, 350.00, 12),
('Sydney Harbor View', 120.0, 3, 400.00, 13);

INSERT INTO Kunde (email, vorname, nachname, IBAN, adresseNr) VALUES 
('anna.schmidt@gmail.com', 'Anna', 'Schmidt', 'DE12345678901234567890', 1),
('max.mueller@gmail.com', 'Max', 'Müller', 'DE09876543210987654321', 2),
('lisa.bauer@gmail.com', 'Lisa', 'Bauer', 'DE12312312312312312312', 3),
('peter.klein@gmail.com', 'Peter', 'Klein', 'ES12345678901234567890', 4),
('sandra.huber@gmail.com', 'Sandra', 'Huber', 'ES09876543210987654321', 5),
('mario.rossi@gmail.com', 'Mario', 'Rossi', 'IT12345678901234567890', 6);

INSERT INTO Buchung (buchungsNr, buchungsdatum, reisezeit, storno, anreise, abreise, sternAnz, ferienwohnung_name, bewertungsdatum, zahlungsArt, rechnungsdatum) VALUES 
('B001', '2024-01-01', NULL, NULL, '2024-01-10', '2024-01-15', 5, 'Berliner Loft', '2024-01-20', 'Kreditkarte', '2024-01-01'),
('B002', '2024-02-01', NULL, NULL, '2024-02-05', '2024-02-10', 4, 'Hamburger Hafenblick', '2024-02-15', 'PayPal', '2024-02-01'),
('B003', '2024-03-01', NULL, NULL, '2024-03-12', '2024-03-20', 3, 'Barcelona Beach Retreat', '2024-03-25', 'Kreditkarte', '2024-03-01'),
('B004', '2024-04-01', NULL, NULL, '2024-04-10', '2024-04-15', 4, 'Italienisches Paradies', '2024-04-20', 'Kreditkarte', '2024-04-01'),
('B005', '2024-07-01', NULL, NULL, '2024-07-05', '2024-07-10', 5, 'New Yorker Loft', '2024-07-15', 'PayPal', '2024-07-01'),

('B006', NULL, NULL, NULL, NULL, NULL, NULL, 'Madrid Penthouse', NULL, NULL, NULL),
('B007', NULL, NULL, NULL, NULL, NULL, NULL, 'Pariser Eleganz', NULL, NULL, NULL),
('B008', NULL, NULL, NULL, NULL, NULL, NULL, 'Sydney Harbor View', NULL, NULL, NULL),
('B009', '2024-08-01', NULL, NULL, '2024-08-08', '2024-08-14', 3, 'Wiener Chalet', '2024-08-20', 'PayPal', '2024-08-01');

INSERT INTO Bezahlung (bezahlNr, betrag, datum, buchungNR) VALUES 
(1, 600.00, '2024-01-01', 'B001'),
(2, 900.00, '2024-02-01', 'B002'),
(3, 1200.00, '2024-03-01', 'B003'),
(4, 700.00, '2024-04-01', 'B004'),
(5, 1750.00, '2024-07-01', 'B005'),
(6, 950.00, '2024-08-01', 'B009');

INSERT INTO Ausstattung (bezeichnung) VALUES 
('WiFi'), 
('Klimaanlage'), 
('Sauna'), 
('Balkon'), 
('Pool'), 
('Whirlpool'), 
('Terrasse'), 
('Garten'), 
('Kamin'), 
('Smart TV');

INSERT INTO WohnungBesitztAusstattung (ausstattung_bezeichnung, ferienwohnung_name) VALUES 
('WiFi', 'Berliner Loft'),
('Klimaanlage', 'Berliner Loft'),
('Pool', 'Münchner Villa'),
('WiFi', 'Münchner Villa'),
('Balkon', 'Hamburger Hafenblick'),
('WiFi', 'Hamburger Hafenblick'),
('Klimaanlage', 'Madrid Penthouse'),
('WiFi', 'Madrid Penthouse'),
('Sauna', 'Barcelona Beach Retreat'),
('Pool', 'Barcelona Beach Retreat'),
('WiFi', 'Italienisches Paradies'),
('Balkon', 'Italienisches Paradies'),
('Klimaanlage', 'Pariser Eleganz'),
('WiFi', 'Pariser Eleganz'),
('Pool', 'Wiener Chalet'),
('WiFi', 'Wiener Chalet'),
('WiFi', 'New Yorker Loft'),
('Whirlpool', 'New Yorker Loft'),
('WiFi', 'Sydney Harbor View'),
('Terrasse', 'Sydney Harbor View');

INSERT INTO Touristenattraktion (bezeichnung, beschreibung) VALUES 
('Brandenburger Tor', 'Historisches Wahrzeichen in Berlin'),
('Englischer Garten', 'Großer Park in München'),
('Sagrada Familia', 'Berühmte Kirche in Barcelona'),
('Kolosseum', 'Römisches Amphitheater in Italien'),
('Statue of Liberty', 'Famous statue in New York'),
('Sydney Opera House', 'Iconic landmark in Sydney');

INSERT INTO FerienwohnungNaheTouristenattraktion (entfernung, ferienwohnung_name, touristenattraktion_bezeichnung) VALUES 
(1.2, 'Berliner Loft', 'Brandenburger Tor'),
(0.8, 'Münchner Villa', 'Englischer Garten'),
(1.5, 'Barcelona Beach Retreat', 'Sagrada Familia'),
(2.0, 'Italienisches Paradies', 'Kolosseum'),
(2.0, 'New Yorker Loft', 'Statue of Liberty'),
(1.0, 'Sydney Harbor View', 'Sydney Opera House');
