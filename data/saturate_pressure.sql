-- Insert pressure units
INSERT INTO units (symbol, name, description) VALUES
    ('pa', 'pascal', 'The base unit of pressure in SI'),
    ('kpa', 'kilopascal', '1000 pascals'),
    ('mpa', 'megapascal', '1000000 pascals'),
    ('bar', 'bar', '100000 pascals'),
    ('mbar', 'millibar', '100 pascals'),
    ('atm', 'atmosphere', 'Standard atmospheric pressure'),
    ('psi', 'pounds per square inch', 'Imperial pressure unit'),
    ('mmhg', 'millimeters of mercury', 'Medical pressure unit'),
    ('inhg', 'inches of mercury', 'Weather pressure unit');

-- Insert pressure conversions
INSERT INTO conversions (from_unit, to_unit, factor)
SELECT u1.id, u2.id, CASE 
    WHEN u1.symbol = 'pa' AND u2.symbol = 'kpa' THEN 0.001
    WHEN u1.symbol = 'kpa' AND u2.symbol = 'pa' THEN 1000.0
    WHEN u1.symbol = 'pa' AND u2.symbol = 'mpa' THEN 0.000001
    WHEN u1.symbol = 'mpa' AND u2.symbol = 'pa' THEN 1000000.0
    WHEN u1.symbol = 'pa' AND u2.symbol = 'bar' THEN 0.00001
    WHEN u1.symbol = 'bar' AND u2.symbol = 'pa' THEN 100000.0
    WHEN u1.symbol = 'pa' AND u2.symbol = 'mbar' THEN 0.01
    WHEN u1.symbol = 'mbar' AND u2.symbol = 'pa' THEN 100.0
    WHEN u1.symbol = 'pa' AND u2.symbol = 'atm' THEN 0.00000986923
    WHEN u1.symbol = 'atm' AND u2.symbol = 'pa' THEN 101325.0
    WHEN u1.symbol = 'pa' AND u2.symbol = 'psi' THEN 0.000145038
    WHEN u1.symbol = 'psi' AND u2.symbol = 'pa' THEN 6894.76
    WHEN u1.symbol = 'pa' AND u2.symbol = 'mmhg' THEN 0.00750062
    WHEN u1.symbol = 'mmhg' AND u2.symbol = 'pa' THEN 133.322
    WHEN u1.symbol = 'pa' AND u2.symbol = 'inhg' THEN 0.000295301
    WHEN u1.symbol = 'inhg' AND u2.symbol = 'pa' THEN 3386.39
    WHEN u1.symbol = 'bar' AND u2.symbol = 'atm' THEN 0.986923
    WHEN u1.symbol = 'atm' AND u2.symbol = 'bar' THEN 1.01325
    WHEN u1.symbol = 'bar' AND u2.symbol = 'psi' THEN 14.5038
    WHEN u1.symbol = 'psi' AND u2.symbol = 'bar' THEN 0.0689476
    WHEN u1.symbol = 'atm' AND u2.symbol = 'psi' THEN 14.6959
    WHEN u1.symbol = 'psi' AND u2.symbol = 'atm' THEN 0.068046
END
FROM units u1, units u2
WHERE (u1.symbol, u2.symbol) IN (
    ('pa', 'kpa'), ('kpa', 'pa'),
    ('pa', 'mpa'), ('mpa', 'pa'),
    ('pa', 'bar'), ('bar', 'pa'),
    ('pa', 'mbar'), ('mbar', 'pa'),
    ('pa', 'atm'), ('atm', 'pa'),
    ('pa', 'psi'), ('psi', 'pa'),
    ('pa', 'mmhg'), ('mmhg', 'pa'),
    ('pa', 'inhg'), ('inhg', 'pa'),
    ('bar', 'atm'), ('atm', 'bar'),
    ('bar', 'psi'), ('psi', 'bar'),
    ('atm', 'psi'), ('psi', 'atm')
); 