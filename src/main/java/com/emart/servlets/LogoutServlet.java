package com.emart.servlets;

import com.emart.entities.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            //own try catch
            try {
                HttpSession s = request.getSession();

                //logout process
                s.removeAttribute("currentUser");

                //logout message
                s.setAttribute("msg", "Logged out successfully...!");
                s.setAttribute("color", "success");
                response.sendRedirect("login.jsp");

            } catch (Exception e) {

                e.printStackTrace();

                //if logout is not possible show message
                HttpSession s = request.getSession();
                s.setAttribute("msg", "Something went wrong...!");
                s.setAttribute("color", "danger");

                //not logged out then return into page
                User user = (User) s.getAttribute("currentUser");

                //condition for already logged out or not
                if (user != null) {

                    //condition for returning into admin page for admin
                    if (user.getUserType().equalsIgnoreCase("admin")) {
                        response.sendRedirect("admin.jsp");

                        //condition for returning into home page for normal users
                    } else if (user.getUserType().equalsIgnoreCase("normal")) {
                        response.sendRedirect("home.jsp");
                    }
                } else {
                    response.sendRedirect("login.jsp");
                }
            }
        }
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
