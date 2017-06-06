-- Qs1
-- check the number of airports
SELECT COUNT(*) FROM airports;
--+------+
--| L3   |
--+======+
--| 7184 |
--+------+
--1 tuple (3.667ms)

-- Qs2
-- two airports are connected if there is at least one flight in the routes table that originates from one airport and arrives at the other airport. This is the (undirected) Aiports Graph
SELECT COUNT(*) FROM routes;
--+-------+
--| L3    |
--+=======+
--| 65612 |
--+-------+
--1 tuple (3.249ms)

-- Qs3
-- check the number of airlines
SELECT COUNT(*) FROM airlines;
--+------+
--| L3   |
--+======+
--| 6162 |
--+------+
--1 tuple (3.352ms)

-- Qs4a
-- two airlines are connected, if there is a flight from airline 1 that lands in the country of the base of airline 2. This is the (directed) Airlines Graph
SELECT COUNT(*) FROM
(
    SELECT DISTINCT airlines1.AirlineID as AirlineID_src, airlines2.AirlineID as AirlineID_tgt
    FROM
        airlines AS airlines1,
        airlines AS airlines2,
        routes,
        airports
    WHERE
        routes.AirlineID = airlines1.AirlineID AND            -- a route of airline 1
        routes.DestinationAirportID = airports.airportID AND  -- arriving at airport
        airports.Country = airlines2.Country AND              -- where airport country is the country of airline 2
        airlines2.AirlineID <> routes.AirlineID               -- and it is not a route of airline 2
) AS airlines_graph;
--+--------+
--| L7     |
--+========+
--| 467359 |
--+--------+
--1 tuple (2.3s)

-- Qs4b
-- same query with GROUP BY instead of DISTINCT
SELECT COUNT(*) FROM
(
    SELECT airlines1.AirlineID as AirlineID_src, airlines2.AirlineID as AirlineID_tgt
    FROM
        airlines AS airlines1,
        airlines AS airlines2,
        routes,
        airports
    WHERE
        routes.AirlineID = airlines1.AirlineID AND            -- a route of airline 1
        routes.DestinationAirportID = airports.airportID AND  -- arriving at airport
        airports.Country = airlines2.Country AND              -- where airport country is the country of airline 2
        airlines2.AirlineID <> routes.AirlineID
    GROUP BY airlines1.AirlineID, airlines2.AirlineID
) AS airlines_graph;
--+--------+
--| L7     |
--+========+
--| 467359 |
--+--------+
--1 tuple (2.2s)

-- Qs5
-- create a VIEW for the Airlines Graph
CREATE VIEW airlines_graph_vw AS
SELECT
    airlines1.AirlineID AS AirlineID_src,
    MAX(airlines1.Name) AS Name_src,
    MAX(airlines1.Country) AS Country_src,
    airlines2.AirlineID AS AirlineID_tgt,
    MAX(airlines2.Name) AS Name_tgt,
    MAX(airlines2.Country) AS Country_tgt
FROM
    airlines AS airlines1,
    airlines AS airlines2,
    routes,
    airports
WHERE
    routes.AirlineID = airlines1.AirlineID AND
    routes.DestinationAirportID = airports.AirportID AND
    airports.Country = airlines2.Country AND
    airlines2.AirlineID <> routes.AirlineID
GROUP BY airlines1.AirlineID, airlines2.AirlineID;
