-- Active: 1722504789881@@mysql.sqlpub.com@3306@interview_data

-- 课程表   课程id 课程名称 授课老师
CREATE TABLE t_mysql_course (
    cid INT PRIMARY KEY, cname VARCHAR(50), tid INT, FOREIGN KEY (tid) REFERENCES t_mysql_teacher (tid)
);

INSERT INTO
    t_mysql_course
VALUES (1, '语文', 2),
    (2, '数学', 1),
    (3, '英语', 3);