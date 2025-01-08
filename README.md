# Canteen Management System (PL/SQL Project)

# created by : Shinde Mitanshu Dipak

# College Name : Amrutvahini College of Engineering

## description :
A Canteen Management System (CMS) using PL/SQL (Procedural Language/Structured Query Language) is a database-driven application designed to manage various aspects of a canteen or cafeteria in an institution like a school, college, office, or organization. The main objective of the system is to automate the operations of the canteen, including managing food items, orders, employee details, inventory, and payments. The CMS typically uses a back-end database powered by *PL/SQL to ensure data consistency, integrity, and efficiency in managing these operations.



 ## Key Functionalities of the Canteen Management System

1.1 Food Item Management
- Adding new food items: New dishes or snacks are added to the system with details such as name, category (vegetarian/non-vegetarian), price, and stock quantity.
- Modifying existing items: Food items can be updated, including changing prices, descriptions, or availability.
- Deleting food items: Items that are no longer available can be removed from the menu.

 1.2 Order Management
- Placing orders: Users (students, employees, etc.) can place orders for food items.
- Tracking orders: The system tracks the status of the orders (pending, completed, or cancelled).
- Order history: Users can view their order history and check previous orders made.

 1.3 Inventory Management
- Stock management: The system keeps track of the available stock of ingredients and food items.
- Restocking: When stock levels are low, the system can generate notifications to request restocking.
- **Stock depletion tracking**: When items are sold or consumed, the system decreases the stock automatically.

1.4 Employee Management
- Employee details: Manage employee information like name, role (cook, cashier, etc.), contact information, and salary.
- Employee scheduling: Schedule shifts for employees and track their attendance.
- Payroll: Manage salary details, deductions, and other financial aspects for employees.

1.5 Payment and Billing
- Billing system: Once the order is placed, the system generates a bill that shows the price of each item and the total amount.
- Payment options: It can accept different payment methods (cash, card, or online payments).
- Invoice generation: A receipt or invoice is generated upon successful payment.

1.6 Reporting and Analytics
- Sales reports: Track daily, weekly, or monthly sales data.
- Stock report: Generate inventory reports to track stock consumption.
- Employee performance report: Evaluate the performance and attendance of canteen employees.

1.7 User Authentication and Role-based Access
- Admin and User roles: Different user roles (Admin, Employee, Customer) have different access privileges.
- Login/Logout system Users must authenticate themselves to access the system, ensuring security.


 ## Database Schema for the Canteen Management System**

The Canteen Management System would require a **relational database schema** to store and organize its data efficiently. Here’s an outline of a possible schema:

#### 2.1 **Tables**

1. **Customers Table**
   - `Customer_ID` (Primary Key)
   - `Name`
   - `Email`
   - `Phone_Number`
   - `Address`

2. **Food Items Table**
   - `Food_ID` (Primary Key)
   - `Food_Name`
   - `Category` (e.g., snacks, beverages, meals)
   - `Price`
   - `Stock_Quantity`

3. **Orders Table**
   - `Order_ID` (Primary Key)
   - `Customer_ID` (Foreign Key referencing `Customers`)
   - `Order_Date`
   - `Total_Price`
   - `Order_Status` (e.g., Pending, Completed, Cancelled)

4. **Order Details Table**
   - `Order_Detail_ID` (Primary Key)
   - `Order_ID` (Foreign Key referencing `Orders`)
   - `Food_ID` (Foreign Key referencing `Food Items`)
   - `Quantity`
   - `Price` (Price at the time of order)

5. **Employees Table**
   - `Employee_ID` (Primary Key)
   - `Name`
   - `Role`
   - `Salary`
   - `Shift_Timing`
   - `Contact_Info`

6. **Inventory Table**
   - `Inventory_ID` (Primary Key)
   - `Food_ID` (Foreign Key referencing `Food Items`)
   - `Stock_Level`
   - `Restock_Level`

