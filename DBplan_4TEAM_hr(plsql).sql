SELECT USER
FROM DUAL;
--==>> HR

------------------------------시퀀스 생성----------------------------------------

-- 교수코드 SEQUENCE
CREATE SEQUENCE SEQ_PROFESSOR
START WITH 1001 
INCREMENT BY 1
MAXVALUE 9999
NOCACHE;
--==>> Sequence SEQ_PROFESSOR이(가) 생성되었습니다.


-- 학생코드 SEQUENCE
CREATE SEQUENCE SEQ_STUDENT
START WITH 1001
INCREMENT BY 1
MAXVALUE 9999
NOCACHE;
--==>> Sequence SEQ_STUDENT이(가) 생성되었습니다.

-- 과정코드 SEQUENCE
CREATE SEQUENCE SEQ_COURSE
START WITH 1000
INCREMENT BY 1
MAXVALUE 1999
NOCACHE;
--==>> Sequence SEQ_COURSE이(가) 생성되었습니다.

-- 과목코드 SEQUENCE
CREATE SEQUENCE SEQ_SUBJECT
START WITH 2000
INCREMENT BY 1
MAXVALUE 2999
NOCACHE;
--==>> Sequence SEQ_SUBJECT이(가) 생성되었습니다.

-- 강의실코드 SEQUENCE
CREATE SEQUENCE SEQ_ROOM
START WITH 3000
INCREMENT BY 1
MAXVALUE 3999
NOCACHE;
--==>> Sequence SEQ_ROOM이(가) 생성되었습니다.

-- 교재코드 SEQUENCE
CREATE SEQUENCE SEQ_BOOK
START WITH 4000
INCREMENT BY 1
MAXVALUE 4999
NOCACHE;
--==>> Sequence SEQ_BOOK이(가) 생성되었습니다.

-- 과정개설코드 SEQUENCE
CREATE SEQUENCE SEQ_OPENC
START WITH 10000
INCREMENT BY 1
MAXVALUE 19999
NOCACHE;
--==>> Sequence SEQ_OPENC이(가) 생성되었습니다.

-- 과목개설코드 SEQUENCE
CREATE SEQUENCE SEQ_OPENS
START WITH 20000
INCREMENT BY 1
MAXVALUE 29999
NOCACHE;
--==>> Sequence SEQ_OPENS이(가) 생성되었습니다.

-- 수강신청코드 SEQUENCE
CREATE SEQUENCE SEQ_REGISTER
START WITH 30000
INCREMENT BY 1
MAXVALUE 39999
NOCACHE;
--==>> Sequence SEQ_REGISTER이(가) 생성되었습니다.

---------------------------------시퀀스 생성 끝----------------------------------

-------------------------------0. 로그인 프로시저--------------------------------

-- 로그인 프로시저(관리자) PRC_LOGIN_ADMIN(ADMIN_CODE,ADMIN_PW)

CREATE OR REPLACE PROCEDURE PRC_LOGIN_ADMIN
( V_ADMIN_CODE  IN TBL_ADMIN.ADMIN_CODE%TYPE
, V_ADMIN_PW    IN TBL_ADMIN.ADMIN_PW%TYPE
)
IS
    -- 변수선언
    V_ORI_ADMIN_PW  TBL_ADMIN.ADMIN_PW%TYPE;    --입력받은 ADMIN_CODE에 해당하는 유효한 PW.
    
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    SELECT ADMIN_PW INTO V_ORI_ADMIN_PW
    FROM TBL_ADMIN
    WHERE ADMIN_CODE = V_ADMIN_CODE;
    
    
    IF ( V_ORI_ADMIN_PW != V_ADMIN_PW )
        THEN RAISE USER_DEFINE_ERROR;
    ELSE
        DBMS_OUTPUT.PUT_LINE('관리자 페이지로 로그인되었습니다.');
    END IF;
       
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20100, '아이디 또는 패스워드를 잘못 입력하였습니다.');
            ROLLBACK;
        WHEN OTHERS
            THEN RAISE_APPLICATION_ERROR(-20100, '아이디 또는 패스워드를 잘못 입력하였습니다.');
            ROLLBACK;
    
    --커밋
    --COMMIT;
    
END;
--==>> Procedure PRC_LOGIN_ADMIN이(가) 컴파일되었습니다.

-- 로그인 프로시저 (교수) PRC_LOGIN_PROFESSOR(PROF_CODE,PROF_PW)
CREATE OR REPLACE PROCEDURE PRC_LOGIN_PROFESSOR
( V_PROF_CODE   IN TBL_PROFESSOR.PROF_CODE%TYPE
, V_PROF_PW     IN TBL_PROFESSOR.PROF_PW%TYPE
)
IS
    --변수선언
    V_ORI_PROF_PW   TBL_PROFESSOR.PROF_PW%TYPE;    --입력받은 PROF_CODE에 해당하는 유효한 PW.
    
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    SELECT PROF_PW INTO V_ORI_PROF_PW
    FROM TBL_PROFESSOR
    WHERE PROF_CODE = V_PROF_CODE;

    IF ( V_ORI_PROF_PW != V_PROF_PW )
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('교수 페이지로 로그인되었습니다.');
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20100, '아이디 또는 패스워드를 잘못 입력하였습니다.');
            ROLLBACK;
        WHEN OTHERS
            THEN RAISE_APPLICATION_ERROR(-20100, '아이디 또는 패스워드를 잘못 입력하였습니다.');
            ROLLBACK;
    
    --커밋
    --COMMIT;
    
END;
--==>> Procedure PRC_LOGIN_PROFESSOR이(가) 컴파일되었습니다.

-- 로그인 프로시저 (학생) PRC_LOGIN_STUDENT(STD_CODE,STD_PW)
CREATE OR REPLACE PROCEDURE PRC_LOGIN_STUDENT
( V_STD_CODE    IN TBL_STUDENT.STD_CODE%TYPE
, V_STD_PW      IN TBL_STUDENT.STD_PW%TYPE
)
IS
    --변수선언
    V_ORI_STD_PW    TBL_STUDENT.STD_PW%TYPE;    --입력받은 STD_CODE에 해당하는 유효한 PW.
    
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    SELECT STD_PW INTO V_ORI_STD_PW
    FROM TBL_STUDENT
    WHERE STD_CODE = V_STD_CODE;
    
    IF ( V_ORI_STD_PW != V_STD_PW )
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('학생 페이지로 로그인되었습니다.');
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20100, '아이디 또는 패스워드를 잘못 입력하였습니다.');
            ROLLBACK;   
        WHEN OTHERS
            THEN RAISE_APPLICATION_ERROR(-20100, '아이디 또는 패스워드를 잘못 입력하였습니다.');
            ROLLBACK;
    
    --커밋
    --COMMIT;
    
END;
--==>> Procedure PRC_LOGIN_STUDENT이(가) 컴파일되었습니다.

-----------------------------1. 교수 프로시저------------------------------------

-- 교수 INSERT 프로시저 PRC_PROFESSOR_INSERT(PROF_NAME,PROF_SSN)

CREATE OR REPLACE PROCEDURE PRC_PROFESSOR_INSERT
(   
    V_PROF_NAME  IN TBL_PROFESSOR.PROF_NAME%TYPE            --이름
   ,V_PROF_SSN   IN TBL_PROFESSOR.PROF_SSN%TYPE             --주민번호뒷자리   
)
IS
    V_PROF_CODE   TBL_PROFESSOR.PROF_CODE%TYPE;             -- 코드

BEGIN
    -- 교수 코드(시퀀스)
    V_PROF_CODE := CONCAT('P' , TO_CHAR(SEQ_PROFESSOR.NEXTVAL));   
    
    -- INSERT 쿼리문
    INSERT INTO TBL_PROFESSOR(PROF_CODE, PROF_NAME, PROF_SSN, PROF_PW)
    VALUES(V_PROF_CODE, V_PROF_NAME, V_PROF_SSN, V_PROF_SSN);
    
    -- 커밋
    -- COMMIT;
    
    --예외 처리
      EXCEPTION
        WHEN OTHERS 
            THEN ROLLBACK;
    
END;
--==>> Procedure PRC_PROFESSOR_INSERT이(가) 컴파일되었습니다


-- 교수 UPDATE 프로시저 PRC_PROFESSOR_UPDATE(코드, 바꿀이름, 주민번호, 바꿀PW)
CREATE OR REPLACE PROCEDURE PRC_PROFESSOR_UPDATE
(
     V_PROF_CODE    IN TBL_PROFESSOR.PROF_CODE%TYPE 
    ,V_PROF_NAME    IN TBL_PROFESSOR.PROF_NAME%TYPE     -- 바꿀이름
    ,V_PROF_SSN     IN TBL_PROFESSOR.PROF_SSN%TYPE 
    ,V_PROF_PW      IN TBL_PROFESSOR.PROF_PW%TYPE       -- 바꿀PW
)
IS
    
BEGIN
    -- 코드, 주민번호 비교 → NAME, PW 변경
    UPDATE TBL_PROFESSOR
    SET PROF_NAME = V_PROF_NAME, PROF_PW = V_PROF_PW 
    WHERE PROF_CODE = V_PROF_CODE AND (SELECT PROF_SSN
                                       FROM TBL_PROFESSOR
                                       WHERE PROF_CODE=V_PROF_CODE)=V_PROF_SSN;
    
    --커밋
    --COMMIT;
    
    
    --예외 처리
      EXCEPTION
        WHEN OTHERS 
            THEN ROLLBACK;                                   
END;
--==>> Procedure PRC_PROFESSOR_UPDATE이(가) 컴파일되었습니다.


-- 교수 DELETE 프로시저 PRC_PROFESSOR_DELETE(PROF_CODE,PROF_PW)

CREATE OR REPLACE PROCEDURE PRC_PROFESSOR_DELETE
(
     V_PROF_CODE    IN TBL_PROFESSOR.PROF_CODE%TYPE
    ,V_PROF_PW      IN TBL_PROFESSOR.PROF_PW%TYPE 
)
IS
BEGIN
    
    -- CODE, PW 같으면 해당되는 행 삭제 
    DELETE
    FROM TBL_PROFESSOR
    WHERE PROF_CODE = V_PROF_CODE AND (SELECT PROF_PW
                                       FROM TBL_PROFESSOR
                                       WHERE PROF_CODE=V_PROF_CODE)=V_PROF_PW;
        
      -- 커밋
      -- COMMIT;
      
      
      --예외 처리
      EXCEPTION
        WHEN OTHERS 
            THEN ROLLBACK;
    
         
END;
--==>> Procedure PRC_PROFESSOR_DELETE이(가) 컴파일되었습니다.


-----------------------------2. 학생 프로시저------------------------------------

-- 학생 입력 프로시저 생성 PRC_STUDENT_INSERT(이름, 주민번호뒷자리)
CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
(   V_STD_NAME IN TBL_STUDENT.STD_NAME%TYPE   -- 학생이름
,   V_STD_SSN  IN TBL_STUDENT.STD_SSN%TYPE    -- 주민번호뒷자리
)
IS
    V_STD_CODE TBL_STUDENT.STD_CODE%TYPE;     -- 생성된 코드를 담을 변수

BEGIN
    -- 학생 코드 생성
    V_STD_CODE := 'S' || TO_CHAR(SEQ_STUDENT.NEXTVAL);
    
    -- 학생 테이블 INSERT 쿼리문 구성
    INSERT INTO TBL_STUDENT(STD_CODE, STD_NAME, STD_SSN, STD_PW)
    VALUES(V_STD_CODE, V_STD_NAME, V_STD_SSN, V_STD_SSN);
    
    -- 커밋
    -- COMMIT;
END;
--==>> Procedure PRC_STUDENT_INSERT이(가) 컴파일되었습니다.

-- 학생 업데이트 프로시저 생성 PRC_STUDENT_UPDATE(학생코드, 이름, 주민번호뒷자리, 학생PW)

CREATE OR REPLACE PROCEDURE PRC_STUDENT_UPDATE
(   V_STD_CODE IN TBL_STUDENT.STD_CODE%TYPE
,   V_STD_NAME IN TBL_STUDENT.STD_NAME%TYPE   -- 바꿀이름
,   V_STD_SSN  IN TBL_STUDENT.STD_SSN%TYPE
,   V_STD_PW   IN TBL_STUDENT.STD_PW%TYPE     -- 바꿀PW
)
IS
BEGIN
     -- 코드, 주민번호 비교 → NAME, PW 변경
    UPDATE TBL_STUDENT
    SET STD_NAME = V_STD_NAME
      , STD_PW = V_STD_PW
    WHERE STD_CODE =  V_STD_CODE AND (SELECT STD_SSN
                                      FROM TBL_STUDENT
                                      WHERE STD_CODE=V_STD_CODE)=V_STD_SSN;

    -- 커밋
    -- COMMIT;
END;
--==>> Procedure PRC_STUDENT_UPDATE이(가) 컴파일되었습니다.

-- 학생 삭제 프로시저 생성 PRC_STUDENT_UPDATE(학생코드, 학생PW)

