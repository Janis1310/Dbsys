CREATE TABLE Ferienwohnung
(
    ferienwohnungsName VARCHAR2(255) PRIMARY KEY CHECK (LENGTH(ferienwohnungsName) > 3),
    groesse NUMBER NOT NULL CHECK (groesse > 0),
    anzahlZimmer INT NOT NULL CHECK (anzahlZimmer > 0) CHECK (anzahlZimmer < 15),
    preisProTag NUMBER NOT NULL CHECK (preisProTag > 0),
    adressnr INT NOT NULL,
    CONSTRAINT ferienwohnung_fk FOREIGN KEY (adressnr) REFERENCES Adresse(adressnr) -- Standartmaessig ON DELETE RESTRICT
);

CREATE TABLE Bilder
(
    url VARCHAR2(255) PRIMARY KEY,
    ferienwohnungsname VARCHAR2(255) NOT NULL,
    CONSTRAINT bilder_fk FOREIGN KEY (ferienwohnungsname) REFERENCES Ferienwohnung(ferienwohnungsname)
);
CREATE TABLE Ausstattung
(
    bezeichnung VARCHAR2(255) PRIMARY KEY
);

CREATE TABLE Besitzt
(
    ausstatungsbezeichnung VARCHAR2(255) NOT NULL,
    ferienwohnungsname VARCHAR2(255) NOT NULL CHECK (LENGTH(ferienwohnungsname) > 3),
    CONSTRAINT besitzt_pk PRIMARY KEY (ausstatungsbezeichnung, ferienwohnungsname),
    CONSTRAINT besitzt_fk1 FOREIGN KEY (ausstatungsbezeichnung) REFERENCES Ausstattung(bezeichnung) ON DELETE CASCADE,
    CONSTRAINT besitzt_fk2 FOREIGN KEY (ferienwohnungsname) REFERENCES Ferienwohnung(ferienwohnungsname) ON DELETE CASCADE
);

CREATE TABLE Touristenattraktion
(
    bezeichnung VARCHAR2(255) PRIMARY KEY,
    beschreibung VARCHAR2(255) --Kann attribut
);

CREATE TABLE Ferienwohnung_Touristenattraktion
(
    ferienwohnungsName VARCHAR2(255) NOT NULL,
    touristenattraktionsBezeichnung VARCHAR2(255) NOT NULL,
    entfernung NUMBER NOT NULL,
    CONSTRAINT ferienwohnung_touristen_pk PRIMARY KEY (ferienwohnungsName, touristenattraktionsBezeichnung),
    CONSTRAINT ferienwohnung_touristen_fk1 FOREIGN KEY (ferienwohnungsName) REFERENCES Ferienwohnung(ferienwohnungsName) ON DELETE CASCADE,
    CONSTRAINT ferienwohnung_touristen_fk2 FOREIGN KEY (touristenattraktionsBezeichnung) REFERENCES Touristenattraktion(bezeichnung) ON DELETE CASCADE
);

CREATE TABLE Buchung
(
    buchungsnr INT PRIMARY KEY,
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
    CONSTRAINT buchung_fk1 FOREIGN KEY (ferienwohnungsname) REFERENCES Ferienwohnung(ferienwohnungsname),
    CONSTRAINT buchung_fk2 FOREIGN KEY (email) REFERENCES Kunde(email)
);
ALTER TABLE Buchung ADD CONSTRAINT check_abreise_anreise CHECK (abreise > anreise);
ALTER TABLE Buchung ADD CONSTRAINT check_bewertungsdatum CHECK (bewertungsdatum > anreise);

CREATE TABLE Kunde
(
    email VARCHAR2(255) PRIMARY KEY, 
        CONSTRAINT email_format CHECK (REGEXP_LIKE(email, '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')),
    vorname VARCHAR2(255) NOT NULL,
    nachname VARCHAR2(255) NOT NULL,
    IBAN VARCHAR2(255) NOT NULL,
        constraint IBAN_foramat CHECK (REGEXP_LIKE(IBAN, '^[A-Z]{2}[0-9]{2}[A-Z0-9]{4}[0-9]{7}([A-Z0-9]?){0,16}$')),
    passwort VARCHAR2(255) NOT NULL,
    adressnr INT NOT NULL,
    CONSTRAINT kunde_fk FOREIGN KEY (adressnr) REFERENCES Adresse(adressnr)
);

CREATE TABLE Land 
(
    bezeichnung VARCHAR2(255) PRIMARY KEY
);
CREATE TABLE Adresse
(
    adressnr INT PRIMARY KEY,
    strasse VARCHAR2(255) NOT NULL,
    hausnummer INT NOT NULL,
        CONSTRAINT hausnummer_format CHECK (REGEXP_LIKE(hausnummer, '^[0-9]{1,5}$')),
    plz INT NOT NULL CHECK (plz > 0),
    ort VARCHAR2(255) NOT NULL CHECK (LENGTH(ort) > 2),
    landbezeichnung VARCHAR2(255) NOT NULL,
    CONSTRAINT adresse_fk FOREIGN KEY (landbezeichnung) REFERENCES Land(bezeichnung)
);

CREATE TABLE Bezahlung
(
    bezahlungsnr INT PRIMARY KEY,
    betrag NUMBER NOT NULL CHECK (betrag > 0),
    zahlungsdatum DATE NOT NULL,
    buchungsnr INT NOT NULL,
    CONSTRAINT bezahlung_fk FOREIGN KEY (buchungsnr) REFERENCES Buchung(buchungsnr)
);

COMMIT;