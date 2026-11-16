SET search_path TO public;

-- Clear before creating the tables in case there is any scratch data and to prevent bugs and errors
DROP TABLE IF EXISTS teaching_allocation CASCADE;
DROP TABLE IF EXISTS planned_activity CASCADE;
DROP TABLE IF EXISTS course_instance CASCADE;
DROP TABLE IF EXISTS course_layout CASCADE;
DROP TABLE IF EXISTS salary_history CASCADE;
DROP TABLE IF EXISTS employee CASCADE;
DROP TABLE IF EXISTS department CASCADE;
DROP TABLE IF EXISTS activity_type CASCADE;
DROP TABLE IF EXISTS system_rules CASCADE;

-- Abbasi
-- ACTIVITY_TYPE
CREATE TABLE activity_type (
    activity_name VARCHAR(50) PRIMARY KEY,
    multiplication_factor DECIMAL(4,2) NOT NULL CHECK (multiplication_factor >= 0)
);
-- SYSTEM_RULES
CREATE TABLE system_rules (
    rule_name VARCHAR(100) PRIMARY KEY,
    rule_value DECIMAL(10,3) NOT NULL
);

-- Samat
-- DEPARTMENT
CREATE TABLE department (
    department_id SERIAL PRIMARY KEY,--Serial
    department_name VARCHAR(100) NOT NULL,
    manager_employee_id INT NULL UNIQUE   -- NULL until the manager exists
);
-- EMPLOYEE
CREATE TABLE employee (
    employee_id SERIAL PRIMARY KEY, --Serial
    name VARCHAR(50) NOT NULL,
    title VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    department_id INT NOT NULL REFERENCES department(department_id),
    supervisor_id INT NULL REFERENCES employee(employee_id)
);
-- SALARY_HISTORY
CREATE TABLE salary_history (
    employee_id INT NOT NULL REFERENCES employee(employee_id), --serial
    effective_date DATE NOT NULL,
    salary DECIMAL(10,2) NOT NULL CHECK (salary >= 0),
    PRIMARY KEY (employee_id, effective_date)
);

-- Links department.manager_employee_id to an existing employee_id in the employee table
ALTER TABLE department -- Name of the rule. Constraint is rule
ADD CONSTRAINT fk_department_manager
FOREIGN KEY (manager_employee_id) REFERENCES employee(employee_id);

-- Husein
-- COURSE_LAYOUT
CREATE TABLE course_layout (
    course_code VARCHAR(20) NOT NULL,
    effective_date DATE NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    hp DECIMAL(3,1) NOT NULL CHECK (hp > 0),
    min_students INT NOT NULL CHECK (min_students >= 0),
    max_students INT NOT NULL,
    PRIMARY KEY (course_code, effective_date),
    CHECK (min_students <= max_students)
);
-- COURSE_INSTANCE
CREATE TABLE course_instance (
    course_instance_id VARCHAR(20) PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL,
    effective_date DATE NOT NULL,
    period VARCHAR(2) NOT NULL CHECK (period IN ('P1','P2','P3','P4')),
    year INT NOT NULL,
    num_students INT NOT NULL CHECK (num_students >= 0),
    FOREIGN KEY (course_code, effective_date) REFERENCES course_layout(course_code, effective_date)
);
-- PLANNED_ACTIVITY
CREATE TABLE planned_activity (
    course_instance_id VARCHAR(20) NOT NULL REFERENCES course_instance(course_instance_id),
    activity_name VARCHAR(50) NOT NULL REFERENCES activity_type(activity_name),
    planned_hours INT NOT NULL CHECK (planned_hours >= 0),
    PRIMARY KEY (course_instance_id, activity_name)
);
-- TEACHING_ALLOCATION
CREATE TABLE teaching_allocation (
    allocation_id SERIAL PRIMARY KEY,
    employee_id INT NOT NULL REFERENCES employee(employee_id),
    course_instance_id VARCHAR(20) NOT NULL REFERENCES course_instance(course_instance_id),
    activity_name VARCHAR(50) NOT NULL REFERENCES activity_type(activity_name),
    allocated_hours INT NOT NULL CHECK (allocated_hours >= 0),
    UNIQUE (employee_id, course_instance_id, activity_name)
);
-- Abbasi
DROP FUNCTION IF EXISTS check_max_course_instances() CASCADE;
-- CHECK_MAX_COURSE_INSTANCES
CREATE FUNCTION check_max_course_instances() RETURNS trigger 
LANGUAGE plpgsql AS $$
DECLARE
    max_allowed INT;
    new_year INT;
    new_period VARCHAR;
    current_count INT;
BEGIN
    -- Get the limit from system_rules which in our case is 4
    SELECT rule_value 
    INTO max_allowed
    FROM system_rules 
    WHERE rule_name = 'max_course_instances_per_period';

    -- Get the year and period of the instance we are adding
    SELECT year, period 
    INTO new_year, new_period
    FROM course_instance 
    WHERE course_instance_id = NEW.course_instance_id;

    -- Get how many other instances this teacher already has in that period
    SELECT COUNT(DISTINCT ta.course_instance_id) INTO current_count
    FROM teaching_allocation ta
    JOIN course_instance ci ON ci.course_instance_id = ta.course_instance_id
    WHERE ta.employee_id = NEW.employee_id
      AND ci.year = new_year
      AND ci.period = new_period
      AND ta.course_instance_id <> NEW.course_instance_id
      AND ta.allocation_id <> NEW.allocation_id;

    --  Stop if the teacher is already at the limit
    IF current_count >= max_allowed THEN
       RAISE EXCEPTION 'Employee % has reached the maximum course instances for this period.', NEW.employee_id;
    END IF;
    RETURN NEW;
END;
$$;
-- Checks the max course limit before adding or updating a row
CREATE TRIGGER trg_max_course_instances
BEFORE INSERT OR UPDATE ON teaching_allocation
FOR EACH ROW EXECUTE FUNCTION check_max_course_instances();