CREATE OR REPLACE PROCEDURE PRC_STUDENT_DELETE
(   V_STD_CODE IN TBL_STUDENT.STD_CODE%TYPE      -- 학생코드
,   V_STD_PW   IN TBL_STUDENT.STD_PW%TYPE     -- 학생PW
)
IS
BEGIN
    -- 학생 테이블 DELETE 쿼리문 구성
    DELETE
    FROM TBL_STUDENT
    WHERE STD_CODE = V_STD_CODE AND (SELECT V_STD_PW
                                     FROM TBL_STUDENT
                                     WHERE STD_CODE=V_STD_CODE)=V_STD_PW;
    
    -- 커밋
    -- COMMIT;
END;
--==>> Procedure PRC_STUDENT_DELETE이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------

-----------------------------3. 과정 프로시저------------------------------------

-- ① 과정정보 INSERT
-- 과정이름을 넣으면 코드가 자동적으로 부여
-- 실행 예)
-- EXEC PRC_COURSE_INSERT(과정이름)
CREATE OR REPLACE PROCEDURE PRC_COURSE_INSERT
( V_CRS_NAME    IN TBL_COURSE.CRS_NAME%TYPE )
IS
    -- 주요 변수 선언
    V_CRS_CODE TBL_COURSE.CRS_CODE%TYPE;
BEGIN
    -- 변수 초기화
    V_CRS_CODE := TO_CHAR(SEQ_COURSE.NEXTVAL);
    
    -- 연산 및 처리
    INSERT INTO TBL_COURSE(CRS_CODE, CRS_NAME)
    VALUES(V_CRS_CODE, V_CRS_NAME);
END;
--==>> Procedure PRC_COURSE_INSERT이(가) 컴파일되었습니다.

-- ② 과정정보 UPDATE
-- 실행 예)
-- EXEC PRC_COURSE_UPDATE(과정코드, 수정할과정이름)
CREATE OR REPLACE PROCEDURE PRC_COURSE_UPDATE
( V_CRS_CODE    IN TBL_COURSE.CRS_CODE%TYPE
, V_CRS_NAME    IN TBL_COURSE.CRS_NAME%TYPE
)
IS
BEGIN
    UPDATE TBL_COURSE
    SET CRS_NAME = V_CRS_NAME
    WHERE CRS_CODE = V_CRS_CODE;
END;
--==>> Procedure PRC_COURSE_UPDATE이(가) 컴파일되었습니다.

-- ③ 과정정보 DELETE
-- 실행 예
-- EXEC PRC_COURSE_DELETE(과정코드)
-- 전제: 개강 전에만 과정 삭제 가능함
-- 과정코드가 사라지면.. 과정개설코드가 사라져야하고..
-- 그 안에 있는 과목개설코드(과목시작일, 종료일이 정해져 있기 때문에)가 사라져야 함.
-- 그리고 수강신청코드도 사라져야 함

CREATE OR REPLACE PROCEDURE PRC_COURSE_DELETE
( V_CRS_CODE    IN TBL_COURSE.CRS_CODE%TYPE )
IS
BEGIN
    -- 개설된 과정이 없다면 삭제 
    DELETE
    FROM TBL_COURSE
    WHERE CRS_CODE = V_CRS_CODE;
    
    -- 예외처리
    EXCEPTION
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_COURSE_DELETE이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------

-----------------------------4. 과목 프로시저------------------------------------
-- 과목 입력 프로시저 생성 PRC_SUBJECT_INSERT(과목명)

CREATE OR REPLACE PROCEDURE PRC_SUBJECT_INSERT
( V_SUB_NAME  IN TBL_SUBJECT.SUB_NAME%TYPE
)
IS
    --필요 변수 선언
    V_SUB_CODE  TBL_SUBJECT.SUB_CODE%TYPE;
    
BEGIN
    --V_SUB_CODE 변수 초기화
    V_SUB_CODE := TO_CHAR(SEQ_SUBJECT.NEXTVAL);

    --INSERT 쿼리문 작성
    INSERT INTO TBL_SUBJECT(SUB_CODE,SUB_NAME)
    VALUES(V_SUB_CODE, V_SUB_NAME);
    
    --커밋
    --COMMIT;

END;
--==>> Procedure PRC_SUBJECT_INSERT이(가) 컴파일되었습니다.

-- 과목 업데이트 프로시저 생성 PRC_SUBJECT_UPDATE(과목코드, 변경과목명)
CREATE OR REPLACE PROCEDURE PRC_SUBJECT_UPDATE
( V_SUB_CODE  IN TBL_SUBJECT.SUB_CODE%TYPE
, V_SUB_NAME  IN TBL_SUBJECT.SUB_NAME%TYPE
)
IS  
BEGIN
    --UPDATE 쿼리문 작성
    UPDATE TBL_SUBJECT
    SET SUB_NAME = V_SUB_NAME
    WHERE SUB_CODE = V_SUB_CODE;
    
    --커밋
    --COMMIT;

END;
--==>> Procedure PRC_SUBJECT_UPDATE이(가) 컴파일되었습니다.

-- 과목 삭제 프로시저 생성 PRC_SUBJECT_DELETE(과목코드) => 해당 과목 삭제 시 수강신청이 이미 된..과정의 과목일경우 삭제불가..?(상관없음..)
CREATE OR REPLACE PROCEDURE PRC_SUBJECT_DELETE
( V_SUB_CODE  IN TBL_SUBJECT.SUB_CODE%TYPE
)
IS    
BEGIN
    --DELETE 쿼리문 작성
    DELETE
    FROM TBL_SUBJECT
    WHERE SUB_CODE = V_SUB_CODE;
    
    --커밋
    --COMMIT;    
    
    --예외처리..
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; 

END;
--==>> Procedure PRC_SUBJECT_DELETE이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------

-----------------------------5. 과정개설 프로시저--------------------------------
-- 과정개설 INSERT 프로시저 PRC_OPENC_INSERT(과정코드,강의실코드,과정시작일자,과정종료일자)
CREATE OR REPLACE PROCEDURE PRC_OPENC_INSERT
( V_CRS_CODE    IN TBL_COURSE.CRS_CODE%TYPE
, V_ROOM_CODE   IN TBL_ROOM.ROOM_CODE%TYPE
, V_CRS_START   IN TBL_OPENC.CRS_START%TYPE
, V_CRS_END     IN TBL_OPENC.CRS_END%TYPE
)
IS
    V_OPENC_CODE        TBL_OPENC.OPENC_CODE%TYPE;
    --V_CRS_START_TEMP    TBL_OPENC.CRS_START%TYPE;
    V_CRS_END_TEMP      TBL_OPENC.CRS_END%TYPE;
    USER_DEFINE_ERROR1  EXCEPTION;
    USER_DEFINE_ERROR2  EXCEPTION;
    
    
    -- CURSOR의 선언
    CURSOR CUR_ROOM_CHECK
    IS
    SELECT CRS_END
    FROM TBL_OPENC
    WHERE ROOM_CODE = V_ROOM_CODE;
    
