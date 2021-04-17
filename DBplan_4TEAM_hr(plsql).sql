SELECT USER
FROM DUAL;
--==>> HR

------------------------------������ ����----------------------------------------

-- �����ڵ� SEQUENCE
CREATE SEQUENCE SEQ_PROFESSOR
START WITH 1001 
INCREMENT BY 1
MAXVALUE 9999
NOCACHE;
--==>> Sequence SEQ_PROFESSOR��(��) �����Ǿ����ϴ�.


-- �л��ڵ� SEQUENCE
CREATE SEQUENCE SEQ_STUDENT
START WITH 1001
INCREMENT BY 1
MAXVALUE 9999
NOCACHE;
--==>> Sequence SEQ_STUDENT��(��) �����Ǿ����ϴ�.

-- �����ڵ� SEQUENCE
CREATE SEQUENCE SEQ_COURSE
START WITH 1000
INCREMENT BY 1
MAXVALUE 1999
NOCACHE;
--==>> Sequence SEQ_COURSE��(��) �����Ǿ����ϴ�.

-- �����ڵ� SEQUENCE
CREATE SEQUENCE SEQ_SUBJECT
START WITH 2000
INCREMENT BY 1
MAXVALUE 2999
NOCACHE;
--==>> Sequence SEQ_SUBJECT��(��) �����Ǿ����ϴ�.

-- ���ǽ��ڵ� SEQUENCE
CREATE SEQUENCE SEQ_ROOM
START WITH 3000
INCREMENT BY 1
MAXVALUE 3999
NOCACHE;
--==>> Sequence SEQ_ROOM��(��) �����Ǿ����ϴ�.

-- �����ڵ� SEQUENCE
CREATE SEQUENCE SEQ_BOOK
START WITH 4000
INCREMENT BY 1
MAXVALUE 4999
NOCACHE;
--==>> Sequence SEQ_BOOK��(��) �����Ǿ����ϴ�.

-- ���������ڵ� SEQUENCE
CREATE SEQUENCE SEQ_OPENC
START WITH 10000
INCREMENT BY 1
MAXVALUE 19999
NOCACHE;
--==>> Sequence SEQ_OPENC��(��) �����Ǿ����ϴ�.

-- ���񰳼��ڵ� SEQUENCE
CREATE SEQUENCE SEQ_OPENS
START WITH 20000
INCREMENT BY 1
MAXVALUE 29999
NOCACHE;
--==>> Sequence SEQ_OPENS��(��) �����Ǿ����ϴ�.

-- ������û�ڵ� SEQUENCE
CREATE SEQUENCE SEQ_REGISTER
START WITH 30000
INCREMENT BY 1
MAXVALUE 39999
NOCACHE;
--==>> Sequence SEQ_REGISTER��(��) �����Ǿ����ϴ�.

---------------------------------������ ���� ��----------------------------------

-------------------------------0. �α��� ���ν���--------------------------------

-- �α��� ���ν���(������) PRC_LOGIN_ADMIN(ADMIN_CODE,ADMIN_PW)

CREATE OR REPLACE PROCEDURE PRC_LOGIN_ADMIN
( V_ADMIN_CODE  IN TBL_ADMIN.ADMIN_CODE%TYPE
, V_ADMIN_PW    IN TBL_ADMIN.ADMIN_PW%TYPE
)
IS
    -- ��������
    V_ORI_ADMIN_PW  TBL_ADMIN.ADMIN_PW%TYPE;    --�Է¹��� ADMIN_CODE�� �ش��ϴ� ��ȿ�� PW.
    
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    SELECT ADMIN_PW INTO V_ORI_ADMIN_PW
    FROM TBL_ADMIN
    WHERE ADMIN_CODE = V_ADMIN_CODE;
    
    
    IF ( V_ORI_ADMIN_PW != V_ADMIN_PW )
        THEN RAISE USER_DEFINE_ERROR;
    ELSE
        DBMS_OUTPUT.PUT_LINE('������ �������� �α��εǾ����ϴ�.');
    END IF;
       
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20100, '���̵� �Ǵ� �н����带 �߸� �Է��Ͽ����ϴ�.');
            ROLLBACK;
        WHEN OTHERS
            THEN RAISE_APPLICATION_ERROR(-20100, '���̵� �Ǵ� �н����带 �߸� �Է��Ͽ����ϴ�.');
            ROLLBACK;
    
    --Ŀ��
    --COMMIT;
    
END;
--==>> Procedure PRC_LOGIN_ADMIN��(��) �����ϵǾ����ϴ�.

-- �α��� ���ν��� (����) PRC_LOGIN_PROFESSOR(PROF_CODE,PROF_PW)
CREATE OR REPLACE PROCEDURE PRC_LOGIN_PROFESSOR
( V_PROF_CODE   IN TBL_PROFESSOR.PROF_CODE%TYPE
, V_PROF_PW     IN TBL_PROFESSOR.PROF_PW%TYPE
)
IS
    --��������
    V_ORI_PROF_PW   TBL_PROFESSOR.PROF_PW%TYPE;    --�Է¹��� PROF_CODE�� �ش��ϴ� ��ȿ�� PW.
    
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    SELECT PROF_PW INTO V_ORI_PROF_PW
    FROM TBL_PROFESSOR
    WHERE PROF_CODE = V_PROF_CODE;

    IF ( V_ORI_PROF_PW != V_PROF_PW )
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('���� �������� �α��εǾ����ϴ�.');
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20100, '���̵� �Ǵ� �н����带 �߸� �Է��Ͽ����ϴ�.');
            ROLLBACK;
        WHEN OTHERS
            THEN RAISE_APPLICATION_ERROR(-20100, '���̵� �Ǵ� �н����带 �߸� �Է��Ͽ����ϴ�.');
            ROLLBACK;
    
    --Ŀ��
    --COMMIT;
    
END;
--==>> Procedure PRC_LOGIN_PROFESSOR��(��) �����ϵǾ����ϴ�.

