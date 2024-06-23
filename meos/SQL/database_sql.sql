-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Gegenereerd op: 15 sep 2021 om 12:41
-- Serverversie: 5.7.33
-- PHP-versie: 7.4.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `meosshop_pepemeos`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `laws`
--

CREATE TABLE `laws` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `fine` int(11) NOT NULL DEFAULT '0',
  `months` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `laws`
--

INSERT INTO `laws` (`id`, `name`, `description`, `fine`, `months`) VALUES
(27, 'R602 - Het negeren van een roodverkeerlicht', 'Niet stoppen bij rood verkeerslicht, ', 350, 0),
(28, 'R628b - Niet opvolgen stopteken wout', 'Het negeren stop teken, Bij verkeers controle en bij vordering ', 1000, 0),
(29, 'D505 - Baldadigheid', 'Op de openbare weg of op een voor publiek toegankelijke plaats tegen goederen of personen baldadigheid plegen\r\nstraatschenderij; waaruit bleek dit; feitelijke baldadigheid beschrijven.', 830, 0),
(30, 'F116a - Inbrekerswerktuig', 'Het is verboden op de weg of in de nabijheid van winkels te vervoeren of bij zich te hebben een voorwerp dat er kennelijk toe is uitgerust om het plegen van (winkel)diefstal te vergemakkelijken', 500, 0),
(31, 'D517 - Identiteitsbewijs', 'Niet voldoen aan de verplichting om een identiteitsbewijs ter inzage aan te bieden feiten en omstandigheden vermelden waarom vordering redelijkerwijze noodzakelijk werd geacht.', 750, 0),
(32, 'Administratiekosten', 'Administratiekosten die wettelijk zijn berekend. die bij elke boete bij geteld word', 12, 0),
(34, 'K150c - Niet op eerste vordering behoorlijk het rijbewijs ter inzage afgeven', 'Niet op eerste vordering behoorlijk het rijbewijs ter inzage afgeven', 750, 0),
(35, 'Artikel 266sr - Belediging ambtenaar in functie', 'Belediging van Ambtenaar in Functie', 4350, 3),
(36, '2e categorie', 'Boete van 2e categorie', 4350, 0),
(37, '1e categorie', 'Boete van 1e categorie', 435, 0),
(38, '3e categorie', 'Boete van de 3e categorie', 8700, 0),
(39, '4e categorie', 'Boete van 4e categorie', 14500, 0),
(40, '5e categorie', 'Boete van 5e Categorie', 20000, 0),
(41, '6e categorie', 'Boete van 6e categorie  - Alleen in overleg geven met korpsleiding', 30000, 0),
(43, 'VA 005 - Snelheidsoverschrijding 5 km/h', 'Overschrijding van maximum snelheid', 187, 0),
(44, 'VA 010 - Snelheidsoverschrijding 10 km/h', 'Overschrijding van maximum snelheid', 210, 0),
(46, 'VA 015 - Snelheidsoverschrijding 15/20 km/h', 'Overschrijding van maximum snelheid', 310, 0),
(47, 'VA 025 - Snelheidsoverschrijding 25/30 km/h', 'Overschrijding van maximum snelheid', 400, 0),
(48, 'VA 040 - Snelheidsoverschrijding 30/40 km/h', 'Overschrijding van maximum snelheid', 675, 0),
(49, 'VA 050 - Snelheidsoverschrijding 50 km/h', 'Overschrijding van maximum snelheid', 1000, 0),
(50, 'VA 060 - Snelheidsoverschrijding 60/70 km/h', 'Overschrijding van maximum snelheid', 1150, 0),
(51, 'VA 080 - Snelheidsoverschrijding 70 /90 km/h', 'Overschrijding van maximum snelheid', 1700, 0),
(52, 'VA 100 - Snelheidsoverschrijding 100 km/h', 'Overschrijding van maximum snelheid', 2500, 0),
(53, 'Artikel 5 - Wegenverkeerswet', 'Het is een ieder verboden zich zodanig te gedragen dat gevaar op de weg wordt veroorzaakt of kan worden veroorzaakt of dat het verkeer op de weg wordt gehinderd of kan worden gehinderd. 3 maanden voorwaardelijk', 4500, 0),
(55, 'Artikel 184 - Niet voldoen aan een bevel of vordering', 'Hij die opzettelijk niet voldoet aan een bevel of een vordering, krachtens wettelijk voorschrift gedaan door een ambtenaar met de uitoefening van enig toezicht belast of door een ambtenaar belast met of bevoegd verklaard tot het opsporen of onderzoeken van strafbare feiten, alsmede hij die opzettelijk enige handeling, door een van die ambtenaren ondernomen ter uitvoering van enig wettelijk voorschrift, belet, belemmert of verijdelt.', 4350, 5),
(57, 'Artikel 426ter - Belemmeren hulpverlener', 'Hij die wederrechtelijk een hulpverlener gedurende de uitoefening van zijn beroep in zijn vrijheid van beweging belemmert of met een of meer anderen zich aan hem tegen zijn uitdrukkelijk verklaarde wil blijft opdringen of hem op hinderlijke wijze blijft volgen wordt gestraft met hechtenis van ten hoogste drie maanden of geldboete van de derde categorie.', 8700, 18),
(58, 'Artikel 196 - Onrechtmatig voordoen als wout ambt.', 'Hij die in het openbaar kledingstukken of opzichtige onderscheidingstekens draagt of voert, welke uitdrukking zijn van een bepaald staatkundig streven, wordt gestraft met hechtenis van ten hoogste twaalf dagen of geldboete van de tweede categorie.', 4500, 15),
(59, 'Artikel 142 - Misbruik noodnummer', 'Valse meldingen maken - onnodig gebruik maken van 112 nummer', 7500, 10),
(60, 'Artikel 48 - Medeplichtigen mishandeling', 'Vechten, na aangifte kan straf gegeven worden', 1250, 5),
(61, 'Artikel 26 - WWM CAT. II&III', 'Vuur handwapens & Munitie', 5000, 12),
(62, 'Artikel 27 - WWM Semi,full automatische ', 'Semi wapens en full automatisch wapens.', 10000, 40),
(63, 'Artikel 13 - WWM cat I', 'Steekwapens en slagwapens (Vrijwillig afstaan geen celstraf van 10 maand)', 2275, 0),
(64, 'Artikel 461 - Verboden toegang', 'Zonder daartoe gerechtigd te zijn zich bevinden op eens anders grond, waarvan de toegang op blijkbare wijze was\r\nverboden op welke blijkbare wijze was de toegang verboden; waar bevond verdachte zich; niet op kenteken.\r\n', 2500, 5),
(65, 'Artikel 310 - Eenvoudige diefstal', 'Het ontnemen van goederen uit bijvoorbeeld, Huis,winkel,persoon (bij nacht is huis art.311)', 1750, 15),
(66, 'Artikel 311 - Gekwalificeerde diefstal', 'diefstal gedurende de voor de nachtrust bestemde tijd, in een woning of op een besloten erf waarop een woning staat, door iemand die zich aldaar buiten weten of tegen de wil van de rechthebbende bevindt;\r\ndiefstal door twee of meer verenigde personen;\r\ndiefstal waarbij de schuldige zich de toegang tot de plaats van het misdrijf heeft verschaft of het weg te nemen goed onder zijn bereik heeft gebracht door middel van braak, verbreking of inklimming, van valse sleutels, van een valse order of een vals kostuum;', 2500, 20),
(67, 'Artikel 312 - Diefstal met geweld', 'Winkel & Huisinbraak', 4000, 30),
(68, 'Artikel 255 - Verlating van hulpbehoevenden', 'Hij die opzettelijk iemand tot wiens onderhoud, verpleging of verzorging hij krachtens wet of overeenkomst verplicht is, in een hulpeloze toestand brengt of laat, wordt gestraft met gevangenisstraf van ten hoogste twee jaren of geldboete van de vierde categorie.', 4350, 48),
(71, 'Artikel 177 - Omkoping', 'Hij die een ambtenaar een gift of belofte doet dan wel een dienst verleent of aanbiedt met het oogmerk om hem te bewegen in zijn bediening, in strijd met zijn plicht, iets te doen of na te laten;\r\n2hij die een ambtenaar een gift of belofte doet dan wel een dienst verleent of aanbiedt ten gevolge of naar aanleiding van hetgeen door deze in zijn huidige of vroegere bediening, in strijd met zijn plicht, is gedaan of nagelaten.', 10000, 20),
(72, 'Artikel 282 - Gijzeling/ontvoeren', 'Hij die opzettelijk iemand wederrechtelijk van de vrijheid berooft of beroofd houdt,\r\n\r\n', 4350, 25),
(73, 'Artikel 302 - Zware mishandeling', 'Hij die aan een ander opzettelijk zwaar lichamelijk letsel toebrengt maar waardoor persoon nog wel zelfstandig na ziekenhuis kan.\r\nZoals aanrijden,of steek/slagwapen,nekslag', 6000, 25),
(74, 'Artikel 48 - Medeplichtigen Moord', 'Hij die opzettelijk een ander van het leven berooft, wordt, als schuldig aan doodslag', 11000, 40),
(75, 'Artikel 287 - Doodslag/Moord', 'Hij die opzettelijk een ander van het leven berooft, wordt, als schuldig aan doodslag', 21750, 60),
(76, 'Artikel 289 - Moord voorbedachten rade', 'Hij die opzettelijk en met voorbedachten rade een ander van het leven berooft,\r\n(Doel bewust iemand vermoorden)', 30000, 80),
(78, 'R315b - Foutief parkeren', 'Als bestuurder een voertuig parkeren op een andere plaats dan daarvoor bestemd is. ', 780, 0),
(80, 'Artikel 11 Opw - SOFT DRUGS (Vanaf 6 tot 10)', 'Op zak hebben van hard drugs zoals (Wiet, Joint)', 2000, 10),
(81, 'Artikel 11 Opw - SOFT DRUGS (Vanaf 11 tot 20)', 'Op zak hebben van hard drugs zoals (Wiet, Joint)', 4000, 30),
(82, 'Artikel 11 Opw -SOFT DRUGS (Vanaf 20+)', 'Op zak hebben van hard drugs zoals (Wiet, Joint)', 6500, 35),
(83, 'Artikel 11 Opw - Softdrugs Bricks', 'Verhandelen van wiet bricks', 1500, 15),
(84, 'Artikel 10 Opw -HARD DRUGS (Vanaf 2 tot 10)', 'Op zak hebben van hard drugs zoals (Oxy,Coke, Meth)', 3000, 35),
(85, 'Artikel 10 Opw - HARD DRUGS (Vanaf 11 tot 20)', 'Op zak hebben van hard drugs zoals (Oxy,Coke, Meth)', 6000, 40),
(86, 'Artikel 10 Opw - Hard drugs (Vanaf 20+)', 'Op zak hebben van hard drugs zoals (Oxy,Coke, Meth)', 10000, 60),
(89, 'Artikel 447e - Niet meewerken identificatieplicht', 'Niet meewerken aan identificatieplicht, zoals vingerafdrukken,dna,bloed,NAW gegevens,foto', 5000, 12),
(91, 'Art. 180 Verzet van arrestatie', 'Het verzetten bij een arrestatie. in cellencomplex/ziekenhuis', 1500, 0),
(94, 'Eenvoudige mishandeling', 'Vechten, na aangifte kan straf gegeven worden', 2500, 5),
(95, 'Verstoring openbare orde ', 'duwen, trekken, schelden,vechten,samenscholing etc.', 3200, 5),
(97, 'Art.317 - Afpersing en afdreiging', 'Hij die, met het oogmerk door geweld of bedreiging met geweld iemand dwingt hetzij tot de afgifte van enig goederen dat geheel of ten dele aan deze of aan een derde toebehoort, hetzij tot het aangaan van een schuld of het teniet doen van een inschuld, hetzij tot het ter beschikking stellen van gegevens, wordt, als schuldig aan afpersing', 8700, 30),
(98, 'Artikel 188 - Valse aangifte', 'Hij die aangifte of klacht doet dat een strafbaar feit gepleegd is, wetende dat het niet gepleegd is, wordt gestraft met gevangenisstraf van ten hoogste een jaar of geldboete van de derde categorie. ', 4005, 24),
(99, 'Artikel 307 - Dood door schuld', 'Bij roekeloos rijden waar een slachtoffer is gevallen, ', 8700, 48),
(100, 'Artikel 138 - Huisvredebreuk', 'Hij die in de woning of het besloten lokaal of erf, bij een ander in gebruik, wederrechtelijk binnendringt of, wederrechtelijk aldaar vertoevende, zich niet op de vordering van of vanwege de rechthebbende aanstonds verwijdert.\r\n\r\nHij die zich de toegang heeft verschaft door middel van braak of inklimming, van valse sleutels, van een valse order of een vals kostuum, of die, zonder voorkennis van de rechthebbende en anders dan ten gevolge van vergissing binnengekomen, aldaar wordt aangetroffen in de voor de nachtrust bestemde tijd, wordt geacht te zijn binnengedrongen.', 4900, 24),
(103, 'Artikel 1 - Gezichtsbedekkende kleding', 'In openbaar masker dragen, en na eerste vordering niet afdoen.', 750, 0),
(104, 'Artikel 350 - Vernieling', 'Hij die opzettelijk en wederrechtelijk enig goed dat geheel of ten dele aan een ander toebehoort, vernielt, beschadigt, onbruikbaar maakt of wegmaakt, wordt gestraft met gevangenisstraf van ten hoogste twee jaren of geldboete van de derde categorie.', 2500, 5),
(105, 'Artikel 285 - Bedreiging', 'met enig misdrijf tegen het leven gericht,bepaalde uitingen zoals ik maak je kapot,of ik smijt je van de berg', 5000, 15),
(108, 'Heterdaad grinden.', 'Zei die heterdaad gepakt zijn op het grinden van materialen en/of geld ontvangen deze boete.', 2000, 10),
(109, 'Heterdaad janken', 'Hij/zij die heterdaad gepakt zijn of alleen maar zoutig zijn kunnen deze boete ontvangen voor hun gedrag.', 3500, 10),
(110, 'R426a - Rijden zonder verlichting', 'als bestuurder van een motorvoertuig, bromfietser, snorfietser of als bestuurder van een gehandicaptenvoertuig rijden terwijl niet gelijktijdig met het groot licht, het dimlicht, het stadslicht of het mistlicht, het achterlicht brandt bij nacht, binnen de bebouwde kom.', 600, 0),
(112, 'Terroristische bommelding', 'Deze straf kan gegeven worden, voor Heterdaad betrappen van plaatsen van Bommen in onder andere autos, etc etc, tevens ook voor het dragen voor bomgordel, explosieven. Meer info volgt.', 30000, 120),
(115, 'Artikel 6 Schuldig aan verkeersongeluk', 'Het is een ieder die aan het verkeer deelneemt verboden zich zodanig te gedragen dat een aan zijn schuld te wijten verkeersongeval plaatsvindt waardoor een ander wordt gedood of waardoor een ander zwaar lichamelijk letsel wordt toegebracht of zodanig lichamelijk letsel dat daaruit tijdelijke ziekte of verhindering in de uitoefening van de normale bezigheden ontstaat.', 3000, 20),
(116, 'Artikel 7 Plaatsdelict verlaten', 'Het is degene die bij een verkeersongeval is betrokken of door wiens gedraging een verkeersongeval is veroorzaakt, verboden de plaats van het ongeval te verlaten.', 5000, 15),
(117, 'Artikel 8 Rijden onder invloed', 'Het is een ieder verboden een voertuig te besturen, als bestuurder te doen besturen of als begeleider op te treden, terwijl hij verkeert onder zodanige invloed van een stof, waarvan hij weet of redelijkerwijs moet weten, dat het gebruik daarvan - al dan niet in combinatie met het gebruik van een andere stof - de rijvaardigheid kan verminderen, dat hij niet tot behoorlijk besturen of tot behoorlijk te begeleiden in staat moet worden geacht', 4500, 15),
(119, 'Artikel 36 Geen kenteken hebben.', 'kentekenplichtig voertuig van persoon heeft geen kenteken.', 2000, 0),
(121, 'Artikel 140 Deelneming criminele oragnisatie', 'Deelneming aan een organisatie die tot oogmerk heeft het plegen van misdrijven, wordt gestraft met gevangenisstraf van ten hoogste zes jaren of geldboete van de vijfde categorie.', 4500, 10),
(122, 'Artikel 149 Grafsteen opzettelijk vernielen', 'Hij die opzettelijk een graf schendt of enig op een begraafplaats opgericht gedenkteken opzettelijk en wederrechtelijk vernielt of beschadigt, wordt gestraft met gevangenisstraf van ten hoogste een jaar of geldboete van de derde categorie.', 1500, 0),
(124, 'Artikel 157 Brandstichting', 'Hij die opzettelijk brand sticht of een ontploffing teweegbrengt word gestraft met 15 maanden en een geld boete van 4500', 4500, 15),
(125, 'Artikel 168 Voertuig onbruikbaar maken', 'Hij die enig vaartuig, voertuig of luchtvaartuig opzettelijk en wederrechtelijk doet zinken, stranden of verongelukken, vernielt, onbruikbaar maakt of beschadigt.', 6500, 0),
(129, 'Artikel 420 - Witwassen', 'Witwassen dat enkel bestaat uit het verwerven of voorhanden hebben van een voorwerp dat onmiddellijk afkomstig is uit enig eigen misdrijf wordt als eenvoudig witwassen.', 4000, 0),
(131, 'Artikel 426 Openbaar dronkenschap', 'Dronken op openbare weg, hinder veroorzaken  (7 maand in cel HB)', 3500, 7),
(133, 'Artikel 5.2.65 Neonlicht voeren', 'Personenauto\'s met meer licht dan toegestaan. (Neon onder de auto, andere kleur koplampen)', 1500, 0),
(134, 'F120a - Klimmen en klauteren', 'Klimmen of zich bevinden op een beeld, monument, overkapping, constructie, openbare toiletgelegenheid, voertuig, hek, heining of andere afsluiting, verkeersmeubilair of daarvoor niet bestemd straatmeubilair waarop?', 95, 3),
(135, 'R395 - Gevaar of hinder veroorzaken met stilstaand voertuig', 'Een voertuig op een zodanige wijze laten staan waardoor op de weg gevaar wordt/kan worden veroorzaakt, dan wel het verkeer wordt/kan worden gehinderd gevaar; situatie omschrijven; cat. 4 uitsluitend gehandicaptenvoertuig\\r\\nmet motor.', 1250, 0),
(136, 'Afsleepkosten ', 'Als je een auto moet laten wegslepen.', 500, 0),
(137, 'Artikel 367 - Helpen bij ontsnapping', 'bevrijding of zelfbevrijding aan zijn schuld te wijten is, wordt hij gestraft met hechtenis.', 4350, 20),
(139, 'F173a - Handelen in verdovende middelen', 'Zich op een openbare plaats ophouden met het kennelijke doel om middelen als bedoeld in artikel 2 en 3 van de Opiumwet of daarop gelijkende waar, al dan niet tegen betaling af te leveren, aan te bieden of te verwerven, daarbij behulpzaam te zijn of daarin te bemiddelen waaruit kon worden aangenomen dat werd gehandeld.', 4150, 24),
(140, 'Artikel 216 - Heling', 'Hij die een goed verwerft, voorhanden heeft of overdraagt, dan wel een persoonlijk recht op of een zakelijk recht ten aanzien van een goed vestigt of overdraagt, terwijl hij ten tijde van de verwerving of het voorhanden krijgen van het goed dan wel het vestigen van het recht wist dat het een door misdrijf verkregen goed betrof.', 4150, 20),
(142, 'K055 - Rijden zonder geldig rijbewijs', 'artikel 107, lid 1 en feitcode K055\\r\\nRijden zonder rijbewijs. Wanneer men een motorvoertuig bestuurt zonder rijbewijs is men in overtreding', 3500, 0),
(144, 'D515 - Valse identiteit opgeven', 'opgeven van een valse naam, voornaam, geboortedatum, geboorteplaats, adres of woon- of verblijfplaats', 3900, 5),
(145, 'F121b - Op openbare weg met aangebroken fles/blik alcohol', 'aangebroken flessen, blikjes e.d. met alcoholhoudende drank bij zich hebben op een openbare plaats in aangew. geb.', 95, 0),
(147, 'H205 - Overlast veroorzaken voor omgeving d.m.v. toestellen of geluidsapparatuur', 'Veroorzaken van geluidhinder voor een omwonende of de omgeving door/met toe- stellen/(geluids)apparaten/handelingen', 1250, 0),
(148, 'F250 - Met een voertuig rijden door park / plantsoen', 'zonder ontheffing rijden/bevinden met vo ertuig/paard in publiektoegankelijk park natuurgebied/plantsoen/recreatieterrein', 1400, 0),
(150, 'CITES - Koraal 1 t/m 10 stuks', 'Het in bezit zijn van \"Vochtig\" Koraal is strafbaar en vastgesteld door de instantie CITES. De hoogte van de boete hangt af van de hoeveelheid. Met Vochtig koraal wordt bedoelt koraal dat nog leeft en dus uit zijn leefomgeving is gehaald', 800, 0),
(151, 'CITES - Koraal 11 t/m 25 stuks', 'Het in bezit zijn van \"Vochtig\" Koraal is strafbaar en vastgesteld door de instantie CITES. De hoogte van de boete hangt af van de hoeveelheid. Met Vochtig koraal wordt bedoelt koraal dat nog leeft en dus uit zijn leefomgeving is gehaald.', 1400, 0),
(152, 'CITES - Koraal 26 t/m 50 stuks', 'Het in bezit zijn van \"Vochtig\" Koraal is strafbaar en vastgesteld door de instantie CITES. De hoogte van de boete hangt af van de hoeveelheid. Met Vochtig koraal wordt bedoelt koraal dat nog leeft en dus uit zijn leefomgeving is gehaald.', 2000, 0),
(153, 'CITES - Koraal 51 t/m 75 stuks', 'Het in bezit zijn van \"Vochtig\" Koraal is strafbaar en vastgesteld door de instantie CITES. De hoogte van de boete hangt af van de hoeveelheid. Met Vochtig koraal wordt bedoelt koraal dat nog leeft en dus uit zijn leefomgeving is gehaald.', 3000, 0),
(154, 'CITES - Koraal 76 t/m 100 stuks', 'Het in bezit zijn van \"Vochtig\" Koraal is strafbaar en vastgesteld door de instantie CITES. De hoogte van de boete hangt af van de hoeveelheid. Met Vochtig koraal wordt bedoelt koraal dat nog leeft en dus uit zijn leefomgeving is gehaald.', 4500, 0),
(155, 'CITES - Koraal 101 t/m 125 stuks', 'Het in bezit zijn van \"Vochtig\" Koraal is strafbaar en vastgesteld door de instantie CITES. De hoogte van de boete hangt af van de hoeveelheid. Met Vochtig koraal wordt bedoelt koraal dat nog leeft en dus uit zijn leefomgeving is gehaald.', 6000, 0),
(156, 'CITES - Koraal 125+', 'Het in bezit zijn van \"Vochtig\" Koraal is strafbaar en vastgesteld door de instantie CITES. De hoogte van de boete hangt af van de hoeveelheid. Met Vochtig koraal wordt bedoelt koraal dat nog leeft en dus uit zijn leefomgeving is gehaald.', 8000, 10),
(157, 'R551a - Eenrichtingsweg overige wegen', 'Handelen in strijd met geslotenverklaring, als bestuurder van een motorvoertuig, bromfiets of snorfiets op autoweg of autosnelweg (spookrijden)', 1400, 0),
(159, 'Artikel 11- WVW Niet APK waardig', 'Niet APK waardig voertuig, Het is verboden opzettelijk wederrechtelijk een aan een ander toebehorend motorrijtuig op de weg te gebruiken.', 1000, 0),
(163, 'Artikel 312 - Kleine bank + Juwelier', 'Diefstal met geweld bij Kleine bank en Juwelier', 8000, 30),
(165, 'Artikel 312 - Pacific Bank', 'Diefstal met geweldpleging bij grote bank', 15000, 50),
(168, 'H107 - Voertuigwrak op de weg laten staan', 'een voertuigwrak parkeren op de weg', 750, 0),
(169, 'Artikel 48 - Medeplichtigen Zware mishandeling', 'Hij die medeplicht is  aan een ander opzettelijk zwaar lichamelijk letsel toebrengt maar waardoor persoon nog wel zelfstandig na ziekenhuis kan.\r\nZoals aanrijden,of steek/slagwapen,nekslag', 3500, 15),
(170, 'Artikel 48 - Medeplichtigen Afpersing en afdreiging', 'Hij die mee doet aan, met het oogmerk om zich of een ander wederrechtelijk te bevoordelen, door geweld of bedreiging met geweld iemand dwingt hetzij tot de afgifte van enig goed dat geheel of ten dele aan deze of aan een derde toebehoort, hetzij tot het aangaan van een schuld of het teniet doen van een inschuld, hetzij tot het ter beschikking stellen van gegevens, wordt, als schuldig aan afpersing.', 4300, 15),
(171, 'Artikel 48 - Medeplichtig Gezijzeling/ontvoering', 'Hij die mede opzettelijk iemand wederrechtelijk van de vrijheid berooft of beroofd houdt.', 2100, 12),
(173, 'Artikel 288 - Poging tot doodslag/moord', 'Iemand proberen van het leven te beroven, maar mislukt ', 11000, 30),
(175, 'Artikel 48 - Medeplichtig Tot poging doodslag/moord', 'Iemand proberen van het leven te beroven, maar mislukt ', 6000, 15),
(176, 'Artikel 48 - Medeplichting Moord voorbedachten rade', 'Hij die medeplichtig is aan opzettelijk en met voorbedachten rade een ander van het leven berooft,\r\n(Doel bewust iemand vermoorden)', 15000, 55),
(177, 'Artikel 161ter - (Koperdiefstal)', 'Titel VII. Misdrijven waardoor de algemene veiligheid van personen of goederen wordt in gevaar gebracht\r\nArtikel 161ter\r\nHij aan wiens schuld te wijten is, dat enig elektriciteitswerk wordt vernield, beschadigd, of onbruikbaar gemaakt, dat stoornis in de gang of in de werking van zodanig werk ontstaat, of dat een ten opzichte van zodanig werk genomen veiligheidsmaatregel wordt verijdeld', 1500, 12);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `profiles`
--