BEGIN
    -- CURSOR 열기
     OPEN CUR_ROOM_CHECK;
    
     LOOP
         FETCH CUR_ROOM_CHECK INTO V_CRS_END_TEMP;
         
         EXIT WHEN CUR_ROOM_CHECK%NOTFOUND;
         
         IF (V_CRS_START <= V_CRS_END_TEMP) --이건가..?
         --기존 강좌종료일자보다 내가 등록할 강좌시작일자가 과거라면
            THEN RAISE USER_DEFINE_ERROR2;
         END IF;
         
     END LOOP;
     
     CLOSE CUR_ROOM_CHECK;

    -- 과정시작일자가 SYSDATE보다 미래이게 
     IF (SYSDATE >= V_CRS_START)
        THEN RAISE USER_DEFINE_ERROR1;
     END IF;
    
    -- V_OPENC_CODE 변수 초기화
    V_OPENC_CODE := TO_CHAR(SEQ_OPENC.NEXTVAL);
    
    INSERT INTO TBL_OPENC(OPENC_CODE, CRS_CODE, ROOM_CODE, CRS_START, CRS_END)
    VALUES (V_OPENC_CODE, V_CRS_CODE, V_ROOM_CODE, V_CRS_START, V_CRS_END);
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR1
            THEN RAISE_APPLICATION_ERROR(-20002, '과정시작일자가 오늘날짜보다 이전입니다.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20003, '현재 강의 진행중인 과정의 강의실입니다.');
            ROLLBACK;
        
    -- 커밋
    --COMMIT;
    
END;
--==>> Procedure PRC_OPENC_INSERT이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------

-----------------------------6. 과목개설 프로시저--------------------------------

-- 기간조건 판별 함수
-- 과정개설코드와 과목시작일자와 과목종료일자를 매개변수로 받는다
CREATE OR REPLACE FUNCTION FN_OPENS_SELECT
(
  V_OPENC_CODE  IN TBL_OPENC.OPENC_CODE%TYPE -- 과정개설코드
, V_SUB_START   IN TBL_OPENS.SUB_START%TYPE  -- 과목시작일자
, V_SUB_END     IN TBL_OPENS.SUB_END%TYPE    -- 과목종료일자
)
RETURN NUMBER
IS
    -- 주요 변수 선언
    V_SUB_START_TEMP    TBL_OPENS.SUB_START%TYPE; -- 과정개설코드가 같은(같은 과정에 속하는) 과목들의 과목시작일자
    V_SUB_END_TEMP      TBL_OPENS.SUB_END%TYPE;   -- 과정개설코드가 같은(같은 과정에 속하는) 과목들의 과목종료일자
    V_RESULT            NUMBER;                   -- 함수를 통해 분기된 결과값
    
    V_CRS_START         TBL_OPENC.CRS_START%TYPE;   -- 과정시작일자
    V_CRS_END           TBL_OPENC.CRS_END%TYPE;     -- 과정종료일자
    
    -- 커서 작성
    CURSOR CUR_OPENS_SELECT
    IS
    SELECT SUB_START, SUB_END                             -- ③해당 과목들의 과목시작일자와, 과목종료일자를 받는다.
    FROM TBL_OPENS
    WHERE OPENS_CODE = (SELECT OPENS_CODE                 -- ② 과목개설코드들을 찾아서
                        FROM TBL_OPENC
                        WHERE OPENC_CODE = V_OPENC_CODE); -- ① 과정개설코드가 같은
BEGIN
    -- V_CRS_START, V_CRS_END 채우기
    SELECT CRS_START, CRS_END INTO V_CRS_START, V_CRS_END   -- 과정시작일과 과정종료일을 따온다.
    FROM TBL_OPENC
    WHERE OPENC_CODE = V_OPENC_CODE;    -- 입력받은 과정개설코드의 
    
    -- 커서 오픈 AND V_SUB_START_TEMP, V_SUB_END_TEMP, V_RESULT 채우기
    OPEN CUR_OPENS_SELECT;
    
    LOOP
        FETCH CUR_OPENS_SELECT INTO V_SUB_START_TEMP, V_SUB_END_TEMP;
        
        --ⓐ 과목시작일자는 SYSDATE 보다 과거이면 안 됨
        IF V_SUB_START < SYSDATE--과목등록일자
        --(과목시작일자가 SYSDATE 전이거나)
        
        --ⓑ 과목 시작일과 과목 종료일은 과정시작일과 과정종료일 사이에 있어야 한다.
        OR V_SUB_END <= V_CRS_START
        -- OR 과목 종료일이 과정시작일 전이다. 과목 시작일은 과목 종료일보다 전이므로, 자연스럽게 과정시작일 보다 과거가 된다.
        OR V_SUB_END > V_CRS_END
        -- OR 과목 종료일이 과정종료일 밖이다. 과목 시작일은 과목 종료일보다 전이므로, 자연스럽게 과정종료일 보다 미래가 된다. 
        
        --ⓒ 과정 내 다른 과목 기간과 겹치지 않아야 함.  
        OR V_SUB_START BETWEEN V_SUB_START_TEMP AND V_SUB_END_TEMP
        -- 등록할 과목의 시작일이 기존과목들 시작일자 와 기존과목들 종료일자 사이에 있거나
        OR V_SUB_END BETWEEN V_SUB_END_TEMP AND V_SUB_END_TEMP
        -- 등록할 과목의 종료일이 기존과목들 시작일자 와 기존과목들 종료일자 사이에 있다면
            THEN V_RESULT := 0; -- UPDATE X
        
        ELSE V_RESULT := 1;     -- UPDATE O
        END IF;
                
        EXIT WHEN CUR_OPENS_SELECT%NOTFOUND;
    END LOOP;

    -- 최종결과값 반환
    RETURN V_RESULT;
END;
--==>> Function FN_OPENS_SELECT이(가) 컴파일되었습니다.


-- ① 과목개설 INSERT
-- 과목시작일자가 SYSDATE < 과목시작일자,  조건 → TRIGGER
-- 과목 정보 입력은 과정명, 과목명, 과목 기간(시작 연월일, 끝 연월일), 교재 명, 교수자 명 정보
-- 실행 예)
-- EXEC PRC_COURSE_UPDATE(과정개설코드, 과목코드, 과목시작일, 과목종료일, 교재코드, 교수자코드)
CREATE OR REPLACE PROCEDURE PRC_OPENS_INSERT
( V_OPENC_CODE  IN TBL_OPENC.OPENC_CODE%TYPE   -- 과정개설코드   -- 기존 등록
, V_SUB_CODE    IN TBL_SUBJECT.SUB_NAME%TYPE    -- 과목코드      -- 기존 등록
, V_SUB_START   IN TBL_OPENS.SUB_START%TYPE     -- 과목시작일
, V_SUB_END     IN TBL_OPENS.SUB_END%TYPE       -- 과목종료일
, V_BOOK_CODE   IN TBL_BOOK.BOOK_CODE%TYPE      -- 교재코드      -- 기존 등록
, V_PROF_CODE   IN TBL_PROFESSOR.PROF_CODE%TYPE -- 교수자코드    -- 얘는 코드가 맞고 
)
IS
    -- 변수    
    V_OPENS_CODE    TBL_OPENS.OPENS_CODE%TYPE;  -- 과목개설코드
    
    V_RESULT            NUMBER;
    
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    -- 과목개설코드
    V_OPENS_CODE := SEQ_OPENS.NEXTVAL;
    -- 함수를 통해 값 따오기
    SELECT FN_OPENS_SELECT(V_OPENC_CODE, V_SUB_START, V_SUB_END) INTO V_RESULT
    FROM DUAL;
    
    -- UPDATE 여부 결정
    IF V_RESULT = 0
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- INSERT 문 작성
    INSERT INTO TBL_OPENS(OPENC_CODE, OPENS_CODE, SUB_CODE, BOOK_CODE, PROF_CODE
                        , SUB_START, SUB_END)
    VALUES(V_OPENC_CODE, V_OPENS_CODE, V_SUB_CODE, V_BOOK_CODE, V_PROF_CODE
         , V_SUB_START, V_SUB_END); -- 출결, 실기, 필기 배점은 NULL 값 들어가도록 생략
         
    -- 예외 캐치
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '기간 설정을 다시 해 주세요~!!!');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_OPENS_INSERT이(가) 컴파일되었습니다.

-- ② 과목개설 UPDATE
-- 과목시작일자가 SYSDATE < 과목시작일자 조건 → TRIGGER
-- 실행 예)
-- EXEC PRC_OPENS_UPDATE(과목개설코드, 과목코드, 과목시작일, 과목종료일, 교재코드, 교수자코드)
-- 과정개설코드 는 변경 불가.
-- *과정개설코드, 과목시작일, 과목종료일은 변경 가능하도록 해야 하는가?
-- 과정개설코드는 복잡해지니까 변경 불가한 것으로 하고, 과목시작일, 종료일, 교재코드, 교수자코드만 변경 가능하도록.
-- 이 경우, ⓐ과목 시작일은 SYSDATE 보다 미래여야 하고, ⓑ과목 시작일과 과목 종료일은 과정시작일과 과정종료일 안이어야 하며,
-- ⓒ다른 과목 기간과 겹치지 않아야 함. 


CREATE OR REPLACE PROCEDURE PRC_OPENS_UPDATE
( V_OPENC_CODE  IN TBL_OPENC.OPENC_CODE%TYPE
, V_OPENS_CODE  IN TBL_OPENS.OPENS_CODE%TYPE
, V_SUB_START   IN TBL_OPENS.SUB_START%TYPE
, V_SUB_END     IN TBL_OPENS.SUB_END%TYPE
, V_BOOK_CODE   IN TBL_BOOK.BOOK_CODE%TYPE
, V_PROF_CODE   IN TBL_PROFESSOR.PROF_CODE%TYPE
)
IS
    V_RESULT            NUMBER;
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    -- 함수를 통해 값 따오기
    SELECT FN_OPENS_SELECT(V_OPENC_CODE, V_SUB_START, V_SUB_END) INTO V_RESULT
    FROM DUAL;
    
    -- UPDATE 여부 결정
    IF V_RESULT = 0
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- UPDATE 문 작성
    UPDATE TBL_OPENS
    SET SUB_START = V_SUB_START, SUB_END = V_SUB_END
      , BOOK_CODE = V_BOOK_CODE, PROF_CODE = V_PROF_CODE 
    WHERE OPENS_CODE = V_OPENS_CODE;
    
    -- 예외 캐치
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '기간 설정을 다시 해 주세요~!!!');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_OPENS_UPDATE이(가) 컴파일되었습니다.

-- ③ 과목개설 DELETE
-- 실행 예)
-- EXEC PRC_OPENS_DELETE(과목개설코드)
-- 과목 삭제는 과정에 영향을 주지 않는다. 교수, 교재, 강의실 ETC.. 수강신청과 학생은 과정에 연결돼 있는 거니까 신경 안 써도 되고.
-- 과목은.. 그냥 ^과목시작일 전에만 삭제 가능^하다고 전제 깔면 아무데도 영향 안 끼치고 얘만 삭제 가능
CREATE OR REPLACE PROCEDURE PRC_OPENS_DELETE
( V_OPENS_CODE  IN TBL_OPENS.OPENS_CODE%TYPE )
IS
BEGIN
    -- DELETE 문 작성
    DELETE
    FROM TBL_OPENS
    WHERE OPENS_CODE = V_OPENS_CODE;
END;
--==>> Procedure PRC_OPENS_DELETE이(가) 컴파일되었습니다.
--------------------------------------------------------------------------------

-----------------------------7. 강의실 프로시저----------------------------------

-- 강의실 입력 프로시저 생성 PRC_ROOM_INSERT(강의실이름, 수용인원)
CREATE OR REPLACE PROCEDURE PRC_ROOM_INSERT
(   V_ROOM_NAME IN TBL_ROOM.ROOM_NAME%TYPE   -- 강의실 이름
,   V_ROOM_NUM  IN TBL_ROOM.ROOM_NUM%TYPE    -- 강의실 수용인원
)
IS
    V_ROOM_CODE TBL_ROOM.ROOM_CODE%TYPE;   -- 생성된 코드를 담을 변수
BEGIN
    -- 강의실 코드 생성
    V_ROOM_CODE := TO_CHAR(SEQ_ROOM.NEXTVAL);
    
    -- 강의실 테이블 INSERT 쿼리문 구성
    INSERT INTO TBL_ROOM(ROOM_CODE, ROOM_NAME, ROOM_NUM)
    VALUES(V_ROOM_CODE, V_ROOM_NAME, V_ROOM_NUM);
    
    -- 커밋
    -- COMMIT;
END;
--==>> Procedure PRC_ROOM_INSERT이(가) 컴파일되었습니다.


-- 강의실 업데이트 프로시저 생성 PRC_ROOM_UPDATE(강의실코드, NEW강의실이름, NEW수용인원)
CREATE OR REPLACE PROCEDURE PRC_ROOM_UPDATE
(   V_ROOM_CODE IN TBL_ROOM.ROOM_CODE%TYPE      -- 강의실 코드
,   V_ROOM_NAME IN TBL_ROOM.ROOM_NAME%TYPE   -- 강의실 이름
,   V_ROOM_NUM  IN TBL_ROOM.ROOM_NUM%TYPE    -- 강의실 수용인원
)
IS
BEGIN
    -- 강의실 테이블 UPDATE 쿼리문 구성
    UPDATE TBL_ROOM
    SET ROOM_NAME = V_ROOM_NAME
      , ROOM_NUM = V_ROOM_NUM
    WHERE ROOM_CODE = V_ROOM_CODE;
    
    -- 커밋
    -- COMMIT;
END;
--==>> Procedure PRC_ROOM_UPDATE이(가) 컴파일되었습니다.

-- 강의실 삭제 프로시저 생성 PRC_ROOM_DELETE(강의실코드)
CREATE OR REPLACE PROCEDURE PRC_STUDENT_DELETE
(   V_ROOM_CODE IN TBL_ROOM.ROOM_CODE%TYPE      -- 강의실코드
)
IS
BEGIN
    -- 강의실 테이블 DELETE 쿼리문 구성
    DELETE
    FROM TBL_ROOM
    WHERE ROOM_CODE = V_ROOM_CODE;
    
    -- 커밋
    -- COMMIT;
END;
--==>> Procedure PRC_STUDENT_DELETE이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------

-----------------------------8. 교재 프로시저------------------------------------

-- 교재 입력 PRC_BOOK_INSERT(교재이름)

CREATE OR REPLACE PROCEDURE PRC_BOOK_INSERT
(
   V_BOOK_NAME   IN TBL_BOOK.BOOK_NAME%TYPE 
)
IS   
    V_BOOK_CODE TBL_BOOK.BOOK_CODE%TYPE ;
BEGIN
    -- 교재코드 
    V_BOOK_CODE := TO_CHAR(SEQ_BOOK.NEXTVAL);
    
    -- INSERT 쿼리문 
    INSERT INTO TBL_BOOK(BOOK_CODE, BOOK_NAME)
    VALUES(V_BOOK_CODE, V_BOOK_NAME);
    
    --커밋
    --COMMIT;

      --예외 처리
      EXCEPTION
        WHEN OTHERS 
            THEN ROLLBACK;    
END;
--==>> Procedure PRC_BOOK_INSERT이(가) 컴파일되었습니다.


-- 교재 수정 PRC_BOOK_UPDATE(교재코드,NEW교재이름)

CREATE OR REPLACE PROCEDURE PRC_BOOK_UPDATE
(
    V_BOOK_CODE     IN TBL_BOOK.BOOK_CODE%TYPE    
,   V_BOOK_NAME     IN TBL_BOOK.BOOK_NAME%TYPE
)
IS
BEGIN

    --UPDATE 쿼리문
    UPDATE TBL_BOOK
    SET BOOK_NAME = V_BOOK_NAME
    WHERE BOOK_CODE = V_BOOK_CODE;
    
    --커밋
    --COMMIT;
    
      --예외 처리
      EXCEPTION
        WHEN OTHERS 
            THEN ROLLBACK;    
END;
--==>> Procedure PRC_BOOK_UPDATE이(가) 컴파일되었습니다.

-- 교재 삭제 PRC_BOOK_DELETE(교재코드)

CREATE OR REPLACE PROCEDURE PRC_BOOK_DELETE
(
    V_BOOK_CODE     IN TBL_BOOK.BOOK_CODE%TYPE 
)
IS
BEGIN

    DELETE
    FROM TBL_BOOK
    WHERE BOOK_CODE = V_BOOK_CODE;

      --커밋
      --COMMIT;

      --예외 처리
      EXCEPTION
        WHEN OTHERS 
            THEN ROLLBACK;
END;
--==>> Procedure PRC_BOOK_DELETE이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------

-----------------------------9. 중도탈락 프로시저--------------------------------

-- 중도탈락 입력 프로시저 생성 PRC_FAIL_INSERT(수강신청코드,중도탈락일자,중도탈락사유)
CREATE OR REPLACE PROCEDURE PRC_FAIL_INSERT
( V_REGISTER_CODE  IN TBL_FAIL.REGISTER_CODE%TYPE
, V_FAIL_DATE      IN TBL_FAIL.FAIL_DATE%TYPE
, V_FAIL_REASON    IN TBL_FAIL.FAIL_REASON%TYPE
)
IS    
BEGIN
    --INSERT 쿼리문 작성
    INSERT INTO TBL_FAIL(REGISTER_CODE, FAIL_DATE, FAIL_REASON)
    VALUES(V_REGISTER_CODE, V_FAIL_DATE, V_FAIL_REASON);
    
    --커밋
    --COMMIT;

END;
--==>> Procedure PRC_FAIL_INSERT이(가) 컴파일되었습니다.

-- 중도탈락 수정 프로시저 생성 PRC_FAIL_UPDATE(기존수강신청코드, NEW수강신청코드, NEW중도탈락일자, NEW중도탈락사유)
CREATE OR REPLACE PROCEDURE PRC_FAIL_UPDATE
( V_OLD_REGISTER_CODE  IN TBL_FAIL.REGISTER_CODE%TYPE
, V_REGISTER_CODE  IN TBL_FAIL.REGISTER_CODE%TYPE
, V_FAIL_DATE      IN TBL_FAIL.FAIL_DATE%TYPE
, V_FAIL_REASON    IN TBL_FAIL.FAIL_REASON%TYPE
)
IS    
BEGIN
    --UPDATE 쿼리문 작성
    UPDATE TBL_FAIL
    SET REGISTER_CODE = V_REGISTER_CODE
      , FAIL_DATE     = V_FAIL_DATE
      , FAIL_REASON   = V_FAIL_REASON
    WHERE REGISTER_CODE = V_OLD_REGISTER_CODE;
    
    --커밋
    --COMMIT;

END;
--==>> Procedure PRC_FAIL_UPDATE이(가) 컴파일되었습니다