-- �α��� ���ν��� (�л�) PRC_LOGIN_STUDENT(STD_CODE,STD_PW)
CREATE OR REPLACE PROCEDURE PRC_LOGIN_STUDENT
( V_STD_CODE    IN TBL_STUDENT.STD_CODE%TYPE
, V_STD_PW      IN TBL_STUDENT.STD_PW%TYPE
)
IS
    --��������
    V_ORI_STD_PW    TBL_STUDENT.STD_PW%TYPE;    --�Է¹��� STD_CODE�� �ش��ϴ� ��ȿ�� PW.
    
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    SELECT STD_PW INTO V_ORI_STD_PW
    FROM TBL_STUDENT
    WHERE STD_CODE = V_STD_CODE;
    
    IF ( V_ORI_STD_PW != V_STD_PW )
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('�л� �������� �α��εǾ����ϴ�.');
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20100, '���̵� �Ǵ� �н����带 �߸� �Է��Ͽ����ϴ�.');
            ROLLBACK;   
        WHEN OTHERS
            THEN RAISE_APPLICATION_ERROR(-20100, '���̵� �Ǵ� �н����带 �߸� �Է��Ͽ����ϴ�.');
            ROLLBACK;
    
    --Ŀ��
    --COMMIT;
    
END;
--==>> Procedure PRC_LOGIN_STUDENT��(��) �����ϵǾ����ϴ�.

-----------------------------1. ���� ���ν���------------------------------------

-- ���� INSERT ���ν��� PRC_PROFESSOR_INSERT(PROF_NAME,PROF_SSN)

CREATE OR REPLACE PROCEDURE PRC_PROFESSOR_INSERT
(   
    V_PROF_NAME  IN TBL_PROFESSOR.PROF_NAME%TYPE            --�̸�
   ,V_PROF_SSN   IN TBL_PROFESSOR.PROF_SSN%TYPE             --�ֹι�ȣ���ڸ�   
)
IS
    V_PROF_CODE   TBL_PROFESSOR.PROF_CODE%TYPE;             -- �ڵ�

BEGIN
    -- ���� �ڵ�(������)
    V_PROF_CODE := CONCAT('P' , TO_CHAR(SEQ_PROFESSOR.NEXTVAL));   
    
    -- INSERT ������
    INSERT INTO TBL_PROFESSOR(PROF_CODE, PROF_NAME, PROF_SSN, PROF_PW)
    VALUES(V_PROF_CODE, V_PROF_NAME, V_PROF_SSN, V_PROF_SSN);
    
    -- Ŀ��
    -- COMMIT;
    
    --���� ó��
      EXCEPTION
        WHEN OTHERS 
            THEN ROLLBACK;
    
END;
--==>> Procedure PRC_PROFESSOR_INSERT��(��) �����ϵǾ����ϴ�


-- ���� UPDATE ���ν��� PRC_PROFESSOR_UPDATE(�ڵ�, �ٲ��̸�, �ֹι�ȣ, �ٲ�PW)
CREATE OR REPLACE PROCEDURE PRC_PROFESSOR_UPDATE
(
     V_PROF_CODE    IN TBL_PROFESSOR.PROF_CODE%TYPE 
    ,V_PROF_NAME    IN TBL_PROFESSOR.PROF_NAME%TYPE     -- �ٲ��̸�
    ,V_PROF_SSN     IN TBL_PROFESSOR.PROF_SSN%TYPE 
    ,V_PROF_PW      IN TBL_PROFESSOR.PROF_PW%TYPE       -- �ٲ�PW
)
IS
    
BEGIN
    -- �ڵ�, �ֹι�ȣ �� �� NAME, PW ����
    UPDATE TBL_PROFESSOR
    SET PROF_NAME = V_PROF_NAME, PROF_PW = V_PROF_PW 
    WHERE PROF_CODE = V_PROF_CODE AND (SELECT PROF_SSN
                                       FROM TBL_PROFESSOR
                                       WHERE PROF_CODE=V_PROF_CODE)=V_PROF_SSN;
    
    --Ŀ��
    --COMMIT;
    
    
    --���� ó��
      EXCEPTION
        WHEN OTHERS 
            THEN ROLLBACK;                                   
END;
--==>> Procedure PRC_PROFESSOR_UPDATE��(��) �����ϵǾ����ϴ�.


-- ���� DELETE ���ν��� PRC_PROFESSOR_DELETE(PROF_CODE,PROF_PW)

CREATE OR REPLACE PROCEDURE PRC_PROFESSOR_DELETE
(
     V_PROF_CODE    IN TBL_PROFESSOR.PROF_CODE%TYPE
    ,V_PROF_PW      IN TBL_PROFESSOR.PROF_PW%TYPE 
)
IS
BEGIN
    
    -- CODE, PW ������ �ش�Ǵ� �� ���� 
    DELETE
    FROM TBL_PROFESSOR
    WHERE PROF_CODE = V_PROF_CODE AND (SELECT PROF_PW
                                       FROM TBL_PROFESSOR
                                       WHERE PROF_CODE=V_PROF_CODE)=V_PROF_PW;
        
      -- Ŀ��
      -- COMMIT;
      
      
      --���� ó��
      EXCEPTION
        WHEN OTHERS 
            THEN ROLLBACK;
    
         
END;
--==>> Procedure PRC_PROFESSOR_DELETE��(��) �����ϵǾ����ϴ�.


-----------------------------2. �л� ���ν���------------------------------------

-- �л� �Է� ���ν��� ���� PRC_STUDENT_INSERT(�̸�, �ֹι�ȣ���ڸ�)
CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
(   V_STD_NAME IN TBL_STUDENT.STD_NAME%TYPE   -- �л��̸�
,   V_STD_SSN  IN TBL_STUDENT.STD_SSN%TYPE    -- �ֹι�ȣ���ڸ�
)
IS
    V_STD_CODE TBL_STUDENT.STD_CODE%TYPE;     -- ������ �ڵ带 ���� ����

BEGIN
    -- �л� �ڵ� ����
    V_STD_CODE := 'S' || TO_CHAR(SEQ_STUDENT.NEXTVAL);
    
    -- �л� ���̺� INSERT ������ ����
    INSERT INTO TBL_STUDENT(STD_CODE, STD_NAME, STD_SSN, STD_PW)
    VALUES(V_STD_CODE, V_STD_NAME, V_STD_SSN, V_STD_SSN);
    
    -- Ŀ��
    -- COMMIT;
END;
--==>> Procedure PRC_STUDENT_INSERT��(��) �����ϵǾ����ϴ�.

-- �л� ������Ʈ ���ν��� ���� PRC_STUDENT_UPDATE(�л��ڵ�, �̸�, �ֹι�ȣ���ڸ�, �л�PW)

