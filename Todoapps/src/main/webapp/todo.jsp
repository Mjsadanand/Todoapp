
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) session1.getAttribute("username");

    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/todolist", "root", "Veda@718");
    PreparedStatement ps = con.prepareStatement("SELECT * FROM tasks WHERE username = ?");
    ps.setString(1, username);
    ResultSet rs = ps.executeQuery();
    boolean hasTasks = rs.isBeforeFirst();
 
    PreparedStatement ps2 = con.prepareStatement("SELECT first_name, last_name, dob, email FROM register WHERE username = ?");
    ps2.setString(1, username);
    ResultSet rs2 = ps2.executeQuery();

    String firstName = "", lastName = "", dob = "", email = "";
    if (rs2.next()) {
        firstName = rs2.getString("first_name");
        lastName = rs2.getString("last_name");
        dob = rs2.getString("dob");
        email = rs2.getString("email");
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>To-Do List</title>
    <link rel="stylesheet" href="todo.css">
    <script>
        function setGreeting() {
            var now = new Date();
            var hour = now.getHours();
            var greeting;

            if (hour >= 5 && hour < 12) {
                greeting = "Good Morning";
            } else if (hour >= 12 && hour < 17) {
                greeting = "Good Afternoon";
            } 
            else if (hour >= 17 && hour < 19) {
                greeting = "Good Evening";
            }else {
                greeting = "Good Night";
            }

            document.getElementById("greeting").innerHTML = greeting + ", <%= username %>!";
        }

        function toggleDropdown() {
            document.getElementById("dropdown").classList.toggle("show");
        }
        
        function openModal() {
            document.getElementById("todoModal").style.display = "block";
        }
        
        function closeModal() {
            document.getElementById("todoModal").style.display = "none";
        }
        function openProfileModal() {
            document.getElementById("profileFirstName").innerText = "<%= firstName %>";
            document.getElementById("profileLastName").innerText = "<%= lastName %>";
            document.getElementById("profileDOB").innerText = "<%= dob %>";
            document.getElementById("profileEmail").innerText = "<%= email %>";
            document.getElementById("profileModal").style.display = "block";
        }

        function closeProfileModal() {
            document.getElementById("profileModal").style.display = "none";
        }

    </script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
        }
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #333;
            color: white;
            padding: 10px 20px;
        }
        .navbar .greeting {
            font-size: 18px;
        }
        .container {
            width: 100%;
            padding: 20px;
        }
        .btn {
            padding: 10px 15px;
            margin: 10px 0;
            background-color: black;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.4);
        }
        .modal-content {
            background-color: white;
            margin: 15% auto;
            padding: 20px;
            width: 50%;
            border-radius: 5px;
        }
        .close {
            float: right;
            cursor: pointer;
            font-size: 20px;
        }
        .modal-content input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .modal-content button {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
        .modal-content button:hover {
            background-color: #218838;
        }
        .no-tasks {
            text-align: center;
            margin-top: 20px;
            font-size: 18px;
            color: #666;
        }
        .profile {
            position: relative;
            display: inline-block;
        }
        .profile-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
        }
        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background-color: white;
            min-width: 150px;
            box-shadow: 0px 4px 8px rgba(0,0,0,0.2);
            z-index: 1;
            border-radius: 5px;
        }
        .dropdown-content a {
            color: black;
            padding: 10px;
            text-decoration: none;
            display: block;
        }
        .dropdown-content a:hover {
            background-color: #ddd;
        }
          .show {
            display: block;
        }
             .btn.delete {
            color: black;
            background-color: transparent;
        }
        .btn.edit {
            color: black;
            background-color: transparent;
        }
        table th{
        color:black;
        background-color: lightblue;
        }
        table, th, td {
    border: 2px solid #ddd;
    padding: 8px;
}
.modal {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.4);
}

.modal-content {
    background-color: white;
    margin: 15% auto;
    padding: 20px;
    width: 40%;
    border-radius: 5px;
    text-align: center;
}

.close {
    float: right;
    cursor: pointer;
    font-size: 20px;
}
select {
    width: 100%;
    padding: 10px;
    font-size: 16px;
    border: 2px solid #ccc;
    border-radius: 5px;
    background-color: #fff;
    cursor: pointer;
    transition: border-color 0.3s ease-in-out;
}

select:focus {
    border-color: #007bff;
    outline: none;
}

option {
    font-size: 16px;
    background-color: #fff;
}


    </style>
</head>
<body onload="setGreeting()">
    <div class="navbar">
        <div class="greeting" id="greeting"></div>
                <div class="profile">
            <div class="profile-icon" onclick="toggleDropdown()">👤</div>
            <div id="dropdown" class="dropdown-content">
                <a href="#" onclick="openProfileModal()">Profile Info</a>
                <a href="logout.jsp">Logout</a>
            </div>
        </div>
    </div>

    <div class="modal" id="todoModal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h3>Add New Task</h3>
            <form action="Todo" method="post">
                <input type="hidden" name="action" value="add">
                <input type="text" name="topic" placeholder="Enter topic" required>
                <input type="text" name="content" placeholder="Enter content" required>
                <input type="time" name="time" placeholder="Time" required>

                <select name="status" required>
				    <option value="" disabled selected>Select Status</option>
				    <option value="pending">Pending</option>
				    <option value="completed">Completed</option>
				</select>
                <button type="submit" class="btn">Add Task</button>
            </form>
        </div>
    </div>
    <div class="modal" id="profileModal">
<div class="modal-content">
    <span class="close" onclick="closeProfileModal()">&times;</span>
    <h3>User Profile</h3>
    <table class="profile-table">
        <tr>
            <th>Field</th>
            <th>Details</th>
        </tr>
        <tr>
            <td><strong>First Name</strong></td>
            <td id="profileFirstName"></td>
        </tr>
        <tr>
            <td><strong>Last Name</strong></td>
            <td id="profileLastName"></td>
        </tr>
        <tr>
            <td><strong>Date of Birth</strong></td>
            <td id="profileDOB"></td>
        </tr>
        <tr>
            <td><strong>Email</strong></td>
            <td id="profileEmail"></td>
        </tr>
    </table>
</div>

</div>
    

    <div class="container">
            <button class="btn" onclick="openModal()">Create To-Do</button>
        <h3>To-Do List</h3>
        <% if (!hasTasks) { %>
            <p class="no-tasks">No tasks found. Click "Create To-Do" to add one.</p>
        <% } else { %>
        <table>
            <tr>
                <th>Topic</th>
                <th>Content</th>
                <th>Time</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            <% while (rs.next()) { %>
            <tr>
                <td><%= rs.getString("topic") %></td>
                <td><%= rs.getString("content") %></td>
                <td><%= rs.getString("time") %></td>
                <td><%= rs.getString("status") %></td>
                <td>
                <a class="btn edit" href="update.jsp?taskId=<%= rs.getInt("id") %>">Edit</a>
                    <a class="btn delete" href="Todo?action=delete&taskId=<%= rs.getInt("id") %>">Delete</a> 
                    
                </td>
            </tr>
            <% } %>
        </table>
        <% } %>
    </div>
</body>
</html>