-- 중도탈락 삭제 프로시저 생성 PRC_FAIL_DELETE(수강신청코드)
CREATE OR REPLACE PROCEDURE PRC_FAIL_DELETE
( V_REGISTER_CODE  IN TBL_FAIL.REGISTER_CODE%TYPE
)
IS    
BEGIN
    --DELETE 쿼리문 작성
    DELETE
    FROM TBL_FAIL
    WHERE REGISTER_CODE = V_REGISTER_CODE;
    
    --커밋
    --COMMIT;

END;
--==>> Procedure PRC_FAIL_DELETE이(가) 컴파일되었습니다.
--------------------------------------------------------------------------------

-----------------------------10. 성적 프로시저-----------------------------------

-- 성적 업데이트 프로시저 생성 PRC_SCORE_UPDATE(수강신청코드, 과목개설코드, 출결, 실기, 필기)

CREATE OR REPLACE PROCEDURE PRC_SCORE_UPDATE
(   V_REGISTER_CODE IN TBL_REGISTER.REGISTER_CODE%TYPE   -- 수강신청코드
,   V_OPENS_CODE    IN TBL_OPENS.OPENS_CODE%TYPE         -- 과목개설코드
,   V_C_SCORE       IN TBL_SCORE.C_SCORE%TYPE
,   V_S_SCORE       IN TBL_SCORE.S_SCORE%TYPE
,   V_P_SCORE       IN TBL_SCORE.P_SCORE%TYPE
)
IS
    V_C_PERCENT TBL_OPENS.C_PERCENT%TYPE;
    V_S_PERCENT TBL_OPENS.S_PERCENT%TYPE;
    V_P_PERCENT TBL_OPENS.P_PERCENT%TYPE;
    
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    -- 비교할 배점 담아오기(과목개설 코드가 동일한 배점 가져오기)
    SELECT C_PERCENT, S_PERCENT, P_PERCENT INTO V_C_PERCENT, V_S_PERCENT, V_P_PERCENT
    FROM TBL_OPENS
    WHERE OPENS_CODE = V_OPENS_CODE;
    
    -- 입력한 점수가 0보다 작거나 설정되어있는 배점보다 클 경우 예외 발생
    IF ((V_C_SCORE < 0) OR (V_C_SCORE > V_C_PERCENT) OR (V_S_SCORE < 0) OR (V_S_SCORE > V_S_PERCENT) OR (V_P_SCORE < 0) OR (V_P_SCORE > V_P_PERCENT))
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 성적 테이블 UPDATE 쿼리문 구성
    UPDATE TBL_SCORE
    SET C_SCORE = V_C_SCORE
      , S_SCORE = V_S_SCORE
      , P_SCORE = V_P_SCORE
    WHERE REGISTER_CODE = V_REGISTER_CODE
      AND OPENS_CODE = V_OPENS_CODE; 
    
    -- 커밋
    -- COMMIT;
    
    -- 예외 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20200, '점수를 다시 입력해주세요.(0미만, 배점 초과 불가)');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_SCORE_UPDATE이(가) 컴파일되었습니다.

-- 성적 삭제(다시 NULL 값으로) 프로시저 생성 PRC_SCORE_DELETE()
CREATE OR REPLACE PROCEDURE PRC_SCORE_DELETE
(   V_REGISTER_CODE IN TBL_REGISTER.REGISTER_CODE%TYPE   -- 수강신청코드
,   V_OPENS_CODE    IN TBL_OPENS.OPENS_CODE%TYPE         -- 과목개설코드
)
IS
BEGIN
    -- 성적 테이블 DELETE 쿼리문 구성
    UPDATE TBL_SCORE
    SET C_SCORE = ''
      , S_SCORE = ''
      , P_SCORE = ''
    WHERE REGISTER_CODE = V_REGISTER_CODE
      AND OPENS_CODE = V_OPENS_CODE; 
    
    -- 커밋
    -- COMMIT;
END;
--==>> Procedure PRC_SCORE_DELETE이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------

-----------------------------11. 배점 프로시저-----------------------------------

-- 배점 UPDATE 프로시저 PRC_PERCENT_UPDATE(과목개설코드)

CREATE OR REPLACE PROCEDURE PRC_PERCENT_UPDATE
(
    V_OPENS_CODE    IN TBL_OPENS.OPENS_CODE%TYPE
,   V_C_PERCENT     IN TBL_OPENS.C_PERCENT%TYPE         -- 출결
,   V_S_PERCENT     IN TBL_OPENS.S_PERCENT%TYPE         -- 실기
,   V_P_PERCENT     IN TBL_OPENS.P_PERCENT%TYPE         -- 필기
)
IS
BEGIN        
    -- 배점 테이블 UPDATE 쿼리문 구성
    UPDATE TBL_OPENS
    SET C_PERCENT = V_C_PERCENT
       ,S_PERCENT = V_S_PERCENT
       ,P_PERCENT = V_P_PERCENT
    WHERE OPENS_CODE =V_OPENS_CODE;
        
      --예외 처리
      EXCEPTION
        WHEN OTHERS 
            THEN ROLLBACK;
END;
--==>> Procedure PRC_PERCENT_UPDATE이(가) 컴파일되었습니다.

-- 배점 DELETE PRC_PERCENT_DELETE(과목개설코드)

CREATE OR REPLACE PROCEDURE PRC_PERCENT_DELETE
( 
   V_OPENS_CODE    IN TBL_OPENS.OPENS_CODE%TYPE
)
IS
BEGIN
    
    UPDATE TBL_OPENS
    SET C_PERCENT = ''
       ,S_PERCENT = ''
       ,P_PERCENT = ''
    WHERE OPENS_CODE =V_OPENS_CODE;       

      --예외 처리
      EXCEPTION
        WHEN OTHERS 
            THEN ROLLBACK;
END;
--==>> Procedure PRC_PERCENT_DELETE이(가) 컴파일되었습니다.
--------------------------------------------------------------------------------

-----------------------------12. 수강신청 프로시저-------------------------------
-- 수강신청 입력 프로시저 생성 PRC_REGISTER_INSERT(과정개설코드, 학생코드) 
-- 수강신청일자는 DEFAULT 값으로..
-- 수강신청일자(SYSDATE) < 과정시작일자 => 수강신청 VIEW 자체에서 이미 해당 조건으로만 보일 수 있게 설정하면, 
-- 프로시저에서 거르지않아도 된다고 생각하여, 따로 예외처리 하지 않았음.
CREATE OR REPLACE PROCEDURE PRC_REGISTER_INSERT
( V_OPENC_CODE  IN TBL_OPENC.OPENC_CODE%TYPE
, V_STD_CODE    IN TBL_STUDENT.STD_CODE%TYPE
)
IS
    --필요변수선언
    V_REGISTER_CODE TBL_REGISTER.REGISTER_CODE%TYPE;
