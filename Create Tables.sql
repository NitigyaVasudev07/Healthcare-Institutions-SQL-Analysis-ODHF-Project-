BEGIN;


CREATE TABLE Facility
(
    facility_id integer,
    facility_name character varying(200),
    source_facility_type character varying(200),
    provider character varying(200),
    PRIMARY KEY (facility_id)
);

CREATE TABLE Facility_Address
(
    facility_id integer,
    Address_id integer,
    street_no integer,
    street_name character varying(200),
    postal_code character varying(200),
    city character varying(200),
    province character(200),
    PRIMARY KEY (Address_id)
);

CREATE TABLE Address
(
    Source_id integer,
    source_format_str_address character varying(200),
    facility_id integer,
    PRIMARY KEY (Source_id)
);

CREATE TABLE Geographic_Identifiers
(
    geo_id integer,
    CSDname character varying(200),
    CSDuid integer,
    Pruid integer,
    Source_id integer,
    PRIMARY KEY (geo_id)
);

CREATE TABLE Facility_Coordinates
(
    geo_id integer,
    location_id integer,
    latitude integer,
    longitude integer,
    PRIMARY KEY (location_id)
);

ALTER TABLE Facility_Address
    ADD FOREIGN KEY (facility_id)
    REFERENCES Facility (facility_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE Address
    ADD FOREIGN KEY (facility_id)
    REFERENCES Facility (facility_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE Geographic_Identifiers
    ADD FOREIGN KEY (Source_id)
    REFERENCES Address (Source_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE Facility_Coordinates
    ADD FOREIGN KEY (geo_id)
    REFERENCES Geographic_Identifiers (geo_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;