CREATE OR REPLACE PROCEDURE PRC_STUDENT_UPDATE
(   V_STD_CODE IN TBL_STUDENT.STD_CODE%TYPE
,   V_STD_NAME IN TBL_STUDENT.STD_NAME%TYPE   -- �ٲ��̸�
,   V_STD_SSN  IN TBL_STUDENT.STD_SSN%TYPE
,   V_STD_PW   IN TBL_STUDENT.STD_PW%TYPE     -- �ٲ�PW
)
IS
BEGIN
     -- �ڵ�, �ֹι�ȣ �� �� NAME, PW ����
    UPDATE TBL_STUDENT
    SET STD_NAME = V_STD_NAME
      , STD_PW = V_STD_PW
    WHERE STD_CODE =  V_STD_CODE AND (SELECT STD_SSN
                                      FROM TBL_STUDENT
                                      WHERE STD_CODE=V_STD_CODE)=V_STD_SSN;

    -- Ŀ��
    -- COMMIT;
END;
--==>> Procedure PRC_STUDENT_UPDATE��(��) �����ϵǾ����ϴ�.

-- �л� ���� ���ν��� ���� PRC_STUDENT_UPDATE(�л��ڵ�, �л�PW)

CREATE OR REPLACE PROCEDURE PRC_STUDENT_DELETE
(   V_STD_CODE IN TBL_STUDENT.STD_CODE%TYPE      -- �л��ڵ�
,   V_STD_PW   IN TBL_STUDENT.STD_PW%TYPE     -- �л�PW
)
IS
BEGIN
    -- �л� ���̺� DELETE ������ ����
    DELETE
    FROM TBL_STUDENT
    WHERE STD_CODE = V_STD_CODE AND (SELECT V_STD_PW
                                     FROM TBL_STUDENT
                                     WHERE STD_CODE=V_STD_CODE)=V_STD_PW;
    
    -- Ŀ��
    -- COMMIT;
END;
--==>> Procedure PRC_STUDENT_DELETE��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

-----------------------------3. ���� ���ν���------------------------------------

-- �� �������� INSERT
-- �����̸��� ������ �ڵ尡 �ڵ������� �ο�
-- ���� ��)
-- EXEC PRC_COURSE_INSERT(�����̸�)
CREATE OR REPLACE PROCEDURE PRC_COURSE_INSERT
( V_CRS_NAME    IN TBL_COURSE.CRS_NAME%TYPE )
IS
    -- �ֿ� ���� ����
    V_CRS_CODE TBL_COURSE.CRS_CODE%TYPE;
BEGIN
    -- ���� �ʱ�ȭ
    V_CRS_CODE := TO_CHAR(SEQ_COURSE.NEXTVAL);
    
    -- ���� �� ó��
    INSERT INTO TBL_COURSE(CRS_CODE, CRS_NAME)
    VALUES(V_CRS_CODE, V_CRS_NAME);
END;
--==>> Procedure PRC_COURSE_INSERT��(��) �����ϵǾ����ϴ�.

-- �� �������� UPDATE
-- ���� ��)
-- EXEC PRC_COURSE_UPDATE(�����ڵ�, �����Ұ����̸�)
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
--==>> Procedure PRC_COURSE_UPDATE��(��) �����ϵǾ����ϴ�.

-- �� �������� DELETE
-- ���� ��
-- EXEC PRC_COURSE_DELETE(�����ڵ�)
-- ����: ���� ������ ���� ���� ������
-- �����ڵ尡 �������.. ���������ڵ尡 ��������ϰ�..
-- �� �ȿ� �ִ� ���񰳼��ڵ�(���������, �������� ������ �ֱ� ������)�� ������� ��.
-- �׸��� ������û�ڵ嵵 ������� ��

CREATE OR REPLACE PROCEDURE PRC_COURSE_DELETE
( V_CRS_CODE    IN TBL_COURSE.CRS_CODE%TYPE )
IS
BEGIN
    -- ������ ������ ���ٸ� ���� 
    DELETE
    FROM TBL_COURSE
    WHERE CRS_CODE = V_CRS_CODE;
    
    -- ����ó��
    EXCEPTION
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_COURSE_DELETE��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

-----------------------------4. ���� ���ν���------------------------------------
-- ���� �Է� ���ν��� ���� PRC_SUBJECT_INSERT(�����)

CREATE OR REPLACE PROCEDURE PRC_SUBJECT_INSERT
( V_SUB_NAME  IN TBL_SUBJECT.SUB_NAME%TYPE
)
IS
    --�ʿ� ���� ����
    V_SUB_CODE  TBL_SUBJECT.SUB_CODE%TYPE;
    
BEGIN
    --V_SUB_CODE ���� �ʱ�ȭ
    V_SUB_CODE := TO_CHAR(SEQ_SUBJECT.NEXTVAL);

    --INSERT ������ �ۼ�
    INSERT INTO TBL_SUBJECT(SUB_CODE,SUB_NAME)
    VALUES(V_SUB_CODE, V_SUB_NAME);
    
    --Ŀ��
    --COMMIT;

END;
--==>> Procedure PRC_SUBJECT_INSERT��(��) �����ϵǾ����ϴ�.

-- ���� ������Ʈ ���ν��� ���� PRC_SUBJECT_UPDATE(�����ڵ�, ��������)
CREATE OR REPLACE PROCEDURE PRC_SUBJECT_UPDATE
( V_SUB_CODE  IN TBL_SUBJECT.SUB_CODE%TYPE
, V_SUB_NAME  IN TBL_SUBJECT.SUB_NAME%TYPE
)
IS  
BEGIN
    --UPDATE ������ �ۼ�
    UPDATE TBL_SUBJECT
    SET SUB_NAME = V_SUB_NAME
    WHERE SUB_CODE = V_SUB_CODE;
    
    --Ŀ��
    --COMMIT;

END;
--==>> Procedure PRC_SUBJECT_UPDATE��(��) �����ϵǾ����ϴ�.

-- ���� ���� ���ν��� ���� PRC_SUBJECT_DELETE(�����ڵ�) => �ش� ���� ���� �� ������û�� �̹� ��..������ �����ϰ�� �����Ұ�..?(�������..)
CREATE OR REPLACE PROCEDURE PRC_SUBJECT_DELETE
( V_SUB_CODE  IN TBL_SUBJECT.SUB_CODE%TYPE
)
IS    
BEGIN
    --DELETE ������ �ۼ�
    DELETE
    FROM TBL_SUBJECT
    WHERE SUB_CODE = V_SUB_CODE;
    
    --Ŀ��
    --COMMIT;    
    
    --����ó��..
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK; 

END;
--==>> Procedure PRC_SUBJECT_DELETE��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

