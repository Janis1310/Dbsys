CREATE TABLE Ferienwohnung
(
    ferienwohnungsName INT,
    groesse NUMBER,
    anzahlZimmer INT,
    preisProTag NUMBER,
    adressnr INT,
    CONSTRAINT ferienwohnung_pk PRIMARY KEY (ferienwohnungsName)
);
CREATE TABLE Bilder
(
    url VARCHAR2(255) PRIMARY KEY,
    ferienwohnungsname VARCHAR2(255) NOT NULL,
    CONSTRAINT bilder_fk FOREIGN KEY (ferienwohnungsname) REFERENCES Ferienwohnung(ferienwohnungsname)
)
CREATE TABLE Ausstattung
(
    bezeichnung VARCHAR2(255) PRIMARY KEY
)
CREATE TABLE Besitzt
(
    ausstatungsbezeichnung VARCHAR2(255)PRIMARY KEY,
    ferienwohnungsname VARCHAR2(255) PRIMARY KEY,
    CONSTRAINT besitzt_fk FOREIGN KEY (ausstatungsbezeichnung) REFERENCES Ausstattung(bezeichnung),
    CONSTRAINT besitzt_fk FOREIGN KEY (ferienwohnungsname) REFERENCES Ferienwohnung(ferienwohnungsname)
)

CREATE TABLE Touristenattrakton
(
    bezeichnung VARCHAR2(255) PRIMARY KEY,
    beschreibung VARCHAR2(255)
)

CREATE TABLE Ferienwohnung_Touristenattraktion
(
    ferienwohnungsName VARCHAR2(255) PRIMARY KEY,
    touristenattraktionsBezeichnung VARCHAR2(255) PRIMARY KEY,
    entfernung NUMBER,
    CONSTRAINT ferienwohnung_touristen_fk1 FOREIGN KEY (ferienwohnungsName) REFERENCES Ferienwohnung(ferienwohnungsName),
    CONSTRAINT ferienwohnung_touristen_fk2 FOREIGN KEY (touristenattraktionsBezeichnung) REFERENCES Touristenattraktion(bezeichnung)
)

CREATE TABLE Buchung
(
    buchungsnr INT PRIMARY KEY,
    buchungsdatum DATE,
    storno DATE,
    abreise DATE,
    anreise DATE,
    sternanzahl INT,
    betrag NUMBER,
    email VARCHAR2(255),
    ferienwohnungsname VARCHAR2(255),
    bewertungsdatum DATE,
    zahlungsart VARCHAR2(255),
    rechnungsdatum DATE,
    CONSTRAINT buchung_fk1 FOREIGN KEY (ferienwohnungsname) REFERENCES Ferienwohnung(ferienwohnungsname),
    CONSTRAINT buchung_fk2 FOREIGN KEY (email) REFERENCES Kunde(email)
);

CREATE TABLE Kunde
(
    email VARCHAR2(255) PRIMARY KEY,
    vorname VARCHAR2(255),
    nachname VARCHAR2(255),
    IBAN VARCHAR2(255),
    passwort VARCHAR2(255),
    adressnr INT,
    CONSTRAINT kunde_fk FOREIGN KEY (adressnr) REFERENCES Adresse(adressnr)
);
CREATE TABLE Land 
(
    bezeichnung VARCHAR2(255) PRIMARY KEY
)
CREATE TABLE Adresse
(
    adressnr INT PRIMARY KEY,
    strasse VARCHAR2(255),
    hausnummer INT,
    plz INT,
    ort VARCHAR2(255),
    landbezeichnung VARCHAR2(255),
    CONSTRAINT adresse_fk FOREIGN KEY (landbezeichnung) REFERENCES Land(bezeichnung)
)

CREATE TABLE Bezahlung
(
    bezahlungsnr INT PRIMARY KEY,
    betrag NUMBER,
    zahlungsdatum DATE,
    buchungsnr INT
    CONSTRAINT bezahlung_fk FOREIGN KEY (buchungsnr) REFERENCES Buchung(buchungsnr)
)