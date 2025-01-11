-- Insert currency units
INSERT INTO units (symbol, name, description) VALUES
    ('usd', 'US Dollar', 'United States Dollar'),
    ('eur', 'Euro', 'European Union Euro'),
    ('gbp', 'British Pound', 'British Pound Sterling'),
    ('jpy', 'Japanese Yen', 'Japanese Yen'),
    ('cny', 'Chinese Yuan', 'Chinese Yuan Renminbi'),
    ('inr', 'Indian Rupee', 'Indian Rupee'),
    ('cad', 'Canadian Dollar', 'Canadian Dollar'),
    ('aud', 'Australian Dollar', 'Australian Dollar'),
    ('chf', 'Swiss Franc', 'Swiss Franc'),
    ('hkd', 'Hong Kong Dollar', 'Hong Kong Dollar');

-- Insert currency conversions (example rates, should be updated regularly)
INSERT INTO conversions (from_unit, to_unit, factor)
SELECT u1.id, u2.id, CASE 
    WHEN u1.symbol = 'usd' AND u2.symbol = 'eur' THEN 0.85
    WHEN u1.symbol = 'eur' AND u2.symbol = 'usd' THEN 1.18
    WHEN u1.symbol = 'usd' AND u2.symbol = 'gbp' THEN 0.73
    WHEN u1.symbol = 'gbp' AND u2.symbol = 'usd' THEN 1.37
    WHEN u1.symbol = 'usd' AND u2.symbol = 'jpy' THEN 110.0
    WHEN u1.symbol = 'jpy' AND u2.symbol = 'usd' THEN 0.00909
    WHEN u1.symbol = 'usd' AND u2.symbol = 'cny' THEN 6.45
    WHEN u1.symbol = 'cny' AND u2.symbol = 'usd' THEN 0.155
    WHEN u1.symbol = 'usd' AND u2.symbol = 'inr' THEN 74.5
    WHEN u1.symbol = 'inr' AND u2.symbol = 'usd' THEN 0.0134
    WHEN u1.symbol = 'usd' AND u2.symbol = 'cad' THEN 1.25
    WHEN u1.symbol = 'cad' AND u2.symbol = 'usd' THEN 0.80
    WHEN u1.symbol = 'usd' AND u2.symbol = 'aud' THEN 1.36
    WHEN u1.symbol = 'aud' AND u2.symbol = 'usd' THEN 0.735
    WHEN u1.symbol = 'usd' AND u2.symbol = 'chf' THEN 0.92
    WHEN u1.symbol = 'chf' AND u2.symbol = 'usd' THEN 1.087
    WHEN u1.symbol = 'usd' AND u2.symbol = 'hkd' THEN 7.78
    WHEN u1.symbol = 'hkd' AND u2.symbol = 'usd' THEN 0.129
    WHEN u1.symbol = 'eur' AND u2.symbol = 'gbp' THEN 0.86
    WHEN u1.symbol = 'gbp' AND u2.symbol = 'eur' THEN 1.16
END
FROM units u1, units u2
WHERE (u1.symbol, u2.symbol) IN (
    ('usd', 'eur'), ('eur', 'usd'),
    ('usd', 'gbp'), ('gbp', 'usd'),
    ('usd', 'jpy'), ('jpy', 'usd'),
    ('usd', 'cny'), ('cny', 'usd'),
    ('usd', 'inr'), ('inr', 'usd'),
    ('usd', 'cad'), ('cad', 'usd'),
    ('usd', 'aud'), ('aud', 'usd'),
    ('usd', 'chf'), ('chf', 'usd'),
    ('usd', 'hkd'), ('hkd', 'usd'),
    ('eur', 'gbp'), ('gbp', 'eur')
); 