-----------------------------5. �������� ���ν���--------------------------------
-- �������� INSERT ���ν��� PRC_OPENC_INSERT(�����ڵ�,���ǽ��ڵ�,������������,������������)
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
    
    
    -- CURSOR�� ����
    CURSOR CUR_ROOM_CHECK
    IS
    SELECT CRS_END
    FROM TBL_OPENC
    WHERE ROOM_CODE = V_ROOM_CODE;
    
BEGIN
    -- CURSOR ����
     OPEN CUR_ROOM_CHECK;
    
     LOOP
         FETCH CUR_ROOM_CHECK INTO V_CRS_END_TEMP;
         
         EXIT WHEN CUR_ROOM_CHECK%NOTFOUND;
         
         IF (V_CRS_START <= V_CRS_END_TEMP) --�̰ǰ�..?
         --���� �����������ں��� ���� ����� ���½������ڰ� ���Ŷ��
            THEN RAISE USER_DEFINE_ERROR2;
         END IF;
         
     END LOOP;
     
     CLOSE CUR_ROOM_CHECK;

    -- �����������ڰ� SYSDATE���� �̷��̰� 
     IF (SYSDATE >= V_CRS_START)
        THEN RAISE USER_DEFINE_ERROR1;
     END IF;
    
    -- V_OPENC_CODE ���� �ʱ�ȭ
    V_OPENC_CODE := TO_CHAR(SEQ_OPENC.NEXTVAL);
    
    INSERT INTO TBL_OPENC(OPENC_CODE, CRS_CODE, ROOM_CODE, CRS_START, CRS_END)
    VALUES (V_OPENC_CODE, V_CRS_CODE, V_ROOM_CODE, V_CRS_START, V_CRS_END);
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR1
            THEN RAISE_APPLICATION_ERROR(-20002, '�����������ڰ� ���ó�¥���� �����Դϴ�.');
            ROLLBACK;
        WHEN USER_DEFINE_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20003, '���� ���� �������� ������ ���ǽ��Դϴ�.');
            ROLLBACK;
        
    -- Ŀ��
    --COMMIT;
    
END;
--==>> Procedure PRC_OPENC_INSERT��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

-----------------------------6. ���񰳼� ���ν���--------------------------------

-- �Ⱓ���� �Ǻ� �Լ�
-- ���������ڵ�� ����������ڿ� �����������ڸ� �Ű������� �޴´�
CREATE OR REPLACE FUNCTION FN_OPENS_SELECT
(
  V_OPENC_CODE  IN TBL_OPENC.OPENC_CODE%TYPE -- ���������ڵ�
, V_SUB_START   IN TBL_OPENS.SUB_START%TYPE  -- �����������
, V_SUB_END     IN TBL_OPENS.SUB_END%TYPE    -- ������������
)
RETURN NUMBER
IS
    -- �ֿ� ���� ����
    V_SUB_START_TEMP    TBL_OPENS.SUB_START%TYPE; -- ���������ڵ尡 ����(���� ������ ���ϴ�) ������� �����������
    V_SUB_END_TEMP      TBL_OPENS.SUB_END%TYPE;   -- ���������ڵ尡 ����(���� ������ ���ϴ�) ������� ������������
    V_RESULT            NUMBER;                   -- �Լ��� ���� �б�� �����
    
    V_CRS_START         TBL_OPENC.CRS_START%TYPE;   -- ������������
    V_CRS_END           TBL_OPENC.CRS_END%TYPE;     -- ������������
    
    -- Ŀ�� �ۼ�
    CURSOR CUR_OPENS_SELECT
    IS
    SELECT SUB_START, SUB_END                             -- ���ش� ������� ����������ڿ�, �����������ڸ� �޴´�.
    FROM TBL_OPENS
    WHERE OPENS_CODE = (SELECT OPENS_CODE                 -- �� ���񰳼��ڵ���� ã�Ƽ�
                        FROM TBL_OPENC
                        WHERE OPENC_CODE = V_OPENC_CODE); -- �� ���������ڵ尡 ����
BEGIN
    -- V_CRS_START, V_CRS_END ä���
    SELECT CRS_START, CRS_END INTO V_CRS_START, V_CRS_END   -- ���������ϰ� ������������ ���´�.
    FROM TBL_OPENC
    WHERE OPENC_CODE = V_OPENC_CODE;    -- �Է¹��� ���������ڵ��� 
    
    -- Ŀ�� ���� AND V_SUB_START_TEMP, V_SUB_END_TEMP, V_RESULT ä���
    OPEN CUR_OPENS_SELECT;
    
    LOOP
        FETCH CUR_OPENS_SELECT INTO V_SUB_START_TEMP, V_SUB_END_TEMP;
        
        --�� ����������ڴ� SYSDATE ���� �����̸� �� ��
        IF V_SUB_START < SYSDATE--����������
        --(����������ڰ� SYSDATE ���̰ų�)
        
        --�� ���� �����ϰ� ���� �������� ���������ϰ� ���������� ���̿� �־�� �Ѵ�.
        OR V_SUB_END <= V_CRS_START
        -- OR ���� �������� ���������� ���̴�. ���� �������� ���� �����Ϻ��� ���̹Ƿ�, �ڿ������� ���������� ���� ���Ű� �ȴ�.
        OR V_SUB_END > V_CRS_END
        -- OR ���� �������� ���������� ���̴�. ���� �������� ���� �����Ϻ��� ���̹Ƿ�, �ڿ������� ���������� ���� �̷��� �ȴ�. 
        
        --�� ���� �� �ٸ� ���� �Ⱓ�� ��ġ�� �ʾƾ� ��.  
        OR V_SUB_START BETWEEN V_SUB_START_TEMP AND V_SUB_END_TEMP
        -- ����� ������ �������� ��������� �������� �� ��������� �������� ���̿� �ְų�
        OR V_SUB_END BETWEEN V_SUB_END_TEMP AND V_SUB_END_TEMP
        -- ����� ������ �������� ��������� �������� �� ��������� �������� ���̿� �ִٸ�
            THEN V_RESULT := 0; -- UPDATE X
        
        ELSE V_RESULT := 1;     -- UPDATE O
        END IF;
                
        EXIT WHEN CUR_OPENS_SELECT%NOTFOUND;
    END LOOP;

    -- ��������� ��ȯ
    RETURN V_RESULT;
END;
--==>> Function FN_OPENS_SELECT��(��) �����ϵǾ����ϴ�.


