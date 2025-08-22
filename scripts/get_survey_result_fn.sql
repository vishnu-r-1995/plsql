-- Create function
-- Conditional Aggregation with Ratios:
-- Uses SUM(CASE ...) to count specific conditions (action = 'answer' or show) and computes a ratio (answer_count / show_count)
-- Common in analytics for calculating metrics like conversion rates, success rates, or probabilities

ALTER SESSION SET CURRENT_SCHEMA=appuser;

CREATE OR REPLACE FUNCTION get_survey_result_fn (
    p_column_name IN VARCHAR2,
    p_condition IN VARCHAR2
) RETURN VARCHAR2
IS
    v_sql VARCHAR2(1000);
    v_result VARCHAR2(100);
BEGIN
    IF p_column_name NOT IN ('question_id') THEN
        RAISE_APPLICATION_ERROR(-20001, 'Invalid column name. Use: question_id');
    END IF;
    IF p_condition NOT IN ('MAX', 'MIN') THEN
        RAISE_APPLICATION_ERROR(-20002, 'Invalid condition. Use: MAX, MIN');
    END IF;

    v_sql := '
        WITH answer_rate AS (
            SELECT question_id, 
                   CASE 
                       WHEN SUM(CASE WHEN action = ''show'' THEN 1 ELSE 0 END) = 0 THEN 0
                       ELSE SUM(CASE WHEN action = ''answer'' THEN 1 ELSE 0 END) / 
                            SUM(CASE WHEN action = ''show'' THEN 1 ELSE 0 END)
                   END AS rate
            FROM surveylog
            GROUP BY question_id
            ORDER BY question_id
        )
        SELECT surveylog.' || p_column_name || '
        FROM answer_rate
        INNER JOIN surveylog on answer_rate.question_id = surveylog.question_id
        WHERE rate = (SELECT ' || p_condition || '(rate) FROM answer_rate)
        AND ROWNUM = 1';

    EXECUTE IMMEDIATE v_sql INTO v_result;
    RETURN v_result;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'Error in get_survey_result_fn: ' || SQLERRM);
END;
/