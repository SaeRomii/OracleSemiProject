SELECT USER
FROM DUAL;
--==>> HR

------------------------------���̺� ����----------------------------------------
--���������� ���̺�
CREATE TABLE TBL_ADMIN
( ADMIN_CODE VARCHAR2(20) 
, ADMIN_PW   VARCHAR2(20) CONSTRAINT ADMIN_ADMIN_PW_NN NOT NULL
, CONSTRAINT ADMIN_ADMIN_CODE_PK PRIMARY KEY(ADMIN_CODE)
);
--==>> Table TBL_ADMIN��(��) �����Ǿ����ϴ�.


-- �������� ���̺�
-- �����ڵ� ù �ڸ� P�� ���� P || 0001 ~~
-- �ֹι�ȣ ���ڸ����� ù �ڸ��� �Է� ������ ������ 1,2,3,4 �������� ����
CREATE TABLE TBL_PROFESSOR
( PROF_CODE VARCHAR2(20)                                                                -- �����ڵ� PK 
, PROF_NAME VARCHAR2(20)         CONSTRAINT PROFESSOR_PROF_NAME_NN NOT NULL             -- �����̸�
, PROF_SSN  CHAR(7)              CONSTRAINT PROFESSOR_PROF_SSN_NN NOT NULL              -- �ֹι�ȣ ���ڸ�
, PROF_PW   VARCHAR2(20)         CONSTRAINT PROFESSOR_PROF_PW_NN NOT NULL               -- ����PW
, PROF_DATE  DATE DEFAULT SYSDATE CONSTRAINT PROFESSOR_PROF_DATE_NN NOT NULL             -- �������
, CONSTRAINT PROFESSOR_PROF_CODE_PK PRIMARY KEY(PROF_CODE)                                   -- �����ڵ� �⺻Ű
, CONSTRAINT PROFESSOR_PROF_SSN_CK  CHECK(SUBSTR(PROF_CODE,1,1) IN ('1','2','3','4'))        -- �����ֹι�ȣ CK
);
--==>> Table TBL_PROFESSOR��(��) �����Ǿ����ϴ�.

--ALTER TABLE TBL_PROFESSOR
--MODIFY PROF_PW DEFAULT PROF_SSN;       -- ���̺� ���� �� default �ֹι�ȣ ���ڸ� �߰�????


-- �л����� ���̺�
-- �л��ڵ� ù �ڸ� S�� ���� S || 0001 ~~
-- �ֹι�ȣ ���ڸ����� ù �ڸ��� �Է� ������ ������ 1,2,3,4 �������� ����
CREATE TABLE TBL_STUDENT
( STD_CODE  VARCHAR2(20)                                                                -- �л��ڵ�
, STD_NAME  VARCHAR2(20)    CONSTRAINT STUDENT_STD_NAME_NN NOT NULL                     -- �л��̸�
, STD_SSN   CHAR(7)         CONSTRAINT STUDENT_STD_SSN_NN NOT NULL                      -- �ֹι�ȣ ���ڸ�
, STD_PW    VARCHAR2(20)    CONSTRAINT STUDENT_STD_PW_NN NOT NULL                       -- �л�PW
, STD_DATE  DATE            DEFAULT SYSDATE   CONSTRAINT STUDENT_STD_DATE_NN NOT NULL   -- �������
, CONSTRAINT STUDENT_STD_CODE_PK PRIMARY KEY(STD_CODE)
, CONSTRAINT STUDENT_STD_SSN_CK CHECK(SUBSTR(STD_SSN, 1, 1) IN ('1', '2', '3', '4'))
);
--==>> Table TBL_STUDENT��(��) �����Ǿ����ϴ�.


-- �������� ���̺�
CREATE TABLE TBL_COURSE
( CRS_CODE VARCHAR2(20)                                                                 -- �����ڵ�
, CRS_NAME VARCHAR2(50) CONSTRAINT COURSE_CRS_NAME_NN NOT NULL                          -- �����̸�
, CONSTRAINT COURSE_CRS_CODE_PK PRIMARY KEY(CRS_CODE)
);
--==>> Table TBL_COURSE��(��) �����Ǿ����ϴ�.

