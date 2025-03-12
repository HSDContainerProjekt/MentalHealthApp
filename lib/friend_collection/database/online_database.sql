DROP TABLE friends;
CREATE TABLE friends (
    FriendID int NOT NULL,
    Name varchar(255),
    Nickname varchar(255),
    Birthday varchar(255),
    ZodiacSign varchar(255),
    Animal varchar(255),
    HairColor varchar(255),
    Eyecolor varchar(255),
    FavoriteColor varchar(255),
    FavoriteSong varchar(255),
    FavoriteFood varchar(255),
    FavoriteBook varchar(255),
    FavoriteFilm varchar(255),
    FavoriteAnimal varchar(255),
    FavoriteNumber NUMBER
    PRIMARY KEY (FriendID)
);

DROP TABLE friendship;
CREATE TABLE friendship (
    friend1 int NOT NULL,
    friend2 int NOT NULL,
    status int NOT NULL 
)