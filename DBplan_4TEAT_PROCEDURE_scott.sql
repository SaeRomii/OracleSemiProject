SELECT USER
FROM DUAL;
--==>> SCOTT

-- �α��� ���ν���(������)
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


-- �α��� ���ν��� (����)
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


-- �α��� ���ν��� (�л�)
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



-- ���������ڵ� SEQUENCE
CREATE SEQUENCE SEQ_OPENC
START WITH 10000
INCREMENT BY 1
MAXVALUE 19999
NOCACHE;


-- ��������� ���ν��� �Է� PRC_OPENC_INSERT
-- �����������ڰ� SYSDATE < ������������ ���� �� TRIGGER
-- �� ���ǽǿ� �����Ⱓ ��ġ�� �ȵ�
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


-- �������� ���ν��� ���� PRC_OPENC_UPDATE(���������ڵ�, ���ǽ��ڵ�, ������������, ������������ ����)
-- �����ְ��ڵ�, �� ���ǽ�, 
CREATE OR REPLACE PROCEDURE PRC_OPENC_UPDATE
( V_OPENC_CODE  IN TBL_OPENC.OPENC_CODE%TYPE
, V_ROOM_CODE   IN TBL_ROOM.ROOM_CODE%TYPE
, V_CRS_START   IN TBL_OPENC.CRS_START%TYPE
, V_CRS_END     IN TBL_OPENC.CRS_END%TYPE
)
IS  
    --V_OPENC_CODE    TBL_OPENC.OPENC_CODE%TYPE;
    V_CRS_END_TEMP  TBL_OPENC.CRS_END%TYPE;
    
    USER_DEFINE_ERROR  EXCEPTION;
    
    --Ŀ�� ����
    CURSOR CUR_ROOM_CHE
    IS
    SELECT CRS_END
    FROM TBL_OPENC
    WHERE ROOM_CODE = V_ROOM_CODE;
    
BEGIN
    -- Ŀ�� ����
    OPEN CUR_ROOM_CHE;
    
    LOOP
        FETCH CUR_ROOM_CHE INTO V_CRS_END_TEMP;
        
        EXIT WHEN CUR_ROOM_CHE%NOTFOUND;
        
        IF (V_CRS_START <= V_CRS_END_TEMP)
            THEN RAISE USER_DEFINE_ERROR;
        END IF;
        
    END LOOP;
    
    -- Ŀ�� �ݱ�
    CLOSE CUR_ROOM_CHE;

    -- UPDATE ������
    UPDATE TBL_OPENC
    SET ROOM_CODE = V_ROOM_CODE, CRS_START = V_CRS_START, CRS_END = V_CRS_END
    WHERE OPENC_CODE = V_OPENC_CODE;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20004, '���� ���� �������� ������ ���ǽ��Դϴ�.');
            ROLLBACK;
    
    --Ŀ��
    --COMMIT;
END;


-- �������� ���ν��� ���� PRC_OPENC_DELETE(�ڵ� �����ϸ� �� �����ǳ���..?)
CREATE OR REPLACE PROCEDURE PRC_OPENC_DELETE
( V_OPENC_CODE  IN TBL_OPENC.OPENC_CODE%TYPE
)
IS
BEGIN
    
    -- DELETE ������
    DELETE
    FROM TBL_OPENC
    WHERE OPENC_CODE = V_OPENC_CODE;
    
    --Ŀ��
    --COMMIT;
    
END;


--�� ������
--������, �л�������, �������� �л���, �����ں�



-- �� ������ ���� ���� ��� ������ �� 
-- ������, �����Ȱ����, �Ⱓ, �����, ���ǽ�, �������࿩�� ��ȸ 
CREATE OR REPLACE VIEW VIEW_PROFESSORS
AS
SELECT TP.PROF_NAME "������", TS.SUB_NAME "�����", TOS.SUB_START "���������", TOS.SUB_END "����������"
     , TB.BOOK_NAME"�����", TR.ROOM_NAME"���ǽ�"
     , CASE WHEN SYSDATE BETWEEN OS.SUB_START AND OS.SUB_END THEN '����������' 
             WHEN SYSDATE < OS.SUB_START THEN '���ǿ���'
             ELSE '���ǿϷ�' END "�������࿩��"
FROM TBL_PROFESSOR TP, TBL_SUBJECT TS, TBL_OPENS TOS, TBL_BOOK TB, TBL_ROOM TR, TBL_OPENC TOC, TBL_COURSE TC
WHERE TOS.PROF_CODE = TP.PROF_CODE(+)
  AND TOS.SUB_CODE = TS.SUB_CODE(+)
  AND TOS.BOOK_CODE = TB.BOOK_CODE(+)
  AND TOC.CRS_CODE = TC.CRS_CODE(+)
  AND TOS.OPENC_CODE = TOC.OPENC_CODE(+)
  AND TOC.ROOM_CODE = TR.ROOM_CODE(+);
--WHERE �ٽ��غ��� 

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
  AND TOS.PROF_CODE = P.PROF_CODE(+);
























