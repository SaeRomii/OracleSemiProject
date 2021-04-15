SELECT USER
FROM DUAL;
--==>> HR

------------------------------테이블 생성----------------------------------------
--관리자정보 테이블
CREATE TABLE TBL_ADMIN
( ADMIN_CODE VARCHAR2(20) 
, ADMIN_PW   VARCHAR2(20) CONSTRAINT ADMIN_ADMIN_PW_NN NOT NULL
, CONSTRAINT ADMIN_ADMIN_CODE_PK PRIMARY KEY(ADMIN_CODE)
);
--==>> Table TBL_ADMIN이(가) 생성되었습니다.


-- 교수정보 테이블
-- 교수코드 첫 자리 P로 시작 P || 0001 ~~
-- 주민번호 뒷자리에서 첫 자리에 입력 가능한 데이터 1,2,3,4 제약조건 설정
CREATE TABLE TBL_PROFESSOR
( PROF_CODE VARCHAR2(20)                                                                -- 교수코드 PK 
, PROF_NAME VARCHAR2(20)         CONSTRAINT PROFESSOR_PROF_NAME_NN NOT NULL             -- 교수이름
, PROF_SSN  CHAR(7)              CONSTRAINT PROFESSOR_PROF_SSN_NN NOT NULL              -- 주민번호 뒷자리
, PROF_PW   VARCHAR2(20)         CONSTRAINT PROFESSOR_PROF_PW_NN NOT NULL               -- 교수PW
, PROF_DATE  DATE DEFAULT SYSDATE CONSTRAINT PROFESSOR_PROF_DATE_NN NOT NULL             -- 등록일자
, CONSTRAINT PROFESSOR_PROF_CODE_PK PRIMARY KEY(PROF_CODE)                                   -- 교수코드 기본키
, CONSTRAINT PROFESSOR_PROF_SSN_CK  CHECK(SUBSTR(PROF_CODE,1,1) IN ('1','2','3','4'))        -- 교수주민번호 CK
);
--==>> Table TBL_PROFESSOR이(가) 생성되었습니다.

--ALTER TABLE TBL_PROFESSOR
--MODIFY PROF_PW DEFAULT PROF_SSN;       -- 테이블 생성 후 default 주민번호 뒷자리 추가????


-- 학생정보 테이블
-- 학생코드 첫 자리 S로 시작 S || 0001 ~~
-- 주민번호 뒷자리에서 첫 자리에 입력 가능한 데이터 1,2,3,4 제약조건 설정
CREATE TABLE TBL_STUDENT
( STD_CODE  VARCHAR2(20)                                                                -- 학생코드
, STD_NAME  VARCHAR2(20)    CONSTRAINT STUDENT_STD_NAME_NN NOT NULL                     -- 학생이름
, STD_SSN   CHAR(7)         CONSTRAINT STUDENT_STD_SSN_NN NOT NULL                      -- 주민번호 뒷자리
, STD_PW    VARCHAR2(20)    CONSTRAINT STUDENT_STD_PW_NN NOT NULL                       -- 학생PW
, STD_DATE  DATE            DEFAULT SYSDATE   CONSTRAINT STUDENT_STD_DATE_NN NOT NULL   -- 등록일자
, CONSTRAINT STUDENT_STD_CODE_PK PRIMARY KEY(STD_CODE)
, CONSTRAINT STUDENT_STD_SSN_CK CHECK(SUBSTR(STD_SSN, 1, 1) IN ('1', '2', '3', '4'))
);
--==>> Table TBL_STUDENT이(가) 생성되었습니다.


-- 과정정보 테이블
CREATE TABLE TBL_COURSE
( CRS_CODE VARCHAR2(20)                                                                 -- 과정코드
, CRS_NAME VARCHAR2(50) CONSTRAINT COURSE_CRS_NAME_NN NOT NULL                          -- 과정이름
, CONSTRAINT COURSE_CRS_CODE_PK PRIMARY KEY(CRS_CODE)
);
--==>> Table TBL_COURSE이(가) 생성되었습니다.