BEGIN
    --변수 초기화
    V_REGISTER_CODE := TO_CHAR(SEQ_REGISTER.NEXTVAL);
    
    --INSERT 쿼리문 작성
    INSERT INTO TBL_REGISTER(REGISTER_CODE, OPENC_CODE, STD_CODE)
    VALUES(V_REGISTER_CODE, V_OPENC_CODE, V_STD_CODE);
    
    --커밋
    --COMMIT;

END;
--==>>  Procedure PRC_REGISTER_INSERT이(가) 컴파일되었습니다.

-- 수강신청 수정 프로시저 생성 PRC_REGISTER_UPDATE(수강신청코드, NEW과정개설코드, NEW학생코드) -- 수강신청코드와 수강신청일자는 변경되지않아야함..
CREATE OR REPLACE PROCEDURE PRC_REGISTER_UPDATE
( V_REGISTER_CODE IN TBL_REGISTER.REGISTER_CODE%TYPE
, V_OPENC_CODE    IN TBL_OPENC.OPENC_CODE%TYPE
, V_STD_CODE      IN TBL_STUDENT.STD_CODE%TYPE
)
IS
BEGIN
    --UPDATE 쿼리문 작성
    UPDATE TBL_REGISTER
    SET OPENC_CODE = V_OPENC_CODE
      , STD_CODE = V_STD_CODE
    WHERE REGISTER_CODE = V_REGISTER_CODE;
    
    --커밋
    --COMMIT;

END;
--==>> Procedure PRC_REGISTER_UPDATE이(가) 컴파일되었습니다.

-- 수강신청 삭제 프로시저 생성 PRC_REGISTER_DELETE(수강신청코드)--**중도탈락기록이 있는 수강신청코드의 경우.. 수강신청삭제 불가.
CREATE OR REPLACE PROCEDURE PRC_REGISTER_DELETE
( V_REGISTER_CODE IN TBL_REGISTER.REGISTER_CODE%TYPE
)
IS
BEGIN
    --DELETE 쿼리문 작성
    DELETE 
    FROM TBL_REGISTER
    WHERE REGISTER_CODE = V_REGISTER_CODE;
    
    --커밋
    --COMMIT;
    
    --예외처리..
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;  

END;
--==>> Procedure PRC_REGISTER_DELETE이(가) 컴파일되었습니다.

--------------------------------------------------------------------------------

-----------------------------13. 관리자 프로시저---------------------------------

-- 관리자정보 업데이트 프로시저 PRC_ADMIN_UPDATE(기존CODE, NEW CODE, 기존 PW, NEW PW)

CREATE OR REPLACE PROCEDURE PRC_ADMIN_UPDATE
(   
    V_OLD_CODE   IN TBL_ADMIN.ADMIN_CODE%TYPE            
   ,V_NEW_CODE   IN TBL_ADMIN.ADMIN_CODE%TYPE  
   ,V_OLD_PW   IN TBL_ADMIN.ADMIN_PW%TYPE 
   ,V_NEW_PW   IN TBL_ADMIN.ADMIN_PW%TYPE
)
IS
BEGIN
    
    -- UPDATE 쿼리문
    UPDATE TBL_ADMIN
    SET ADMIN_CODE = V_NEW_CODE, ADMIN_PW = V_NEW_PW 
    WHERE ADMIN_CODE = V_OLD_CODE AND (SELECT ADMIN_PW
                                       FROM TBL_ADMIN
                                       WHERE ADMIN_CODE=V_OLD_CODE)=V_OLD_PW;
    -- 커밋
    -- COMMIT;
    
    --예외 처리
      EXCEPTION
        WHEN OTHERS 
            THEN ROLLBACK;
    
END;
--==>> Procedure PRC_ADMIN_UPDATE이(가) 컴파일되었습니다.
--------------------------------------------------------------------------------




-- ① 교수자 계정 관리 기능 구현한 뷰 
-- 교수명, 배정된과목명, 기간, 교재명, 강의실, 강의진행여부 조회 
CREATE OR REPLACE VIEW VIEW_PROFESSORS
AS
SELECT TP.PROF_NAME "교수명", TS.SUB_NAME "과목명", TOS.SUB_START "과목시작일", TOS.SUB_END "과목종료일"
     , TB.BOOK_NAME"교재명", TR.ROOM_NAME"강의실"
     , CASE WHEN SYSDATE BETWEEN TOS.SUB_START AND TOS.SUB_END THEN '강의진행중' 
             WHEN SYSDATE < TOS.SUB_START THEN '강의예정'
             ELSE '강의완료' END "강의진행여부"
FROM TBL_PROFESSOR TP, TBL_SUBJECT TS, TBL_OPENS TOS, TBL_BOOK TB, TBL_ROOM TR, TBL_OPENC TOC, TBL_COURSE TC
WHERE TOS.PROF_CODE = TP.PROF_CODE(+)
  AND TOS.SUB_CODE = TS.SUB_CODE(+)
  AND TOS.BOOK_CODE = TB.BOOK_CODE(+)
  AND TOC.CRS_CODE = TC.CRS_CODE(+)
  AND TOS.OPENC_CODE = TOC.OPENC_CODE(+)
  AND TOC.ROOM_CODE = TR.ROOM_CODE(+);
  
SELECT *
FROM VIEW_PROFESSORS;
--가능

-- ② 관리자 과정 출력 뷰 생성
-- 과정명, 강의실, 과목명, 과목 기간(시간일, 종료일), 교재명, 교수명
CREATE OR REPLACE VIEW VIEW_COURSE
AS
SELECT TC.CRS_NAME "과정명", TR.ROOM_NAME "강의실", TS.SUB_NAME "과목명", TOS.SUB_START "과목시작일자"
     , TOS.SUB_END "과목종료일자", TB.BOOK_NAME "교재명", TP.PROF_NAME "교수명"
FROM TBL_COURSE TC, TBL_ROOM TR, TBL_SUBJECT TS, TBL_OPENS TOS, TBL_BOOK TB, TBL_PROFESSOR TP, TBL_OPENC TOC
WHERE TOS.OPENC_CODE = TOC.OPENC_CODE(+)
  AND TOC.ROOM_CODE = TR.ROOM_CODE(+)
  AND TOS.SUB_CODE = TS.SUB_CODE(+)
  AND TOC.CRS_CODE = TC.CRS_CODE(+)
  AND TOS.BOOK_CODE = TB.BOOK_CODE(+)
  AND TOS.PROF_CODE = TP.PROF_CODE(+);

SELECT *
FROM VIEW_COURSE;
--가능