-- �� ���񰳼� INSERT
-- ����������ڰ� SYSDATE < �����������,  ���� �� TRIGGER
-- ���� ���� �Է��� ������, �����, ���� �Ⱓ(���� ������, �� ������), ���� ��, ������ �� ����
-- ���� ��)
-- EXEC PRC_COURSE_UPDATE(���������ڵ�, �����ڵ�, ���������, ����������, �����ڵ�, �������ڵ�)
CREATE OR REPLACE PROCEDURE PRC_OPENS_INSERT
( V_OPENC_CODE  IN TBL_OPENC.OPENC_CODE%TYPE   -- ���������ڵ�   -- ���� ���
, V_SUB_CODE    IN TBL_SUBJECT.SUB_NAME%TYPE    -- �����ڵ�      -- ���� ���
, V_SUB_START   IN TBL_OPENS.SUB_START%TYPE     -- ���������
, V_SUB_END     IN TBL_OPENS.SUB_END%TYPE       -- ����������
, V_BOOK_CODE   IN TBL_BOOK.BOOK_CODE%TYPE      -- �����ڵ�      -- ���� ���
, V_PROF_CODE   IN TBL_PROFESSOR.PROF_CODE%TYPE -- �������ڵ�    -- ��� �ڵ尡 �°� 
)
IS
    -- ����    
    V_OPENS_CODE    TBL_OPENS.OPENS_CODE%TYPE;  -- ���񰳼��ڵ�
    
    V_RESULT            NUMBER;
    
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    -- ���񰳼��ڵ�
    V_OPENS_CODE := SEQ_OPENS.NEXTVAL;
    -- �Լ��� ���� �� ������
    SELECT FN_OPENS_SELECT(V_OPENC_CODE, V_SUB_START, V_SUB_END) INTO V_RESULT
    FROM DUAL;
    
    -- UPDATE ���� ����
    IF V_RESULT = 0
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- INSERT �� �ۼ�
    INSERT INTO TBL_OPENS(OPENC_CODE, OPENS_CODE, SUB_CODE, BOOK_CODE, PROF_CODE
                        , SUB_START, SUB_END)
    VALUES(V_OPENC_CODE, V_OPENS_CODE, V_SUB_CODE, V_BOOK_CODE, V_PROF_CODE
         , V_SUB_START, V_SUB_END); -- ���, �Ǳ�, �ʱ� ������ NULL �� ������ ����
         
    -- ���� ĳġ
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '�Ⱓ ������ �ٽ� �� �ּ���~!!!');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_OPENS_INSERT��(��) �����ϵǾ����ϴ�.

-- �� ���񰳼� UPDATE
-- ����������ڰ� SYSDATE < ����������� ���� �� TRIGGER
-- ���� ��)
-- EXEC PRC_OPENS_UPDATE(���񰳼��ڵ�, �����ڵ�, ���������, ����������, �����ڵ�, �������ڵ�)
-- ���������ڵ� �� ���� �Ұ�.
-- *���������ڵ�, ���������, ������������ ���� �����ϵ��� �ؾ� �ϴ°�?
-- ���������ڵ�� ���������ϱ� ���� �Ұ��� ������ �ϰ�, ���������, ������, �����ڵ�, �������ڵ常 ���� �����ϵ���.
-- �� ���, �Ͱ��� �������� SYSDATE ���� �̷����� �ϰ�, �ΰ��� �����ϰ� ���� �������� ���������ϰ� ���������� ���̾�� �ϸ�,
-- �ϴٸ� ���� �Ⱓ�� ��ġ�� �ʾƾ� ��. 


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
    -- �Լ��� ���� �� ������
    SELECT FN_OPENS_SELECT(V_OPENC_CODE, V_SUB_START, V_SUB_END) INTO V_RESULT
    FROM DUAL;
    
    -- UPDATE ���� ����
    IF V_RESULT = 0
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- UPDATE �� �ۼ�
    UPDATE TBL_OPENS
    SET SUB_START = V_SUB_START, SUB_END = V_SUB_END
      , BOOK_CODE = V_BOOK_CODE, PROF_CODE = V_PROF_CODE 
    WHERE OPENS_CODE = V_OPENS_CODE;
    
    -- ���� ĳġ
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '�Ⱓ ������ �ٽ� �� �ּ���~!!!');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_OPENS_UPDATE��(��) �����ϵǾ����ϴ�.

-- �� ���񰳼� DELETE
-- ���� ��)
-- EXEC PRC_OPENS_DELETE(���񰳼��ڵ�)
-- ���� ������ ������ ������ ���� �ʴ´�. ����, ����, ���ǽ� ETC.. ������û�� �л��� ������ ����� �ִ� �Ŵϱ� �Ű� �� �ᵵ �ǰ�.
-- ������.. �׳� ^��������� ������ ���� ����^�ϴٰ� ���� ��� �ƹ����� ���� �� ��ġ�� �길 ���� ����
CREATE OR REPLACE PROCEDURE PRC_OPENS_DELETE
( V_OPENS_CODE  IN TBL_OPENS.OPENS_CODE%TYPE )
IS
BEGIN
    -- DELETE �� �ۼ�
    DELETE
    FROM TBL_OPENS
    WHERE OPENS_CODE = V_OPENS_CODE;
END;
--==>> Procedure PRC_OPENS_DELETE��(��) �����ϵǾ����ϴ�.
--------------------------------------------------------------------------------

-----------------------------7. ���ǽ� ���ν���----------------------------------

-- ���ǽ� �Է� ���ν��� ���� PRC_ROOM_INSERT(���ǽ��̸�, �����ο�)
CREATE OR REPLACE PROCEDURE PRC_ROOM_INSERT
(   V_ROOM_NAME IN TBL_ROOM.ROOM_NAME%TYPE   -- ���ǽ� �̸�
,   V_ROOM_NUM  IN TBL_ROOM.ROOM_NUM%TYPE    -- ���ǽ� �����ο�
)
IS
    V_ROOM_CODE TBL_ROOM.ROOM_CODE%TYPE;   -- ������ �ڵ带 ���� ����
BEGIN
    -- ���ǽ� �ڵ� ����
    V_ROOM_CODE := TO_CHAR(SEQ_ROOM.NEXTVAL);
    
    -- ���ǽ� ���̺� INSERT ������ ����
    INSERT INTO TBL_ROOM(ROOM_CODE, ROOM_NAME, ROOM_NUM)
    VALUES(V_ROOM_CODE, V_ROOM_NAME, V_ROOM_NUM);
    
    -- Ŀ��
    -- COMMIT;
END;
--==>> Procedure PRC_ROOM_INSERT��(��) �����ϵǾ����ϴ�.


-- ���ǽ� ������Ʈ ���ν��� ���� PRC_ROOM_UPDATE(���ǽ��ڵ�, NEW���ǽ��̸�, NEW�����ο�)
CREATE OR REPLACE PROCEDURE PRC_ROOM_UPDATE
(   V_ROOM_CODE IN TBL_ROOM.ROOM_CODE%TYPE      -- ���ǽ� �ڵ�
,   V_ROOM_NAME IN TBL_ROOM.ROOM_NAME%TYPE   -- ���ǽ� �̸�
,   V_ROOM_NUM  IN TBL_ROOM.ROOM_NUM%TYPE    -- ���ǽ� �����ο�
)
IS
BEGIN
    -- ���ǽ� ���̺� UPDATE ������ ����
    UPDATE TBL_ROOM
    SET ROOM_NAME = V_ROOM_NAME
      , ROOM_NUM = V_ROOM_NUM
    WHERE ROOM_CODE = V_ROOM_CODE;
    
    -- Ŀ��
    -- COMMIT;
END;
--==>> Procedure PRC_ROOM_UPDATE��(��) �����ϵǾ����ϴ�.

-- ���ǽ� ���� ���ν��� ���� PRC_ROOM_DELETE(���ǽ��ڵ�)
CREATE OR REPLACE PROCEDURE PRC_STUDENT_DELETE
(   V_ROOM_CODE IN TBL_ROOM.ROOM_CODE%TYPE      -- ���ǽ��ڵ�
)
IS
BEGIN
    -- ���ǽ� ���̺� DELETE ������ ����
    DELETE
    FROM TBL_ROOM
    WHERE ROOM_CODE = V_ROOM_CODE;
    
    -- Ŀ��
    -- COMMIT;
END;
--==>> Procedure PRC_STUDENT_DELETE��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

-----------------------------8. ���� ���ν���------------------------------------

-- ���� �Է� PRC_BOOK_INSERT(�����̸�)

CREATE OR REPLACE PROCEDURE PRC_BOOK_INSERT
(
   V_BOOK_NAME   IN TBL_BOOK.BOOK_NAME%TYPE 
)
IS   
    V_BOOK_CODE TBL_BOOK.BOOK_CODE%TYPE ;
BEGIN
    -- �����ڵ� 
    V_BOOK_CODE := TO_CHAR(SEQ_BOOK.NEXTVAL);
    
    -- INSERT ������ 
    INSERT INTO TBL_BOOK(BOOK_CODE, BOOK_NAME)
    VALUES(V_BOOK_CODE, V_BOOK_NAME);
    
    --Ŀ��
    --COMMIT;

      --���� ó��
      EXCEPTION
        WHEN OTHERS 
            THEN ROLLBACK;    
END;
--==>> Procedure PRC_BOOK_INSERT��(��) �����ϵǾ����ϴ�.


-- ���� ���� PRC_BOOK_UPDATE(�����ڵ�,NEW�����̸�)

CREATE OR REPLACE PROCEDURE PRC_BOOK_UPDATE
(
    V_BOOK_CODE     IN TBL_BOOK.BOOK_CODE%TYPE    
,   V_BOOK_NAME     IN TBL_BOOK.BOOK_NAME%TYPE
)
IS
BEGIN

    --UPDATE ������
    UPDATE TBL_BOOK
    SET BOOK_NAME = V_BOOK_NAME
    WHERE BOOK_CODE = V_BOOK_CODE;
    
    --Ŀ��
    --COMMIT;
    
      --���� ó��
      EXCEPTION
        WHEN OTHERS 
            THEN ROLLBACK;    
END;
--==>> Procedure PRC_BOOK_UPDATE��(��) �����ϵǾ����ϴ�.

-- ���� ���� PRC_BOOK_DELETE(�����ڵ�)

CREATE OR REPLACE PROCEDURE PRC_BOOK_DELETE
(
    V_BOOK_CODE     IN TBL_BOOK.BOOK_CODE%TYPE 
)
IS
BEGIN

    DELETE
    FROM TBL_BOOK
    WHERE BOOK_CODE = V_BOOK_CODE;

      --Ŀ��
      --COMMIT;

      --���� ó��
      EXCEPTION
        WHEN OTHERS 
            THEN ROLLBACK;
END;
--==>> Procedure PRC_BOOK_DELETE��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

-----------------------------9. �ߵ�Ż�� ���ν���--------------------------------

-- �ߵ�Ż�� �Է� ���ν��� ���� PRC_FAIL_INSERT(������û�ڵ�,�ߵ�Ż������,�ߵ�Ż������)
CREATE OR REPLACE PROCEDURE PRC_FAIL_INSERT
( V_REGISTER_CODE  IN TBL_FAIL.REGISTER_CODE%TYPE
, V_FAIL_DATE      IN TBL_FAIL.FAIL_DATE%TYPE
, V_FAIL_REASON    IN TBL_FAIL.FAIL_REASON%TYPE
)
IS    
BEGIN
    --INSERT ������ �ۼ�
    INSERT INTO TBL_FAIL(REGISTER_CODE, FAIL_DATE, FAIL_REASON)
    VALUES(V_REGISTER_CODE, V_FAIL_DATE, V_FAIL_REASON);
    
    --Ŀ��
    --COMMIT;

END;
--==>> Procedure PRC_FAIL_INSERT��(��) �����ϵǾ����ϴ�.

-- �ߵ�Ż�� ���� ���ν��� ���� PRC_FAIL_UPDATE(����������û�ڵ�, NEW������û�ڵ�, NEW�ߵ�Ż������, NEW�ߵ�Ż������)
CREATE OR REPLACE PROCEDURE PRC_FAIL_UPDATE
( V_OLD_REGISTER_CODE  IN TBL_FAIL.REGISTER_CODE%TYPE
, V_REGISTER_CODE  IN TBL_FAIL.REGISTER_CODE%TYPE
, V_FAIL_DATE      IN TBL_FAIL.FAIL_DATE%TYPE
, V_FAIL_REASON    IN TBL_FAIL.FAIL_REASON%TYPE
)
IS    
BEGIN
    --UPDATE ������ �ۼ�
    UPDATE TBL_FAIL
    SET REGISTER_CODE = V_REGISTER_CODE
      , FAIL_DATE     = V_FAIL_DATE
      , FAIL_REASON   = V_FAIL_REASON
    WHERE REGISTER_CODE = V_OLD_REGISTER_CODE;
    
    --Ŀ��
    --COMMIT;