ALTER TABLE TBL_COURSE MODIFY CRS_NAME VARCHAR2(100);
--==>> Table TBL_COURSE이(가) 변경되었습니다.

-- 과목정보 테이블
CREATE TABLE TBL_SUBJECT
( SUB_CODE  VARCHAR2(20)                                                                -- 과목코드
, SUB_NAME  VARCHAR2(50) CONSTRAINT SUBJECT_SUB_NAME_NN NOT NULL                        -- 과목이름
, CONSTRAINT SUBJECT_SUB_CODE_PK PRIMARY KEY(SUB_CODE)
);
--==>> Table TBL_SUBJECT이(가) 생성되었습니다.


-- 교재정보 테이블
CREATE TABLE TBL_BOOK
( BOOK_CODE VARCHAR2(20)                                                                -- 교재코드
, BOOK_NAME VARCHAR2(50)    CONSTRAINT BOOK_BOOK_NAME_NN NOT NULL                       -- 교재이름
, CONSTRAINT BOOK_BOOK_CODE_PK PRIMARY KEY(BOOK_CODE)
);
--==>> Table TBL_BOOK이(가) 생성되었습니다.
ALTER TABLE TBL_BOOK MODIFY BOOK_NAME VARCHAR2(100);
--==>> Table TBL_BOOK이(가) 변경되었습니다.

-- 강의실정보 테이블
-- 수용인원 제약조건 설정
CREATE TABLE TBL_ROOM
( ROOM_CODE VARCHAR2(20)                                                                -- 강의실코드
, ROOM_NAME VARCHAR2(30)    CONSTRAINT ROOM_ROOM_NAME_NN NOT NULL                       -- 강의실이름
, ROOM_NUM  NUMBER(3)       CONSTRAINT ROOM_ROOM_NUM_NN NOT NULL                        -- 수용인원
, CONSTRAINT ROOM_ROOM_CODE_PK PRIMARY KEY(ROOM_CODE)
, CONSTRAINT ROOM_ROOM_NUM_CK CHECK(ROOM_NUM > 0)
);
--==>> Table TBL_ROOM이(가) 생성되었습니다.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';


-- 과정개설 테이블
-- 과정시작일자가 SYSDATE < 과정시작일자 조건 → TRIGGER
-- 과정종료일자가 과목시작일자 < 과목종료일자 제약조건 설정
CREATE TABLE TBL_OPENC
( OPENC_CODE  VARCHAR2(20)                                                              -- 과정개설코드
, CRS_CODE    VARCHAR2(20) CONSTRAINT OPENC_CRS_CODE_NN NOT NULL                        -- 과정코드
, ROOM_CODE   VARCHAR2(20) CONSTRAINT OPENC_ROOM_CODE_NN NOT NULL                       -- 강의실코드
, CRS_START   DATE CONSTRAINT OPENC_CRS_START_NN NOT NULL                               -- 과정시작일자
, CRS_END     DATE CONSTRAINT OPENC_CRS_END_NN NOT NULL                                 -- 과정종료일자
, CONSTRAINT OPENC_OPENC_CODE_PK PRIMARY KEY(OPENC_CODE)
, CONSTRAINT OPENC_CRS_CODE_FK FOREIGN KEY(CRS_CODE)
             REFERENCES TBL_COURSE(CRS_CODE)
, CONSTRAINT OPENC_ROOM_CODE_FK FOREIGN KEY(ROOM_CODE)
             REFERENCES TBL_ROOM(ROOM_CODE)
--, CONSTRAINT OPENC_CRS_START_CK CHECK (SYSDATE < CRS_START)           INSERT TRIGGER시 적용해야할 부분
, CONSTRAINT OPENC_CRS_END_CK CHECK (CRS_START < CRS_END)
);
--==>> Table TBL_OPENC이(가) 생성되었습니다.


