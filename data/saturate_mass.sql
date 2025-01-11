-- Insert mass units
INSERT INTO units (symbol, name, description) VALUES
    ('kg', 'kilogram', 'The base unit of mass in SI'),
    ('g', 'gram', '1/1000 of a kilogram'),
    ('mg', 'milligram', '1/1000000 of a kilogram'),
    ('µg', 'microgram', '1/1000000000 of a kilogram'),
    ('t', 'metric ton', '1000 kilograms'),
    ('lb', 'pound', 'Imperial pound'),
    ('oz', 'ounce', 'Imperial ounce'),
    ('st', 'stone', '14 pounds'),
    ('slug', 'slug', 'Imperial unit of mass');

-- Insert mass conversions
INSERT INTO conversions (from_unit, to_unit, factor)
SELECT u1.id, u2.id, CASE 
    WHEN u1.symbol = 'kg' AND u2.symbol = 'g' THEN 1000.0
    WHEN u1.symbol = 'g' AND u2.symbol = 'kg' THEN 0.001
    WHEN u1.symbol = 'kg' AND u2.symbol = 'lb' THEN 2.20462
    WHEN u1.symbol = 'lb' AND u2.symbol = 'kg' THEN 0.453592
    WHEN u1.symbol = 'kg' AND u2.symbol = 'oz' THEN 35.274
    WHEN u1.symbol = 'oz' AND u2.symbol = 'kg' THEN 0.0283495
    WHEN u1.symbol = 'g' AND u2.symbol = 'lb' THEN 0.00220462
    WHEN u1.symbol = 'lb' AND u2.symbol = 'g' THEN 453.592
    WHEN u1.symbol = 'g' AND u2.symbol = 'oz' THEN 0.035274
    WHEN u1.symbol = 'oz' AND u2.symbol = 'g' THEN 28.3495
    WHEN u1.symbol = 'lb' AND u2.symbol = 'oz' THEN 16.0
    WHEN u1.symbol = 'oz' AND u2.symbol = 'lb' THEN 0.0625
    WHEN u1.symbol = 'g' AND u2.symbol = 'mg' THEN 1000.0
    WHEN u1.symbol = 'mg' AND u2.symbol = 'g' THEN 0.001
    WHEN u1.symbol = 'mg' AND u2.symbol = 'µg' THEN 1000.0
    WHEN u1.symbol = 'µg' AND u2.symbol = 'mg' THEN 0.001
    WHEN u1.symbol = 'kg' AND u2.symbol = 't' THEN 0.001
    WHEN u1.symbol = 't' AND u2.symbol = 'kg' THEN 1000.0
    WHEN u1.symbol = 'lb' AND u2.symbol = 'st' THEN 0.0714286
    WHEN u1.symbol = 'st' AND u2.symbol = 'lb' THEN 14.0
    WHEN u1.symbol = 'kg' AND u2.symbol = 'slug' THEN 0.0685218
    WHEN u1.symbol = 'slug' AND u2.symbol = 'kg' THEN 14.5939
END
FROM units u1, units u2
WHERE (u1.symbol, u2.symbol) IN (
    ('kg', 'g'), ('g', 'kg'),
    ('kg', 'lb'), ('lb', 'kg'),
    ('kg', 'oz'), ('oz', 'kg'),
    ('g', 'lb'), ('lb', 'g'),
    ('g', 'oz'), ('oz', 'g'),
    ('lb', 'oz'), ('oz', 'lb'),
    ('g', 'mg'), ('mg', 'g'),
    ('mg', 'µg'), ('µg', 'mg'),
    ('kg', 't'), ('t', 'kg'),
    ('lb', 'st'), ('st', 'lb'),
    ('kg', 'slug'), ('slug', 'kg')
); 