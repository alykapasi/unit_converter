-- Insert speed units
INSERT INTO units (symbol, name, description) VALUES
    ('m/s', 'meters per second', 'The base unit of speed in SI'),
    ('km/h', 'kilometers per hour', 'Kilometers per hour'),
    ('mph', 'miles per hour', 'Miles per hour'),
    ('kn', 'knot', 'Nautical miles per hour'),
    ('ft/s', 'feet per second', 'Feet per second'),
    ('mach', 'mach number', 'Speed of sound at sea level');

-- Insert speed conversions
INSERT INTO conversions (from_unit, to_unit, factor)
SELECT u1.id, u2.id, CASE 
    WHEN u1.symbol = 'm/s' AND u2.symbol = 'km/h' THEN 3.6
    WHEN u1.symbol = 'km/h' AND u2.symbol = 'm/s' THEN 0.277778
    WHEN u1.symbol = 'm/s' AND u2.symbol = 'mph' THEN 2.23694
    WHEN u1.symbol = 'mph' AND u2.symbol = 'm/s' THEN 0.44704
    WHEN u1.symbol = 'm/s' AND u2.symbol = 'kn' THEN 1.94384
    WHEN u1.symbol = 'kn' AND u2.symbol = 'm/s' THEN 0.514444
    WHEN u1.symbol = 'm/s' AND u2.symbol = 'ft/s' THEN 3.28084
    WHEN u1.symbol = 'ft/s' AND u2.symbol = 'm/s' THEN 0.3048
    WHEN u1.symbol = 'm/s' AND u2.symbol = 'mach' THEN 0.00291545
    WHEN u1.symbol = 'mach' AND u2.symbol = 'm/s' THEN 343.0
    WHEN u1.symbol = 'km/h' AND u2.symbol = 'mph' THEN 0.621371
    WHEN u1.symbol = 'mph' AND u2.symbol = 'km/h' THEN 1.60934
    WHEN u1.symbol = 'km/h' AND u2.symbol = 'kn' THEN 0.539957
    WHEN u1.symbol = 'kn' AND u2.symbol = 'km/h' THEN 1.852
    WHEN u1.symbol = 'mph' AND u2.symbol = 'kn' THEN 0.868976
    WHEN u1.symbol = 'kn' AND u2.symbol = 'mph' THEN 1.15078
END
FROM units u1, units u2
WHERE (u1.symbol, u2.symbol) IN (
    ('m/s', 'km/h'), ('km/h', 'm/s'),
    ('m/s', 'mph'), ('mph', 'm/s'),
    ('m/s', 'kn'), ('kn', 'm/s'),
    ('m/s', 'ft/s'), ('ft/s', 'm/s'),
    ('m/s', 'mach'), ('mach', 'm/s'),
    ('km/h', 'mph'), ('mph', 'km/h'),
    ('km/h', 'kn'), ('kn', 'km/h'),
    ('mph', 'kn'), ('kn', 'mph')
); 