use [Bank Loan DB]

SELECT *
FROM bank_loan_data

-----Loan Applications------

SELECT COUNT(id) AS Total_Loan_Applications
FROM bank_loan_data;

-----Month to Date(MTD) Applications----

SELECT COUNT(id) AS Total_Applications
FROM bank_loan_data
WHERE MONTH(issue_date) = 12


-----Previous Month to Date(PMTD) Applications----

SELECT COUNT(id) AS Total_Applications
FROM bank_loan_data
WHERE MONTH(issue_date) = 11



-----Total Funded Amount-----

SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan_data



-----Month To Date(MTD) Funded Amount-----

SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 12



-----Previous Month To Date(PMTD) Total Funded Amount-----

SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 11


-----Total Amount Received-----

SELECT SUM(total_payment) AS Total_Amount_Collected
FROM bank_loan_data


-----Month To Date(MTD) Total Amount Received-----

SELECT SUM(total_payment) AS Total_Amount_Collected
FROM bank_loan_data
WHERE MONTH(issue_date) = 12


-----Previous Month To Date(PMTD) Total Amount Received-----


SELECT SUM(total_payment) AS Total_Amount_Collected
FROM bank_loan_data
WHERE MONTH(issue_date) = 11


-----Average Interest Rate-----


SELECT AVG(int_rate)*100 AS Avg_Int_Rate
FROM bank_loan_data


------Month To Date(MTD)------

SELECT AVG(int_rate)*100 AS MTD_Avg_Rate 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12


------Previous Month To Date(PMTD) Average Interest------

SELECT AVG(int_rate)*100 AS PMTD_Avg_Int_Rate
FROM bank_loan_data
WHERE MONTH(issue_date) = 11



-----Avg Debt To Income(DTI)-----

SELECT AVG(dti)*100 AS Avg_DTI
FROM bank_loan_data



-----Month To Date(MTD) Avg Debt To Income(DTI)------


SELECT AVG(dti)*100 AS PMTD_Avg_DTI
FROM bank_loan_data
WHERE MONTH(issue_date) = 12


-----Previous Month To Date(PMTD) Avg Debt To Income(DTI)------


SELECT AVG(dti)*100 AS PMTD_Avg_DTI
FROM bank_loan_data
WHERE MONTH(issue_date) = 11


----------------------------------------------------------------------
-------------------------GOOD LOAN ISSUED-----------------------------
----------------------------------------------------------------------



-----Good Loan Percentage------

SELECT
      (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END)*100.0)/COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data



-----Good Loan Applications------

SELECT COUNT(id) AS Good_Loan_Applications
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'


-----Good Loan Funded Amount------

SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'


------Good Loan Amount Received-----

SELECT SUM(total_payment) AS Good_Loan_amount_received
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'


------------------------------------------------------------------------
--------------------------BAD LOAN ISSUED-------------------------------
------------------------------------------------------------------------


-------Bad Loan Percentage-------

SELECT
      (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END)*100.0) /
	    COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data


-------Bad Loan Application------

SELECT COUNT(id) AS Bad_Loan_Applications
FROM bank_loan_data
WHERE loan_status = 'Charged Off'


-------Bad Loan Funded Amount-------

SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount
FROM bank_loan_data
WHERE loan_status = 'Charged Off'


--------Bad Loan Amount Received-------

SELECT SUM(total_payment) AS Bad_Loan_Amount_Received
FROM bank_loan_data
WHERE loan_status = 'Charged Off'


--------------------------------------------------------------------
---------------------------LOAN STATUS------------------------------
--------------------------------------------------------------------


SELECT loan_status,
       COUNT(id) AS LoanCount,
       SUM(total_payment) AS Total_Amount_Received,
	   SUM(loan_amount) AS Total_Funded_Amount,
	   AVG(int_rate * 100) AS Interest_Rate,
	   AVG(dti * 100) AS DTI
FROM bank_loan_data
GROUP BY loan_status



SELECT
      loan_status,
	  SUM(total_payment) AS MTD_Total_Amount_Received,
	  SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 12
GROUP BY loan_status



-----------------------------------------------------------------------
--------------------BANK LOAN REPORT|OVERVIEW--------------------------
-----------------------------------------------------------------------


----------MONTH WISE--------------

SELECT
      MONTH(issue_date) AS Month_Number,
	  DATENAME(MONTH,issue_date) AS Month_name,
	  COUNT(id) AS Total_Loan_Applications,
	  SUM(loan_amount) AS Total_Funded_Amount,
	  SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date),DATENAME(MONTH,issue_date)
ORDER BY MONTH(issue_date)


------------STATE WISE-------------


SELECT
      address_state AS State,
	  COUNT(id) AS Total_Loan_Applications,
	  SUM(loan_amount) AS Total_Funded_Amount,
	  SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state


-------------------TERM---------------------


SELECT
      term AS Term,
	  COUNT(id) AS Total_Loan_Applications,
	  SUM(loan_amount) AS Total_Funded_Amount,
	  SUM(total_payment) As Total_Amount_Received
FROM bank_loan_data
GROUP By term
ORDER By term



-----------------EMPLOYEE LENGTH---------------------

SELECT
      emp_length AS Employee_Lenght,
	  COUNT(id) AS Total_Loan_Applications,
	  SUM(loan_amount) AS Total_Funded_Amount,
	  SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP By emp_length
ORDER By emp_length


-----------------PURPOSE------------------

SELECT
      purpose AS Purpose,
	  COUNT(id) AS Total_Loan_Applications,
	  SUM(loan_amount) AS Total_Funded_Amount,
	  SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP By purpose
ORDER By purpose


-------------------------------------------------------------------------
--------------------------HOME OWNERSHIP---------------------------------
-------------------------------------------------------------------------

SELECT
     home_ownership AS Home_Ownership,
	 COUNT(id) AS Total_Applications,
	 SUM(loan_amount) AS Total_Funded_Amount,
	 SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership


--- NOTE: we have applied multiple filters on all the dashboards.
--- you can check the results for the filters as well by modifying query
--- and comparing the results

---eg:below we are looking for grade A only but you can look for each grade just by replacing A with any of given grade
----(A,B,C,D,E,F)

SELECT 
     purpose AS Purpose,
	 COUNT(id) AS Total_Loan_Applications,
	 SUM(loan_amount) AS Total_Funded_Amount,
	 SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose
