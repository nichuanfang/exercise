-- Active: 1722504789881@@mysql.sqlpub.com@3306@interview_data

CREATE TABLE t_mysql_score (
    sid INT, cid INT, score INT, FOREIGN KEY (sid) REFERENCES t_mysql_student (sid), FOREIGN KEY (cid) REFERENCES t_mysql_course (cid)
);

INSERT INTO
    t_mysql_score
VALUES (1, 1, 80),
    (1, 2, 90),
    (1, 3, 99),
    (2, 1, 70),
    (2, 2, 60),
    (2, 3, 80),
    (3, 1, 80),
    (3, 2, 80),
    (3, 3, 80),
    (4, 1, 50),
    (4, 2, 30),
    (4, 3, 20),
    (5, 1, 76),
    (5, 2, 87),
    (6, 1, 31),
    (6, 3, 34),
    (7, 2, 89),
    (7, 3, 98);