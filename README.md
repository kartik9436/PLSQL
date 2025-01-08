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



### 6. **Conclusion**

A **Canteen Management System** using PL/SQL helps automate and streamline the processes involved in running a canteen, from inventory and employee management to order processing and payment tracking. The system ensures better management of food items, stock levels, orders, and payments, while also offering insights through reporting features. With PL/SQL procedures, functions, and triggers, the backend becomes highly efficient in terms of data management and transaction handling.
