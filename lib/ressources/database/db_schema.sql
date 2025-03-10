DROP TABLE IF EXISTS PsychologicalCounselingService;
DROP TABLE IF EXISTS EmergencyAmbulance;
DROP TABLE IF EXISTS University;
DROP TABLE IF EXISTS City;

CREATE TABLE Universities (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    counseling_link VARCHAR(512) NOT NULL
);

-- Dann die Daten einfügen
INSERT INTO Universities (name, city, counseling_link) VALUES
('Goethe Uni', 'Frankfurt', 'https://www.uni-frankfurt.de/120593878/Angebote_der_PBS?legacy_request=1'),
('Uni Mainz', 'Mainz', 'https://www.pbs.uni-mainz.de/'),
('Uni Trier', 'Trier', 'https://www.studiwerk.de/cms/psychosoziale_beratung-1001.html'),
('Uni Wuppertal', 'Wuppertal', 'https://www.zsb.uni-wuppertal.de/de/beratung/psychologische-beratung/'),
('Uni Siegen', 'Siegen', 'https://www.uni-siegen.de/zsb/psychologische/beratung.html?lang=de'),
('Uni Aachen', 'Aachen', 'https://www.rwth-aachen.de/cms/root/studium/beratung-hilfe/~sei/psychologische-beratung/'),
('Uni Bonn', 'Bonn', 'https://www.studierendenwerk-bonn.de/beratung-soziales/psychologische-beratungsstelle-pbs'),
('Uni Bielefeld', 'Bielefeld', 'https://www.uni-bielefeld.de/studium/studierende/information-studienberatung/studienberatungsangebote/gesundheitsfoerderung/psychosoziale-versorgung/'),
('Uni Paderborn', 'Paderborn', 'https://zsb.uni-paderborn.de/psychosoziale-beratung'),
('Uni Essen', 'Essen', 'https://www.stw-edu.de/beratung/psychologische-beratung/'),
('Uni Dortmund', 'Dortmund', 'https://www.tu-dortmund.de/psychologischeberatung/'),
('Hs Hamm Lippstadt', 'Hamm Lippstadt', 'https://www.hshl.de/studieren/wichtige-service-einrichtungen-und-beratungsangebote/zentrale-studienberatung/studienberatung-fuer-studierende/'),
('TH Köln', 'Köln', 'https://www.th-koeln.de/studium/beratung-bei-psycho-sozialen-problemen_64638.php'),
('Uni Köln', 'Köln', 'https://inklusion.uni-koeln.de/beratung/psychologische_beratung/index_ger.html'),
('Uni Hamburg', 'Hamburg', 'https://www.uni-hamburg.de/campuscenter/beratung/beratungsangebote/psychologische-beratung/beratungsprozess-bei-uns.html'),
('TU Hamburg', 'Hamburg', 'https://www.tuhh.de/tuhh/studium/im-studium/zentrale-studienberatung/beratung'),
('HSD', 'Düsseldorf', 'https://www.hs-duesseldorf.de/studium/beratung_und_kontakt/psb/einzel'),
('HHU', 'Düsseldorf', 'https://www.hhu.de/psychologischeberatung'),
('Uni Leipzig', 'Leipzig', 'https://www.studentenwerk-leipzig.de/beratung-soziales/psychosoziale-beratung/beratungsgespraech/'),
('Uni Dresden', 'Dresden', 'https://www.studentenwerk-dresden.de/soziales/psychosoziale-beratung.html');

-- Fortsetzung der Inserts (Teil 2)
INSERT INTO Universities (name, city, counseling_link) VALUES
('TU Darmstadt', 'Darmstadt', 'https://studierendenwerkdarmstadt.de/beratung-und-soziales/psychotherapeutische-beratungsstelle-2/'),
('Hochschule Darmstadt', 'Darmstadt', 'https://studierendenwerkdarmstadt.de/beratung-und-soziales/psychotherapeutische-beratungsstelle-2/'),
('Uni Gießen', 'Gießen', 'https://www.uni-giessen.de/de/fbz/zentren/zfbk/PBS/pbsstart'),
('Uni Kassel', 'Kassel', 'https://www.studierendenwerk-kassel.de/beratung/psychologische-beratung'),
('Uni Marburg', 'Marburg', 'https://www.uni-marburg.de/de/studium/service/mental-health/angebote-an-der-uni/pbs'),
('Hochschule Fulda', 'Fulda', 'https://www.hs-fulda.de/orientieren/umschauen/beraten-lassen/beratungsangebote/fuer-studierende/psychosoziale-beratung#c174859'),
('University of applied Science Frankfurt', 'Frankfurt', 'https://www.frankfurt-university.de/de/studium/beratungsangebote/zentrale-studienberatung-zsb/studierende/psychosozialberatung/'),
('Hochschule Rhein/Main', 'Wiesbaden', 'https://www.hs-rm.de/de/studium/information-und-beratung/sprechzeiten-der-psychologischen-beratung'),
('Uni Augsburg', 'Augsburg', 'https://www.uni-augsburg.de/de/studium/organisation-beratung/beratung/'),
('Uni Bamberg', 'Bamberg', 'https://www.uni-bamberg.de/studium/im-studium/beratungsangebote-der-universitaet/psychotherapeutische-beratung/');

