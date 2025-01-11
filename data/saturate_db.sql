-- Additional Distance Units
INSERT OR IGNORE INTO units (symbol, name, description) VALUES
    ('nm', 'nanometer', '1 billionth of a meter'),
    ('µm', 'micrometer', '1 millionth of a meter'),
    ('mm', 'millimeter', '1/1000 of a meter'),
    ('dm', 'decimeter', '1/10 of a meter'),
    ('dam', 'decameter', '10 meters'),
    ('hm', 'hectometer', '100 meters'),
    ('nmi', 'nautical mile', 'Naval distance unit'),
    ('ft', 'foot', 'Imperial foot'),
    ('fur', 'furlong', 'Traditional unit of distance'),
    ('ly', 'light-year', 'Astronomical distance unit'),
    ('au', 'astronomical unit', 'Mean Earth-Sun distance'),
    ('pc', 'parsec', 'Astronomical distance unit');

-- Additional Distance Conversions
INSERT OR IGNORE INTO conversions 
WITH RECURSIVE
    nm_id AS (SELECT id FROM units WHERE symbol = 'nm'),
    um_id AS (SELECT id FROM units WHERE symbol = 'µm'),
    mm_id AS (SELECT id FROM units WHERE symbol = 'mm'),
    cm_id AS (SELECT id FROM units WHERE symbol = 'cm'),
    dm_id AS (SELECT id FROM units WHERE symbol = 'dm'),
    m_id AS (SELECT id FROM units WHERE symbol = 'm'),
    nmi_id AS (SELECT id FROM units WHERE symbol = 'nmi'),
    ft_id AS (SELECT id FROM units WHERE symbol = 'ft'),
    in_id AS (SELECT id FROM units WHERE symbol = 'in')
SELECT * FROM (
    SELECT (SELECT * FROM nm_id), (SELECT * FROM um_id), 0.001 UNION ALL
    SELECT (SELECT * FROM um_id), (SELECT * FROM nm_id), 1000 UNION ALL
    SELECT (SELECT * FROM um_id), (SELECT * FROM mm_id), 0.001 UNION ALL
    SELECT (SELECT * FROM mm_id), (SELECT * FROM um_id), 1000 UNION ALL
    SELECT (SELECT * FROM mm_id), (SELECT * FROM cm_id), 0.1 UNION ALL
    SELECT (SELECT * FROM cm_id), (SELECT * FROM mm_id), 10 UNION ALL
    SELECT (SELECT * FROM dm_id), (SELECT * FROM cm_id), 10 UNION ALL
    SELECT (SELECT * FROM cm_id), (SELECT * FROM dm_id), 0.1 UNION ALL
    SELECT (SELECT * FROM m_id), (SELECT * FROM dm_id), 10 UNION ALL
    SELECT (SELECT * FROM dm_id), (SELECT * FROM m_id), 0.1 UNION ALL
    SELECT (SELECT * FROM nmi_id), (SELECT * FROM m_id), 1852 UNION ALL
    SELECT (SELECT * FROM m_id), (SELECT * FROM nmi_id), 1/1852.0 UNION ALL
    SELECT (SELECT * FROM ft_id), (SELECT * FROM in_id), 12 UNION ALL
    SELECT (SELECT * FROM in_id), (SELECT * FROM ft_id), 1/12.0
);

-- Additional Mass Units
INSERT OR IGNORE INTO mass_units (symbol, name, description) VALUES
    ('mg', 'milligram', '1/1000 of a gram'),
    ('µg', 'microgram', '1/1000000 of a gram'),
    ('ng', 'nanogram', '1 billionth of a gram'),
    ('t', 'metric ton', '1000 kilograms'),
    ('st', 'stone', 'British mass unit'),
    ('cwt', 'hundredweight', 'Imperial mass unit'),
    ('gr', 'grain', 'Traditional mass unit'),
    ('ct', 'carat', 'Jewellery mass unit'),
    ('slug', 'slug', 'Imperial mass unit');

-- Additional Mass Conversions
INSERT OR IGNORE INTO mass_conversions 
WITH RECURSIVE
    mg_id AS (SELECT id FROM mass_units WHERE symbol = 'mg'),
    g_id AS (SELECT id FROM mass_units WHERE symbol = 'g'),
    kg_id AS (SELECT id FROM mass_units WHERE symbol = 'kg'),
    t_id AS (SELECT id FROM mass_units WHERE symbol = 't'),
    lb_id AS (SELECT id FROM mass_units WHERE symbol = 'lb'),
    st_id AS (SELECT id FROM mass_units WHERE symbol = 'st')
SELECT * FROM (
    SELECT (SELECT * FROM mg_id), (SELECT * FROM g_id), 0.001 UNION ALL
    SELECT (SELECT * FROM g_id), (SELECT * FROM mg_id), 1000 UNION ALL
    SELECT (SELECT * FROM kg_id), (SELECT * FROM t_id), 0.001 UNION ALL
    SELECT (SELECT * FROM t_id), (SELECT * FROM kg_id), 1000 UNION ALL
    SELECT (SELECT * FROM st_id), (SELECT * FROM lb_id), 14 UNION ALL
    SELECT (SELECT * FROM lb_id), (SELECT * FROM st_id), 1/14.0
);

-- Additional Speed Units
INSERT OR IGNORE INTO speed_units (symbol, name, description) VALUES
    ('km_h', 'kilometers per hour', 'Metric speed'),
    ('mach', 'mach number', 'Speed of sound'),
    ('knot', 'knot', 'Nautical speed'),
    ('c', 'speed of light', 'Universal speed limit'),
    ('in_s', 'inches per second', 'Imperial speed'),
    ('mm_s', 'millimeters per second', 'Metric speed');

