
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package System;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import dbConnection.DBConnect;
import java.sql.SQLException;

/**
 *
 * @author Akram
 */
public class ApplyCourse2 extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *     
* @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String a, b;
            int courseID = 0, staffID = 0, result = 0;
            a = request.getParameter("courseID");
            
            if (a != null) {
                courseID = Integer.parseInt(a);
                staffID = Verifier.getStaffID(request);
            }
            out.println(courseID + "<br>");
            out.println(staffID + "<br>");
            
            result = applyCourse(courseID, staffID);
            if (result == 1) {
                response.sendRedirect("./User/ApplyCourse.jsp?status=1");
            } else if (result == 0) {
                out.println("ERROR : <a href='./User/ApplyCourse.jsp' > Back</a>");
            }
        }
    }

    public int applyCourse(int courseID, int staffID) {
        DBConnect db = new DBConnect();
        try {
            db.loadConnection();
            Connection con = db.getConnection();
            String query = "INSERT into participationinfo "
                    + "(staffID, courseID, participantRole, participantStatus, attendanceStatus)"
                    + "values (?,?,'participant','Unverified',0) ";
            PreparedStatement statement = con.prepareStatement(query);
            statement.setInt(1, staffID);
            statement.setInt(2, courseID);
            int result = statement.executeUpdate();
            return result;
            
        } catch (SQLException sqle) {
            System.err.println("Error connecting: " + sqle);
            System.err.println("Punca: " + sqle.toString());
            System.err.println("SQLState: " + sqle.getSQLState());
            System.err.println("Message: " + sqle.getMessage());
            System.err.println("Vendor: " + sqle.getErrorCode());
        } catch (Exception e) {
            System.err.println("Error: " + e);
        }
        finally{
            db.closeConnection();
        }
        return 0;
    }
// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *     
* @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *     
* @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *     
* @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