END;
--==>> Procedure PRC_FAIL_UPDATE��(��) �����ϵǾ����ϴ�

-- �ߵ�Ż�� ���� ���ν��� ���� PRC_FAIL_DELETE(������û�ڵ�)
CREATE OR REPLACE PROCEDURE PRC_FAIL_DELETE
( V_REGISTER_CODE  IN TBL_FAIL.REGISTER_CODE%TYPE
)
IS    
BEGIN
    --DELETE ������ �ۼ�
    DELETE
    FROM TBL_FAIL
    WHERE REGISTER_CODE = V_REGISTER_CODE;
    
    --Ŀ��
    --COMMIT;

END;
--==>> Procedure PRC_FAIL_DELETE��(��) �����ϵǾ����ϴ�.
--------------------------------------------------------------------------------

-----------------------------10. ���� ���ν���-----------------------------------

-- ���� ������Ʈ ���ν��� ���� PRC_SCORE_UPDATE(������û�ڵ�, ���񰳼��ڵ�, ���, �Ǳ�, �ʱ�)

CREATE OR REPLACE PROCEDURE PRC_SCORE_UPDATE
(   V_REGISTER_CODE IN TBL_REGISTER.REGISTER_CODE%TYPE   -- ������û�ڵ�
,   V_OPENS_CODE    IN TBL_OPENS.OPENS_CODE%TYPE         -- ���񰳼��ڵ�
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
    -- ���� ���� ��ƿ���(���񰳼� �ڵ尡 ������ ���� ��������)
    SELECT C_PERCENT, S_PERCENT, P_PERCENT INTO V_C_PERCENT, V_S_PERCENT, V_P_PERCENT
    FROM TBL_OPENS
    WHERE OPENS_CODE = V_OPENS_CODE;
    
    -- �Է��� ������ 0���� �۰ų� �����Ǿ��ִ� �������� Ŭ ��� ���� �߻�
    IF ((V_C_SCORE < 0) OR (V_C_SCORE > V_C_PERCENT) OR (V_S_SCORE < 0) OR (V_S_SCORE > V_S_PERCENT) OR (V_P_SCORE < 0) OR (V_P_SCORE > V_P_PERCENT))
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- ���� ���̺� UPDATE ������ ����
    UPDATE TBL_SCORE
    SET C_SCORE = V_C_SCORE
      , S_SCORE = V_S_SCORE
      , P_SCORE = V_P_SCORE
    WHERE REGISTER_CODE = V_REGISTER_CODE
      AND OPENS_CODE = V_OPENS_CODE; 
    
    -- Ŀ��
    -- COMMIT;
    
    -- ���� ó��
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20200, '������ �ٽ� �Է����ּ���.(0�̸�, ���� �ʰ� �Ұ�)');
            ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_SCORE_UPDATE��(��) �����ϵǾ����ϴ�.

-- ���� ����(�ٽ� NULL ������) ���ν��� ���� PRC_SCORE_DELETE()
CREATE OR REPLACE PROCEDURE PRC_SCORE_DELETE
(   V_REGISTER_CODE IN TBL_REGISTER.REGISTER_CODE%TYPE   -- ������û�ڵ�
,   V_OPENS_CODE    IN TBL_OPENS.OPENS_CODE%TYPE         -- ���񰳼��ڵ�
)
IS
BEGIN
    -- ���� ���̺� DELETE ������ ����
    UPDATE TBL_SCORE
    SET C_SCORE = ''
      , S_SCORE = ''
      , P_SCORE = ''
    WHERE REGISTER_CODE = V_REGISTER_CODE
      AND OPENS_CODE = V_OPENS_CODE; 
    
    -- Ŀ��
    -- COMMIT;
END;
--==>> Procedure PRC_SCORE_DELETE��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

-----------------------------11. ���� ���ν���-----------------------------------

-- ���� UPDATE ���ν��� PRC_PERCENT_UPDATE(���񰳼��ڵ�)

CREATE OR REPLACE PROCEDURE PRC_PERCENT_UPDATE
(
    V_OPENS_CODE    IN TBL_OPENS.OPENS_CODE%TYPE
,   V_C_PERCENT     IN TBL_OPENS.C_PERCENT%TYPE         -- ���
,   V_S_PERCENT     IN TBL_OPENS.S_PERCENT%TYPE         -- �Ǳ�
,   V_P_PERCENT     IN TBL_OPENS.P_PERCENT%TYPE         -- �ʱ�
)
IS
BEGIN        
    -- ���� ���̺� UPDATE ������ ����
    UPDATE TBL_OPENS
    SET C_PERCENT = V_C_PERCENT
       ,S_PERCENT = V_S_PERCENT
       ,P_PERCENT = V_P_PERCENT
    WHERE OPENS_CODE =V_OPENS_CODE;
        
      --���� ó��
      EXCEPTION
        WHEN OTHERS 
            THEN ROLLBACK;
END;
--==>> Procedure PRC_PERCENT_UPDATE��(��) �����ϵǾ����ϴ�.

-- ���� DELETE PRC_PERCENT_DELETE(���񰳼��ڵ�)

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

      --���� ó��
      EXCEPTION
        WHEN OTHERS 
            THEN ROLLBACK;
END;
--==>> Procedure PRC_PERCENT_DELETE��(��) �����ϵǾ����ϴ�.
--------------------------------------------------------------------------------

-----------------------------12. ������û ���ν���-------------------------------
-- ������û �Է� ���ν��� ���� PRC_REGISTER_INSERT(���������ڵ�, �л��ڵ�) 
-- ������û���ڴ� DEFAULT ������..
-- ������û����(SYSDATE) < ������������ => ������û VIEW ��ü���� �̹� �ش� �������θ� ���� �� �ְ� �����ϸ�, 
-- ���ν������� �Ÿ����ʾƵ� �ȴٰ� �����Ͽ�, ���� ����ó�� ���� �ʾ���.
CREATE OR REPLACE PROCEDURE PRC_REGISTER_INSERT
( V_OPENC_CODE  IN TBL_OPENC.OPENC_CODE%TYPE
, V_STD_CODE    IN TBL_STUDENT.STD_CODE%TYPE
)
IS
    --�ʿ亯������
    V_REGISTER_CODE TBL_REGISTER.REGISTER_CODE%TYPE;