-- 과목개설 테이블
-- 과목시작일자가 SYSDATE < 과목시작일자 조건 → TRIGGER
-- 과목종료일자가 과목시작일자 < 과목종료일자 제약조건 설정
-- 배점 0~100사이, 배점 합이 100까지인 조건은 예외처리로 할건지 여기서 넣을건지? 네
CREATE TABLE TBL_OPENS
( OPENS_CODE    VARCHAR2(20)                                                            -- 과목개설코드
, OPENC_CODE    VARCHAR2(20) CONSTRAINT OPENS_OPENC_CODE_NN NOT NULL                    -- 과정개설코드
, SUB_CODE      VARCHAR2(20) CONSTRAINT OPENS_SUB_CODE_NN NOT NULL                      -- 과목코드
, BOOK_CODE     VARCHAR2(20) CONSTRAINT OPENS_BOOK_CODE_NN NOT NULL                     -- 교재코드
, PROF_CODE     VARCHAR2(20) CONSTRAINT OPENS_PROF_CODE_NN NOT NULL                     -- 교수코드
, SUB_START     DATE         CONSTRAINT OPENS_SUB_STRAT_NN NOT NULL                     -- 과목시작일자
, SUB_END       DATE         CONSTRAINT OPENS_SUB_END_NN NOT NULL                       -- 과목종료일자
, C_PERCENT     NUMBER(3)                                                              -- 출결배점
, S_PERCENT     NUMBER(3)                                                              -- 실기배점
, P_PERCENT     NUMBER(3)                                                              -- 필기배점
, CONSTRAINT OPENS_OPENS_CODE_PK PRIMARY KEY(OPENS_CODE)
, CONSTRAINT OPENS_OPENC_CODE_FK FOREIGN KEY(OPENC_CODE) REFERENCES TBL_OPENC(OPENC_CODE)
, CONSTRAINT OPENS_SUB_CODE_FK FOREIGN KEY(SUB_CODE) REFERENCES TBL_SUBJECT(SUB_CODE)
, CONSTRAINT OPENS_BOOK_CODE_FK FOREIGN KEY(BOOK_CODE) REFERENCES TBL_BOOK(BOOK_CODE)
, CONSTRAINT OPENS_PROF_CODE_FK FOREIGN KEY(PROF_CODE) REFERENCES TBL_PROFESSOR(PROF_CODE)
--, CONSTRAINT OPENS_SUB_START_CK CHECK (SYSDATE < SUB_START)            INSERT TRIGGER시 적용해야할 부분
, CONSTRAINT OPENS_SUB_END_CK CHECK (SUB_START < SUB_END)
, CONSTRAINT OPENS_PERCENT_TOTAL_CK CHECK (C_PERCENT + S_PERCENT + P_PERCENT = 100)
, CONSTRAINT OPENS_C_PERCENT_CK CHECK (0 <= C_PERCENT AND C_PERCENT <= 100)
, CONSTRAINT OPENS_S_PERCENT_CK CHECK (0 <= S_PERCENT AND S_PERCENT <= 100)
, CONSTRAINT OPENS_P_PERCENT_CK CHECK (0 <= P_PERCENT AND P_PERCENT <= 100)
);
--==>> Table TBL_OPENS이(가) 생성되었습니다.



-- 수강신청 테이블
-- 수강신청일자 → 수강신청일자(SYSDATE) < 과정시작일자 제약조건 생략 → INSERT 프로시저시 적용해야할 부분
CREATE TABLE TBL_REGISTER                                                       
( REGISTER_CODE VARCHAR2(20)                                                        -- 수강신청코드
, OPENC_CODE    VARCHAR2(20)          CONSTRAINT REGISTER_OPENC_CODE_NN NOT NULL    -- 과정개설코드
, STD_CODE      VARCHAR2(20)          CONSTRAINT REGISTER_STD_CODE_NN NOT NULL      -- 학생코드
, REGISTER_DATE DATE DEFAULT SYSDATE  CONSTRAINT REGISTER_REGISTER_DATE_NN NOT NULL -- 수강신청일자
, CONSTRAINT REGISTER_REGISTER_CODE_PK PRIMARY KEY(REGISTER_CODE)                   -- 수강신청코드 기본키
, CONSTRAINT REGISTER_OPENC_CODE_FK FOREIGN KEY(OPENC_CODE)                         -- 과정개설코드 FK
            REFERENCES TBL_OPENC(OPENC_CODE)
, CONSTRAINT REGISTER_STU_CODE_FK FOREIGN KEY(STD_CODE)                             -- 학생코드 FK
            REFERENCES TBL_STUDENT(STD_CODE)
--, CONSTRAINT REGISTER_REGI_CODE_CK CHECK(REGISTER_CODE BETWEEN 30000 AND 39999)      -- 수강신청코드 CK
);
--==>> Table TBL_REGISTER이(가) 생성되었습니다.


-- 성적정보 테이블 생성
-- 출결 → 0 <= 출결 <= 출결배점  프로시저에서 적용해야할 부분
CREATE TABLE TBL_SCORE
( REGISTER_CODE VARCHAR2(20) CONSTRAINT SCORE_REGISTER_CODE_NN NOT NULL             -- 수강신청코드
, OPENS_CODE    VARCHAR2(20) CONSTRAINT SCORE_OPENS_CODE_NN NOT NULL                -- 과목개설코드
, C_SCORE       NUMBER(3)                                                           -- 출결
, S_SCORE       NUMBER(3)                                                           -- 실기
, P_SCORE       NUMBER(3)                                                           -- 필기
, CONSTRAINT SCORE_REGISTER_CODE_FK FOREIGN KEY(REGISTER_CODE)
             REFERENCES TBL_REGISTER(REGISTER_CODE)
, CONSTRAINT SCORE_OPENS_CODE_FK FOREIGN KEY(OPENS_CODE)
             REFERENCES TBL_OPENS(OPENS_CODE)
);
--==>> Table TBL_SCORE이(가) 생성되었습니다.


-- 중도탈락
-- 중도탈락일자 과정시작일자 <= 중도탈락일자 < 과정종료일자   → 프로시저에서 적용해야할 부분
-- 실제 중도탈락 신청일자와 명단에 추가될 탈락일자가 다를 수 있어서 DEFAULT SYSDATE 적용하지 않았음
CREATE TABLE TBL_FAIL
( REGISTER_CODE VARCHAR2(20)     CONSTRAINT FAIL_REGISTER_CODE_NN NOT NULL           -- 수강신청코드
, FAIL_DATE     DATE            CONSTRAINT FAIL_FAIL_DATE_NN NOT NULL               -- 중도탈락일자
, FAIL_REASON   VARCHAR2(100)                                                       -- 중도탈락사유
, CONSTRAINT FAIL_REGISTER_CODE_FK FOREIGN KEY(REGISTER_CODE)
             REFERENCES TBL_REGISTER(REGISTER_CODE)
);
--==>> Table TBL_FAIL이(가) 생성되었습니다.

------------------------------테이블 생성 끝-------------------------------------

------------------------------데이터 입력----------------------------------------
-- 관리자 정보 입력
INSERT INTO TBL_ADMIN(ADMIN_CODE,ADMIN_PW)
VALUES('ADMIN',1234);

