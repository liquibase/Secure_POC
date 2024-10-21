--liquibase formatted sql

--changeset jbennett:ddl_create_table_organizations labels:release-1.0.0
CREATE TABLE ORGANIZATIONS (
    ID NUMBER PRIMARY KEY,
    NAME VARCHAR2(200),
    INDUSTRY VARCHAR2(400),
    EMPLOYEE_COUNT NUMBER
);  
--rollback DROP TABLE ORGANIZATIONS;

--changeset jbennett:dml_insert_organizations labels:release-1.1.0
INSERT INTO ORGANIZATIONS VALUES (1, 'Acme Corporation', 'Explosives', 1);
INSERT INTO ORGANIZATIONS VALUES (2, 'Initech', 'Y2K', 50);
INSERT INTO ORGANIZATIONS VALUES (3, 'Umbrella Corporation', 'Zombies', 10000);
INSERT INTO ORGANIZATIONS VALUES (4, 'Soylent Corp', 'People', 100);
INSERT INTO ORGANIZATIONS VALUES (5, 'Globex Corp', 'Widgets', 5000);
--rollback DELETE FROM ORGANIZATIONS WHERE ID BETWEEN 1 AND 5;

--changeset jbennett:ddl_create_table_addresses labels:release-1.2.0
CREATE TABLE ADDRESSES (
    ID NUMBER PRIMARY KEY,
    ADDRESS_LINE_1 VARCHAR2(500),
    CITY VARCHAR2(200),
    STATE VARCHAR2(3),
    ZIP_CODE VARCHAR2(9),
    ORG_ID NUMBER
);
--rollback DROP TABLE ADDRESSES;

--changeset jbennett:dml_create_constraint_addresses labels:release-1.2.0
ALTER TABLE ADDRESSES ADD CONSTRAINT ORG_FK1 FOREIGN KEY (ORG_ID) REFERENCES ORGANIZATIONS(ID);
--rollback ALTER TABLE ADDRESSES DROP CONSTRAINT ORG_FK1;

--changeset jbennett:ddl_create_table_employees labels:release-1.3.0
CREATE TABLE EMPLOYEES (
    ID NUMBER PRIMARY KEY,
    FIRST_NAME  VARCHAR2(200),
    LAST_NAME  VARCHAR2(200),
    DATE_OF_BIRTH VARCHAR2(50),
    ORG_ID NUMBER
);  
--rollback DROP TABLE EMPLOYEES;

--changeset jbennett:dml_create_constraint_employees labels:release-1.3.0
ALTER TABLE EMPLOYEES ADD CONSTRAINT ORG_FK2 FOREIGN KEY (ORG_ID) REFERENCES ORGANIZATIONS(ID);
--rollback ALTER TABLE EMPLOYEES DROP CONSTRAINT ORG_FK2;