ALTER TABLE TBL_COURSE MODIFY CRS_NAME VARCHAR2(100);
--==>> Table TBL_COURSE��(��) ����Ǿ����ϴ�.

-- �������� ���̺�
CREATE TABLE TBL_SUBJECT
( SUB_CODE  VARCHAR2(20)                                                                -- �����ڵ�
, SUB_NAME  VARCHAR2(50) CONSTRAINT SUBJECT_SUB_NAME_NN NOT NULL                        -- �����̸�
, CONSTRAINT SUBJECT_SUB_CODE_PK PRIMARY KEY(SUB_CODE)
);
--==>> Table TBL_SUBJECT��(��) �����Ǿ����ϴ�.


-- �������� ���̺�
CREATE TABLE TBL_BOOK
( BOOK_CODE VARCHAR2(20)                                                                -- �����ڵ�
, BOOK_NAME VARCHAR2(50)    CONSTRAINT BOOK_BOOK_NAME_NN NOT NULL                       -- �����̸�
, CONSTRAINT BOOK_BOOK_CODE_PK PRIMARY KEY(BOOK_CODE)
);
--==>> Table TBL_BOOK��(��) �����Ǿ����ϴ�.
ALTER TABLE TBL_BOOK MODIFY BOOK_NAME VARCHAR2(100);
--==>> Table TBL_BOOK��(��) ����Ǿ����ϴ�.

-- ���ǽ����� ���̺�
-- �����ο� �������� ����
CREATE TABLE TBL_ROOM
( ROOM_CODE VARCHAR2(20)                                                                -- ���ǽ��ڵ�
, ROOM_NAME VARCHAR2(30)    CONSTRAINT ROOM_ROOM_NAME_NN NOT NULL                       -- ���ǽ��̸�
, ROOM_NUM  NUMBER(3)       CONSTRAINT ROOM_ROOM_NUM_NN NOT NULL                        -- �����ο�
, CONSTRAINT ROOM_ROOM_CODE_PK PRIMARY KEY(ROOM_CODE)
, CONSTRAINT ROOM_ROOM_NUM_CK CHECK(ROOM_NUM > 0)
);
--==>> Table TBL_ROOM��(��) �����Ǿ����ϴ�.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';


-- �������� ���̺�
-- �����������ڰ� SYSDATE < ������������ ���� �� TRIGGER
-- �����������ڰ� ����������� < ������������ �������� ����
CREATE TABLE TBL_OPENC
( OPENC_CODE  VARCHAR2(20)                                                              -- ���������ڵ�
, CRS_CODE    VARCHAR2(20) CONSTRAINT OPENC_CRS_CODE_NN NOT NULL                        -- �����ڵ�
, ROOM_CODE   VARCHAR2(20) CONSTRAINT OPENC_ROOM_CODE_NN NOT NULL                       -- ���ǽ��ڵ�
, CRS_START   DATE CONSTRAINT OPENC_CRS_START_NN NOT NULL                               -- ������������
, CRS_END     DATE CONSTRAINT OPENC_CRS_END_NN NOT NULL                                 -- ������������
, CONSTRAINT OPENC_OPENC_CODE_PK PRIMARY KEY(OPENC_CODE)
, CONSTRAINT OPENC_CRS_CODE_FK FOREIGN KEY(CRS_CODE)
             REFERENCES TBL_COURSE(CRS_CODE)
, CONSTRAINT OPENC_ROOM_CODE_FK FOREIGN KEY(ROOM_CODE)
             REFERENCES TBL_ROOM(ROOM_CODE)
--, CONSTRAINT OPENC_CRS_START_CK CHECK (SYSDATE < CRS_START)           INSERT TRIGGER�� �����ؾ��� �κ�
, CONSTRAINT OPENC_CRS_END_CK CHECK (CRS_START < CRS_END)
);
--==>> Table TBL_OPENC��(��) �����Ǿ����ϴ�.