BEGIN
    --���� �ʱ�ȭ
    V_REGISTER_CODE := TO_CHAR(SEQ_REGISTER.NEXTVAL);
    
    --INSERT ������ �ۼ�
    INSERT INTO TBL_REGISTER(REGISTER_CODE, OPENC_CODE, STD_CODE)
    VALUES(V_REGISTER_CODE, V_OPENC_CODE, V_STD_CODE);
    
    --Ŀ��
    --COMMIT;

END;
--==>>  Procedure PRC_REGISTER_INSERT��(��) �����ϵǾ����ϴ�.

-- ������û ���� ���ν��� ���� PRC_REGISTER_UPDATE(������û�ڵ�, NEW���������ڵ�, NEW�л��ڵ�) -- ������û�ڵ�� ������û���ڴ� ��������ʾƾ���..
CREATE OR REPLACE PROCEDURE PRC_REGISTER_UPDATE
( V_REGISTER_CODE IN TBL_REGISTER.REGISTER_CODE%TYPE
, V_OPENC_CODE    IN TBL_OPENC.OPENC_CODE%TYPE
, V_STD_CODE      IN TBL_STUDENT.STD_CODE%TYPE
)
IS
BEGIN
    --UPDATE ������ �ۼ�
    UPDATE TBL_REGISTER
    SET OPENC_CODE = V_OPENC_CODE
      , STD_CODE = V_STD_CODE
    WHERE REGISTER_CODE = V_REGISTER_CODE;
    
    --Ŀ��
    --COMMIT;

END;
--==>> Procedure PRC_REGISTER_UPDATE��(��) �����ϵǾ����ϴ�.

-- ������û ���� ���ν��� ���� PRC_REGISTER_DELETE(������û�ڵ�)--**�ߵ�Ż������� �ִ� ������û�ڵ��� ���.. ������û���� �Ұ�.
CREATE OR REPLACE PROCEDURE PRC_REGISTER_DELETE
( V_REGISTER_CODE IN TBL_REGISTER.REGISTER_CODE%TYPE
)
IS
BEGIN
    --DELETE ������ �ۼ�
    DELETE 
    FROM TBL_REGISTER
    WHERE REGISTER_CODE = V_REGISTER_CODE;
    
    --Ŀ��
    --COMMIT;
    
    --����ó��..
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;  

END;
--==>> Procedure PRC_REGISTER_DELETE��(��) �����ϵǾ����ϴ�.

--------------------------------------------------------------------------------

-----------------------------13. ������ ���ν���---------------------------------

-- ���������� ������Ʈ ���ν��� PRC_ADMIN_UPDATE(����CODE, NEW CODE, ���� PW, NEW PW)

CREATE OR REPLACE PROCEDURE PRC_ADMIN_UPDATE
(   
    V_OLD_CODE   IN TBL_ADMIN.ADMIN_CODE%TYPE            
   ,V_NEW_CODE   IN TBL_ADMIN.ADMIN_CODE%TYPE  
   ,V_OLD_PW   IN TBL_ADMIN.ADMIN_PW%TYPE 
   ,V_NEW_PW   IN TBL_ADMIN.ADMIN_PW%TYPE
)
IS
BEGIN
    
    -- UPDATE ������
    UPDATE TBL_ADMIN
    SET ADMIN_CODE = V_NEW_CODE, ADMIN_PW = V_NEW_PW 
    WHERE ADMIN_CODE = V_OLD_CODE AND (SELECT ADMIN_PW
                                       FROM TBL_ADMIN
                                       WHERE ADMIN_CODE=V_OLD_CODE)=V_OLD_PW;
    -- Ŀ��
    -- COMMIT;
    
    --���� ó��
      EXCEPTION
        WHEN OTHERS 
            THEN ROLLBACK;
    
END;
--==>> Procedure PRC_ADMIN_UPDATE��(��) �����ϵǾ����ϴ�.
--------------------------------------------------------------------------------




-- �� ������ ���� ���� ��� ������ �� 
-- ������, �����Ȱ����, �Ⱓ, �����, ���ǽ�, �������࿩�� ��ȸ 
CREATE OR REPLACE VIEW VIEW_PROFESSORS
AS
SELECT TP.PROF_NAME "������", TS.SUB_NAME "�����", TOS.SUB_START "���������", TOS.SUB_END "����������"
     , TB.BOOK_NAME"�����", TR.ROOM_NAME"���ǽ�"
     , CASE WHEN SYSDATE BETWEEN TOS.SUB_START AND TOS.SUB_END THEN '����������' 
             WHEN SYSDATE < TOS.SUB_START THEN '���ǿ���'
             ELSE '���ǿϷ�' END "�������࿩��"
FROM TBL_PROFESSOR TP, TBL_SUBJECT TS, TBL_OPENS TOS, TBL_BOOK TB, TBL_ROOM TR, TBL_OPENC TOC, TBL_COURSE TC
WHERE TOS.PROF_CODE = TP.PROF_CODE(+)
  AND TOS.SUB_CODE = TS.SUB_CODE(+)
  AND TOS.BOOK_CODE = TB.BOOK_CODE(+)
  AND TOC.CRS_CODE = TC.CRS_CODE(+)
  AND TOS.OPENC_CODE = TOC.OPENC_CODE(+)
  AND TOC.ROOM_CODE = TR.ROOM_CODE(+);
  
SELECT *
FROM VIEW_PROFESSORS;
--����

-- �� ������ ���� ��� �� ����
-- ������, ���ǽ�, �����, ���� �Ⱓ(�ð���, ������), �����, ������
CREATE OR REPLACE VIEW VIEW_COURSE
AS
SELECT TC.CRS_NAME "������", TR.ROOM_NAME "���ǽ�", TS.SUB_NAME "�����", TOS.SUB_START "�����������"
     , TOS.SUB_END "������������", TB.BOOK_NAME "�����", TP.PROF_NAME "������"
FROM TBL_COURSE TC, TBL_ROOM TR, TBL_SUBJECT TS, TBL_OPENS TOS, TBL_BOOK TB, TBL_PROFESSOR TP, TBL_OPENC TOC
WHERE TOS.OPENC_CODE = TOC.OPENC_CODE(+)
  AND TOC.ROOM_CODE = TR.ROOM_CODE(+)
  AND TOS.SUB_CODE = TS.SUB_CODE(+)
  AND TOC.CRS_CODE = TC.CRS_CODE(+)
  AND TOS.BOOK_CODE = TB.BOOK_CODE(+)
  AND TOS.PROF_CODE = TP.PROF_CODE(+);

SELECT *
FROM VIEW_COURSE;
--����






