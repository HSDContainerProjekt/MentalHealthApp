CREATE DATABASE FriendsOnlineDatabase;

CREATE OR REPLACE TABLE Friends (
    FriendID int NOT NULL,
    Name varchar(255),
    Birthday varchar(255),
    PRIMARY KEY (FriendID)
)