7. **Payments Table**
   - `Payment_ID` (Primary Key)
   - `Order_ID` (Foreign Key referencing `Orders`)
   - `Payment_Method` (e.g., Cash, Credit, Debit, Online)
   - `Payment_Amount`
   - `Payment_Date`

8. **Login Table**
   - `User_ID` (Primary Key)
   - `Username`
   - `Password`
   - `Role` (Admin, Employee, User)

---

### 3. **PL/SQL Procedures and Functions**

PL/SQL, being an extension of SQL, allows for writing stored procedures, functions, and triggers to handle complex operations. Here’s how it can be utilized:

#### 3.1 **Stored Procedures**
- **Place an Order**: A stored procedure can be written to add an order and update the stock when the order is confirmed.
  
  ```sql
  CREATE OR REPLACE PROCEDURE PlaceOrder (
      p_customer_id IN NUMBER,
      p_food_id IN NUMBER,
      p_quantity IN NUMBER
  ) IS
      v_price NUMBER;
      v_total NUMBER;
  BEGIN
      -- Get the price of the food item
      SELECT price INTO v_price FROM food_items WHERE food_id = p_food_id;
      
      -- Calculate total price
      v_total := v_price * p_quantity;
      
      -- Insert order details
      INSERT INTO orders (customer_id, order_date, total_price, order_status)
      VALUES (p_customer_id, SYSDATE, v_total, 'Pending');
      
      -- Update the stock
      UPDATE food_items
      SET stock_quantity = stock_quantity - p_quantity
      WHERE food_id = p_food_id;
  END PlaceOrder;
  ```

#### 3.2 **Triggers**
- **Stock Update Trigger**: A trigger can be set up to automatically update the stock whenever an order is placed.
  
  ```sql
  CREATE OR REPLACE TRIGGER update_stock_after_order
  AFTER INSERT ON order_details
  FOR EACH ROW
  BEGIN
      UPDATE food_items
      SET stock_quantity = stock_quantity - :NEW.quantity
      WHERE food_id = :NEW.food_id;
  END;
  ```

#### 3.3 **Functions**
- **Calculate Total Bill**: A function can be created to calculate the total price for an order based on the food items and their quantities.
  
  ```sql
  CREATE OR REPLACE FUNCTION CalculateTotalBill (
      p_order_id IN NUMBER
  ) RETURN NUMBER IS
      v_total NUMBER := 0;
  BEGIN
      SELECT SUM(od.quantity * fi.price)
      INTO v_total
      FROM order_details od
      JOIN food_items fi ON od.food_id = fi.food_id
      WHERE od.order_id = p_order_id;
      
      RETURN v_total;
  END CalculateTotalBill;
  ```

---

### 4. **PL/SQL Exception Handling**

In a real-world scenario, exceptions may arise due to various reasons like stock depletion, invalid data entry, or database connection issues. PL/SQL provides an exception-handling mechanism:

```sql
BEGIN
   -- Try placing the order
   PlaceOrder(1001, 10, 2);
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Food item not found.');
   WHEN DUP_VAL_ON_INDEX THEN
      DBMS_OUTPUT.PUT_LINE('Duplicate entry detected.');
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
```

---

### 5. **User Interface**

While the database and logic of the system would be handled by PL/SQL, the user interface (UI) for interacting with the system can be built using web technologies (HTML, CSS, JavaScript) or a desktop application (Java, C#). The UI would handle the following:

- Display food items
- Allow users to place and view orders
- Show available stock and allow employees to update inventory
- Generate invoices after payment
- Provide reports for admins

---

### 6. **Conclusion**

A **Canteen Management System** using PL/SQL helps automate and streamline the processes involved in running a canteen, from inventory and employee management to order processing and payment tracking. The system ensures better management of food items, stock levels, orders, and payments, while also offering insights through reporting features. With PL/SQL procedures, functions, and triggers, the backend becomes highly efficient in terms of data management and transaction handling.
