# About

This is a small Relational Graph Analytics Benchmark (sRGAB) to test the capabilities and the correctness of a relational database that supports graph analytics.

There are three relational tables (airports, airlines, and routes), x sanity check queries, and x benchmark queries.

The data are taken from the [OpenFlights](https://openflights.org/data.php) Airport, Airline and Route Databases which are made available under the Open Database License.

# Install

1. Run `generate-sql.sh` to create the `openflights_copy.sql` file with the correct local path to copy the data from. This should be run in the same directory where the .dat files are.

2. Next, setup the database by executing the sql scripts in the following order:
```
openflights_schema.sql
openflights_copy.sql
openflights_alter.sql
```

3. If you need to drop the database, run
```
openflights_drop.sql
```

# Schema

| AIRPORTS |   | ROUTES |     | AIRLINES |
|:---      |---|  ---   |:---| ---      |
|**_AirportID_** (pk)|   |Airline   |   |**_AirlineID_** (pk)|
|Name      |   |*AirlineID* (fk)    |   |Name     |
|City      |   |SourceAirport       |   |Alias    |
|Country   |   |*SourceAirportID* (fk)|   |IATA     |
|IATA      |   |DestinationAirport  |   |ICAO     |
|ICAO      |   |*DestinationAirportID* (fk)|   |Callsign |
|Latitude  |   |Codeshare           |   |Country  |
|Longitude |   |Stops               |   |Active   |
|Altitude  |   |Equipment           |   |         |
|Timezone  |
|DST       |
|Tz        |
|Type      |
|Source    |


# Sanity check queries

