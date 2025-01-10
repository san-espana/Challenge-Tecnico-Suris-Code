# SurisChallenge

## Description

SurisChallenge is a web application designed to provide specific functionality with a .NET backend API and a React frontend, built with Vite. The app relies on a SQL Server database to store and manage data.

## Technologies Used

- **Frontend:** React (Vite)
- **Backend:** .NET API
- **Database:** SQL Server
- **Other:** Node.js, CSS/SCSS

## Features

- Backend API built with **.NET**
- Frontend application using **React** (Vite)
- Date picker functionality using **React DatePicker**
- Form management with **Formik** and validation using **Yup**
- AJAX requests handled with **AXIOS**
- Database connection to **SQL Server**
- Saved query containing tables, stored procedures, and data

## Installation

### Prerequisites

Ensure you have the following installed:

- [Node.js](https://nodejs.org/)
- [SQL Server](https://www.microsoft.com/en-us/sql-server)
- **.NET 7.0**

### Steps to Run Locally

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/suris-challenge.git


### Steps to Run Locally

2. **Navigate to the project directory:**
   ```bash
   cd suris-challenge


### Steps to Run Locally

3. **Set up the database:**
- In your **SQL Server** environment, execute the saved query provided in the repository. This query will create the necessary tables, stored procedures, and insert data into the database.

4. **Configure the .NET API:**
- Open the `appsettings.json` file in the **.NET API** project.
- Modify the Connection String with the one that I sent via email.

**Note:** I would NEVER use this connection string publicly for security reasons.

**Important:** The user credentials I created in the database were not functioning correctly, and I would need more time to debug it. However, the connection string should look something like this:

```json
"ConnectionStrings": {
  "DefaultConnection": "Server=your-server-name;Database=YourDatabase;User Id=your-username;Password=your-password"
}
```

5. **Install React dependencies:**
- In the **React** project folder, run the following command to install dependencies:
  ```bash
  npm install

6. **Run the .NET backend:**
- In the **.NET API** project folder, run the backend with:
  ```bash
  dotnet run

7. **Run the React frontend:**
- In the **React** project folder, run:
  ```bash
  npm run dev

8. **Access the app:**
- Open the URL provided in the terminal (usually `http://localhost:3000`) to view the application in your browser.



---

## Thank You for Reviewing! 🙌

Thank you for taking the time to check out my project! 🚀 This web application offers a **simple yet effective solution** for managing reservations, featuring a clean and functional interface. It showcases key skills in both **frontend and backend development**, including **form validation** and **data handling**. 

Feel free to explore the code, and don't hesitate to reach out if you have any questions or feedback. I'm always open to suggestions! 😊

**Happy coding!** 👨‍💻👩‍💻

---
