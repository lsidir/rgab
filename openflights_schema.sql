CREATE TABLE AIRPORTS (
		AirportID  INTEGER      NOT NULL, -- Unique OpenFlights identifier for this airport.
		Name       CHAR(120)    NOT NULL, -- Name of airport. May or may not contain the City name.
		City       CHAR(80)     NOT NULL, -- Main city served by airport. May be spelled differently from Name.
		Country    CHAR(80)     NOT NULL, -- Country or territory where airport is located. See countries.dat to cross-reference to ISO 3166-1 codes.
		IATA       CHAR(3),               -- 3-letter IATA code. Null if not assigned/unknown.
		ICAO       CHAR(4),               -- 4-letter ICAO code. Null if not assigned.
		Latitude   DECIMAL(21,18) NOT NULL, -- Decimal degrees, usually to six significant digits. Negative is South, positive is North.
		Longitude  DECIMAL(21,18) NOT NULL, -- Decimal degrees, usually to six significant digits. Negative is West, positive is East.
		Altitude   INTEGER      NOT NULL, -- In feet.
		Timezone   DECIMAL(4,2),          -- Hours offset from UTC. Fractional hours are expressed as decimals, eg. India is 5.5.
		DST        CHAR(1),               -- Daylight savings time. One of E (Europe), A (US/Canada), S (South America), O (Australia), Z (New Zealand), N (None) or U (Unknown).
		Tz         CHAR(120),             -- Timezone in "tz" (Olson) format, eg. "America/Los_Angeles".
		Type       CHAR(8)      NOT NULL, -- Type of the airport. Value "airport" for air terminals, "station" for train stations, "port" for ferry terminals and "unknown" if not known. In airports.csv, only type=airport is included.
		Source     CHAR(12)     NOT NULL  -- Source of this data. "OurAirports" for data sourced from OurAirports, "Legacy" for old data not matched to OurAirports (mostly DAFIF), "User" for unverified user contributions. In airports.csv, only source=OurAirports is included.
		);

CREATE TABLE AIRLINES (
		AirlineID INTEGER       NOT NULL, -- Unique OpenFlights identifier for this airline.
		Name      CHAR(120)     NOT NULL, -- Name of the airline.
		Alias     CHAR(120),              -- Alias of the airline. For example, All Nippon Airways is commonly known as "ANA".
		IATA      CHAR(2),                -- 2-letter IATA code, if available.
		ICAO      CHAR(3),                -- 3-letter ICAO code, if available.
		Callsign  CHAR(120),              -- Airline callsign.
		Country   CHAR(80),               -- Country or territory where airline is incorporated.
		Active    CHAR(1)       NOT NULL  -- "Y" if the airline is or has until recently been operational, "N" if it is defunct. This field is not reliable: in particular, major airlines that stopped flying long ago, but have not had their IATA code reassigned (eg. Ansett/AN), will incorrectly show as "Y"
		);

CREATE TABLE ROUTES (
		Airline   CHAR(3)            NOT NULL, -- 2-letter (IATA) or 3-letter (ICAO) code of the airline.
		AirlineID INTEGER            NOT NULL, -- Unique OpenFlights identifier for airline (see Airline).
		SourceAirport CHAR(4)        NOT NULL, -- 3-letter (IATA) or 4-letter (ICAO) code of the source airport.
		SourceAirportID INTEGER      NOT NULL, -- Unique OpenFlights identifier for source airport (see Airport)
		DestinationAirport CHAR(4)   NOT NULL, -- 3-letter (IATA) or 4-letter (ICAO) code of the destination airport.
		DestinationAirportID INTEGER NOT NULL, -- Unique OpenFlights identifier for destination airport (see Airport)
		Codeshare CHAR(1),                -- "Y" if this flight is a codeshare (that is, not operated by Airline, but another carrier), empty otherwise.
		Stops INTEGER                NOT NULL, -- Number of stops on this flight ("0" for direct)
		Equipment CHAR(60)           NOT NULL  -- 3-letter codes for plane type(s) generally used on this flight, separated by spaces
		);

-- Routes are directional: if an airline operates services from A to B and from B to A, both A-B and B-A are listed separately.
-- Routes where one carrier operates both its own and codeshare flights are listed only once.
-- For this "test", records with nulls in the CSV file are removed
