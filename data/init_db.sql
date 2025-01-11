-- Base schema for all unit conversion databases
CREATE TABLE units (
    id INTEGER PRIMARY KEY,
    symbol TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    description TEXT
);

CREATE TABLE conversions (
    from_unit INTEGER,
    to_unit INTEGER,
    factor REAL NOT NULL,
    FOREIGN KEY (from_unit) REFERENCES units(id),
    FOREIGN KEY (to_unit) REFERENCES units(id),
    PRIMARY KEY (from_unit, to_unit)
); 