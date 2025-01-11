-- Insert temperature units
INSERT INTO units (symbol, name, description) VALUES
    ('c', 'Celsius', 'Celsius temperature scale'),
    ('f', 'Fahrenheit', 'Fahrenheit temperature scale'),
    ('k', 'Kelvin', 'Kelvin temperature scale');

-- Insert temperature conversions
INSERT INTO conversions (from_unit, to_unit, factor)
SELECT u1.id, u2.id, CASE 
    WHEN u1.symbol = 'c' AND u2.symbol = 'f' THEN 1.8
    WHEN u1.symbol = 'f' AND u2.symbol = 'c' THEN 0.5555555556
    WHEN u1.symbol = 'c' AND u2.symbol = 'k' THEN 1.0
    WHEN u1.symbol = 'k' AND u2.symbol = 'c' THEN 1.0
    WHEN u1.symbol = 'f' AND u2.symbol = 'k' THEN 0.5555555556
    WHEN u1.symbol = 'k' AND u2.symbol = 'f' THEN 1.8
END
FROM units u1, units u2
WHERE (u1.symbol, u2.symbol) IN (
    ('c', 'f'), ('f', 'c'),
    ('c', 'k'), ('k', 'c'),
    ('f', 'k'), ('k', 'f')
); 