ALTER SESSION SET CURRENT_SCHEMA = appuser;

-- Create base table
CREATE TABLE surveylog (
    question_id VARCHAR2(50),
    action VARCHAR2(20)
);

-- Sample data
INSERT INTO surveylog VALUES ('Q1', 'show');
INSERT INTO surveylog VALUES ('Q1', 'answer');
INSERT INTO surveylog VALUES ('Q1', 'answer');
INSERT INTO surveylog VALUES ('Q2', 'show');
INSERT INTO surveylog VALUES ('Q2', 'show');
INSERT INTO surveylog VALUES ('Q2', 'answer');
COMMIT;