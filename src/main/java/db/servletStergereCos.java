package db;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

@WebServlet("/dbServletStergereCos")
public class servletStergereCos extends HttpServlet {
	private static final long serialVersionUID = 1L;


    public servletStergereCos() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from the request
        String idStr = request.getParameter("idIntrare");
        long idIntrare = Long.parseLong(idStr);

        // Create an instance of the JavaBean
        javabean jb = new javabean();
        boolean errorOccurred = false;
        try {
            jb.connect(); // Connect to the database
            jb.stergeProdusCos(idIntrare); // Perform the database operation
        } catch (SQLException e) {
            errorOccurred = true; // Set flag to indicate error
        } catch (Exception e) {
            errorOccurred = true; // Set flag to indicate error
        } finally {
            try {
                jb.disconnect(); // Ensure the database connection is closed
            } catch (SQLException e) {
                e.printStackTrace(); // Log this exception
            }
        }

        // Redirect based on error occurrence
        if (errorOccurred) {
            response.sendRedirect("error.jsp"); // Redirect on error
        } else {
            response.sendRedirect("Cos.jsp"); // Redirect on success
        }
    }
}
