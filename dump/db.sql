CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DROP TYPE IF EXISTS status_type;

CREATE TYPE  status_type AS ENUM('OPEN', 'ORDERED');

CREATE TABLE IF NOT EXISTS carts (
  id UUID PRIMARY KEY,
  user_id UUID NOT NULL,
  created_at DATE NOT NULL,
  updated_at DATE NOT NULL,
  status status_type
);

CREATE TABLE IF NOT EXISTS cart_items (
  cart_id UUID REFERENCES carts(id),
  product_id UUID,
  count INTEGER
);

INSERT INTO carts (id, user_id, created_at, updated_at, status)
VALUES 
  ('1f2e3d4c-5b6a-7f8e-9d0e-1a2b3c4d5e6f', '123e4567-e89b-12d3-a456-426655440000', '2021-10-01', '2021-10-01', 'OPEN'),
  ('2f3e4d5c-6b7a-8f9e-0d1e-2a3b4c5d6e7f', '234e5678-e9ab-23d4-b567-537755550000', '2021-10-02', '2021-10-02', 'ORDERED'),
  ('3f4e5d6c-7b8a-9f0e-1d2e-3a4b5c6d7e8f', '345e6789-fabc-34d5-c678-648855660000', '2021-10-03', '2021-10-03', 'OPEN'),
  ('4f5e6d7c-8b9a-0e1f-2d3e-4b5c6d7e8f9a', '456e7890-abcd-45e6-d789-759955770000', '2021-10-04', '2021-10-04', 'ORDERED'),
  ('5e6d7c8b-9a0e-1f2d-3e4b-5c6d7e8f9a0b', '567f8901-bcde-56f7-e890-861055880000', '2021-10-05', '2021-10-05', 'OPEN');

INSERT INTO cart_items (cart_id, product_id, count)
VALUES 
  ('1f2e3d4c-5b6a-7f8e-9d0e-1a2b3c4d5e6f', '123e4567-e89b-12d3-a456-426655440001', 2),
  ('1f2e3d4c-5b6a-7f8e-9d0e-1a2b3c4d5e6f', '123e4567-e89b-12d3-a456-426655440002', 1),
  ('2f3e4d5c-6b7a-8f9e-0d1e-2a3b4c5d6e7f', '234e5678-e9ab-23d4-b567-537755550001', 3),
  ('3f4e5d6c-7b8a-9f0e-1d2e-3a4b5c6d7e8f', '345e6789-fabc-34d5-c678-648855660001', 4),
  ('5e6d7c8b-9a0e-1f2d-3e4b-5c6d7e8f9a0b', '567f8901-bcde-56f7-e890-861055880001', 2);