-- ���񰳼� ���̺�
-- ����������ڰ� SYSDATE < ����������� ���� �� TRIGGER
-- �����������ڰ� ����������� < ������������ �������� ����
-- ���� 0~100����, ���� ���� 100������ ������ ����ó���� �Ұ��� ���⼭ ��������? ��
CREATE TABLE TBL_OPENS
( OPENS_CODE    VARCHAR2(20)                                                            -- ���񰳼��ڵ�
, OPENC_CODE    VARCHAR2(20) CONSTRAINT OPENS_OPENC_CODE_NN NOT NULL                    -- ���������ڵ�
, SUB_CODE      VARCHAR2(20) CONSTRAINT OPENS_SUB_CODE_NN NOT NULL                      -- �����ڵ�
, BOOK_CODE     VARCHAR2(20) CONSTRAINT OPENS_BOOK_CODE_NN NOT NULL                     -- �����ڵ�
, PROF_CODE     VARCHAR2(20) CONSTRAINT OPENS_PROF_CODE_NN NOT NULL                     -- �����ڵ�
, SUB_START     DATE         CONSTRAINT OPENS_SUB_STRAT_NN NOT NULL                     -- �����������
, SUB_END       DATE         CONSTRAINT OPENS_SUB_END_NN NOT NULL                       -- ������������
, C_PERCENT     NUMBER(3)                                                              -- ������
, S_PERCENT     NUMBER(3)                                                              -- �Ǳ����
, P_PERCENT     NUMBER(3)                                                              -- �ʱ����
, CONSTRAINT OPENS_OPENS_CODE_PK PRIMARY KEY(OPENS_CODE)
, CONSTRAINT OPENS_OPENC_CODE_FK FOREIGN KEY(OPENC_CODE) REFERENCES TBL_OPENC(OPENC_CODE)
, CONSTRAINT OPENS_SUB_CODE_FK FOREIGN KEY(SUB_CODE) REFERENCES TBL_SUBJECT(SUB_CODE)
, CONSTRAINT OPENS_BOOK_CODE_FK FOREIGN KEY(BOOK_CODE) REFERENCES TBL_BOOK(BOOK_CODE)
, CONSTRAINT OPENS_PROF_CODE_FK FOREIGN KEY(PROF_CODE) REFERENCES TBL_PROFESSOR(PROF_CODE)
--, CONSTRAINT OPENS_SUB_START_CK CHECK (SYSDATE < SUB_START)            INSERT TRIGGER�� �����ؾ��� �κ�
, CONSTRAINT OPENS_SUB_END_CK CHECK (SUB_START < SUB_END)
, CONSTRAINT OPENS_PERCENT_TOTAL_CK CHECK (C_PERCENT + S_PERCENT + P_PERCENT = 100)
, CONSTRAINT OPENS_C_PERCENT_CK CHECK (0 <= C_PERCENT AND C_PERCENT <= 100)
, CONSTRAINT OPENS_S_PERCENT_CK CHECK (0 <= S_PERCENT AND S_PERCENT <= 100)
, CONSTRAINT OPENS_P_PERCENT_CK CHECK (0 <= P_PERCENT AND P_PERCENT <= 100)
);
--==>> Table TBL_OPENS��(��) �����Ǿ����ϴ�.