-- 학생 입력 
EXEC PRC_STUDENT_INSERT('김가영', '2345678');
EXEC PRC_STUDENT_INSERT('김서현', '2456789');
EXEC PRC_STUDENT_INSERT('안정미', '2102938');
EXEC PRC_STUDENT_INSERT('이상화', '2683941');
EXEC PRC_STUDENT_INSERT('이새롬', '2987646');
EXEC PRC_STUDENT_INSERT('김호진', '1029385');
EXEC PRC_STUDENT_INSERT('전혜림', '2385921');
EXEC PRC_STUDENT_INSERT('정주희', '2638493');
EXEC PRC_STUDENT_INSERT('박정준', '1958302');
EXEC PRC_STUDENT_INSERT('차은우', '1385921');
EXEC PRC_STUDENT_INSERT('이하림', '4385921');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

-- 교수 입력
EXEC PRC_PROFESSOR_INSERT('유승호', '1234567');
EXEC PRC_PROFESSOR_INSERT('서강준', '1968203');
EXEC PRC_PROFESSOR_INSERT('박보영', '2968391');
EXEC PRC_PROFESSOR_INSERT('서인국', '1968402'); 
EXEC PRC_PROFESSOR_INSERT('박보영', '2596820');
EXEC PRC_PROFESSOR_INSERT('송강', '1852818');
EXEC PRC_PROFESSOR_INSERT('이솜', '2485921');
EXEC PRC_PROFESSOR_INSERT('박보영', '2948518');
EXEC PRC_PROFESSOR_INSERT('배수지', '2182212');
EXEC PRC_PROFESSOR_INSERT('전여빈', '2166192');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

-- 과정 정보 입력
EXEC PRC_COURSE_INSERT('임베디드 플랫폼 연동 융합 개발자 양성 과정');
EXEC PRC_COURSE_INSERT('AWS 클라우드 활용 풀스택 개발자 양성 과정');
EXEC PRC_COURSE_INSERT('JAVA 기반의 스마트 웹 풀스택 개발자 양성과정');
EXEC PRC_COURSE_INSERT('JAVA를 활용한 웹 콘텐츠 양성과정');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

-- 과목 정보 입력
EXEC PRC_SUBJECT_INSERT('Java');
EXEC PRC_SUBJECT_INSERT('Oracle');
EXEC PRC_SUBJECT_INSERT('HTML');
EXEC PRC_SUBJECT_INSERT('CSS');
EXEC PRC_SUBJECT_INSERT('JSP');
EXEC PRC_SUBJECT_INSERT('Servlet');
EXEC PRC_SUBJECT_INSERT('UI/UX');
EXEC PRC_SUBJECT_INSERT('JavaScript');
EXEC PRC_SUBJECT_INSERT('jQuery');
EXEC PRC_SUBJECT_INSERT('네트워크');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

-- 강의실 입력
EXEC PRC_ROOM_INSERT('A강의장', 20)
EXEC PRC_ROOM_INSERT('B강의장', 10)
EXEC PRC_ROOM_INSERT('C강의장', 15)
EXEC PRC_ROOM_INSERT('D강의장', 25)
EXEC PRC_ROOM_INSERT('E강의장', 18)
EXEC PRC_ROOM_INSERT('F강의장', 22)
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

-- 교재 입력
EXEC PRC_BOOK_INSERT('자바의 정석');
EXEC PRC_BOOK_INSERT('이것이 자바다');
EXEC PRC_BOOK_INSERT('HTML5+CSS3 웹표준의 정석');
EXEC PRC_BOOK_INSERT('Do it! 자바스크립트 + 제이쿼리 입문');
EXEC PRC_BOOK_INSERT('서비스 운영이 쉬워지는 AWS 인프라 구축 가이드');
EXEC PRC_BOOK_INSERT('UML 기초와 응용');
EXEC PRC_BOOK_INSERT('오라클로 배우는 데이터베이스 개론과 실습');
EXEC PRC_BOOK_INSERT('모두의 네트워크');
EXEC PRC_BOOK_INSERT('JSP 웹 프로그래밍 입문+활용');
EXEC PRC_BOOK_INSERT('UI/UX 요구 분석');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.


