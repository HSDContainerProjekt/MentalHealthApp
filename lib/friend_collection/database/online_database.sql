DROP TABLE Friends;
CREATE TABLE Friends (
    FriendID int NOT NULL,
    Name varchar(255),
    Birthday varchar(255),
    PRIMARY KEY (FriendID)
);

DROP TABLE friendship;
CREATE TABLE friendship (
    friend1 int NOT NULL,
    friend2 int NOT NULL,
    status int NOT NULL 
)