-- Additional Speed Conversions
INSERT OR IGNORE INTO speed_conversions 
WITH RECURSIVE
    kmh_id AS (SELECT id FROM speed_units WHERE symbol = 'km_h'),
    ms_id AS (SELECT id FROM speed_units WHERE symbol = 'm_s'),
    mach_id AS (SELECT id FROM speed_units WHERE symbol = 'mach')
SELECT * FROM (
    SELECT (SELECT * FROM kmh_id), (SELECT * FROM ms_id), 0.277778 UNION ALL
    SELECT (SELECT * FROM ms_id), (SELECT * FROM kmh_id), 3.6 UNION ALL
    SELECT (SELECT * FROM mach_id), (SELECT * FROM ms_id), 343 UNION ALL
    SELECT (SELECT * FROM ms_id), (SELECT * FROM mach_id), 1/343.0
);

-- Additional Pressure Units
INSERT OR IGNORE INTO pressure_units (symbol, name, description) VALUES
    ('bar', 'bar', 'Metric pressure unit'),
    ('mbar', 'millibar', 'Meteorological pressure'),
    ('kPa', 'kilopascal', 'Metric pressure'),
    ('MPa', 'megapascal', 'High pressure unit'),
    ('atm', 'atmosphere', 'Standard atmosphere'),
    ('torr', 'torr', 'Traditional pressure unit'),
    ('mmHg', 'millimeters of mercury', 'Medical pressure'),
    ('inHg', 'inches of mercury', 'Weather pressure');

-- Additional Pressure Conversions
INSERT OR IGNORE INTO pressure_conversions 
WITH RECURSIVE
    pa_id AS (SELECT id FROM pressure_units WHERE symbol = 'Pa'),
    bar_id AS (SELECT id FROM pressure_units WHERE symbol = 'bar'),
    atm_id AS (SELECT id FROM pressure_units WHERE symbol = 'atm')
SELECT * FROM (
    SELECT (SELECT * FROM bar_id), (SELECT * FROM pa_id), 100000 UNION ALL
    SELECT (SELECT * FROM pa_id), (SELECT * FROM bar_id), 0.00001 UNION ALL
    SELECT (SELECT * FROM atm_id), (SELECT * FROM pa_id), 101325 UNION ALL
    SELECT (SELECT * FROM pa_id), (SELECT * FROM atm_id), 1/101325.0
);

-- Additional Force Units
INSERT OR IGNORE INTO force_units (symbol, name, description) VALUES
    ('dyn', 'dyne', 'CGS unit of force'),
    ('kN', 'kilonewton', 'Metric large force'),
    ('kgf', 'kilogram-force', 'Traditional force'),
    ('pdl', 'poundal', 'Imperial force unit'),
    ('ozf', 'ounce-force', 'Small imperial force');

-- Additional Force Conversions
INSERT OR IGNORE INTO force_conversions 
WITH RECURSIVE
    n_id AS (SELECT id FROM force_units WHERE symbol = 'N'),
    kn_id AS (SELECT id FROM force_units WHERE symbol = 'kN'),
    dyn_id AS (SELECT id FROM force_units WHERE symbol = 'dyn')
SELECT * FROM (
    SELECT (SELECT * FROM kn_id), (SELECT * FROM n_id), 1000 UNION ALL
    SELECT (SELECT * FROM n_id), (SELECT * FROM kn_id), 0.001 UNION ALL
    SELECT (SELECT * FROM dyn_id), (SELECT * FROM n_id), 0.00001 UNION ALL
    SELECT (SELECT * FROM n_id), (SELECT * FROM dyn_id), 100000
);

-- Additional Currencies
INSERT OR IGNORE INTO currencies (code, name, symbol, description) VALUES
    ('CNY', 'Chinese Yuan', '¥', 'Chinese currency'),
    ('INR', 'Indian Rupee', '₹', 'Indian currency'),
    ('AUD', 'Australian Dollar', 'A$', 'Australian currency'),
    ('CHF', 'Swiss Franc', 'Fr.', 'Swiss currency'),
    ('NZD', 'New Zealand Dollar', 'NZ$', 'New Zealand currency'),
    ('SGD', 'Singapore Dollar', 'S$', 'Singapore currency'),
    ('HKD', 'Hong Kong Dollar', 'HK$', 'Hong Kong currency'),
    ('SEK', 'Swedish Krona', 'kr', 'Swedish currency'),
    ('KRW', 'South Korean Won', '₩', 'South Korean currency'),
    ('BRL', 'Brazilian Real', 'R$', 'Brazilian currency');

-- Additional Exchange Rates
INSERT OR IGNORE INTO exchange_rates 
WITH RECURSIVE
    usd_id AS (SELECT id FROM currencies WHERE code = 'USD'),
    eur_id AS (SELECT id FROM currencies WHERE code = 'EUR'),
    cny_id AS (SELECT id FROM currencies WHERE code = 'CNY'),
    inr_id AS (SELECT id FROM currencies WHERE code = 'INR')
SELECT * FROM (
    SELECT (SELECT * FROM usd_id), (SELECT * FROM cny_id), 6.45, CURRENT_TIMESTAMP UNION ALL
    SELECT (SELECT * FROM usd_id), (SELECT * FROM inr_id), 74.5, CURRENT_TIMESTAMP UNION ALL
    SELECT (SELECT * FROM eur_id), (SELECT * FROM cny_id), 7.75, CURRENT_TIMESTAMP UNION ALL
    SELECT (SELECT * FROM eur_id), (SELECT * FROM inr_id), 89.4, CURRENT_TIMESTAMP
); 