CREATE TABLE `profiles` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(255) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT 'https://i.imgur.com/tdi3NGa.png',
  `fingerprint` varchar(255) DEFAULT NULL,
  `dnacode` varchar(255) DEFAULT NULL,
  `note` text,
  `lastsearch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `reports`
--

CREATE TABLE `reports` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `profileid` int(11) DEFAULT NULL,
  `report` text NOT NULL,
  `laws` text,
  `created` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `job` varchar(255) NOT NULL DEFAULT 'police',
  `role` varchar(255) NOT NULL,
  `rank` varchar(255) NOT NULL,
  `last_login` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `name`, `job`, `role`, `rank`, `last_login`) VALUES
(270, 'admin', '$2y$10$5srD2iAIGB8eue1gHUVbHOVRKWT4lMN/dKKqWoiCO/bcg24AbJQCW', 'Admin', 'police', 'user', 'Hoofdinspecteur', '2021-09-15');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `vehicles`
--

CREATE TABLE `vehicles` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(255) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `plate` varchar(255) NOT NULL,
  `typevehicle` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT 'https://i.imgur.com/tdi3NGa.png',
  `note` text,
  `lastsearch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `warrants`
--

CREATE TABLE `warrants` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `laws`
--
ALTER TABLE `laws`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexen voor tabel `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `warrants`
--
ALTER TABLE `warrants`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `laws`
--
ALTER TABLE `laws`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=178;

--
-- AUTO_INCREMENT voor een tabel `profiles`
--
ALTER TABLE `profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=271;

--
-- AUTO_INCREMENT voor een tabel `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT voor een tabel `warrants`
--
ALTER TABLE `warrants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=175;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
