-- Insert distance units
INSERT INTO units (symbol, name, description) VALUES
    ('m', 'meter', 'The base unit of length in SI'),
    ('km', 'kilometer', '1000 meters'),
    ('mi', 'mile', 'Imperial mile'),
    ('yd', 'yard', 'Imperial yard'),
    ('in', 'inch', 'Imperial inch'),
    ('cm', 'centimeter', '1/100 of a meter'),
    ('mm', 'millimeter', '1/1000 of a meter'),
    ('µm', 'micrometer', '1/1000000 of a meter'),
    ('nm', 'nanometer', '1/1000000000 of a meter'),
    ('dm', 'decimeter', '1/10 of a meter'),
    ('ft', 'foot', 'Imperial foot'),
    ('nmi', 'nautical mile', 'Nautical mile');

-- Insert distance conversions
INSERT INTO conversions (from_unit, to_unit, factor)
SELECT u1.id, u2.id, CASE 
    WHEN u1.symbol = 'm' AND u2.symbol = 'km' THEN 0.001
    WHEN u1.symbol = 'km' AND u2.symbol = 'm' THEN 1000.0
    WHEN u1.symbol = 'm' AND u2.symbol = 'mi' THEN 0.000621371
    WHEN u1.symbol = 'mi' AND u2.symbol = 'm' THEN 1609.34
    WHEN u1.symbol = 'm' AND u2.symbol = 'yd' THEN 1.09361
    WHEN u1.symbol = 'yd' AND u2.symbol = 'm' THEN 0.9144
    WHEN u1.symbol = 'm' AND u2.symbol = 'in' THEN 39.3701
    WHEN u1.symbol = 'in' AND u2.symbol = 'm' THEN 0.0254
    WHEN u1.symbol = 'm' AND u2.symbol = 'cm' THEN 100.0
    WHEN u1.symbol = 'cm' AND u2.symbol = 'm' THEN 0.01
    WHEN u1.symbol = 'km' AND u2.symbol = 'mi' THEN 0.621371
    WHEN u1.symbol = 'mi' AND u2.symbol = 'km' THEN 1.60934
    WHEN u1.symbol = 'km' AND u2.symbol = 'yd' THEN 1093.61
    WHEN u1.symbol = 'yd' AND u2.symbol = 'km' THEN 0.0009144
    WHEN u1.symbol = 'km' AND u2.symbol = 'in' THEN 39370.0787
    WHEN u1.symbol = 'in' AND u2.symbol = 'km' THEN 0.0000254
    WHEN u1.symbol = 'km' AND u2.symbol = 'cm' THEN 100000.0
    WHEN u1.symbol = 'cm' AND u2.symbol = 'km' THEN 0.00001
    WHEN u1.symbol = 'mi' AND u2.symbol = 'yd' THEN 1760.0
    WHEN u1.symbol = 'yd' AND u2.symbol = 'mi' THEN 0.000568182
    WHEN u1.symbol = 'mi' AND u2.symbol = 'in' THEN 63360.0
    WHEN u1.symbol = 'in' AND u2.symbol = 'mi' THEN 0.0000157828
    WHEN u1.symbol = 'yd' AND u2.symbol = 'in' THEN 36.0
    WHEN u1.symbol = 'in' AND u2.symbol = 'yd' THEN 0.0277778
    WHEN u1.symbol = 'yd' AND u2.symbol = 'cm' THEN 91.44
    WHEN u1.symbol = 'cm' AND u2.symbol = 'yd' THEN 0.0109361
    WHEN u1.symbol = 'in' AND u2.symbol = 'cm' THEN 2.54
    WHEN u1.symbol = 'cm' AND u2.symbol = 'in' THEN 0.393701
    WHEN u1.symbol = 'mm' AND u2.symbol = 'cm' THEN 0.1
    WHEN u1.symbol = 'cm' AND u2.symbol = 'mm' THEN 10.0
    WHEN u1.symbol = 'µm' AND u2.symbol = 'mm' THEN 0.001
    WHEN u1.symbol = 'mm' AND u2.symbol = 'µm' THEN 1000.0
    WHEN u1.symbol = 'nm' AND u2.symbol = 'µm' THEN 0.001
    WHEN u1.symbol = 'µm' AND u2.symbol = 'nm' THEN 1000.0
    WHEN u1.symbol = 'dm' AND u2.symbol = 'm' THEN 0.1
    WHEN u1.symbol = 'm' AND u2.symbol = 'dm' THEN 10.0
    WHEN u1.symbol = 'dm' AND u2.symbol = 'cm' THEN 10.0
    WHEN u1.symbol = 'cm' AND u2.symbol = 'dm' THEN 0.1
    WHEN u1.symbol = 'ft' AND u2.symbol = 'in' THEN 12.0
    WHEN u1.symbol = 'in' AND u2.symbol = 'ft' THEN 0.0833333333333333
    WHEN u1.symbol = 'm' AND u2.symbol = 'nmi' THEN 0.000539956803455724
    WHEN u1.symbol = 'nmi' AND u2.symbol = 'm' THEN 1852.0
END
FROM units u1, units u2
WHERE (u1.symbol, u2.symbol) IN (
    ('m', 'km'), ('km', 'm'),
    ('m', 'mi'), ('mi', 'm'),
    ('m', 'yd'), ('yd', 'm'),
    ('m', 'in'), ('in', 'm'),
    ('m', 'cm'), ('cm', 'm'),
    ('km', 'mi'), ('mi', 'km'),
    ('km', 'yd'), ('yd', 'km'),
    ('km', 'in'), ('in', 'km'),
    ('km', 'cm'), ('cm', 'km'),
    ('mi', 'yd'), ('yd', 'mi'),
    ('mi', 'in'), ('in', 'mi'),
    ('yd', 'in'), ('in', 'yd'),
    ('yd', 'cm'), ('cm', 'yd'),
    ('in', 'cm'), ('cm', 'in'),
    ('mm', 'cm'), ('cm', 'mm'),
    ('µm', 'mm'), ('mm', 'µm'),
    ('nm', 'µm'), ('µm', 'nm'),
    ('dm', 'm'), ('m', 'dm'),
    ('dm', 'cm'), ('cm', 'dm'),
    ('ft', 'in'), ('in', 'ft'),
    ('m', 'nmi'), ('nmi', 'm')
); 