-- ������û ���̺�
-- ������û���� �� ������û����(SYSDATE) < ������������ �������� ���� �� INSERT ���ν����� �����ؾ��� �κ�
CREATE TABLE TBL_REGISTER                                                       
( REGISTER_CODE VARCHAR2(20)                                                        -- ������û�ڵ�
, OPENC_CODE    VARCHAR2(20)          CONSTRAINT REGISTER_OPENC_CODE_NN NOT NULL    -- ���������ڵ�
, STD_CODE      VARCHAR2(20)          CONSTRAINT REGISTER_STD_CODE_NN NOT NULL      -- �л��ڵ�
, REGISTER_DATE DATE DEFAULT SYSDATE  CONSTRAINT REGISTER_REGISTER_DATE_NN NOT NULL -- ������û����
, CONSTRAINT REGISTER_REGISTER_CODE_PK PRIMARY KEY(REGISTER_CODE)                   -- ������û�ڵ� �⺻Ű
, CONSTRAINT REGISTER_OPENC_CODE_FK FOREIGN KEY(OPENC_CODE)                         -- ���������ڵ� FK
            REFERENCES TBL_OPENC(OPENC_CODE)
, CONSTRAINT REGISTER_STU_CODE_FK FOREIGN KEY(STD_CODE)                             -- �л��ڵ� FK
            REFERENCES TBL_STUDENT(STD_CODE)
--, CONSTRAINT REGISTER_REGI_CODE_CK CHECK(REGISTER_CODE BETWEEN 30000 AND 39999)      -- ������û�ڵ� CK
);
--==>> Table TBL_REGISTER��(��) �����Ǿ����ϴ�.


-- �������� ���̺� ����
-- ��� �� 0 <= ��� <= ������  ���ν������� �����ؾ��� �κ�
CREATE TABLE TBL_SCORE
( REGISTER_CODE VARCHAR2(20) CONSTRAINT SCORE_REGISTER_CODE_NN NOT NULL             -- ������û�ڵ�
, OPENS_CODE    VARCHAR2(20) CONSTRAINT SCORE_OPENS_CODE_NN NOT NULL                -- ���񰳼��ڵ�
, C_SCORE       NUMBER(3)                                                           -- ���
, S_SCORE       NUMBER(3)                                                           -- �Ǳ�
, P_SCORE       NUMBER(3)                                                           -- �ʱ�
, CONSTRAINT SCORE_REGISTER_CODE_FK FOREIGN KEY(REGISTER_CODE)
             REFERENCES TBL_REGISTER(REGISTER_CODE)
, CONSTRAINT SCORE_OPENS_CODE_FK FOREIGN KEY(OPENS_CODE)
             REFERENCES TBL_OPENS(OPENS_CODE)
);
--==>> Table TBL_SCORE��(��) �����Ǿ����ϴ�.


-- �ߵ�Ż��
-- �ߵ�Ż������ ������������ <= �ߵ�Ż������ < ������������   �� ���ν������� �����ؾ��� �κ�
-- ���� �ߵ�Ż�� ��û���ڿ� ��ܿ� �߰��� Ż�����ڰ� �ٸ� �� �־ DEFAULT SYSDATE �������� �ʾ���
CREATE TABLE TBL_FAIL
( REGISTER_CODE VARCHAR2(20)     CONSTRAINT FAIL_REGISTER_CODE_NN NOT NULL           -- ������û�ڵ�
, FAIL_DATE     DATE            CONSTRAINT FAIL_FAIL_DATE_NN NOT NULL               -- �ߵ�Ż������
, FAIL_REASON   VARCHAR2(100)                                                       -- �ߵ�Ż������
, CONSTRAINT FAIL_REGISTER_CODE_FK FOREIGN KEY(REGISTER_CODE)
             REFERENCES TBL_REGISTER(REGISTER_CODE)
);
--==>> Table TBL_FAIL��(��) �����Ǿ����ϴ�.

------------------------------���̺� ���� ��-------------------------------------

------------------------------������ �Է�----------------------------------------
-- ������ ���� �Է�
INSERT INTO TBL_ADMIN(ADMIN_CODE,ADMIN_PW)
VALUES('ADMIN',1234);

