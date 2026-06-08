-- Sample data for Cinemas
INSERT INTO cinemas (name, location) VALUES 
('CineMax Central', 'Main St. 123'),
('CineMax North', 'Avenue 5th');

-- Sample data for Movies
INSERT INTO movies (title, duration_minutes, rating) VALUES 
('Inception', 148, 'PG-13'),
('Toy Story', 81, 'G'),
('The Dark Knight', 152, 'PG-13'),
('Interstellar', 169, 'PG-13'),
('Pulp Fiction', 154, 'R');

-- Sample data for Rooms
INSERT INTO rooms (cinema_id, room_name, capacity) VALUES 
(1, 'IMAX 1', 250),
(1, 'Standard A', 100),
(2, 'VIP Suite', 40),
(2, 'Standard B', 120);

-- Sample data for Screenings
INSERT INTO screenings (movie_id, room_id, start_time, price) VALUES 
(1, 1, '2024-06-10 18:00:00', 15.50),
(1, 1, '2024-06-10 21:30:00', 15.50),
(2, 2, '2024-06-10 14:00:00', 10.00),
(3, 1, '2024-06-11 19:00:00', 18.00),
(4, 3, '2024-06-11 20:00:00', 25.00),
(5, 4, '2024-06-12 22:00:00', 12.00);