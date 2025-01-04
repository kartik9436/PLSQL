CREATE TABLE food_menu (
    food_id NUMBER PRIMARY KEY,
    food_name VARCHAR2(100) NOT NULL,
    food_price NUMBER NOT NULL,
    votes NUMBER DEFAULT 0
);

CREATE TABLE orders (
    order_id NUMBER PRIMARY KEY,
    food_id NUMBER,
    customer_name VARCHAR2(100) NOT NULL,
    order_date DATE DEFAULT SYSDATE,
    quantity NUMBER DEFAULT 1,
    FOREIGN KEY (food_id) REFERENCES food_menu(food_id)
);

CREATE TABLE food_votes (
    vote_id NUMBER PRIMARY KEY,
    food_id NUMBER,
    customer_name VARCHAR2(100),
    vote_date DATE DEFAULT SYSDATE,
    FOREIGN KEY (food_id) REFERENCES food_menu(food_id)
);

CREATE SEQUENCE seq_food_id
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

CREATE SEQUENCE seq_order_id
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

CREATE SEQUENCE seq_vote_id
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

CREATE OR REPLACE PROCEDURE add_food_to_menu (
    p_food_name IN VARCHAR2,
    p_food_price IN NUMBER
) IS
BEGIN
    INSERT INTO food_menu (food_id, food_name, food_price)
    VALUES (seq_food_id.NEXTVAL, p_food_name, p_food_price);
    COMMIT;
END add_food_to_menu;
/

CREATE OR REPLACE PROCEDURE place_order (
    p_customer_name IN VARCHAR2,
    p_food_id IN NUMBER,
    p_quantity IN NUMBER
) IS
    v_food_price NUMBER;
BEGIN
    BEGIN
        SELECT food_price INTO v_food_price
        FROM food_menu
        WHERE food_id = p_food_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Error: Food item not found for the provided food_id.');
            RETURN;
    END;
    INSERT INTO orders (order_id, food_id, customer_name, quantity)
    VALUES (seq_order_id.NEXTVAL, p_food_id, p_customer_name, p_quantity);
    COMMIT;
END place_order;
/

CREATE OR REPLACE PROCEDURE vote_for_food (
    p_customer_name IN VARCHAR2,
    p_food_id IN NUMBER
) IS
BEGIN
    DECLARE
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM food_votes WHERE customer_name = p_customer_name AND food_id = p_food_id;
        IF v_count > 0 THEN
            DBMS_OUTPUT.PUT_LINE('You have already voted for this item.');
        ELSE
            INSERT INTO food_votes (vote_id, food_id, customer_name)
            VALUES (seq_vote_id.NEXTVAL, p_food_id, p_customer_name);
            UPDATE food_menu
            SET votes = votes + 1
            WHERE food_id = p_food_id;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Thank you for voting!');
        END IF;
    END;
END vote_for_food;
/

CREATE OR REPLACE PROCEDURE view_menu IS
BEGIN
    FOR food_rec IN (SELECT * FROM food_menu) LOOP
        DBMS_OUTPUT.PUT_LINE('Food ID: ' || food_rec.food_id || ' | Name: ' || food_rec.food_name || ' | Price: ' || food_rec.food_price || ' | Votes: ' || food_rec.votes);
    END LOOP;
END view_menu;
/

CREATE OR REPLACE PROCEDURE view_orders IS
BEGIN
    FOR order_rec IN (SELECT * FROM orders) LOOP
        DBMS_OUTPUT.PUT_LINE('Order ID: ' || order_rec.order_id || ' | Customer: ' || order_rec.customer_name || ' | Food ID: ' || order_rec.food_id || ' | Quantity: ' || order_rec.quantity || ' | Date: ' || order_rec.order_date);
    END LOOP;
END view_orders;
/

CREATE OR REPLACE PROCEDURE view_voting_results IS
BEGIN
    FOR vote_rec IN (SELECT food_id, food_name, votes FROM food_menu ORDER BY votes DESC) LOOP
        DBMS_OUTPUT.PUT_LINE('Food ID: ' || vote_rec.food_id || ' | Name: ' || vote_rec.food_name || ' | Votes: ' || vote_rec.votes);
    END LOOP;
END view_voting_results;
/

BEGIN
    add_food_to_menu('Pasta', 120);
    add_food_to_menu('Burger', 80);
    add_food_to_menu('Pizza', 150);
    add_food_to_menu('Salad', 50);
END;
/

BEGIN
    place_order('Mitanshu', 1, 2);
    place_order('Nitin', 2, 1);
    place_order('Bhavik', 3, 3);
END;
/

BEGIN
    vote_for_food('Mitanshu', 1);
    vote_for_food('Bhavik', 2);
    vote_for_food('Nitin', 3);
    vote_for_food('Mitanshu', 2);
END;
/

BEGIN
    view_menu;
END;
/

BEGIN
    view_orders;
END;
/

BEGIN
    view_voting_results;
END;
/
