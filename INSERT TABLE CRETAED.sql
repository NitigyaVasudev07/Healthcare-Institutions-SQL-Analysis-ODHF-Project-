BEGIN;


CREATE TABLE Facility
(
    facility_id character varying,
    facility_name character varying(200),
    source_facility_type character varying(200),
    provider character varying(200),
    PRIMARY KEY (facility_id)
);

CREATE TABLE Facility_address
(
    facility_id character varying(200),
    Address_id character varying(200),
    street_no character varying(200),
    street_name character varying(200),
    postal_code character varying(200),
    city character varying(200),
    province character varying(200),
    PRIMARY KEY (Address_id)
);

CREATE TABLE Address
(
    facility_id character varying,
    Source_id character varying(200),
    Source_format_str_address character varying(200),
    PRIMARY KEY (Source_id)
);

CREATE TABLE Geographic
(
    Source_id character varying,
    geo_id character varying,
    CSDname character varying,
    CSDuid character varying,
    Pruid character varying,
    PRIMARY KEY (geo_id)
);

CREATE TABLE Coordinates
(
    geo_id character varying(200),
    location_id character varying(200),
    latitude character varying(200),
    longitude character varying(200),
    PRIMARY KEY (location_id)
);

ALTER TABLE Facility_address
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


ALTER TABLE Geographic
    ADD FOREIGN KEY (Source_id)
    REFERENCES Address (Source_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE Coordinates
    ADD FOREIGN KEY (geo_id)
    REFERENCES Geographic (geo_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;