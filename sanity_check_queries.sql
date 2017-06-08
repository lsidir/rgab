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
-- create a VIEW for the Airlines Graph (replace MAX() with FIRST() if supported)
CREATE VIEW airlines_graph_view AS
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

-- Qs5a
-- Count the airlines graph_view
SELECT COUNT(*) FROM airlines_graph_view;
--+--------+
--| L25    |
--+========+
--| 467359 |
--+--------+
--1 tuple (2.2s)

--Qs5b
-- Count how many airlines appear as edge sources in the Airlines Graph.
SELECT COUNT(*) FROM airlines WHERE airlines.AirlineID IN (SELECT AirlineID_src FROM  airlines_graph_view);
--+------+
--| L55  |
--+======+
--|  544 |
--+------+
--1 tuple (2.2s)

--Qs5c
-- Count how many airlines appear as edge targets in the Airlines Graph.
SELECT COUNT(*) FROM airlines WHERE airlines.AirlineID IN (SELECT AirlineID_tgt FROM  airlines_graph_view);
--+------+
--| L55  |
--+======+
--| 5975 |
--+------+
--1 tuple (2.3s)

--Qs6
-- Dense Rank the AirlinesID from table airlines to create unique and consequtive ids for airlines and join them with the source and target of the Airlines graph to upodate the AirlineID_src and AirlineID_tgt to the newly assigned ids from dense rank.
SELECT src_vertices.id AS src_id,
       tgt_vertices.id AS tgt_id
FROM airlines_graph_view,
     (SELECT airlines.AirlineID, (DENSE_RANK() OVER (ORDER BY airlines.AirlineID)) AS id FROM airlines) AS src_vertices,
     (SELECT airlines.AirlineID, (DENSE_RANK() OVER (ORDER BY airlines.AirlineID)) AS id FROM airlines) AS tgt_vertices
WHERE airlines_graph_view.AirlineID_src = src_vertices.AirlineID AND
      airlines_graph_view.AirlineID_tgt = tgt_vertices.AirlineID;

