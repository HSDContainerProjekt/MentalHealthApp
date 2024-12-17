CREATE TABLE City (
    CityID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100)
);

CREATE TABLE EmergencyAmbulance (
    AmbulanceID INT PRIMARY KEY AUTO_INCREMENT,
    CityID INT,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(20),
    FOREIGN KEY (CityID) REFERENCES City(CityID)
);

CREATE TABLE University (
    UniversityID INT PRIMARY KEY AUTO_INCREMENT,
    CityID INT,
    Name VARCHAR(255),
    FOREIGN KEY (CityID) REFERENCES City(CityID)
);

CREATE TABLE PsychologicalCounselingService (
    CounselingServiceID INT PRIMARY KEY AUTO_INCREMENT,
    UniversityID INT,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(20),
    FOREIGN KEY (UniversityID) REFERENCES University(UniversityID)
);

-- Dummy-Daten
INSERT INTO City (Name) VALUES
('Berlin'),
('Hamburg'),
('München');

INSERT INTO EmergencyAmbulance (CityID, Address, PhoneNumber) VALUES
(1, 'Hauptstraße 1, 10115 Berlin', '+49 30 112'),
(2, 'Reeperbahn 1, 20359 Hamburg', '+49 40 112'),
(3, 'Karlsplatz 1, 80335 München', '+49 89 112');

INSERT INTO University (CityID, Name) VALUES
(1, 'Humboldt-Universität zu Berlin'),
(2, 'Universität Hamburg'),
(3, 'Ludwig-Maximilians-Universität München');

INSERT INTO PsychologicalCounselingService (UniversityID, Address, PhoneNumber) VALUES
(1, 'Unter den Linden 6, 10117 Berlin', '+49 30 2093 70270'),
(2, 'Von-Melle-Park 5, 20146 Hamburg', '+49 40 42838 9090'),
(3, 'Leopoldstraße 13, 80802 München', '+49 89 2180 9999');