-- �л� �Է� 
EXEC PRC_STUDENT_INSERT('�谡��', '2345678');
EXEC PRC_STUDENT_INSERT('�輭��', '2456789');
EXEC PRC_STUDENT_INSERT('������', '2102938');
EXEC PRC_STUDENT_INSERT('�̻�ȭ', '2683941');
EXEC PRC_STUDENT_INSERT('�̻���', '2987646');
EXEC PRC_STUDENT_INSERT('��ȣ��', '1029385');
EXEC PRC_STUDENT_INSERT('������', '2385921');
EXEC PRC_STUDENT_INSERT('������', '2638493');
EXEC PRC_STUDENT_INSERT('������', '1958302');
EXEC PRC_STUDENT_INSERT('������', '1385921');
EXEC PRC_STUDENT_INSERT('���ϸ�', '4385921');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

-- ���� �Է�
EXEC PRC_PROFESSOR_INSERT('����ȣ', '1234567');
EXEC PRC_PROFESSOR_INSERT('������', '1968203');
EXEC PRC_PROFESSOR_INSERT('�ں���', '2968391');
EXEC PRC_PROFESSOR_INSERT('���α�', '1968402'); 
EXEC PRC_PROFESSOR_INSERT('�ں���', '2596820');
EXEC PRC_PROFESSOR_INSERT('�۰�', '1852818');
EXEC PRC_PROFESSOR_INSERT('�̼�', '2485921');
EXEC PRC_PROFESSOR_INSERT('�ں���', '2948518');
EXEC PRC_PROFESSOR_INSERT('�����', '2182212');
EXEC PRC_PROFESSOR_INSERT('������', '2166192');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

-- ���� ���� �Է�
EXEC PRC_COURSE_INSERT('�Ӻ���� �÷��� ���� ���� ������ �缺 ����');
EXEC PRC_COURSE_INSERT('AWS Ŭ���� Ȱ�� Ǯ���� ������ �缺 ����');
EXEC PRC_COURSE_INSERT('JAVA ����� ����Ʈ �� Ǯ���� ������ �缺����');
EXEC PRC_COURSE_INSERT('JAVA�� Ȱ���� �� ������ �缺����');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

-- ���� ���� �Է�
EXEC PRC_SUBJECT_INSERT('Java');
EXEC PRC_SUBJECT_INSERT('Oracle');
EXEC PRC_SUBJECT_INSERT('HTML');
EXEC PRC_SUBJECT_INSERT('CSS');
EXEC PRC_SUBJECT_INSERT('JSP');
EXEC PRC_SUBJECT_INSERT('Servlet');
EXEC PRC_SUBJECT_INSERT('UI/UX');
EXEC PRC_SUBJECT_INSERT('JavaScript');
EXEC PRC_SUBJECT_INSERT('jQuery');
EXEC PRC_SUBJECT_INSERT('��Ʈ��ũ');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

-- ���ǽ� �Է�
EXEC PRC_ROOM_INSERT('A������', 20)
EXEC PRC_ROOM_INSERT('B������', 10)
EXEC PRC_ROOM_INSERT('C������', 15)
EXEC PRC_ROOM_INSERT('D������', 25)
EXEC PRC_ROOM_INSERT('E������', 18)
EXEC PRC_ROOM_INSERT('F������', 22)
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

-- ���� �Է�
EXEC PRC_BOOK_INSERT('�ڹ��� ����');
EXEC PRC_BOOK_INSERT('�̰��� �ڹٴ�');
EXEC PRC_BOOK_INSERT('HTML5+CSS3 ��ǥ���� ����');
EXEC PRC_BOOK_INSERT('Do it! �ڹٽ�ũ��Ʈ + �������� �Թ�');
EXEC PRC_BOOK_INSERT('���� ��� �������� AWS ������ ���� ���̵�');
EXEC PRC_BOOK_INSERT('UML ���ʿ� ����');
EXEC PRC_BOOK_INSERT('����Ŭ�� ���� �����ͺ��̽� ���а� �ǽ�');
EXEC PRC_BOOK_INSERT('����� ��Ʈ��ũ');
EXEC PRC_BOOK_INSERT('JSP �� ���α׷��� �Թ�+Ȱ��');
EXEC PRC_BOOK_INSERT('UI/UX �䱸 �м�');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.