-- Fortsetzung der Inserts (Teil 3)
INSERT INTO Universities (name, city, counseling_link) VALUES
('Uni Bayreuth', 'Bayreuth', 'https://www.studentenwerk-oberfranken.de/beratung-und-soziales/psychologische-beratung/bayreuth.html'),
('Tu Nürnberg', 'Nürnberg', 'https://www.th-nuernberg.de/beratung-services/beratungsstellen/psychologische-beratung/'),
('Hochschule für Philosophie', 'München', 'https://www.studierendenwerk-muenchen-oberbayern.de/beratungsnetzwerk/psychotherapeutische-und-psychosoziale-beratung/'),
('LMU München', 'München', 'https://www.studierendenwerk-muenchen-oberbayern.de/beratungsnetzwerk/psychotherapeutische-und-psychosoziale-beratung/'),
('TU München', 'München', 'https://www.tum.de/studium/hilfe-und-beratung/gesundheit/hilfe-bei-psychischen-belastungen'),
('Uni Passau', 'Passau', 'https://www.uni-passau.de/psychologische-beratung'),
('Uni Regensburg', 'Regensburg', 'https://www.uni-regensburg.de/studium/zentrale-studienberatung/beratung/psychologische-beratung/index.html'),
('Uni Würzburg', 'Würzburg', 'https://www.swerk-wue.de/wuerzburg/beratung/psychotherapeutische-beratung'),
('TH Aschaffenburg', 'Aschaffenburg', 'https://www.th-ab.de/studium/beratungsangebote/psychotherapeutische-betratung'),
('Universität Freiburg', 'Freiburg im Breisgau', 'https://www.swfr.de/soziales/psychotherapeutische-beratung');

-- Fortsetzung der Inserts (Teil 4)
INSERT INTO Universities (name, city, counseling_link) VALUES
('Universität Heidelberg', 'Heidelberg', 'https://www.stw.uni-heidelberg.de/de/pbs'),
('Universität Hohenheim', 'Stuttgart', 'https://www.my-stuwe.de/beratung-soziales/psychotherapeutische-beratung/'),
('Karlsruher Institut für Technologie (KIT)', 'Karlsruhe', 'https://www.kmb.kit.edu/65.php'),
('Universität Konstanz', 'Konstanz', 'https://seezeit.com/beratung/psychotherapeutische-beratung/'),
('Universität Mannheim', 'Mannheim', 'https://www.uni-mannheim.de/universitaet/anfahrt-und-campusplan/sicherheit-auf-dem-campus/informationen-und-ansprechpersonen/'),
('Universität Stuttgart', 'Stuttgart', 'https://www.student.uni-stuttgart.de/uni-a-bis-z/Psychologische-Beratung/'),
('Universität Tübingen', 'Tübingen', 'https://www.my-stuwe.de/beratung-soziales/psychotherapeutische-beratung/'),
('Universität Ulm', 'Ulm', 'https://studierendenwerk-ulm.de/beratung-betreuung/psychosoziale-beratung/'),
('Pädagogische Hochschule Freiburg', 'Freiburg im Breisgau', 'https://www.swfr.de/soziales/psychotherapeutische-beratung'),
('Pädagogische Hochschule Heidelberg', 'Heidelberg', 'https://www.ph-heidelberg.de/studium/im-studium/beratung/psychosoziale-und-paedagogische-beratung/');

