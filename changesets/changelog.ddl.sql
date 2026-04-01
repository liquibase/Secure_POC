--liquibase formatted sql

/*
    ********** Release 1.0.0 **********
*/
--changeset jbennett:ddl_create_table_organizations labels:release-1.0.0
CREATE TABLE ORGANIZATIONS (
    ID INT PRIMARY KEY NOT NULL,
    NAME VARCHAR(200),
    INDUSTRY VARCHAR(400),
    EMPLOYEE_COUNT INT
);
--rollback DROP TABLE ORGANIZATIONS;

--changeset jbennett:dml_insert_organizations labels:release-1.0.0
INSERT INTO ORGANIZATIONS (ID, NAME, INDUSTRY, EMPLOYEE_COUNT) VALUES (1, 'Acme Corporation', 'Explosives', 1);
INSERT INTO ORGANIZATIONS (ID, NAME, INDUSTRY, EMPLOYEE_COUNT) VALUES (2, 'Initech', 'Y2K', 50);
INSERT INTO ORGANIZATIONS (ID, NAME, INDUSTRY, EMPLOYEE_COUNT) VALUES (3, 'Umbrella Corporation', 'Zombies', 10000);
INSERT INTO ORGANIZATIONS (ID, NAME, INDUSTRY, EMPLOYEE_COUNT) VALUES (4, 'Soylent Corp', 'People', 100);
INSERT INTO ORGANIZATIONS (ID, NAME, INDUSTRY, EMPLOYEE_COUNT) VALUES (5, 'Globex Corp', 'Widgets', 5000);
--rollback DELETE FROM ORGANIZATIONS WHERE ID BETWEEN 1 AND 5;

/*
    ********** Release 1.0.1 **********
*/
--changeset dzentgraf:ddl_create_table_addresses labels:release-1.0.1
CREATE TABLE ADDRESSES (
    ID INT PRIMARY KEY NOT NULL,
    ADDRESS_LINE_1 VARCHAR(500),
    CITY VARCHAR(200),
    STATE VARCHAR(3),
    ZIP_CODE VARCHAR(9),
    ORG_ID INT
);
--rollback DROP TABLE ADDRESSES;

--changeset dzentgraf:ddl_create_fk_addresses labels:release-1.0.1
ALTER TABLE ADDRESSES
    ADD CONSTRAINT ORG_FK1
    FOREIGN KEY (ORG_ID)
    REFERENCES ORGANIZATIONS(ID);
--rollback ALTER TABLE ADDRESSES DROP CONSTRAINT ORG_FK1;

--changeset dzentgraf:ddl_create_table_employees labels:release-1.0.1
CREATE TABLE EMPLOYEES (
    ID INT PRIMARY KEY NOT NULL,
    FIRST_NAME VARCHAR(200),
    LAST_NAME VARCHAR(200),
    DATE_OF_BIRTH DATE,
    EMAIL_ADDRESS VARCHAR(200),
    ORG_ID INT
);
--rollback DROP TABLE EMPLOYEES;

--changeset dzentgraf:dml_insert_employees labels:release-1.0.1
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DATE_OF_BIRTH, EMAIL_ADDRESS, ORG_ID) VALUES (1, 'Taylor', 'Morgan', DATE('1988-04-15'), 'redacted@example.com', 1);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DATE_OF_BIRTH, EMAIL_ADDRESS, ORG_ID) VALUES (2, 'Jordan', 'Lee', DATE('1992-09-03'), 'redacted@example.com', 2);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DATE_OF_BIRTH, EMAIL_ADDRESS, ORG_ID) VALUES (3, 'Casey', 'Nguyen', DATE('1985-12-22'), 'redacted@example.com', 3);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DATE_OF_BIRTH, EMAIL_ADDRESS, ORG_ID) VALUES (4, 'Riley', 'Patel', DATE('1990-06-11'), 'redacted@example.com', 4);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, DATE_OF_BIRTH, EMAIL_ADDRESS, ORG_ID) VALUES (5, 'Avery', 'Chen', DATE('1995-02-27'), 'redacted@example.com', 5);
--rollback DELETE FROM EMPLOYEES WHERE ID BETWEEN 1 AND 5;

/*
    ********** Release 1.0.2 **********
*/
--changeset molivas:ddl_create_fk_employees labels:release-1.0.2
ALTER TABLE EMPLOYEES
    ADD CONSTRAINT ORG_FK2
    FOREIGN KEY (ORG_ID)
    REFERENCES ORGANIZATIONS(ID);
--rollback ALTER TABLE EMPLOYEES DROP CONSTRAINT ORG_FK2;

--changeset jbennett:dml_delete_organizations labels:release-1.0.2
DELETE FROM ORGANIZATIONS;
--rollback empty

--changeset molivas:sp_create_getemployeesbyorg labels:release-1.0.2 --splitStatements:false --runOnChange:true
CREATE OR REPLACE FUNCTION get_employees_by_org(p_org_id integer)
RETURNS TABLE (
    ID integer,
    FIRST_NAME varchar,
    LAST_NAME varchar,
    DATE_OF_BIRTH date
) AS $$
BEGIN
    RETURN QUERY
    SELECT e.ID, e.FIRST_NAME, e.LAST_NAME, e.DATE_OF_BIRTH
    FROM EMPLOYEES e
    WHERE e.ORG_ID = p_org_id;
END;
$$ LANGUAGE plpgsql;
--rollback DROP FUNCTION IF EXISTS get_employees_by_org(integer);

/*
    ********** Release 1.0.3 **********
*/
--changeset jbennett:dml_email_fix labels:jira-1388,release-1.0.3
UPDATE EMPLOYEES SET EMAIL_ADDRESS = 'taylor.morgan2@example.com' WHERE ID = 1;
--rollback UPDATE EMPLOYEES SET EMAIL_ADDRESS = 'redacted@example.com' WHERE ID = 1;

--changeset mikeo:dcl_grant_employee_guest labels:jira-1412,release-1.0.3
GRANT SELECT ON EMPLOYEES TO guest;
--rollback REVOKE SELECT ON EMPLOYEES FROM guest;