CREATE TABLE Land (
    bezeichnung VARCHAR(255) PRIMARY KEY
);

CREATE TABLE Adresse (
    adressNr INT PRIMARY KEY,
    hausNr INT NOT NULL,
    strasse VARCHAR(255) NOT NULL,
    ort VARCHAR(255) NOT NULL,
    postleihzahl VARCHAR(255) NOT NULL,
    landName VARCHAR(255) NOT NULL,
    CONSTRAINT adresse_land_fk FOREIGN KEY (landName) REFERENCES Land(bezeichnung)
);

CREATE TABLE Ferienwohnung (
    Fname VARCHAR(255) PRIMARY KEY,
    groesse DECIMAL(10, 2) NOT NULL CHECK (groesse > 0),
    anzahlZimmer INT NOT NULL,
    preisProTag DECIMAL(10, 2) NOT NULL,
    adresseNr INT NOT NULL,
    CONSTRAINT ferienwohnung_adresse_fk FOREIGN KEY (adresseNr) REFERENCES Adresse(adressNr) ON DELETE RESTRICT
);

CREATE TABLE Buchung (
    buchungsNr VARCHAR(255) PRIMARY KEY,
    buchungsdatum DATE,
    reisezeit DATE,
    storno DATE,
    anreise DATE,
    abreise DATE,
    sternAnz INT CHECK (sternAnz <= 5),
    ferienwohnung_name VARCHAR(255) NOT NULL,
    bewertungsdatum DATE,
    zahlungsArt VARCHAR(255),
    rechnungsdatum DATE,
    CONSTRAINT buchung_ferienwohnung_fk FOREIGN KEY (ferienwohnung_name) REFERENCES Ferienwohnung(Fname) ON DELETE RESTRICT
);

CREATE TABLE Bezahlung (
    bezahlNr INT PRIMARY KEY,
    betrag DOUBLE NOT NULL,
    datum DATE NOT NULL,
    buchungNR VARCHAR(255) NOT NULL,
    CONSTRAINT bezahlung_buchung_fk FOREIGN KEY (buchungNR) REFERENCES Buchung(buchungsNr) ON DELETE RESTRICT
);

CREATE TABLE Bilder (
    bildUrl VARCHAR(255) PRIMARY KEY,
    ferienwohnung_name VARCHAR(255) NOT NULL,
    CONSTRAINT bilder_ferienwohnung_fk FOREIGN KEY (ferienwohnung_name) REFERENCES Ferienwohnung(Fname)
);

CREATE TABLE Ausstattung (
    bezeichnung VARCHAR(255) PRIMARY KEY
);

CREATE TABLE WohnungBesitztAusstattung (
    ausstattung_bezeichnung VARCHAR(255) NOT NULL,
    ferienwohnung_name VARCHAR(255) NOT NULL,
    CONSTRAINT wohnung_ausstattung_fk FOREIGN KEY (ausstattung_bezeichnung) REFERENCES Ausstattung(bezeichnung) ON DELETE CASCADE,
    CONSTRAINT wohnung_ferienwohnung_fk FOREIGN KEY (ferienwohnung_name) REFERENCES Ferienwohnung(Fname) ON DELETE CASCADE
);

CREATE TABLE Touristenattraktion (
    bezeichnung VARCHAR(255) PRIMARY KEY,
    beschreibung VARCHAR(255)
);

CREATE TABLE FerienwohnungNaheTouristenattraktion (
    entfernung DOUBLE,
    ferienwohnung_name VARCHAR(255) NOT NULL,
    touristenattraktion_bezeichnung VARCHAR(255) NOT NULL,
    CONSTRAINT ferienwohnung_touristenattraktion_fk FOREIGN KEY (ferienwohnung_name) REFERENCES Ferienwohnung(Fname) ON DELETE RESTRICT,
    CONSTRAINT touristenattraktion_fk FOREIGN KEY (touristenattraktion_bezeichnung) REFERENCES Touristenattraktion(bezeichnung) ON DELETE CASCADE
);

CREATE TABLE Kunde (
    email VARCHAR(255) PRIMARY KEY,
    vorname VARCHAR(255) NOT NULL,
    nachname VARCHAR(255) NOT NULL,
    IBAN VARCHAR(255) NOT NULL,
    adresseNr INT NOT NULL,
    CONSTRAINT kunde_adresse_fk FOREIGN KEY (adresseNr) REFERENCES Adresse(adressNr) ON DELETE RESTRICT
);
