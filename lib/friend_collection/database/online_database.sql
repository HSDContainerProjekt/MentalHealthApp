CREATE DATABASE FriendsOnlineDatabase;

DROP TABLE Friends;
CREATE TABLE Friends (
    FriendID int NOT NULL,
    Name varchar(255),friendsfriendsFriendID
    Birthday date,
    PRIMARY KEY (FriendID)
);

INSERT INTO Friends VALUES(
	3,
    'TEST1',
    '2000-01-01');
    
COMMIT;