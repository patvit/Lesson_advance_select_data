CREATE TABLE IF NOT EXISTS styles (
	style_id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS musicians (
	musician_id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS tracks (
	tracks_id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL,
	albom INTEGER NOT NULL REFERENCES alboms(alboms_id),
	duration INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS alboms (
	alboms_id  SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL,
	year date NOT NULL
);

CREATE TABLE IF NOT EXISTS musician_styles (
	style_id INTEGER REFERENCES styles(style_id),
	musician_id INTEGER REFERENCES Musicians(musician_id)
);

CREATE TABLE IF NOT EXISTS musicians_alboms (
	alboms_id INTEGER REFERENCES Alboms(alboms_id),
	musician_id INTEGER REFERENCES Musicians(musician_id)
);

CREATE TABLE IF NOT EXISTS collection (
	collection_id  SERIAL PRIMARY KEY,
	tracks_id INTEGER NOT NULL REFERENCES tracks(tracks_id),
	name VARCHAR(60) NOT NULL,
	year date NOT NULL
);
CREATE TABLE IF NOT EXISTS collection_tracks (
	tracks_id INTEGER REFERENCES tracks(tracks_id),
	collection_id INTEGER REFERENCES collection(collection_id)
	);