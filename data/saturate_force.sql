-- Insert force units
INSERT INTO units (symbol, name, description) VALUES
    ('n', 'newton', 'The base unit of force in SI'),
    ('kn', 'kilonewton', '1000 newtons'),
    ('dyn', 'dyne', 'CGS unit of force'),
    ('lbf', 'pound-force', 'Imperial pound force'),
    ('kgf', 'kilogram-force', 'Kilogram force'),
    ('pdl', 'poundal', 'Imperial unit of force');

-- Insert force conversions
INSERT INTO conversions (from_unit, to_unit, factor)
SELECT u1.id, u2.id, CASE 
    WHEN u1.symbol = 'n' AND u2.symbol = 'kn' THEN 0.001
    WHEN u1.symbol = 'kn' AND u2.symbol = 'n' THEN 1000.0
    WHEN u1.symbol = 'n' AND u2.symbol = 'dyn' THEN 100000.0
    WHEN u1.symbol = 'dyn' AND u2.symbol = 'n' THEN 0.00001
    WHEN u1.symbol = 'n' AND u2.symbol = 'lbf' THEN 0.224809
    WHEN u1.symbol = 'lbf' AND u2.symbol = 'n' THEN 4.44822
    WHEN u1.symbol = 'n' AND u2.symbol = 'kgf' THEN 0.101972
    WHEN u1.symbol = 'kgf' AND u2.symbol = 'n' THEN 9.80665
    WHEN u1.symbol = 'n' AND u2.symbol = 'pdl' THEN 7.23301
    WHEN u1.symbol = 'pdl' AND u2.symbol = 'n' THEN 0.138255
    WHEN u1.symbol = 'kn' AND u2.symbol = 'lbf' THEN 224.809
    WHEN u1.symbol = 'lbf' AND u2.symbol = 'kn' THEN 0.00444822
    WHEN u1.symbol = 'kgf' AND u2.symbol = 'lbf' THEN 2.20462
    WHEN u1.symbol = 'lbf' AND u2.symbol = 'kgf' THEN 0.453592
END
FROM units u1, units u2
WHERE (u1.symbol, u2.symbol) IN (
    ('n', 'kn'), ('kn', 'n'),
    ('n', 'dyn'), ('dyn', 'n'),
    ('n', 'lbf'), ('lbf', 'n'),
    ('n', 'kgf'), ('kgf', 'n'),
    ('n', 'pdl'), ('pdl', 'n'),
    ('kn', 'lbf'), ('lbf', 'kn'),
    ('kgf', 'lbf'), ('lbf', 'kgf')
); 