-- Fortsetzung der Inserts (Teil 5 - Final)
INSERT INTO Universities (name, city, counseling_link) VALUES
('Freie Universität Berlin', 'Berlin', 'https://www.fu-berlin.de/sites/studienberatung/psychologische_beratung/index.html'),
('Humboldt Uni', 'Berlin', 'https://www.stw.berlin/beratung/psychologische-beratung/'),
('TU Berlin', 'Berlin', 'https://www.tu.berlin/studienberatung/im-studium/psychologische-beratung');
INSERT INTO Universities (name, city, counseling_link) VALUES
('Pädagogische Hochschule Karlsruhe', 'Karlsruhe', 'https://www.sw-ka.de/de/beratung/psychologisch/'),
('Pädagogische Hochschule Ludwigsburg', 'Ludwigsburg', 'https://www.eh-ludwigsburg.de/studium/rat-und-hilfe/psychologische-beratung-fuer-studierende'),
('Pädagogische Hochschule Schwäbisch Gmünd', 'Schwäbisch Gmünd', 'https://www.ph-gmuend.de/hochschule/verwaltung-serviceeinrichtungen/studierendenwerk/psychosoziale-beratung'),
('Pädagogische Hochschule Weingarten', 'Weingarten', 'https://www.rwu.de/intern/beratung-hilfe#tab-6901'),
('Hochschule für Musik Freiburg', 'Freiburg im Breisgau', 'https://www.swfr.de/soziales/psychotherapeutische-beratung'),
('Hochschule für Musik Karlsruhe', 'Karlsruhe', 'https://www.sw-ka.de/de/beratung/psychologisch/'),
('Hochschule Heilbronn', 'Heilbronn', 'https://www.hs-heilbronn.de/de/psychosoziale-beratung'),
('Hochschule Mannheim', 'Mannheim', 'https://www.hs-mannheim.de/die-hochschule/organisation-und-gremien/zusammen-am-campus/sozialberatung.html'),
('Hochschule für Technik Stuttgart', 'Stuttgart', 'https://www.studierendenwerk-stuttgart.de/beratung/psychotherapeutische-beratung'),
('Hochschule Ulm', 'Ulm', 'https://studierendenwerk-ulm.de/beratung-betreuung/psychosoziale-beratung/'),
('Hochschule für Gestaltung Schwäbisch Gmünd', 'Schwäbisch Gmünd', 'https://www.ph-gmuend.de/hochschule/verwaltung-serviceeinrichtungen/studierendenwerk/psychosoziale-beratung'),
('Technische Universität Chemnitz', 'Chemnitz', 'https://www.tu-chemnitz.de/hsw/psychologie/professuren/klinpsy/BFC/'),
('Technische Universität Bergakademie Freiberg', 'Freiberg', 'https://www.studentenwerk-freiberg.de/freiberg/beratung/psychosoziale-beratung/de/'),
('Hochschule für Musik und Theater Leipzig', 'Leipzig', 'https://www.hmt-leipzig.de/home/mein-studium/psychologische-beratung'),
('Hochschule für Grafik und Buchkunst Leipzig', 'Leipzig', 'https://www.hmt-leipzig.de/home/mein-studium/psychologische-beratung'),
('Hochschule für Musik Carl Maria von Weber Dresden', 'Dresden', 'https://www.studentenwerk-dresden.de/soziales/psychosoziale-beratung.html'),
('Hochschule für Bildende Künste Dresden', 'Dresden', 'https://www.studentenwerk-dresden.de/soziales/psychosoziale-beratung.html'),
('Hochschule für Technik, Wirtschaft und Kultur Leipzig', 'Leipzig', 'https://stura.htwk-leipzig.de/beratung/studentenwerk-leipzig/psychosoziale-beratung'),
('Hochschule für Technik und Wirtschaft Dresden', 'Dresden', 'https://www.studentenwerk-dresden.de/soziales/psychosoziale-beratung.html'),
('Hochschule Mittweida', 'Mittweida', 'https://blog.hs-mittweida.de/2019/08/beratung-bei-psychischen-und-sozialen-problemen/'),
('Westsächsische Hochschule Zwickau', 'Zwickau', 'https://www.fh-zwickau.de/studium/studierende/beratungsangebot/'),
('Hochschule Zittau/Görlitz', 'Zittau, Görlitz', 'https://www.hszg.de/studium/campusleben/beratungsangebote'),
('Martin-Luther-Universität Halle-Wittenberg', 'Halle (Saale), Wittenberg', 'https://studentenwerk-halle.de/beratung-soziales/psychosoziale-beratung/beratungsangebote'),
('Otto-von-Guericke-Universität Magdeburg', 'Magdeburg', 'https://www.studentenwerk-magdeburg.de/soziales/psychosoziale-beratung/'),
('Hochschule Anhalt', 'Bernburg, Dessau, Köthen', 'https://www.hs-anhalt.de/studieren/service-und-beratung/psychologische-beratung.html'),
('Hochschule Harz', 'Wernigerode, Halberstadt', 'https://www.hs-harz.de/studium/studierendenservice/organisation/rechts-und-psychologische-beratung');